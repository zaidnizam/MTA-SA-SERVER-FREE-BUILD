--[["Fuel System|By SuperCroz"]]--
marker1 = createMarker(1943.6787109375,-1778.5,12.390598297119,"cylinder",2,150,255,150,150)
blip1 = createBlip(1943.6787109375,-1778.5,12.390598297119,44,2,0,0,0,0,0,200)
marker2 = createMarker(1943.9921875,-1771.1083984375,12.390598297119,"cylinder",2,150,255,150,150)
marker3 = createMarker(1939.2060546875,-1771.4345703125,12.3828125,"cylinder",2,150,255,150,150)
marker4 = createMarker(1939.3017578125,-1778.236328125,12.390598297119,"cylinder",2,150,255,150,150)
marker5 = createMarker(2120.9228515625,927.486328125,9.8203125,"cylinder",2,150,255,150,150)
blip5 = createBlip(2120.9228515625,927.486328125,9.8203125,44,2,0,0,0,0,0,200)
marker6 = createMarker(2114.7607421875,927.7734375,9.8203125,"cylinder",2,150,255,150,150)
marker7 = createMarker(2114.951171875,917.513671875,9.8203125,"cylinder",2,150,255,150,150)
marker8 = createMarker(70.021484375,1218.794921875,17.810596466064,"cylinder",2,150,255,150,150)
blip = createBlip(70.021484375,1218.794921875,17.810596466064,44,2,0,0,0,0,0,200)
marker9 = createMarker(-2029.5693359375,157.0537109375,27.8359375,"cylinder",2,150,255,150,150)
blip2 = createBlip(-2029.5693359375,157.0537109375,27.8359375,44,2,0,0,0,0,0,200)
marker10 = createMarker(-2023.94140625,156.91796875,27.8359375,"cylinder",2,150,255,150,150)
marker11 = createMarker(-2407.7900390625,981.638671875,44.296875,"cylinder",2,150,255,150,150)
blip3 = createBlip(-2407.7900390625,981.638671875,44.296875,44,2,0,0,0,0,0,200)
marker12 = createMarker(-2407.966796875,971.537109375,44.296875,"cylinder",2,150,255,150,150)
marker13 = createMarker(2205.5888671875,2469.7236328125,9.8203125,"cylinder",2,150,255,150,150)
blip3 = createBlip(2205.5888671875,2469.7236328125,9.8203125,44,2,0,0,0,0,0,200)
marker14 = createMarker(2205.7412109375,2480.01953125,9.8203125,"cylinder",2,150,255,150,150)
marker15 = createMarker(2194.095703125,2475.271484375,9.8203125,"cylinder",2,150,255,150,150)
marker16 = createMarker(2194.220703125,2470.84765625,9.8203125,"cylinder",2,150,255,150,150)
marker17 = createMarker(-1602.03125,-2710.5712890625,47.5390625,"cylinder",2,150,255,150,150)
blip6 = createBlip(-1602.03125,-2710.5712890625,47.5390625,44,2,0,0,0,0,0,200)
marker18 = createMarker(-1605.4091796875,-2714.3037109375,47.533473968506,"cylinder",2,150,255,150,150)
marker19 = createMarker(-1608.5830078125,-2718.638671875,47.5390625,"cylinder",2,150,255,150,150)
marker20 = createMarker(622.9189453125,1680.3486328125,5.9921875,"cylinder",2,150,255,150,150)
blip7 = createBlip(622.9189453125,1680.3486328125,5.9921875,44,2,0,0,0,0,0,200)
marker21 = createMarker(615.6982421875,1690.5673828125,5.9921875,"cylinder",2,150,255,150,150)
marker22 = createMarker(608.8447265625,1700.0146484375,5.9921875,"cylinder",2,150,255,150,150)
marker23 = createMarker(1008.3486328125,-939.84375,41.1796875,"cylinder",2,150,255,150,150)
blip8 = createBlip(1008.3486328125,-939.84375,41.1796875,44,2,0,0,0,0,0,200)
credits = "Fuel System | By SuperCroz"
marker24 = createMarker(999.6259765625,-940.79296875,41.1796875,"cylinder",2,150,255,150,150)
marker25 = createMarker(-92.314453125,-1176.08984375,1.2067136764526,"cylinder",2,150,255,150,150)
blip9 = createBlip(-92.314453125,-1176.08984375,1.2067136764526,44,2,0,0,0,0,0,200)
marker26 = createMarker(-94.1083984375,-1161.775390625,1.2461423873901,"cylinder",2,150,255,150,150)
marker27 = createMarker(1873.2841796875,-2380.119140625,12.5546875,"cylinder",4,150,255,150,150)
blip10 = createBlip(1873.2841796875,-2380.119140625,12.5546875,44,2,0,0,0,0,0,200)
marker28 = createMarker(-1280.7412109375,-0.7314453125,13.1484375,"cylinder",4,150,255,150,150)
blip11 = createBlip(-1280.7412109375,-0.7314453125,13.1484375,44,2,0,0,0,0,0,200)
marker29 = createMarker(1574.8916015625,1449.80078125,9.8299560546875,"cylinder",4,150,255,150,150)
blip12 = createBlip(1574.8916015625,1449.80078125,9.8299560546875,44,2,0,0,0,0,0,200)
marker30 = createMarker(354.5390625,2538.3251953125,15.717609405518,"cylinder",4,150,255,150,150)
blip13 = createBlip(354.5390625,2538.3251953125,15.717609405518,44,2,0,0,0,0,0,200)

MaxFuel = 100 -- 100 is the default Max Fuel.
decreasing = 0.0005 -- per frame.
increasing = 0.35 -- per frame. (when refuelling)
price = 3 -- $3 is default. When changing this variable, make sure that the (new price * increasing speed) > 1, else it won't take player money. 
-- current price * increasing speed = 3 * 0.35 = 1.05 ( > 1)

function setVehicleFuelOnRespawn()
	for k,v in ipairs(getElementsByType("vehicle"))do
		if getElementData(v,"fuel") == false then
			setElementData(v,"fuel",MaxFuel)
		end
	end
end
addEventHandler("onClientRender",root,setVehicleFuelOnRespawn)

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.64 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end


function setFuelDecreasing()
for f,v in ipairs(getElementsByType("vehicle"))do
	local fuel = getElementData(v,"fuel")
		if getVehicleEngineState(v) == true and (not getElementData(v,"fuel") == false) then
			setElementData(v,"fuel",fuel - getElementSpeed(v,"kph")*0.00004 - decreasing)
		end
	end
end
addEventHandler("onClientRender",root,setFuelDecreasing)


x,y = guiGetScreenSize()
function drawTheImages()
if getPedOccupiedVehicle(localPlayer) then
dxDrawImage (x*0.62, y*0.78,100, 123,"fuelcircle.png",0,0,0)
dxDrawImage (x*0.62, y*0.8,100, 123,"fuelarrow.png",getElementData(veh,"fuel") + 230,0,0)
dxDrawImage (x*0.77,y*0.63,150,150,"speedcircle.png")
dxDrawImage (x*0.77,y*0.63,150,150,"speedarrow.png",getElementSpeed(veh,"mph")*0.74 - 11,0,0)
dxDrawImage (x*0.87,y*0.788,25,25,"carhealth.png",getElementRotation(veh),0,0,tocolor(0 - getElementHealth(veh)*0.255,getElementHealth(veh)*0.255,0,255))
end
end
addEventHandler("onClientRender",root,drawTheImages)

function showTheGuiAndDx()
veh = getPedOccupiedVehicle(source)
setElementData(source,"refuelling",true)
outputChatBox("Turn the vehicle engine off to start refuelling. press K",0,255,0)
    function showDx()
        dxDrawRectangle(x*0.452, y*0.290, x*0.396, y*0.2, tocolor(0, 0, 0, 175), false)
        dxDrawRectangle(x*0.452, y*0.290, x*0.396, y*0.25, tocolor(0, 0, 0, 254), false)
        dxDrawText("Fuel Station", x*0.546, y*0.295, x*0.760, y*0.325, tocolor(255, 255, 255, 254), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("Current Fuel : "..math.floor(getElementData(veh,"fuel")*1000)/1000, x*0.457, y*0.332, x*0.842, y*0.371, tocolor(255, 255, 255, 255), 1.10, "sans", "left", "center", false, false, true, false, false)
        if (MaxFuel - getElementData(veh,"fuel")) < 1 then
		dxDrawText("Needed Fuel : "..(MaxFuel) - math.floor(getElementData(veh,"fuel")), x*0.457, y*0.371, x*0.842, y*0.410, tocolor(255, 255, 255, 255), 1.10, "sans", "left", "center", false, false, true, false, false)
        else
		dxDrawText("Needed Fuel : "..(MaxFuel) - (math.floor(getElementData(veh,"fuel")*1000)/1000), x*0.457, y*0.371, x*0.842, y*0.410, tocolor(255, 255, 255, 255), 1.10, "sans", "left", "center", false, false, true, false, false)
		end
		dxDrawText("Liter Price : $"..price, x*0.457, y*0.410, x*0.842, y*0.449, tocolor(255, 255, 255, 255), 1.10, "sans", "left", "center", false, false, true, false, false)
       dxDrawText("Total Cost : "..math.floor(getElementData(localPlayer,"price")*100)/100, x*0.457, y*0.449, x*0.842, y*0.488, tocolor(255, 255, 255, 255), 1.10, "sans", "left", "center", false, false, true, false, false)
        if getVehicleEngineState(veh) == true then
		dxDrawText("Turn Your Engine Off.", x*0.457, y*0.488, x*0.842, y*0.527, tocolor(255, 255, 255, 255), 1.10, "sans", "center", "center", false, false, true, false, false)
		else
		dxDrawText("Turn Your Engine ON To Stop Refuelling.", x*0.457, y*0.488, x*0.842, y*0.527, tocolor(255, 255, 255, 255), 1.10, "sans", "center", "center", false, false, true, false, false)
		end
	end
addEventHandler("onClientRender", root,showDx)
end
addEvent("onClientWantToRefuel",true)
addEventHandler("onClientWantToRefuel",getLocalPlayer(),showTheGuiAndDx)

function showFuelSystem(hitElement) 
triggerEvent("onClientWantToRefuel",hitElement)
setElementData(hitElement,"price",0)
end
addEventHandler("onClientMarkerHit",marker1,showFuelSystem)
addEventHandler("onClientMarkerHit",marker2,showFuelSystem)
addEventHandler("onClientMarkerHit",marker3,showFuelSystem)
addEventHandler("onClientMarkerHit",marker4,showFuelSystem)
addEventHandler("onClientMarkerHit",marker5,showFuelSystem)
addEventHandler("onClientMarkerHit",marker6,showFuelSystem)
addEventHandler("onClientMarkerHit",marker7,showFuelSystem)
addEventHandler("onClientMarkerHit",marker8,showFuelSystem)
addEventHandler("onClientMarkerHit",marker9,showFuelSystem)
addEventHandler("onClientMarkerHit",marker10,showFuelSystem)
addEventHandler("onClientMarkerHit",marker11,showFuelSystem)
addEventHandler("onClientMarkerHit",marker12,showFuelSystem)
addEventHandler("onClientMarkerHit",marker13,showFuelSystem)
addEventHandler("onClientMarkerHit",marker14,showFuelSystem)
addEventHandler("onClientMarkerHit",marker15,showFuelSystem)
addEventHandler("onClientMarkerHit",marker16,showFuelSystem)
addEventHandler("onClientMarkerHit",marker17,showFuelSystem)
addEventHandler("onClientMarkerHit",marker18,showFuelSystem)
addEventHandler("onClientMarkerHit",marker19,showFuelSystem)
addEventHandler("onClientMarkerHit",marker20,showFuelSystem)
addEventHandler("onClientMarkerHit",marker21,showFuelSystem)
addEventHandler("onClientMarkerHit",marker22,showFuelSystem)
addEventHandler("onClientMarkerHit",marker23,showFuelSystem)
addEventHandler("onClientMarkerHit",marker24,showFuelSystem)
addEventHandler("onClientMarkerHit",marker25,showFuelSystem)
addEventHandler("onClientMarkerHit",marker26,showFuelSystem)
addEventHandler("onClientMarkerHit",marker27,showFuelSystem)
addEventHandler("onClientMarkerHit",marker28,showFuelSystem)
addEventHandler("onClientMarkerHit",marker29,showFuelSystem)
addEventHandler("onClientMarkerHit",marker30,showFuelSystem)


function hideTheFuelSystem(hitElement)
removeEventHandler("onClientRender",root,showDx)
setElementData(hitElement,"refuelling",false)
setElementData(hitElement,"price",0)
end
addEventHandler("onClientMarkerLeave",marker1,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker2,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker3,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker4,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker5,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker6,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker7,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker8,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker9,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker10,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker11,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker12,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker13,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker14,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker15,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker16,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker17,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker18,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker19,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker20,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker21,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker22,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker23,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker24,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker25,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker26,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker27,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker28,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker29,hideTheFuelSystem)
addEventHandler("onClientMarkerLeave",marker30,hideTheFuelSystem)

function startRefulling()
local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local fuel = getElementData(veh,"fuel")
		local prices = getElementData(localPlayer,"price")
			if getVehicleEngineState(veh) == false and (not getElementData(veh,"fuel") == false) and getElementData(veh,"fuel") <= MaxFuel and getPlayerMoney(localPlayer) > 0 and getElementData(localPlayer,"refuelling") == true then
				setElementData(veh,"fuel",fuel + increasing)
				setElementData(localPlayer,"price",prices + increasing * price)
				takePlayerMoney(increasing * price)
			end
	end
end
addEventHandler("onClientRender",root,startRefulling)

function onClientResourceStart()
	for k,v in ipairs(getElementsByType("vehicle"))do
		setElementData(v,"fuel",MaxFuel)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,onClientResourceStart)


function setVehicleFuelToZero()
veh = getPedOccupiedVehicle(localPlayer)
	if veh and (not getElementData(veh,"fuel") == false ) and getElementData(veh,"fuel") <= 0 then
		setElementData(veh,"fuel",0)
		setElementData(veh,"run.of.fuel",true)
		setVehicleEngineState(veh,false)
	end
end
addEventHandler("onClientRender",root,setVehicleFuelToZero)


function setPriceTo0()
	if getElementData(localPlayer,"price") == false then
		setElementData(localPlayer,"price",0)
	end
end
addEventHandler("onClientRender",root,setPriceTo0)