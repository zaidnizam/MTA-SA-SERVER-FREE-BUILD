local fuelGaugeWidth = 100 -- Adjust the gauge width based on your UI design

-- Function to draw the fuel gauge
function drawFuelGauge(fuelLevel)
  local gaugeLength = fuelLevel / 100 * fuelGaugeWidth
  dxDrawRectangle(0, 0, fuelGaugeWidth, 5, tocolor(255, 0, 0, 100)) -- Red background
  dxDrawRectangle(0, 0, gaugeLength, 5, tocolor(0, 255, 0, 100)) -- Green fuel bar
  dxDrawText(fuelLevel .. "%", fuelGaugeWidth / 2, 2, tocolor(255, 255, 255, 255), 1, 1, false, false, false) -- Display fuel percentage
end

-- Function to update the fuel gauge based on server data
function updateFuelGauge(vehicle)
  local fuelLevel = getFuelLevelFromSource(vehicle) -- Replace with your logic to get fuel from server
  if fuelLevel then
    drawFuelGauge(fuelLevel)
  end
end

-- Event handler to update fuel gauge when entering a vehicle
addEventHandler("onPlayerEnterVehicle", root, function(vehicle)
  addEvent("updateFuelGaugeClient", vehicle)
end)

-- Event handler to receive fuel level from server and update gauge
addEvent("updateFuelGaugeClient", true)
addEventHandler("updateFuelGaugeClient", root, updateFuelGauge)

-- Function to draw UI (replace with your UI placement logic)
function drawUI()
  dxDrawText("Fuel:", 10, 10, tocolor(255, 255, 255, 255), 1, 1, false, false, false)
  updateFuelGauge(source) -- Replace with the vehicle you want to track
end

addEventHandler("onDraw", root, drawUI)
