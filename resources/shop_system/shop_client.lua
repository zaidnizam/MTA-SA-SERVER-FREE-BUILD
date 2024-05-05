-- Get ready to party when you hit that marker!
addEvent("onMarkerHit", true)
addEventHandler("onMarkerHit", root, function()
    local x, y = guiGetScreenSize()
local browserGUI = guiCreateBrowser(0, 0, x, y, true, true, false)
local browser = guiGetBrowser(browserGUI)

addEventHandler("onClientBrowserCreated", browser, function()
    loadBrowserURL(source, "http://mta/local/frontend/index.html")
    showCursor(true)
    guiSetInputMode("no_binds")
end)

function closeWindowGUI(status, click)
    outputDebugString("Whoa! You just touched the marker! Awesome, right?")
    closeLoginPage()
end
addEvent("closeWindowGUI", true)
addEventHandler("closeWindowGUI", root, closeWindowGUI)

function closeLoginPage()
    if isElement(browserGUI) then 
        destroyElement(browserGUI)
        showCursor(false)
        guiSetInputMode("allow_binds")
    end
end 

    outputChatBox("Whoa! You just touched the marker! Awesome, right?")
end)

-- Function on the client to receive and display the error message
addEvent("onVehicleBuyError", true)
addEventHandler("onVehicleBuyError", resourceRoot, function(vehiID, isValidPurchase)
    if isValidPurchase then
        closeLoginPage()
        outputChatBox("You Purchase Sucess Vehicle ID:" ..vehiID, 0, 255, 111)
    else
        outputChatBox("You Don't Have Enough Money Brother!", 255, 0, 0)
    end
end)


-- send clicked vehicle id to server
function testDrive(status, id)
    triggerServerEvent("onPlayerSpawnVehicle", resourceRoot, status, id)
end
addEvent("testDrive", true)
addEventHandler("testDrive", root, testDrive)

-- send clicked vehicle id and price to server
function buyVehicle(id, price)
    triggerServerEvent("onPlayerBuySpawnVehicle", resourceRoot, id, price)
end
addEvent("buyVehicle", true)
addEventHandler("buyVehicle", root, buyVehicle)



