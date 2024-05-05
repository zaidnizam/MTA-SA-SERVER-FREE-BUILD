local user_db = dbConnect( "sqlite", ":/user.db" )

if user_db then
    outputDebugString( "Connection with database was successfully established." )
else
    outputDebugString( "Connection with database couldn't be established." )
end



-- Function to handle login attempt
function onPlayerAttemptLogin(username, password)
    -- Perform validation (e.g., check against a database)
    local isValidLogin, email, playerName, lastx, lasty, lastz, skinid, playermoney, playerhealth, playerArmor = checkCredentials(username, password)
    
    if isValidLogin then
        -- Send response to client
        triggerClientEvent(client, "onServerSendLoginResponse", resourceRoot, isValidLogin)
        
        triggerClientEvent(client, "closeLoginPage", client)
        -- Spawn the player
        local player = client -- 'client' is the player who triggered the event
        spawnPlayer(player, lastx, lasty, lastz, 90.0, skinid)
        setPlayerMoney(root, playermoney)
        setElementHealth(player, playerhealth)
        setPedArmor(player, playerArmor) 
        fadeCamera(player, true)
        setCameraTarget(player, player)
        setPlayerName (player, playerName)
    else
        -- Send response to client
        triggerClientEvent(client, "onServerSendLoginResponse", resourceRoot, isValidLogin)
    end
end

addEvent("onPlayerAttemptLogin", true)
addEventHandler("onPlayerAttemptLogin", root, onPlayerAttemptLogin)

-- Error codes
local ERROR_INVALID_CREDENTIALS = 0
local ERROR_USER_NOT_FOUND = 1

-- Function to check credentials against SQLite database
function checkCredentials(username, password)
    -- Check if the provided input is an email address
    local isEmail = username:match("^.+@.+%.%w+$") ~= nil
    
    local query
    if isEmail then
        -- Prepare the SQL query to fetch user data based on the provided email
        query = dbQuery(user_db, "SELECT * FROM users WHERE email = ?", username)
    else
        -- Prepare the SQL query to fetch user data based on the provided username
        query = dbQuery(user_db, "SELECT * FROM users WHERE username = ?", username)
    end
    
    -- Execute the query
    local result = dbPoll(query, -1)
    
    -- Check if any result was returned
    if result and #result > 0 then
        -- If a user with the provided input was found, check if the password matches
        local storedPassword = result[1].password -- Assuming the password field is named 'password' in the database
        local storedEmail = result[1].email -- Assuming the email field is named 'email' in the database
        local storedPlayername = result[1].playername -- Assuming the playername field is named 'playername' in the database
        local lastx = result[1].lastX
        local lasty = result[1].lastY
        local lastz = result[1].lastZ
        local skinid = result[1].skinID
        local playermoney = result[1].money
        local playerhealth = result[1].lastHealth
        local playerArmor = result[1].lastArmor
        -- You might need to hash the provided password before comparing it with the stored one
        if password == storedPassword then
            -- Passwords match, login is successful
            return true, storedEmail, storedPlayername, lastx, lasty, lastz, skinid, playermoney, playerhealth, playerArmor -- Return email along with the login status
        else
            -- Passwords don't match, send error code for invalid credentials
            return false, nil, ERROR_INVALID_CREDENTIALS -- Return nil for email and error code
        end
    else
        -- No user with the provided input was found, send error code for user not found
        return false, nil, ERROR_USER_NOT_FOUND -- Return nil for both email and login status, and error code
    end
end


-- Function to handle registration attempt
function onPlayerAttemptRegister(email, username, confirmPassword, playerName)
    -- Perform validation (e.g., check against a database)
    local isValidRegister, errorType = checkCredentialsRegister(email, username)
    
    if isValidRegister then
        -- Insert the new user into the database
        local success = insertUserIntoDatabase(email, username, confirmPassword, playerName)
        
        if success then
            -- Registration and database insertion are successful
            outputDebugString( "Success" )
            
            -- Send response to client
            triggerClientEvent(client, "onServerSendRegisterResponse", resourceRoot, true)
            
            -- Spawn the player
            local player = client -- 'client' is the player who triggered the event
            spawnPlayer(player, 100, 100, 100)
            fadeCamera(player, true)
            setCameraTarget(player, player)
        else
            -- Database insertion failed
            outputDebugString("Failed to insert user into the database.")
        end
    else
        -- Send response to client with error type
        triggerClientEvent(client, "onServerSendRegisterResponse", resourceRoot, false, errorType)
    end
end

-- Function to insert a new user into the database
function insertUserIntoDatabase(email, username, password, playerName)
    -- Hash the password before storing it in the database
    -- You should use a secure hashing algorithm like bcrypt
   -- local hashedPassword = md5(password) -- Example using MD5 hashing (not recommended for production)
    
    -- Prepare the SQL query to insert the new user
    local query = dbQuery(user_db, "INSERT INTO users (email, username, password, playername) VALUES (?, ?, ?, ?)", email, username, password, playerName)
    
    -- Execute the query
    local success = dbPoll(query, -1)
    
    return success
end

-- Function to check credentials against SQLite database for registration
function checkCredentialsRegister(email, username)
    -- Check if username or email already exists in the database
    local queryUsername = dbQuery(user_db, "SELECT * FROM users WHERE username = ?", username)
    local queryEmail = dbQuery(user_db, "SELECT * FROM users WHERE email = ?", email)
    
    local resultUsername = dbPoll(queryUsername, -1)
    local resultEmail = dbPoll(queryEmail, -1)
    
    if resultUsername and #resultUsername > 0 then
        -- Username already exists
        return false, "username"
    elseif resultEmail and #resultEmail > 0 then
        -- Email already exists
        return false, "email"
    else
        -- Registration is valid
        return true
    end
end

addEvent("onPlayerAttemptRegister", true)
addEventHandler("onPlayerAttemptRegister", root, onPlayerAttemptRegister)

addEventHandler("onPlayerQuit", root,
    function(quitType)
        local name = getPlayerName(source)
        local x, y, z = getElementPosition(source)
        local armor = getPedArmor(source)
        local playerHealth = getElementHealth(source)
        local playerMoney = getPlayerMoney(source)       

        -- Update the user's record with their last position
        local query = dbQuery(user_db, "UPDATE users SET lastX = ?, lastY = ?, lastZ = ?, lastHealth = ?, lastArmor = ?, money = ? WHERE playername = ?", x, y, z, playerHealth, armor, playerMoney, name)
        dbFree(query) -- Free the query resource when done

        outputChatBox(getPlayerName(source).." has left the server ("..quitType..")")
        outputDebugString(getPlayerName(source).." has left the server ("..quitType..")".. armor)
    end
)

    
     -- this function is called whenever someone types 'createObject' in the console:
    function createvehCommand(thePlayer, commandName)
        if (thePlayer) then
           local x, y, z = getElementPosition(thePlayer)
           -- create a object next to the player:
           local theObject = createVehicle(528, x + 2, y + 2, z + 4)
           if (theObject) then -- check if the object was created successfully
              outputChatBox("Vehicle created successfully.", thePlayer)
           else
              outputChatBox("Failed to create the Vehicle.", thePlayer)
           end
        end
     end
     addCommandHandler("createveh", createvehCommand)


    --  function onPlayerDeath()
    --     -- Grab the poor soul who met their fate
    --     local player = source

    --     -- Prepare the SQL query to fetch user data based on the provided email
    --     local query = dbQuery(user_db, "SELECT * FROM users WHERE playername = ?", player)

    --     -- Execute the query
    -- local result = dbPoll(query, -1)
    
    -- -- Check if any result was returned
    -- if result and #result > 0 then
    --     -- If a user with the provided input was found, check if the password matches
    --     local skinid = result[1].skinID
    --     -- You might need to hash the provided password before comparing it with the stored one
    --     spawnPlayer(player, 510, -1100, 20, skinid)
    -- end 
    -- end
    
    -- -- Time to handle player deaths with grace and efficiency
    -- addEventHandler("onPlayerWasted", root, onPlayerDeath)
    
    -- register player_Wasted as a handler for onPlayerWasted
function player_Wasted ( ammo, attacker, weapon, bodypart )
    -- setTimer( spawnPlayer, 2000, 1, source, 0, 0, 3 )

    local names = getPlayerName ( source )

     --Prepare the SQL query to fetch user data based on the provided email
    local query = dbQuery(user_db, "SELECT * FROM users WHERE playername = ?", names)

    -- Execute the query
    local result = dbPoll(query, -1)

     -- Check if any result was returned
    if result and #result > 0 then
        -- If a user with the provided input was found, check if the password matches
        local skinid = result[1].skinID


        spawnPlayer(source, 1177, -1324, 15, 0, skinid)
    end 

	-- if there was an attacker
	if ( attacker ) then
		-- we declare our variable outside the following checks
		local tempString
		-- if the element that killed him was a player,
		if ( getElementType ( attacker ) == "player" ) then
			-- put the attacker, victim and weapon info in the string
			tempString = getPlayerName ( attacker ).." killed "..getPlayerName ( source ).." ("..getWeaponNameFromID ( weapon )..")"
		-- else, if it was a vehicle,
		elseif ( getElementType ( attacker ) == "vehicle" ) then
			-- we'll get the name from the attacker vehicle's driver
			tempString = getPlayerName ( getVehicleController ( attacker ) ).." killed "..getPlayerName ( source ).." ("..getWeaponNameFromID ( weapon )..")"
		end
		-- if the victim was shot in the head, append a special message
		if ( bodypart == 9 ) then
			tempString = tempString.." (HEADSHOT!)"
		-- else, just append the bodypart name
		else
			tempString = tempString.." ("..getBodyPartName ( bodypart )..")"
		end
		-- display the message
		outputChatBox ( tempString )
	-- if there was no attacker,
	else
		-- output a death message without attacker info
		outputChatBox ( getPlayerName ( source ).." died. ("..getWeaponNameFromID ( weapon )..") ("..getBodyPartName ( bodypart )..")" )
	end
end
addEventHandler ( "onPlayerWasted", root, player_Wasted )