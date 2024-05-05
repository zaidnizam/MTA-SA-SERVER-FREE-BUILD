-- Define the path to the map file
local mapFilePath = "maps/interiors.map"

-- Function to load and parse the map file
function loadMapData()
    -- Attempt to open the map file
    local file = fileOpen(mapFilePath)
    if not file then
        outputDebugString("Failed to open map file: " .. mapFilePath)
        return
    end
    
    -- Read the contents of the file
    local mapData = fileRead(file, fileGetSize(file))
    fileClose(file)
    
    -- Parse the map data
    parseMapData(mapData)
end

-- Function to load interior data from the map file
function parseMapData(mapData)
    -- Parse the XML data
    local mapXml = xmlLoadString(mapData)
    if not mapXml then
        outputDebugString("Failed to parse map data.")
        return
    end
    
    -- Get all interior elements from the map XML
    local interiorElements = xmlNodeGetChildren(mapXml)
    if not interiorElements then
        outputDebugString("No interior elements found in the map data.")
        xmlUnloadFile(mapXml)
        return
    end
    
    -- Iterate over each interior element
    for _, interiorNode in ipairs(interiorElements) do
        -- Check if the node is an interior element
        if xmlNodeGetName(interiorNode) == "interior" then
            -- Extract id, x, y, z, and marker attributes from the interior node
            local id = xmlNodeGetAttribute(interiorNode, "id")
            local x = tonumber(xmlNodeGetAttribute(interiorNode, "posX"))
            local y = tonumber(xmlNodeGetAttribute(interiorNode, "posY"))
            local z = tonumber(xmlNodeGetAttribute(interiorNode, "posZ"))
            local marker = xmlNodeGetAttribute(interiorNode, "marker")  -- No need to convert to number
            
            -- Output the extracted data for testing
            if marker then
                outputDebugString("ID: " .. id .. ", X: " .. x .. ", Y: " .. y .. ", Z: " .. z .. ", Marker: " .. marker)
            else
                outputDebugString("ID: " .. id .. ", X: " .. x .. ", Y: " .. y .. ", Z: " .. z .. ", No Marker Found")
            end
            
            -- Create a blip for the interior if marker exists
            if marker then
                local blip = createBlip(x, y, z, marker, 2, 255, 0, 0, 255, 0, 1200)  -- Adjust parameters as needed
            end
        end
    end
    
    -- Unload the map XML data
    xmlUnloadFile(mapXml)
end

-- Load the map data when the resource starts
addEventHandler("onResourceStart", resourceRoot, loadMapData)


-- Define the path to the map file
local shopFilePath = "maps/shops.map"

-- Function to load and parse the map file
function loadShopData()
    -- Attempt to open the map file
    local file = fileOpen(shopFilePath)
    if not file then
        outputDebugString("Failed to open map file: " .. shopFilePath)
        return
    end
    
    -- Read the contents of the file
    local shopData = fileRead(file, fileGetSize(file))
    fileClose(file)
    
    -- Parse the map data
    parseShopData(shopData)
end

-- Function to load interior data from the map file
function parseShopData(shopData)
    -- Parse the XML data
    local shopXml = xmlLoadString(shopData)
    if not shopXml then
        outputDebugString("Failed to parse map data.")
        return
    end
    
    -- Get all interior elements from the map XML
    local interiorElements = xmlNodeGetChildren(shopXml)
    if not interiorElements then
        outputDebugString("No interior elements found in the map data.")
        xmlUnloadFile(shopXml)
        return
    end
    
    -- Iterate over each interior element
    for _, interiorNode in ipairs(interiorElements) do
        -- Check if the node is an interior element
        if xmlNodeGetName(interiorNode) == "interior" then
            -- Extract x, y and z attributes from the interior node
            local x = tonumber(xmlNodeGetAttribute(interiorNode, "posX"))
            local y = tonumber(xmlNodeGetAttribute(interiorNode, "posY"))
            local z = tonumber(xmlNodeGetAttribute(interiorNode, "posZ"))
    
            -- outputDebugString(" X: " .. x .. ", Y: " .. y .. ", Z: " .. z)

            -- Create a blip for the interior if marker exists
            if marker then
                local marker = createMarker(x, y, z, "cylinder", 5, 0, 255, 0, 200)  -- Adjust parameters as needed
            end
        end
    end
    
    -- Unload the map XML data
    xmlUnloadFile(shopXml)
end

-- Load the map data when the resource starts
addEventHandler("onResourceStart", resourceRoot, loadShopData)


