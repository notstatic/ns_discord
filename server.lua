-- Config --
local discord = true -- vaaditaanko discordia, jotta palvelimelle pääsee
local xbl = true -- vaaditaanko xbox liveä, jotta palvelimelle pääsee
local live = true -- vaaditaanko LiveID:tä, jotta palvelimelle pääsee
-- Koodi --

AddEventHandler("playerConnecting", function (u, skr, df)
    local s = source
    local i = ExtractIdentifiers(s)
    df.defer()
    df.update("Tarkistetaan tunnisteita..")
    if discord == true then
        if i.d ~= "" then
            df.update('discord löytyi')
        else
            df.done('Onko discord käynnissä?')
        end
    end
    if xbl == true then
        if i.x ~= "" then
            df.update('Xbox Live löytyi')
        else
            df.done('Onko xbox live linkattu fivemiin?')
        end
    end
    if live == true then
        if i.lv ~= "" then
            df.update('LiveID löytyi')
        else
            df.done('Onko LiveID linkattu fivemiin?')
        end
    end
    df.done()
end)

function ExtractIdentifiers(src)
    local identifiers = {
        st = "",
        i = "",
        d = "",
        l = "",
        x = "",
        lv = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.st = id
        elseif string.find(id, "ip") then
            identifiers.i = id
        elseif string.find(id, "discord") then
            identifiers.d = id
        elseif string.find(id, "license") then
            identifiers.l = id
        elseif string.find(id, "xbl") then
            identifiers.x = id
        elseif string.find(id, "live") then
            identifiers.lv = id
        end
    end
    return identifiers
end
