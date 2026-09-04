hirom

; MP Colors
; author: Imzogelmo
; editor: Bropedio
; bugfix: Silent Enigma
; bnw compatibility: Ryo_Hazuki
; reflect colour change: Khaos (IAmUrza)

; C1 ================================================

; Intercept damage number color palette routine
; to check for new MP dmg flag at bit6
org $C12D2B : NOP : NOP : JSL PaletteMP
org $C12B9B : NOP : NOP : JSL PaletteMP_mass

; Add aliases for existing damage number commands (normal/cascade)
org $C191A0 : dw $A4B3  ; battle dynamics $05, alias to $0B

; Add new battle dynamics cmd $08 (mass/simultaneous)
org $C191A6 : dw $9609  ; battle dynamics $08, alias to $03

; Add MP dmg flags based on battle dynamics command ID
org $C1A5A9 : NOP : JSL SetMPDmgFlag
org $C1A6E6 : NOP : JSL SetMPDmgFlagMass

; C2 ================================================

; Fork which battle dynamics command ID based on MP flag
org $C263A9 : JSR DmgCmdAlias
org $C263BB : JSR DmgCmdAliasMass

; Modify palette for MP damage [?]
org $C2C6A1 : db $63,$14,$41,$7F,$E0,$03,$00,$7F

; New Code ==========================================

org $C0DE5E
SetMPDmgFlag:
  ORA #$01           ; [moved] Add "enable dmg numeral" flag
  PHA                ; store flags so far
  LDA ($76)          ; battle dynamics command ID
  CMP #$0B           ; is this the non-alias cmd (for cascade)
  BEQ .done          ; branch if ^
  PLA                ; else, get flags
  JSR BlueForMPHeal	 ; Jump to new subroutine
  PHA
.done
  PLA                ; get flags
  STA $631A,X        ; set animation thread flags
  RTL

SetMPDmgFlagMass:
  ORA #$01           ; [moved] Add "enable dmg numeral" flag
  PHA                ; store flags so far
  LDA ($76)          ; battle dynamics command ID
  CMP #$03           ; is this the non-alias cmd (for mass)
  BEQ .done          ; branch if ^
  PLA                ; else, get flags
  JSR BlueForMPHeal	 ; Jump to new subroutine
  PHA
.done
  PLA                ; get flags
  STA $7B3F,X        ; set animation thread flags
  RTL

PaletteMP:
  PHA                ; store palette
  LDA $631A,X        ; regular damage numerals
  BRA .check_mp      ; branch to check mp flag
.mass
  PHA                ; store palette
  LDA $7B3F,X        ; mass damage numerals
.check_mp
  AND #$40           ; "MP dmg" flag
  BEQ .normal        ; branch if not ^
  PLA                ; else, get palette
  CLC : ADC #$04     ; and advance to next palette
  BRA .set_palette   ; set palette
.normal
  PLA                ; get hp palette color
.set_palette
  STA $0303,Y        ; store palette [?]
  STA $0307,Y        ; store palette [?]
  RTL
warnpc $C0DEA0+1

org $C0DE5A
  dw $1463			 ; Dark Grey
  dw $7DE2			 ; Blue
  
org $C0DEB8
BlueForMPHeal:
  PHA
  PHX
  TDC            ; set accumulator to 0
  TAX            ; set X to 0
.SetX
  LDA $C0DE5A,X  ; Blue mp healing palette
  STA $7FF8,X    ; write over reflect barrier palette
  STA $7DF8,X    ; write over reflect barrier palette
  INX 
  CPX #$0004
  BNE .SetX
  PLX
  PLA            ; Moved from C0/DE67 & C0/DE7A
  ORA #$40       ; Moved from C0/DE68 & C0/DE7B
  RTS

;New Subroutine C2/A763 (Restore reflect palette - also fixes Crusader bug)			 

RestoreReflectPalette:
  TDC             ; originally at C1/AC23
  TAY             ; originally at C1/AC24
  STY $1E         ; originally at C1/AC25
  INY             ; originally at C1/AC27
  INY             ; originally at C1/AC28
  LDA ($76),Y     ; originally at C1/AC29
  JSL $C1AC2E     ; long access to subroutine C1/9CB3 originally called at C1/AC2B)
  PHX
  TDC            ; set accumulator to 0
  TAX  ; set X to 0
.load
  LDA $C2C6A1,X  ; Default reflect barrier palette
  STA $7FF8,X    ; write over reflect barrier palette
  STA $7DF8,X    ; write over reflect barrier palette
  INX 
  CPX #$0008
  BNE .load
  PLX
  RTL
 
org $C2A7DD
DmgCmdAlias:
  PHA                ; store target data
  SEP #$20           ; 8-bit A
  LDA $11A3          ; N: "MP Dmg"
  REP #$20           ; 16-bit A
  BPL .hp_dmg        ; branch if not ^
  PLA                ; restore target data
  ORA #$0005         ; set "MP Dmg" alias cmd
  RTS
.hp_dmg
  PLA                ; restore target data
  ORA #$000B         ; set "HP Dmg" dynamics command
  RTS

DmgCmdAliasMass:
  PHA                ; store battle dynamics command ($03)
  LDA $11A3          ; N: "MP Dmg"
  BPL .done          ; branch if not ^
  PLA                ; clean up stack
  LDA #$08           ; battle dynamics command for MP
  BRA .exit          ; branch to exit
.done
  PLA                ; restore battle dynamics command
.exit
  JMP $629B          ; finish up
warnpc $C2A800+1


org $C1AC21 
  BCC .branchc
  JSL RestoreReflectPalette    ; Jump to new subroutine C2/A763
  JSR $AC5B
.branchc
  JSR $AC35
  RTS
  JSR $9CB3      			  ; Long access to subroutine C1/9CB3
  RTL

;Imzogelmo reflect palette reverted to new "Reflect Aura" colour --changed by Khaos (IAmUrza)
org $C2C6A1
  dw $7FFF 					; White
  dw $7FB4					; Pale blue
  dw $7F2A 					; Pale blue-green
  dw $7EC0 					; "Reflect Aura" blue
