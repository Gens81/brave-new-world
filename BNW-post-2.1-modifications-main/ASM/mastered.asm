arch 65816
hirom
;;|----------------------------------------------|
;;| Mastered Espers Hack            			 |
;;| by: madsiur                                  |
;;| version: 1.0                                 |
;;| Released on: February 20th, 2022             |
;;| apply to: FF3us 1.0 (no header)              |
;;|----------------------------------------------|

;; assemble with bass v14, e.g. ".\bass -o bnw.sfc mastered.asm"
;; https:;;www.romhacking.net/utilities/794/

;;|----------------------------------------------|
;;| variables                                	 |
;;|----------------------------------------------|

;constant STAR_ENABLED(0)		;; value of 1 to add star icon, other values disable insertion
ICON = $D0				;; star icon value (can be changed to another icon)

;;|----------------------------------------------|
;;| functions                                    |
;;|----------------------------------------------|

;arch snes.cpu

;; set base and origin
;macro seek(variable offset) {
;    origin (offset & $3FFFFF)
;    base offset
;}

;;|----------------------------------------------|
;;| star icon                                	 |
;;|----------------------------------------------|

;if STAR_ENABLED == 1 {
;	seek($C487B0)
;	insert "star.bin"	
;}

;;|----------------------------------------------|
;;| bank $C3 code                                |
;;|----------------------------------------------|

;; in init skills menu function

org $C31B5E
	jsl SET_SPELL_OFFSET			;; calculate actor's spell starting RAM offset
	lda $69,x					;; loac actor ID in slot
;; in draw esper's name and MP cost function

org $C35550
					;; index it
	jsl CHECK_MASTERED			;; check if current esper is mastered
	jsl ADD_ICON

org $C3555D
	ldy #$000D					;; blank tiles when scrolling menu

;;|----------------------------------------------|
;;| outside bank $C3 code                        |
;;|----------------------------------------------|

org $C0DCD0						;; you can change this free space offset
								;; as long as it's not in bank $C3
								;; and that you have 110 ($6E) bytes of free space
							
SET_SPELL_OFFSET:
	tdc
	lda.b $28					;; load slot ID (0-3)
	tax							;; index it
	lda $69,x					;; loac actor ID in slot
	sta.b $A3					;; save for restricted esper hack
	xba									
	lda.b #$36					;; 54 spells
	rep #$20					;; 16-bit A
	sta.l $004202				;; prepare multiplication (actor ID * 54)
	nop
	nop
	nop
	nop
	lda.l $004216				;; load multiplication result
	sta.w $0203					;; save it
	sep #$20					;; 8-bit A
	tdc							;; clear A
	lda.b $28					;; load slot ID (0-3)
	tax							;; index it
	rtl


CHECK_MASTERED:
	LDA $F9         			;; Ones digit
	STA $2180  				    ;; Add to string
	lda.b $E5					;; load esper slot
	tax		
	phx
	phy
	tdc							;; clear A
	sta.b $FB					;; clear mastered esper byte
	lda $7E9D89,x				;; load esper ID
	rep #$20					;; 16-bit A
	sta.b $FC					;; save it
	asl							;; x2
	sta.b $FE					;; save it
	asl							;; x4
	asl							;; x8
	clc
	adc.b $FE					;; x10
	clc
	adc.b $FC					;; x11
	tax
	stz.b $FC
	ldy.w #$0003				;; 3 spells max per esper
	sep #$20					;; 8-bit A
loopm:
	tdc							;; clear A
	lda $D86E01,x				;; esper spell
	cmp #$FF					;; compare to null entry
	beq no_esper				;; exit if no esper
	sta.b $FC					;; save spell ID
	rep #$20					;; 16-bit A
	lda.w $0203					;; load current character spell offset
	clc							;; clear carry
	adc.b $FC					;; spell offset + spell ID
	phx							;; save esper data index
	tax							;; set X as spell learnt percentage
	sep #$20					;; 8-bit A
	lda.w $1A6E,x				;; load spell learnt percentage
	plx							;; restore esper data index
	cmp.b #$FF					;; compare learnt rate to 100%
	bne not_mastered			;; branch if not 100%
	inx
	inx							;; go to next esper spell
	dey							;; decrement loop
	bne loopm
no_esper:
	inc.b $FB					;; set esper as mastered
not_mastered:
	ply
	plx
	lda $7E9D89,x				;; load esper ID

	rtl


ADD_ICON:
	ldx.w #$9E97				;; $7E9E97
	stx.w $2181					;; set WRAM low bytes
	lda.b $FB					;; load mastered esper byte
	beq .not_mastered			;; branch if not mastered
	lda.b $29
	cmp #$28
	beq .not_mastered
    lda.b #ICON                 ;; load icon ID
    sta.w $2180                 ;; add it to string
	bra end_string
.not_mastered
	lda #$FF					;; add space
	sta.w $2180                 ;; add it to string
end_string:
    stz.w $2180                 ;; end string
    rtl
