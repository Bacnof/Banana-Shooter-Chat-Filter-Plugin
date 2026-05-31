hook:Add("PlayerSay","Test",function(player,text)

    local function loadWordsFromFile(filename)
        local words = {}
        for line in io.lines(filename) do
            words[line:lower()] = true
        end
        return words
    end


    local function replaceWords(inputString, wordList)
        local output = inputString:gsub("%w+", function(word)
            if wordList[word:lower()] then
                return "banana"
            else
                return word
            end
        end)
        return output
    end


    local blacklist = loadWordsFromFile("Blacklist.txt")
    local text = text

    local result = replaceWords(text, blacklist)

    return result

end)
