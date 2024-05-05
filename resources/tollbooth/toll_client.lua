--[[	Resource Name:	BRIDGE TOLL BOOTHS
		Author:			Mega9
		Version:		2.0.3
		All Rights Reserved (c) 2014
]]



-- Settings
local enableImpulses = true		-- If set to false players will not be able to purchase impulses
-- End of settings

function centerTollGUI (theWindow)
    local screenW, screenH = guiGetScreenSize ()
    local windowW, windowH = guiGetSize (theWindow,false)
    local x, y = (screenW - windowW) / 2, (screenH - windowH) / 2
    guiSetPosition (theWindow, x, y, false)
end

-- Toll GUI
local tollGUI = guiCreateWindow(0.37, 0.22, 0.34, 0.41,"Toll Booth",true)
centerTollGUI (tollGUI)
guiWindowSetMovable(tollGUI,false)
guiWindowSetSizable(tollGUI,false)
guiSetVisible (tollGUI, false)
local tollIMG = guiCreateStaticImage(0.27, 0.07, 0.48, 0.47,"tollbooth.png",true,tollGUI)
local tollinfo = guiCreateLabel(0.34, 0.58, 0.42, 0.04,"Toll Price: $",true,tollGUI)
local tollinfoPrice = guiCreateLabel(0.53, 0.58, 0.42, 0.04,"",true,tollGUI)
local tollPay = guiCreateButton(0.17, 0.66, 0.64, 0.14,"Pay Toll",true,tollGUI)
local tollImpulses = guiCreateButton(0.17, 0.82, 0.64, 0.14,"Purchase Impulses",true,tollGUI)
local tollClose = guiCreateButton(0.88, 0.08, 0.09, 0.09,"X",true,tollGUI)

-- Impulses GUI
local impulsesGUI = guiCreateWindow(0.31, 0.24, 0.35, 0.22, "Purchase Impulses", true)
guiWindowSetSizable(impulsesGUI, false)
guiWindowSetMovable(impulsesGUI,false)
guiSetVisible (impulsesGUI, false)
centerTollGUI (impulsesGUI)
local impulsesAdd = guiCreateButton(0.18, 0.21, 0.65, 0.20, "Add one", true, impulsesGUI)
local impulsesCurrent = guiCreateMemo(0.39, 0.49, 0.16, 0.20, "0", true, impulsesGUI)
guiMemoSetReadOnly(impulsesCurrent, true)
local impulsesInfo = guiCreateLabel(0.25, 0.53, 0.13, 0.11, "Current:", true, impulsesGUI)
local impulsesRemove = guiCreateButton(0.19, 0.72, 0.65, 0.20, "Remove one", true, impulsesGUI)
local impulsesClose = guiCreateButton(0.90, 0.14, 0.08, 0.15, "X", true, impulsesGUI)    

addEvent ("manageTollGUI", true)
addEventHandler ("manageTollGUI", root,
	function (state, tollPrice, guest)
		tollPrice = tonumber (tollPrice)
		if state == 1 then
			if not guiGetVisible (tollGUI) then
				guiSetVisible (tollGUI, true)
				showCursor (true)
				guiSetText (tollinfoPrice, tostring (tollPrice))
				guiSetText (impulsesAdd, "Add one ($"..tollPrice..")")
				guiSetText (impulsesCurrent, "0")
				if enableImpulses == false or guest then
					guiSetEnabled (tollImpulses, false)
				elseif enableImpuses == true then
					guiSetEnabled (tollImpulses, true)
				end
			end
		elseif state == 2 then
			if guiGetVisible (tollGUI) then
				guiSetVisible (tollGUI, false)
				showCursor (false)
			end
		end
	end
)

-- Handles GUI Clicks
addEventHandler ("onClientGUIClick", root,
	function (button, state)
		if button == "left" and state == "up" then
			if source == tollPay then
				local vehicleController = getVehicleController (getPedOccupiedVehicle (localPlayer))
				if vehicleController == localPlayer and getPlayerMoney (vehicleController) < tonumber (guiGetText (tollinfoPrice)) then 
					outputChatBox ("[TOLL] You don't have enough money", 255, 0, 0)
					guiSetVisible (tollGUI, false)
					showCursor (false)
				else
					triggerServerEvent ("tollPaid", localPlayer)
					playSoundFrontEnd (5)
					guiSetVisible (tollGUI, false)
					showCursor (false)
				end
			elseif source == tollClose then
				guiSetVisible (tollGUI, false)
				showCursor (false)
			elseif source == tollImpulses then
				guiSetVisible (tollGUI, false)
				guiSetVisible (impulsesGUI, true)
			elseif source == impulsesClose then
				guiSetVisible (tollGUI, true)
				guiSetVisible (impulsesGUI, false)
			elseif source == impulsesAdd then
				if getPlayerMoney (getVehicleController (getPedOccupiedVehicle (localPlayer))) < tonumber (guiGetText (tollinfoPrice)) then
					outputChatBox ("[TOLL] You don't have enough money", 255, 0, 0)
					guiSetVisible (impulsesGUI, false)
					showCursor (false)
				else
					triggerServerEvent ("manageImpulses", localPlayer, 1)
					guiSetText (impulsesCurrent, tonumber (guiGetText (impulsesCurrent)) + 1)
				end
			elseif source == impulsesRemove then
				if getVehicleController (getPedOccupiedVehicle (localPlayer)) == localPlayer then
					if tonumber (guiGetText (impulsesCurrent)) > 0 then
						guiSetText (impulsesCurrent, tonumber (guiGetText (impulsesCurrent)) - 1)
						triggerServerEvent ("manageImpulses", localPlayer, 2)
					end
				end
			end
		end
	end
)
