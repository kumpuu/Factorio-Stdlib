--- This module is a work in progress
-- @module Data
-- @alias Core

--- Core Functions
-- @section Core

local Core = require 'stdlib/core'
if _G.remote and _G.script then
    error("Data Modules can only be required in the data stage", 2)
end

Core.default_options = {
    ["silent"] = false,
    ["fail"] = false,
    ['verbose'] = false,
}

local function get_options(...)
    local tuple = {}
    for _, arg in ipairs({...}) do
        tuple[#tuple + 1] = Core.default_options[arg] or false
    end
    return table.unpack(tuple)
end

function Core.log(msg)
    local silent, fail = get_options("silent", "fail")
    return (fail and error(msg, 2)) or not silent and log(msg)
end

--- Quick to use empty picture.
-- @treturn table an empty pictures table
function Core.empty_picture()
    return {
        filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        width = 1,
        height = 1
    }
end

--- Quick to use empty pictures.
-- @treturn table an empty pictures table
function Core.empty_pictures()
    local empty = Core.empty_picture()
    return {
        filename = empty.filename,
        width = empty.width,
        height = empty.height,
        line_length = 1,
        frame_count = 1,
        shift = { 0, 0},
        animation_speed = 1,
        direction_count=1
    }
end

--- Quick to use empty animation.
-- @treturn table an empty animations table
function Core.empty_animations()
    return {
        Core.empty_pictures()
    }
end

--- Quick to use empty connections table.
-- @tparam int count how many connection points are needed
-- @treturn table an empty pictures table
function Core.empty_connection_points(count)
    local points = {}
    for i = 1, count or 1, 1 do
        points[i] = {
            shadow =
            {
                copper = {0, 0},
                green = {0, 0},
                red = {0, 0}
            },
            wire =
            {
                copper = {0, 0},
                green = {0, 0},
                red = {0, 0}
            }
        }
    end
    return points
end

-- render layers
-- "tile-transition", "resource", "decorative", "remnants", "floor", "transport-belt-endings", "corpse",
-- "floor-mechanics", "item", "lower-object", "object", "higher-object-above", "higher-object-under",
-- "wires", "lower-radius-visualization", "radius-visualization", "entity-info-icon", "explosion",
-- "projectile", "smoke", "air-object", "air-entity-info-con", "light-effect", "selection-box", "arrow", "cursor"

-- collision masks
-- "ground-tile", "water-tile", "resource-layer", "floor-layer", "item-layer",
-- "object-layer", "player-layer", "ghost-layer", "doodad-layer", "not-colliding-with-itself"

return Core
