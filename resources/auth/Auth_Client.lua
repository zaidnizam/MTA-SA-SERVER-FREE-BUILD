
local x, y = guiGetScreenSize()
local browserGUI = guiCreateBrowser(0, 0, x, y, true, true, false)
local browser = guiGetBrowser(browserGUI)

addEventHandler("onClientBrowserCreated", browser, function()
    loadBrowserURL(source, "http://mta/local/frontend/index.html")
    showCursor(true)
    guiSetInputMode("no_binds")
end)




function playerLogin(status, username, password)
    triggerServerEvent("onPlayerAttemptLogin", resourceRoot, username, password)
end
addEvent("playerLogin", true)
addEventHandler("playerLogin", root, playerLogin)


-- Triggered when the server sends the login response
addEvent("onServerSendLoginResponse", true)
addEventHandler("onServerSendLoginResponse", resourceRoot, function(isValidLogin)
    if isValidLogin then
        -- Login successful
        executeBrowserJavascript(browser, "document.getElementById('loginError').innerHTML = 'Login successful! You have been spawned.';")
        outputChatBox("Login successful! You have been spawned.", 0, 255, 0)
    else
        -- Login failed, display error message based on error code
        local errorCode = tonumber(source)
        if errorCode == ERROR_INVALID_CREDENTIALS then
            executeBrowserJavascript(browser, "document.getElementById('loginError').innerHTML = 'Invalid username or password. Please try again.';")
            outputChatBox("Invalid username or password. Please try again.", 255, 0, 0)
        elseif errorCode == ERROR_USER_NOT_FOUND then
            executeBrowserJavascript(browser, "document.getElementById('loginError').innerHTML = 'User not found. Please register or check your username/email.';")
            outputChatBox("User not found. Please register or check your username/email.", 255, 0, 0)
        else
            executeBrowserJavascript(browser, "document.getElementById('loginError').innerHTML = 'An unknown error occurred. Please try again later.';")
            outputChatBox("An unknown error occurred. Please try again later.", 255, 0, 0)
        end
    end
end)


function playerRegister(status, email, username, confirmPassword, playerName)
    triggerServerEvent("onPlayerAttemptRegister", resourceRoot, email, username, confirmPassword, playerName)
end
addEvent("playerRegister", true)
addEventHandler("playerRegister", root, playerRegister)


-- Triggered when the server sends the register response
addEvent("onServerSendRegisterResponse", true)
addEventHandler("onServerSendRegisterResponse", resourceRoot, function(isValidRegister, errorType)
    if isValidRegister then
        -- Register successful
        executeBrowserJavascript(browser, "registerModal.classList.add('hidden');")
        outputChatBox("Register successful! Now log in to play!", 0, 255, 0)
    else
        -- Register failed, display error message based on error type
        if errorType == "username" then
            executeBrowserJavascript(browser, "document.getElementById('passwordError').innerHTML = 'Username already exists. Please choose a different username.';")
            outputChatBox("Username already exists. Please choose a different username.", 255, 0, 0)
        elseif errorType == "email" then
            executeBrowserJavascript(browser, "document.getElementById('passwordError').innerHTML = 'Email already exists. Please use a different email.';")
            outputChatBox("Email already exists. Please use a different email.", 255, 0, 0)
        else
            executeBrowserJavascript(browser, "document.getElementById('passwordError').innerHTML = 'An unknown error occurred. Please try again later.';")
            outputChatBox("An unknown error occurred. Please try again later.", 255, 0, 0)
        end
    end
end)


function closeLoginPage()
    if isElement(browserGUI) then 
        destroyElement(browserGUI)
        showCursor(false)
        guiSetInputMode("allow_binds")
    end
end 
addEvent("closeLoginPage", true)
addEventHandler("closeLoginPage", root, closeLoginPage)