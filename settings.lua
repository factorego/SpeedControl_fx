-- Mod settings to allow users to configure speed increments
data:extend({
    {
        type = "bool-setting",
        name = "show_speed_control_gui",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "a"
    },
    {
        type = "double-setting",
        name = "speed_increment_decrease1",
        setting_type = "runtime-per-user",
        default_value = -1,
        minimum_value = -25,
        maximum_value = -0.001,
        order = "b"
    },
    {
        type = "double-setting",
        name = "speed_increment_decrease",
        setting_type = "runtime-per-user",
        default_value = -0.1,
        minimum_value = -25,
        maximum_value = -0.001,
        order = "c"
    },
    {
        type = "double-setting",
        name = "speed_increment_decrease2",
        setting_type = "runtime-per-user",
        default_value = -0.01,
        minimum_value = -25,
        maximum_value = -0.001,
        order = "d"
    },
    {
        type = "double-setting",
        name = "speed_increment_increase2",
        setting_type = "runtime-per-user",
        default_value = 0.01,
        minimum_value = 0.001,
        maximum_value = 25,
        order = "e"
    },
    {
        type = "double-setting",
        name = "speed_increment_increase",
        setting_type = "runtime-per-user",
        default_value = 0.1,
        minimum_value = 0.001,
        maximum_value = 25,
        order = "f"
    },
    {
        type = "double-setting",
        name = "speed_increment_increase1",
        setting_type = "runtime-per-user",
        default_value = 1,
        minimum_value = 0.001,
        maximum_value = 25,
        order = "g"
    }
})