function fetchItemsFromDatabase(playerName)
    -- Establish connection with the SQLite database
    local item_db = dbConnect("sqlite", ":/user.db") -- Adjust the database filename as needed
  
    -- Check if the database connection was established successfully
    if item_db then
        outputDebugString("Connection with item table in database was successfully established.")
  
        -- Execute the query to select items for the specified player
        local query = dbQuery(item_db, "SELECT * FROM inventory WHERE playername=?", playerName)
        
        -- Check if the query was executed successfully
        if query then
            -- Collect the result of the query
            local result = dbPoll(query, -1)
            -- Check if the query result is valid and not empty
            if result and #result > 0 then
                -- Create a table to hold item data
                local items = {}
                -- Iterate over each item in the result
                for _, row in ipairs(result) do
                    -- Extract item data
                    local itemid = row.itemid
                    -- Add item data to the table
                    table.insert(items, itemid)
                end
                -- Trigger the custom event on the client side and send the items table
                triggerClientEvent(root, "onClientReceiveItems", root, items)
            else
                outputChatBox("No items found in the database for player " .. playerName)
            end
        else
            outputDebugString("Failed to execute database query.")
        end
  
        -- Free the query handle
        dbFree(query)
    else
        outputDebugString("Connection with item table in database couldn't be established.")
    end
end

addEvent("fetchItemsFromDatabase", true)
addEventHandler("fetchItemsFromDatabase", root, fetchItemsFromDatabase)





function updateDBInventory(itemID, name)
    local items = {}
    -- Establish connection with the SQLite database
    local item_db = dbConnect("sqlite", ":/user.db") -- Adjust the database filename as needed

    -- Check if the database connection was established successfully
    if item_db then
        outputDebugString("Connection with item table in database was successfully established.")

        -- Execute the query to select items for the specified player
        local query = dbQuery(item_db, "SELECT * FROM inventory WHERE playername=?", name)

        -- Check if the query was executed successfully
        if query then
            -- Collect the result of the query
            local result = dbPoll(query, -1)
            -- Check if the query result is valid and not empty
            if result and #result > 0 then
                -- Iterate over each item in the result
                for _, row in ipairs(result) do
                    -- Extract item data
                    local itemid = row.itemid
                    -- Remove the specified itemID from the comma-separated list
                    local newList = {}
                    local removed = false
                    for number in row.itemid:gmatch("%s*([^,]+)%s*,?") do
                        if tonumber(number) == tonumber(itemID) and not removed then
                            removed = true
                        else
                            table.insert(newList, tonumber(number))
                        end
                    end
                    -- Update the inventory in the database with the modified list
                    local updatedList = table.concat(newList, ", ")
                    dbExec(item_db, "UPDATE inventory SET itemid=? WHERE playername=?", updatedList, name)

                    -- Add the item to the items table if it wasn't removed
                    if not removed then
                        table.insert(items, itemid)
                    end
                end
              --  outputChatBox("Item with ID " .. itemID .. " removed from your inventory.")
            else
              --  outputChatBox("No items found in the database for player " .. name)
            end
        else
            outputDebugString("Failed to execute database query.")
        end

        -- Free the query handle
        dbFree(query)
    else
        outputDebugString("Connection with item table in database couldn't be established.")
    end
end

-- Binding the inventory update function to the event handler
addEvent("updateDBInventory", true)
addEventHandler("updateDBInventory", root, updateDBInventory)
