local textMap = { [0x80] = "A", [0x81] = "B", [0x82] = "C", [0x83] = "D", [0x84] = "E", [0x85] = "F", [0x86] = "G", [0x87] = "H", [0x88] = "I", [0x89] = "J", [0x8A] = "K", [0x8B] = "L", [0x8C] = "M", [0x8D] = "N", [0x8E] = "O", [0x8F] = "P", [0x90] = "Q", [0x91] = "R", [0x92] = "S", [0x93] = "T", [0x94] = "U", [0x95] = "V", [0x96] = "W", [0x97] = "X", [0x98] = "Y", [0x99] = "Z", [0x9A] = "a", [0x9B] = "b", [0x9C] = "c", [0x9D] = "d", [0x9E] = "e", [0x9F] = "f", [0xA0] = "g", [0xA1] = "h", [0xA2] = "i", [0xA3] = "j", [0xA4] = "k", [0xA5] = "l", [0xA6] = "m", [0xA7] = "n", [0xA8] = "o", [0xA9] = "p", [0xAA] = "q", [0xAB] = "r", [0xAC] = "s", [0xAD] = "t", [0xAE] = "u", [0xAF] = "v", [0xB0] = "w", [0xB1] = "x", [0xB2] = "y", [0xB3] = "z", [0xB4] = "0", [0xB5] = "1", [0xB6] = "2", [0xB7] = "3", [0xB8] = "4", [0xB9] = "5", [0xBA] = "6", [0xBB] = "7", [0xBC] = "8", [0xBD] = "9", [0xBE] = "!", [0xBF] = "?", [0xC0] = "/", [0xC3] = "'", [0xC4] = "-", [0xC5] = ".", [0xC6] = ",", [0xCB] = "(", [0xCC] = ")", [0xCF] = "*", [0xD2] = "=", [0xF6] = "Holy dmg", [0xF8] = "Bolt dmg", [0xF9] = "Wind dmg", [0xFA] = "Earth dmg", [0xFB] = "Ice dmg", [0xFC] = "Fire dmg", [0xFD] = "Water dmg", [0xE3] = "(L)", [0xE8] = "(W)", [0xE9] = "(B)", [0xEA] = "(G)", [0xEF] = "Dark dmg" }

function trim(out) return (out:gsub("^%s*(.-)%s*$", "%1")) end
function translateStringFromGame(byteTable)
	local out = ""
	for i=1,#byteTable do
		local hex = byteTable[i]
		if (textMap[hex]) then 
			out = out .. textMap[hex]
		elseif (hex == 0x01) then
            out = out .. "\n"
        else
			out = out .. " "
		end
	end
	out = trim(out)
	return out
end

function getPointerStringFromGame(idx,offset,textSource)
    local end_offset = offset + (idx*2)
    local target = memory.readword(end_offset) + textSource
    local n = {}
    local input_byte = memory.readbyte(target + #n)
    while (input_byte ~= 0x00) do
        n[#n + 1] = input_byte
        input_byte = memory.readbyte(target + #n)
    end
    return translateStringFromGame(n)
end

-- displays the effect for a currently-hovered over rage
-- executed in the controller-check of the rage menu
function displayBattleRageEffect()
    local whichChar = memory.readbyte(0x7E62CA)
    local column = memory.readbyte(0x7E892F + whichChar)
    local scrolled = memory.readbyte(0x7E892B + whichChar)
    local row = memory.readbyte(0x7E8933 + whichChar)
    local hoverRage = (((row + scrolled)*2)+column)
    local actualRage = memory.readbyte(0x7E257E + hoverRage)
    if (actualRage == 0xFF) then return end -- don't draw on empty slots
    local rageOffset = 0xC4A820
    local rageLoc = rageOffset + actualRage
    local text = getPointerStringFromGame(actualRage,rageOffset, 0xC40000)
    text = text:gsub("\n","\n33%%: ")
    gui.drawtext(10,14,"66%: "..text) 
end

memory.registerexec(0xC1852C, displayBattleRageEffect)