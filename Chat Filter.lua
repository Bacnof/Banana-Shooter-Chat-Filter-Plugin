local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function readConfig(filename)
    local config = {}
    local file = io.open(filename, "r")
    if not file then
        return nil
    end
    for line in file:lines() do
        local key, value = line:match("^(.-)=(.-)$")
        if key and value then
            config[trim(key)] = trim(value)
        end
    end
    file:close()
    return config
end


local config = readConfig("./Configs/Chat-Filter-Plugin-Config.txt")

if config["debug"] == "true" then
    print("Chat-Filter-Plugin: debug is enabled")
end
if config["enabled"] == "true" then
    if config["debug"] == "true" then
        print("Chat-Filter-Plugin: Plugin is enabled")
    end
    hook:Add("PlayerSay","Chatfilter",function(player,text)

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
                    if config["log"] == "true" then
                        print("Chat-Filter-Plugin: A Player triggered the Chatfilter")
                    end
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
else
    if config["enabled"] == "false" then
        if config["debug"] == "true" then
            print("Chat-Filter-Plugin: debug is enabled")
            print("Chat-Filter-Plugin: Plugin is deactivated")
        end
    end
end
