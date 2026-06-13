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


local config1 = readConfig("./Servers/server/Lua/Configs/Chat-Filter-Plugin-Config.txt")
local config2 = readConfig("./Servers/MyServer/Lua/Configs/Chat-Filter-Plugin-Config.txt")
local config = config1 or config2


if config["debug"] == "true" then
    print("Chat-Filter-Plugin: debug is enabled")
    if config["enabled"] == "true" then
        print("Chat-Filter-Plugin: Plugin is enabled")
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
    else
        if config["enabled"] == "false" then
        print("Chat-Filter-Plugin: Plugin is deactivated")
        else
        print("Chat-Filter-Plugin: Config Error")
        end
    end
else
    if config["debug"] == "false" then
        if config["enabled"] == "true" then
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
        end
    end
end
