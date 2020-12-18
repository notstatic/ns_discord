AddEventHandler("playerConnecting", function (u, skr, df)
    local s = source
    local i = ExtractIdentifiers(s)
    local DiscordID, XboxLiveID, LiveID
    df.defer()
    df.update("Tarkistetaan tunnisteita..")
    if c.discord == true then
        if i.d ~= "" then
            df.update('discord löytyi')
        else
            df.done('Onko discord käynnissä?')
        end
    end
    if c.xboxlive == true then
        if i.x ~= "" then
            df.update('Xbox Live löytyi')
        else
            df.done('Onko xbox live linkattu fivemiin?')
        end
    end
    if c.liveid == true then
        if i.lv ~= "" then
            df.update('LiveID löytyi')
        else
            df.done('Onko LiveID linkattu fivemiin?')
        end
    end
    if c.log == true then
        if c.webhook ~= nil or c.webhook ~= "" then
            if i.d ~= "" then
                DiscordID = '\nDiscord: <@'..i.d:gsub("discord:", "")..'>'
            else
                DiscordID = '\nDiscord: Ei tiedossa'
            end
            if i.x ~= "" then
                XboxLiveID = '\nXbox: '..i.x
            else
                XboxLiveID = '\nXbox: Ei tiedossa'
            end
            if i.lv ~= "" then
                LiveID = '\nLiveID: '..i.lv
            else
                LiveID = '\nLiveID: Ei tiedossa'
            end
            local steam = '\nSteam: '..i.st
            local rockstar = '\nLisenssi: '..i.l
            if c.logip == true then
                local ip = '\nIP: '..GetPlayerEndpoint(s)
                log('Uusi yhteys','**'..GetPlayerName(s)..'** yhdistää palvelimelle...\n\n[PELAAJAN TIEDOT]'..DiscordID..''..steam..''..rockstar..''..XboxLiveID..''..LiveID..''..ip,65334)
            else
                log('Uusi yhteys','**'..GetPlayerName(s)..'** yhdistää palvelimelle...\n\n[PELAAJAN TIEDOT]'..DiscordID..''..steam..''..rockstar..''..XboxLiveID..''..LiveID,65334)
            end
        end
    end
    df.done()
end)
AddEventHandler('playerDropped', function(r)
    if c.log == true then
        local s = source
        local i = ExtractIdentifiers(s)
        local DiscordID, XboxLiveID, LiveID
        if c.webhook ~= nil or c.webhook ~= "" then
            if i.d ~= "" then
                DiscordID = '\nDiscord: <@'..i.d:gsub("discord:", "")..'>'
            else
                DiscordID = '\nDiscord: Ei tiedossa'
            end
            if i.x ~= "" then
                XboxLiveID = '\nXbox: '..i.x
            else
                XboxLiveID = '\nXbox: Ei tiedossa'
            end
            if i.lv ~= "" then
                LiveID = '\nLiveID: '..i.lv
            else
                LiveID = '\nLiveID: Ei tiedossa'
            end
            local steam = '\nSteam: '..i.st
            local rockstar = '\nLisenssi: '..i.l
            if c.logip == true then
                local ip = '\nIP: '..GetPlayerEndpoint(s)
                log('Uusi poistuminen','**'..GetPlayerName(s)..'** poistui palvelimelta.. syy: '..r..'\n\n[PELAAJAN TIEDOT]'..DiscordID..''..steam..''..rockstar..''..XboxLiveID..''..LiveID..''..ip,16711702)
            else
                log('Uusi poistuminen','**'..GetPlayerName(s)..'** poistui palvelimelta.. syy: '..r..'\n\n[PELAAJAN TIEDOT]'..DiscordID..''..steam..''..rockstar..''..XboxLiveID..''..LiveID,16711702)
            end
        end
    end
end)

function log(alertname, message, color)
    PerformHttpRequest(c.webhook, function(err, text, headers) end, 'POST', json.encode({username = alertname, embeds = {{["color"] = color, ["author"] = {["name"] = 's_discord',["icon_url"] = c.avatar}, ["description"] = "".. message .."",}}, avatar_url = c.avatar}), {['Content-Type'] = 'application/json'})
end

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