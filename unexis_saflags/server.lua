-- Version and Resource Name Check
local CURRENT_VERSION = "1.1.0" -- Set your current script version
local VERSION_CHECK_URL = "https://www.jsonkeeper.com/b/T222" -- Replace with your version file URL
local RESOURCE_NAME = "unexis_saflags" -- Expected resource name

-- Check resource name
CreateThread(function()
    if GetCurrentResourceName() ~= RESOURCE_NAME then
        print("^1[unexis_saflags]^0: Resource name mismatch! Expected: " .. RESOURCE_NAME .. ", Found: " .. GetCurrentResourceName())
        print("^1[unexis_saflags]^0: Please rename the resource folder to '" .. RESOURCE_NAME .. "' to use this script.")
        StopResource(GetCurrentResourceName())
    else
        print("^2[unexis_saflags]^0: Resource name verified successfully.")
    end
end)

-- Perform version check
CreateThread(function()
    PerformHttpRequest(VERSION_CHECK_URL, function(err, response, headers)
        if err == 200 then
            local data = json.decode(response)
            if data and data.version and data.version ~= CURRENT_VERSION then
                print("^1[unexis_saflags]^0: A new version is available! (Current: " .. CURRENT_VERSION .. ", Latest: " .. data.version .. ")")
                print("^3[unexis_saflags]^0: Please Download Newest Version From Your Keymaster!.")
            else
                print("^2[unexis_saflags]^0: Script is up to date (Version: " .. CURRENT_VERSION .. ").")
            end
        else
            print("^1[unexis_saflags]^0: Failed to check for updates. Please ensure the version URL is correct.")
        end
    end, "GET", "", {})
end)


