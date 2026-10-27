require "util"

-- Initialize UI buttons and labels
function ui() 
    for _, player in pairs(game.players) do
        update_gui_visibility(player)
    end
end

-- Update GUI visibility based on player settings
function update_gui_visibility(player)
    local show_gui = settings.get_player_settings(player)["show_speed_control_gui"].value
    
    -- Remove existing GUI elements if they exist
    local elements = {"decrease2", "decrease", "decrease1", "display", "increase1", "increase", "increase2"}
    for _, element in ipairs(elements) do
        if player.gui.top[element] then
            player.gui.top[element].destroy()
        end
    end
    
    -- Only create GUI elements if show_gui is true
    if show_gui then
        player.gui.top.add{name = "decrease2", type = "button", caption = "<", style="sc_fentus_button"}
        player.gui.top.add{name = "decrease", type = "button", caption = "<<", style="sc_fentus_button"}
        player.gui.top.add{name = "decrease1", type = "button", caption = "<<<", style="sc_fentus_button"}
        player.gui.top.add{name = "display", type = "label", caption = "Speed "..format_num(game.speed, 2, "x", ""), style="fentus_label"}
        player.gui.top.add{name = "increase1", type = "button", caption = ">>>", style="sc_fentus_button"}
        player.gui.top.add{name = "increase", type = "button", caption = ">>", style="sc_fentus_button"}
        player.gui.top.add{name = "increase2", type = "button", caption = ">", style="sc_fentus_button"}
    end
end

-- Initialize the UI when configuration changes or player joins
script.on_configuration_changed(ui)
script.on_event(defines.events.on_player_joined_game, ui)

-- Handle runtime setting changes
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if event.setting == "show_speed_control_gui" then
        local player = game.players[event.player_index]
        update_gui_visibility(player)
    end
end)

-- Event handler for button clicks and display resets
script.on_event(defines.events.on_gui_click, function(event)
    local player = game.players[event.player_index]
    if event.element.name == "decrease2" then speed(player, settings.get_player_settings(player)["speed_increment_decrease2"].value) end
    if event.element.name == "decrease" then speed(player, settings.get_player_settings(player)["speed_increment_decrease"].value) end
    if event.element.name == "decrease1" then speed(player, settings.get_player_settings(player)["speed_increment_decrease1"].value) end
    if event.element.name == "increase1" then speed(player, settings.get_player_settings(player)["speed_increment_increase1"].value) end
    if event.element.name == "increase" then speed(player, settings.get_player_settings(player)["speed_increment_increase"].value) end
    if event.element.name == "increase2" then speed(player, settings.get_player_settings(player)["speed_increment_increase2"].value) end

    -- Reset speed to 1 when the speed label is clicked
    if event.element.name == "display" then
        game.speed = 1
        update_speed_display()
    end
end)

-- Speed adjustment function with clamping and updated limits
function speed(player, adjust)
    -- Clamp speed between new min (0.001) and max (25)
    game.speed = math.clamp(game.speed + adjust, 0.100, 25)
    update_speed_display()
end

-- Update the speed display for all players
function update_speed_display()
    for _, player in pairs(game.players) do
        if player.gui.top.display then
            player.gui.top.display.caption = "Speed " .. format_num(game.speed, 3, "x", "")
        end
    end
end

-- Format numbers with comma separators and decimal points
function format_num(amount, decimal, prefix, neg_prefix)
    decimal = decimal or 2
    neg_prefix = neg_prefix or "-"
    
    local famount = math.abs(round(amount, decimal))
    local remain = round(math.abs(amount) - math.floor(famount), decimal)
    local formatted = comma_value(math.floor(famount))
    
    if decimal > 0 then
        remain = string.sub(tostring(remain), 3)
        formatted = formatted .. "." .. remain .. string.rep("0", decimal - string.len(remain))
    end
    
    formatted = (prefix or "") .. formatted
    if amount < 0 then
        formatted = (neg_prefix == "()" and "(" .. formatted .. ")" or neg_prefix .. formatted)
    end
    return formatted
end

-- Round a value to the nearest decimal places
function round(val, decimal)
    return decimal and math.floor((val * 10^decimal) + 0.5) / 10^decimal or math.floor(val + 0.5)
end

-- Format numbers with comma separators
function comma_value(amount)
    local formatted = tostring(amount)
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

-- Clamp value between lower and upper bounds
function math.clamp(val, lower, upper)
    return math.max(lower, math.min(upper, val))
end

-- Bind hotkey events to speed functions
script.on_event("decrease2", function(event)
    local player = game.players[event.player_index]
    speed(player, settings.get_player_settings(player)["speed_increment_decrease2"].value)
end)
script.on_event("decrease", function(event)
    local player = game.players[event.player_index]
    speed(player, settings.get_player_settings(player)["speed_increment_decrease"].value)
end)
script.on_event("decrease1", function(event)
    local player = game.players[event.player_index]
    speed(player, settings.get_player_settings(player)["speed_increment_decrease1"].value)
end)
script.on_event("increase1", function(event)
    local player = game.players[event.player_index]
    speed(player, settings.get_player_settings(player)["speed_increment_increase1"].value)
end)
script.on_event("increase", function(event)
    local player = game.players[event.player_index]
    speed(player, settings.get_player_settings(player)["speed_increment_increase"].value)
end)
script.on_event("increase2", function(event)
    local player = game.players[event.player_index]
    speed(player, settings.get_player_settings(player)["speed_increment_increase2"].value)
end)