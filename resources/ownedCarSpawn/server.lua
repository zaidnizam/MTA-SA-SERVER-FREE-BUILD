local user_db = dbConnect( "sqlite", ":/user.db" )

if user_db then
    outputDebugString( "Connection with database was successfully established." )
else
    outputDebugString( "Connection with database couldn't be established." )
end

-- Function to handle player vehicle exit
function onPlayerVehicleExit(vehicle, seat, jacked)
    local player = source -- The player who exited the vehicle
    
    -- Get the position (x, y, z) of the vehicle
    local x, y, z = getElementPosition(vehicle)
    
    -- Get the health of the vehicle
    local vehicleHealth = getElementHealth(vehicle)
    
    -- Get the lock status of the vehicle (assuming it's stored as element data)
    local isLocked = getElementData(vehicle, "isLocked") or 0

      -- Get the vehicle color
      local colorR, colorG, colorB = getVehicleColor(vehicle, true) -- Get the RGB color components
      local rgbs = colorR .. ',' .. colorG .. ',' .. colorB -- Concatenate RGB components with commas
    
    -- Update the database with the vehicle's last position, health, and lock status
    local query = dbQuery(user_db, "UPDATE ownedVehicles SET lastX = ?, lastY = ?, lastZ = ?, vehiclehealth = ?, isLocked = ?, vehicleColor = ? WHERE vehicleid = ?",
        x, y, z, vehicleHealth, isLocked, rgbs, getElementData(vehicle, "vehicleID"))

    -- Execute the SQL query
    dbPoll(query, -1)
end
addEventHandler("onPlayerVehicleExit", root, onPlayerVehicleExit)


-- Function to handle vehicle destruction
function onVehicleExplode()
    local vehicle = source -- Get the vehicle that exploded
    local vehicleID = getElementData(vehicle, "vehicleID") -- Get the ID of the vehicle (assuming it's stored as element data)

    -- Get the position (x, y, z) of the vehicle
    local x, y, z = getElementPosition(vehicle)
    
    -- Get the health of the vehicle
    local vehicleHealth = getElementHealth(vehicle)
    
    -- Get the lock status of the vehicle (assuming it's stored as element data)
    local isLocked = getElementData(vehicle, "isLocked") or 0

     -- Get the vehicle color
     local colorR, colorG, colorB = getVehicleColor(vehicle, true) -- Get the RGB color components
     local rgbs = colorR .. ',' .. colorG .. ',' .. colorB -- Concatenate RGB components with commas
    
    -- Update the database with the vehicle's last position, health, and lock status
    local query = dbQuery(user_db, "UPDATE ownedVehicles SET lastX = ?, lastY = ?, lastZ = ?, vehiclehealth = ?, isLocked = ?, isDestroyed = 1, vehicleColor = ? WHERE vehicleid = ?",
        x, y, z, vehicleHealth, isLocked, rgbs, vehicleID)

    -- Execute the SQL query
    dbPoll(query, -1)
    
    -- Perform other actions you want when a vehicle is destroyed
    outputDebugString("Vehicle with ID " .. tostring(vehicleID) .. " has been destroyed.")

    -- Optionally, you can remove the vehicle from the game or perform other cleanup actions
    destroyElement(vehicle)
end
addEventHandler("onVehicleExplode", root, onVehicleExplode)


-- Function to create vehicles from database information
function createVehiclesFromDatabase()
    -- Query the database to fetch vehicle information for non-destroyed vehicles
    local query = dbQuery(user_db, "SELECT * FROM ownedVehicles WHERE isDestroyed = 0")
    local result = dbPoll(query, -1)

    -- Check if the query was successful and there are rows returned
    if result and #result > 0 then
        for _, row in ipairs(result) do
            -- Extract vehicle information from the row
            local vehicleID = row.vehicleid
            local modelID = row.ModelID
            local x = row.lastX
            local y = row.lastY
            local z = row.lastZ
            local isLocked = row.isLocked
            local color = row.vehicleColor


            -- Create the vehicle if it's not already created
            if not isElement(getElementByID(vehicleID)) then
                -- Create the vehicle using the retrieved information
                local vehicle = createVehicle(modelID, x, y, z)
                    -- Set the vehicle's color
-- Extract the RGB components from the string
local r, g, b = color:match("(%d+),(%d+),(%d+)")

-- Check if all RGB components are captured successfully
if r and g and b then
    -- Convert the extracted components to numbers
    r = tonumber(r)
    g = tonumber(g)
    b = tonumber(b)
    
    -- Output the RGB components
    setVehicleColor(vehicle, r, g, b)
else
    outputChatBox("Failed to extract RGB components from color string: " .. color)
end


      

                -- Set the vehicle ID as element data
                setElementData(vehicle, "vehicleID", vehicleID)

                -- Set the lock status if applicable
                if isLocked == 1 then
                    setElementData(vehicle, "isLocked", true)
                else
                    setElementData(vehicle, "isLocked", false)
                end
            end
        end
    else
        outputDebugString("No non-destroyed vehicles found in the database.")
    end
end

-- Call the function to create vehicles from database information
createVehiclesFromDatabase()


function lock(player, cmd)
    -- Get the nearest vehicle to the player
    local vehicle = getNearestVehicle(player)
    
    if vehicle then
        -- Fetch the owner's details from the database
        local vehicleID = getElementData(vehicle, "vehicleID") -- Assuming you have a vehicle ID stored in element data
        local playerName = getPlayerName(player)
        
        local query = dbQuery(user_db, "SELECT * FROM ownedVehicles WHERE vehicleID = ? AND ownername = ?", vehicleID, playerName)
        
        -- Collect the result of the query
        local result = dbPoll(query, -1)
        
        -- Check if the query result is valid and not empty
        if result and #result > 0 then
            -- Proceed if the player is the rightful owner
            if getElementData(vehicle, "isLocked") == true then
                -- Unlock the vehicle
                local unlockQuery = dbQuery(user_db, "UPDATE ownedVehicles SET isLocked = ? WHERE vehicleid = ?", 0, vehicleID) 
                dbFree(unlockQuery) -- Free the query resource after execution
                setElementData(vehicle, "isLocked", false)
                setVehicleLocked(vehicle, false)
                outputChatBox("This whip's free to roam, baby! Unlocked!", player, 0, 255, 255)
            else
                -- Lock the vehicle
                local lockQuery = dbQuery(user_db, "UPDATE ownedVehicles SET isLocked = ? WHERE vehicleid = ?", 1, vehicleID) 
                dbFree(lockQuery) -- Free the query resource after execution
                setElementData(vehicle, "isLocked", true)
                setVehicleLocked(vehicle, true)
                outputChatBox("Hands off, chump! This ride's mine now! Locked!", player, 0, 255, 255)
            end
        else
            -- Inform the player they're not the owner
            outputChatBox("Step off, punk! You ain't the boss of this set of wheels!", player, 255, 0, 0)
        end
        
        -- Free the query resource
        dbFree(query)
    else
        -- Inform the player no vehicles are nearby
        outputChatBox("Ain't no rides in sight, partner! Looks like you're hoofin' it!", player, 255, 0, 0)
    end
end

addCommandHandler("lock", lock)




function getNearestVehicle(player)
    local x, y, z = getElementPosition(player)
    local vehicles = getElementsByType("vehicle")
    local minDistance = 8 -- Adjust the distance threshold as needed
    local nearestVehicle = nil
    
    for _, vehicle in ipairs(vehicles) do
        local vehicleX, vehicleY, vehicleZ = getElementPosition(vehicle)
        local distance = getDistanceBetweenPoints3D(x, y, z, vehicleX, vehicleY, vehicleZ)
        
        if distance < minDistance then
            minDistance = distance
            nearestVehicle = vehicle
        end
    end
    
    return nearestVehicle
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
    local players = getElementsByType("player")
    for k, player in ipairs(players) do
        bindKey(player, "l", "down", lock)
    end
end)

local playerVehicles = {} -- Store engine state for each player's vehicle

function toggleEngine(player, key, state)
    if key == "k" and state == "down" then
        local vehicle = getPedOccupiedVehicle(player)
        if vehicle and getVehicleController(vehicle) == player then
            local engineState = not getVehicleEngineState(vehicle) -- Toggle engine state
            setVehicleEngineState(vehicle, engineState)
            playerVehicles[player] = engineState -- Update stored engine state
            if engineState then
                outputChatBox("Boom! Your engine just fired up like a rocket ready to blast off into space!", player, 255, 0, 0)
            else
                outputChatBox("Guess what? Your engine is now chilling like a villain, off!", player, 0, 255, 0)
            end
        end
    end
end

function checkEngineState(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle and getVehicleController(vehicle) == player then
        local storedState = playerVehicles[player]
        if storedState ~= nil and storedState ~= getVehicleEngineState(vehicle) then
            outputChatBox("Hey, you're trying to move with the engine off? What the *bleep* are you thinking?", player, 255, 0, 0)
            setVehicleEngineState(vehicle, storedState) -- Set engine to stored state
        end
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in ipairs(getElementsByType("player")) do
        bindKey(player, "K", "down", toggleEngine)
    end
end)

addEventHandler("onVehicleStartMove", root, checkEngineState)

addEventHandler("onVehicleEnter", root, function(player, seat)
    if seat == 0 then -- Only check driver seat
        checkEngineState(player)
    end
end)



addEventHandler("onVehicleStartEnter", root,
function(player, seat, jacked)
    if getElementData(source, "isLocked") == true then
        outputChatBox("This vehicle is locked!", player, 255, 0, 0)
        cancelEvent()
    end
end)


function checkPassengerSeat(player)
    local x, y, z = getElementPosition(player)
    local vehicles = getElementsByType("vehicle")
    local comeAnimation = {
        name = "COME",
        block = "ped",
        anim = "CAR_get_in",
        loop = false,
        time = 5000 -- Adjust the time as needed
    }
    
    
    for _, vehicle in ipairs(vehicles) do
        local vehicleX, vehicleY, vehicleZ = getElementPosition(vehicle)
        local distance = getDistanceBetweenPoints3D(x, y, z, vehicleX, vehicleY, vehicleZ)
        
        if distance < 0 then -- Adjust the distance threshold as needed
            if not getElementData(vehicle, "isLocked") then
                for i = 1, getVehicleMaxPassengers(vehicle) do
                    if not getVehicleOccupant(vehicle, i) then
                        setPedAnimation(player, comeAnimation.name, comeAnimation.anim, -1, false, false, false)
                        warpPedIntoVehicle(player, vehicle, i)
                        return
                    end
                end
                outputChatBox("That vehicle has no passenger seats left!", player, 255, 0, 0)
            else
                outputChatBox("This vehicle is locked! You cannot enter it.", player, 255, 0, 0)
            end
            return
        end
    end
end

addCommandHandler("checkpassengerseat",
function(player)
    checkPassengerSeat(player)
end)





addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
    local players = getElementsByType("player")
    for k, player in ipairs(players) do
        bindKey(player, "g", "down",  checkPassengerSeat)
    end
end)


-- Define a function to check if a value exists in a table
    function tableContains(table, value)
        for _, v in ipairs(table) do
            if v == value then
                return true
            end
        end
        return false
    end
    
    -- Now you can use tableContains instead of table.contains
    addEventHandler("onVehicleStartExit", root,
    function(player, seat, jacked)
        local vehicle = source
        local locked = getElementData(vehicle, "isLocked")
        local originalID = getElementModel(vehicle)
    
        -- List of original vehicle IDs where players can exit even if locked
        local allowedIDs = {448, 461, 462, 463, 468, 471, 481, 509, 510, 521, 522, 581, 586}
    
        if locked == true and not tableContains(allowedIDs, originalID) then
            outputChatBox("Hey, no jumping ship! This ride's locked down tight. Unlock it first.", player, 255, 0, 0)
            cancelEvent()
        end
    end)
    

