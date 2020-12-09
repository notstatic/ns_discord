AddEventHandler("playerConnecting", function (u, skr, df)
    local s = source
    local i = ExtractIdentifiers(s)

    df.defer()
    df.update("Tarkistetaan discord yhteyttä.")
    if i.d then
        df.done()
    else
        df.done('Palvelin ei tunnistanut discord käyttäjääsi')
    end
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