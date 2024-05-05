local x, y = guiGetScreenSize()
browserGUI = guiCreateBrowser(0, 0, x, y, true, true, false)
local browser = guiGetBrowser(browserGUI)

function toggleBrowser()
  browserVisible = not browserVisible
  guiSetVisible(browserGUI, browserVisible)
  showCursor(browserVisible)
  if browserVisible then
    local name = getPlayerName(localPlayer)
    triggerServerEvent("fetchItemsFromDatabase", resourceRoot, name)
      guiSetInputMode("allow_binds")
  else
      guiSetInputMode("allow_binds")
  end
end

function onPlayerJoin()
  if isElement(browserGUI) then
      guiSetVisible(browserGUI, false)
  end
end
addEventHandler("onPlayerJoin", root, onPlayerJoin)

function onKeyToggleBrowser(button, press)
  if button == "i" and press then
      toggleBrowser()
  end
end
addEventHandler("onClientKey", root, onKeyToggleBrowser)

addEventHandler("onClientResourceStart", resourceRoot, function()
  addEventHandler("onClientBrowserCreated", browser, function(ids)
      loadBrowserURL(source, "http://mta/local/index.html")
  end)
end)



function inevntoryCallUp(status, leos)
 -- outputChatBox(leos)
  outputChatBox("Hey HTML calling sucssess")
end
addEvent("inevntoryCallUp", true)
addEventHandler("inevntoryCallUp", root, inevntoryCallUp)



-- Register the custom client-side event handler
addEvent("onClientReceiveItems", true)

-- Define the event handler function to receive items
addEventHandler("onClientReceiveItems", resourceRoot, function(items)
    -- Loop through the received items table
    local allItemIds = {} -- Initialize a table to store all item IDs
    for _, itemID in ipairs(items) do
        table.insert(allItemIds, itemID) -- Add item ID to the table
    end

    -- Convert the Lua table to JSON format
    local jsonItemIds = toJSON(allItemIds)

    -- Execute JavaScript code in the browser to update the element with ID 'ex' with the JSON data
    executeBrowserJavascript(browser, "document.getElementById('ex').textContent = '" .. jsonItemIds .. "'")
end)

-- function updateInventoryDBr(status, RESULT)
 
--   -- Execute JavaScript code in the browser to update the element with ID 'ex' with the JSON data
--   executeBrowserJavascript(browser, "document.getElementById('ex').textContent = '" .. RESULT .. "'")
-- end
-- addEvent("updateInventoryDBr", true)
-- addEventHandler("updateInventoryDBr", root, updateInventoryDBr)


function updateInventoryDB(status, itemID)
  local name = getPlayerName(localPlayer)
 triggerServerEvent("updateDBInventory", resourceRoot, itemID, name)
end
addEvent("updateInventoryDB", true)
addEventHandler("updateInventoryDB", root, updateInventoryDB)