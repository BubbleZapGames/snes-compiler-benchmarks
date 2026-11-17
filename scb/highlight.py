"""Build-time syntax highlighting: 65816 assembly listings, and C/R65 sources."""

import html
import re

MNEMONICS = set("""
adc and asl bcc bcs beq bit bmi bne bpl bra brk brl bvc bvs clc cld cli clv cmp cop cpx
cpy dec dex dey eor inc inx iny jml jmp jsl jsr lda ldx ldy lsr mvn mvp nop ora pea pei
per pha phb phd phk php phx phy pla plb pld plp plx ply rep rol ror rti rtl rts sbc sec
sed sei sep sta stp stx sty stz tax tay tcd tcs tdc trb tsb tsc tsx txa txs txy tya tyx
wai wdm xba xce ina dea
""".split())

ASM_TOKEN = re.compile(r"""
    (?P<label>^\s*[A-Za-z_.~?@][\w.~?@]*:)
  | (?P<str>"[^"\n]*"|'[^'\n]*')
  | (?P<num>\#?(?:\$[0-9A-Fa-f]+|%[01]+|\b0x[0-9A-Fa-f]+\b|\b\d+\b))
  | (?P<dir>(?<![\w.])\.[A-Za-z_]\w*)
  | (?P<word>\b[A-Za-z]{3}(?:\.[bwlBWL])?\b)
""", re.X)


def _span(cls, text):
    return f'<span class="t-{cls}">{html.escape(text)}</span>'


def _comment_split(line, marker=";"):
    """Split off a trailing comment, ignoring the marker inside quotes."""
    quote = None
    for i, ch in enumerate(line):
        if quote:
            if ch == quote:
                quote = None
        elif ch in "\"'":
            quote = ch
        elif ch == marker:
            return line[:i], line[i:]
    return line, ""


def asm(text):
    out = []
    for line in text.splitlines():
        code, comment = _comment_split(line)
        parts, pos = [], 0
        for m in ASM_TOKEN.finditer(code):
            parts.append(html.escape(code[pos:m.start()]))
            kind = m.lastgroup
            tok = m.group()
            if kind == "word":
                kind = "op" if tok.split(".")[0].lower() in MNEMONICS else None
            parts.append(_span(kind, tok) if kind else html.escape(tok))
            pos = m.end()
        parts.append(html.escape(code[pos:]))
        if comment:
            parts.append(_span("com", comment))
        out.append("".join(parts))
    return "\n".join(out)


C_KEYWORDS = set("""
auto break case char const continue default do double else enum extern float for goto if
inline int long register return short signed sizeof static struct switch typedef union
unsigned void volatile while fn let mut loop match impl trait self Self as near far true
false u8 u16 u32 i8 i16 i32 bool def import from in not or and is None
""".split())

C_TOKEN = re.compile(r"""
    (?P<attr>\#!?\[[^\]\n]*\])
  | (?P<com>//[^\n]*|\#[^\n]*$|/\*.*?\*/|\"\"\"[^\n]*)
  | (?P<str>"[^"\n]*"|'(?:\\.|[^'\\\n])')
  | (?P<num>\b0x[0-9A-Fa-f]+\b|\b\d+\b)
  | (?P<word>\b[A-Za-z_]\w*\b)
""", re.X | re.S | re.M)


def source(text, python=False):
    """C, R65 or Python source. Python's '#' comments share the pattern."""
    parts, pos = [], 0
    for m in C_TOKEN.finditer(text):
        kind, tok = m.lastgroup, m.group()
        if kind == "com" and tok.startswith("#") and not python:
            kind = "pre"
        if kind == "word":
            kind = "kw" if tok in C_KEYWORDS else None
        parts.append(html.escape(text[pos:m.start()]))
        parts.append(_span(kind, tok) if kind else html.escape(tok))
        pos = m.end()
    parts.append(html.escape(text[pos:]))
    return "".join(parts)
