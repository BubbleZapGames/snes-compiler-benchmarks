;;; Calypsi linker rules for a 32 KB SNES LoROM (bank $00 $8000-$FFFF).
;;; Small code and data models: code, constants and variables in bank $00,
;;; variables in low RAM. Derived from example/linker-files/linker-small-small-any.scm.
(define memories
  '((memory DirectPage (address (#x0000 . #x00ff))
            (section (registers ztiny)))
    (memory LoRAM (address (#x0100 . #x1eff))
            (section stack data zdata heap))
    (memory ROM (address (#x8000 . #xffbf)) (type ROM)
            (section code compactcode switch cdata data_init_table idata itiny farcode cfar chuge))
    (memory Header (address (#xffc0 . #xffff))
            (section (snes_header #xffc0) (snes_vectors #xffe0) (reset #xfffc) (snes_irq #xfffe)))
    (block stack (size #x0400))
    (block heap (size #x0000))
    (base-address _DirectPageStart DirectPage 0)
    ))
