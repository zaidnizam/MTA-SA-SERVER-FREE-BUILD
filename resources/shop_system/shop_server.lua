local user_db = dbConnect( "sqlite", ":/user.db" )

if user_db then
    outputDebugString( "Connection with database was successfully established." )
else
    outputDebugString( "Connection with database couldn't be established." )
end


local markerSize = 4
local markerType = "rounded"
local markerColor = {255, 0, 0, 150}  -- Red color with some transparency

local lastVehicle = {}  -- Table to store last spawned vehicle for each player

-- Create the marker with all the bells and whistles
local marker = createMarker(541, -1283, 16, "cylinder", markerSize, unpack(markerColor))
local blip =  createBlip( 541, -1283, 16, 55, 1, 0, 0, 255)

-- Set the marker's type
setElementData(marker, "markerType", markerType)

-- Define a function to handle the excitement of marker hits
local function onMarkerHit(hitElement, matchingDimension)
    -- If it's a player, let's give 'em a shout-out!
    if isElement(hitElement) and getElementType(hitElement) == "player" then
        -- Check if the player already has a vehicle spawned
        if lastVehicle[hitElement] and isElement(lastVehicle[hitElement]) then
            destroyElement(lastVehicle[hitElement])  -- Destroy previous vehicle
        end
        
        -- Spawn a vehicle by its ID near the player
        local player = hitElement
        local x, y, z = getElementPosition(player)
        local vehicle = createVehicle(0, 561, -1275, 19, 0, 0)  -- Example vehicle ID
        
        -- Store the newly spawned vehicle
        lastVehicle[player] = vehicle
        
        
        -- Cue the cinematic effect: fade that camera!
        fadeCamera(player, false, 3.0, 255, 0, 0) 
        
        -- Move 'em to a different interior after 2 seconds
        setTimer(function()
            setElementInterior(player, 1, 551, -1275, 19)
        end, 2000, 1)
        
        -- Set a timer to move them outside after 2 seconds
        setTimer(function()
            setElementInterior(player, 0, 551, -1275, 19)
            fadeCamera(player, true, 0.5)
        end, 4000, 1)
        
        -- Blow their minds!
        triggerClientEvent(player, "onMarkerHit", resourceRoot)
    end
end

-- Add an event handler for the exhilarating marker hits
addEventHandler("onMarkerHit", marker, onMarkerHit)

-- Function to handle test drive attempts
function onPlayerSpawnVehicle(status, id)
    local player = source
    local x, y, z = getElementPosition(player)
    local ids = status, id
    
    -- Check if the player already has a vehicle spawned
    if lastVehicle[player] and isElement(lastVehicle[player]) then
        destroyElement(lastVehicle[player])  -- Destroy previous vehicle
    end
    
    -- Spawn a new vehicle
    local vehicle = createVehicle(ids, 561, -1275, 19, 0, 0)  -- Example vehicle ID
    
    -- Store the newly spawned vehicle
    lastVehicle[player] = vehicle
    
    -- Give the player a premium chat message
    outputChatBox("Test Vehicle Created!", player, 255, 165, 0)
    
    -- Create a massive marker to define the test drive area
    local marker = createMarker(x, y, z, "cylinder", 10, 255, 0, 0, 150)
    
    -- Set up a timer for 1 minute of adrenaline-pumping testing
    local remainingTime = 60
    setTimer(function()
        remainingTime = remainingTime - 10
        if remainingTime > 0 then
            -- Keep the player on their toes with dynamic time updates
            outputChatBox("You have " .. remainingTime .. " seconds left to test like a pro!", player, 0, 255, 0)
        else
            -- Time's up! Bid farewell to the test vehicle
            destroyElement(vehicle)
            outputChatBox("Test time over! Vehicle destroyed.", player, 255, 0, 0)
        end
    end, 10000, 6)  -- Execute every 10 seconds for 6 times (60 seconds total)
end

addEvent("onPlayerSpawnVehicle", true)
addEventHandler("onPlayerSpawnVehicle", root, onPlayerSpawnVehicle)


-- Function on the server to handle buy vehicle attempts (only visible for the player)
function onPlayerBuySpawnVehicle(id, money)
    -- Extract numeric part of money string
    local playerMoney = getPlayerMoney(client)       
    local vehicleprice = tonumber(string.match(money, "%d+"))
  
    -- Check if player has enough money
    if playerMoney < vehicleprice then
        -- Send response to client indicating failure
        triggerClientEvent(client, "onVehicleBuyError", resourceRoot, false)
    else
        -- Proceed with spawning the vehicle
        local x, y, z = getElementPosition(client) -- Get player's position for spawning the vehicle
        local rx, ry, rz = getElementRotation(client) -- Get player's rotation for the vehicle
        local vehicle = createVehicle(id, x + 3, y + 3, z, rx, ry, rz) -- Create the vehicle

        
-- Function to generate a unique vehicle ID
function generateUniqueVehicleID()
    local maxAttempts = 100 -- Maximum number of attempts to generate a unique ID
    local attempt = 1 -- Initialize attempt counter
    local vehicleID = nil -- Initialize vehicle ID

    -- Loop until a unique vehicle ID is generated or maximum attempts reached
    repeat
        -- Generate a random ID suffix
        local randomIDPart = math.random(100, 999) -- Generate a random 3-digit number
        
        -- Extract the first three digits from the original spawn vehicle ID
        local originalIDPrefix = tostring(id):sub(1, 3) -- Extract first three characters
        
        -- Combine the original prefix with the random suffix to create the vehicle ID
        vehicleID = tonumber(originalIDPrefix .. randomIDPart)

    

        -- Query the database to check if the generated ID already exists
        local query = dbQuery(user_db, "SELECT id FROM ownedVehicles WHERE vehicleid = ?", vehicleID)
        local result = dbPoll(query, -1)

        -- If the query result is empty, the ID is unique
        if not result or #result == 0 then
            return vehicleID -- Return the unique ID
        end

        -- If the ID already exists, increment attempt counter and try again
        attempt = attempt + 1
    until attempt > maxAttempts -- Exit loop if maximum attempts reached

    -- If maximum attempts reached without finding a unique ID, return nil
    return nil
end

-- Generate a unique vehicle ID
local vehicleID = generateUniqueVehicleID()

-- Check if a unique ID was generated
if vehicleID then
    outputDebugString("Unique Vehicle ID generated: " .. vehicleID)
else
    outputDebugString("Failed to generate a unique Vehicle ID.")
end

        
        -- Set the vehicle ID as element data
        setElementData(vehicle, "vehicleID", vehicleID)
        local keyid = vehicleID

        -- Get the vehicle color
        local colorR, colorG, colorB = getVehicleColor(vehicle, true) -- Get the RGB color components
        local rgbs = colorR .. ',' .. colorG .. ',' .. colorB -- Concatenate RGB components with commas
  
        


-- Prepare the SQL query to insert the new vehicle information into the database
local query = dbQuery(user_db, "INSERT INTO ownedVehicles (vehicleid, ownername, lastX, lastY, lastZ, isLocked, vehiclehealth, ModelID, price, keyid, isDestroyed, vehicleColor) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    vehicleID, getPlayerName(client), x, y, z, 0, 100, id, money, keyid, 0, rgbs) -- Assuming initial health is 100 and isLocked is 0

-- Execute the SQL query
local result, num_affected_rows, insertID = dbPoll(query, -1)

-- Check if the query was successful
if result then
    outputDebugString("Vehicle information inserted into the database with ID: " .. insertID)
else
    outputDebugString("Failed to insert vehicle information into the database")
end

        
        -- Send response to client indicating success and passing the vehicle ID
        triggerClientEvent(client, "onVehicleBuyError", resourceRoot, vehicleID, true)
        
        -- Deduct the money from the player's account
        takePlayerMoney(client, vehicleprice)
    end
end


  
  -- Register event handler for "onPlayerBuySpawnVehicle" on the server
  addEvent("onPlayerBuySpawnVehicle", true)
  addEventHandler("onPlayerBuySpawnVehicle", root, onPlayerBuySpawnVehicle)


  