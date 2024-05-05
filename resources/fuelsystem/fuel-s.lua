function setEngineState(player)
veh = getPedOccupiedVehicle(player)
state = getVehicleEngineState(veh)
if veh then
setVehicleEngineState(veh,not state)
end
end
addCommandHandler("engine",setEngineState)



function command(player,cmd,amount)
local vehicle = getPedOccupiedVehicle(player)
local fuel = getElementData(vehicle,"fuel")
local account = getPlayerAccount(player)
local name = getAccountName(account)
if isObjectInACLGroup("user."..name,aclGetGroup("Admin")) then
if vehicle and tonumber(amount) and (tonumber(fuel) + tonumber(amount)) <= 100 then
setElementData(vehicle,"fuel",tonumber(amount) + tonumber(fuel))
outputChatBox("Your vehicle has been refuelled successfully by Script.("..(amount).."%)",player)
else
outputChatBox("Please Type an amount that keep the car fuel below 100%.",player)
end
else
outputChatBox("Access Denied.",255,255,0)
end
end
addCommandHandler("refuel",command)
 