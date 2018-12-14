;============================================================
; Iceblox Plus for the C64
; By Karl Hörnell
;============================================================

;============================================================
;    specify output file
;============================================================

!cpu 6502
!to "build/icebloxplus.prg",cbm    ; output file

;============================================================
; BASIC loader with start address $c000
;============================================================

* = $0801                               ; BASIC start address (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000...
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152

* = 4096
!source "code/irq.asm"					; The bulk of the code goes here

* = 14160								; start address for green gradient data
!source "data/greens.asm"

* = 14304								; Start address for logo data
!source "data/logodata.asm"


* = 16384								; Sprite data start
!source "data/sprites.asm"

;============================================================
;  Main routine with IRQ setup and custom IRQ routine
;============================================================

* = 32768								; Character data start
!source "data/characters.asm" ; Level graphics building blocks
!source "data/song.asm"
!source "code/variables.asm"

; 40960 character map (1024 bytes)
; 41984 empty ground map (1024 bytes)
; 43008 block data (192 bytes)
; 43200 block data buffer (192 bytes)
; 43392 mask data (768 bytes)

* = $c000     				            ; start address for 6502 code
!source "code/main.asm"
!source "code/help_routines.asm"
