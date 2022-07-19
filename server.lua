--[[
VineList Discord Whitelist

- Developed by Hebi
]]--

WList = Config.WhitelistRoles -- Declaring whitelist roles
BList = Config.BlacklistRoles -- Declaring banlist roles

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    deferrals.defer() -- Starting the script when the player presses connect
    
    local src = source
    local whitelisted = false
    local banned = false
    local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)

    deferrals.update("Checking your status on " .. Config.Name) -- Displaying that the check is running
    Wait(2)

    -- using for loop check for whitelisted roles
    for i=1, #WList do
        for j=1, #roleIDs do
            if exports.Badger_Discord_API:CheckEqual(WList[i], roleIDs[j]) then
                print("[VineList] " .. GetPlayerName(src) .. " Whitelisted with role " .. WList[i]) -- Console Entry
                whitelisted = true
            end
        end
    end

    -- Whitelist Guard
    if not whitelisted then
        print("[VineList] " .. GetPlayerName(src) .. " is not whitelisted.")
        deferrals.done("You are not whitelisted")
        CancelEvent() -- Stopping connection to the server
        return
    end
    
    -- Ban Role Loop Check
    for i=1, #BList do
        for j=1, #roleIDs do
            if exports.Badger_Discord_API:CheckEqual(BList[i], roleIDs[j]) then
                print("[VineList] " .. GetPlayerName(src) .. " Ban check starting.")
                banned = true
            end
        end
    end

    -- Ban Guard
    if banned then
        print("[VineList] " .. GetPlayerName(src) .. " Failed Ban Check.")
        deferrals.done("You are banned, Check Discord")
        CancelEvent()
        return
    end

    -- Allowing Connection to the server
    deferrals.done()
end)