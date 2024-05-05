local vehicles = {} -- Stores vehicle fuel data (replace with a more robust storage mechanism)

-- Function to set a vehicle's fuel level (replace with your logic)
function setVehicleFuel(vehicle, fuelLevel)
  vehicles[vehicle] = fuelLevel
end

-- Function to get a vehicle's fuel level (replace with your logic)
function getVehicleFuel(vehicle)
  return vehicles[vehicle] or 100 -- Default fuel if not set
end

-- Event handler to update fuel based on gameplay logic (replace with your fuel consumption logic)
addEvent("onVehicleDamage", true)
addEventHandler("onVehicleDamage", root, function(vehicle, component, damagetype, destroyed, perpetrator)
  if component == DAMAGE_ENGINE then -- Adjust condition based on your fuel consumption logic
    local currentFuel = getVehicleFuel(vehicle)
    local newFuel = currentFuel - 10 -- Adjust fuel decrease per damage
    setVehicleFuel(vehicle, math.max(0, newFuel)) -- Ensure fuel doesn't go below 0
  end
end)
