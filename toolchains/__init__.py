"""One adapter module per compiler.

Each module provides:

    available(tc) -> bool             is the compiler installed?
    version(tc) -> dict               provenance for the run record
    build(tc, src, work) -> Build     ROM, symbol addresses, ROM bytes in use
    listing(tc, work) -> str | None   the assembly emitted for bench's unit
"""
