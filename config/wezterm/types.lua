---@meta

---@class Wezterm
---@field action table<string, function>
---@field action_callback fun(function)
---@field color table
---@field color_scheme string
---@field config_builder fun():table
---@field font table
---@field font_with_fallback fun(table):table
---@field format fun(table):string
---@field gui table
---@field pad_left fun(string, integer):string
---@field nerdfonts table<string,string>
---@field on fun(string, function)
---@field pad_right fun(string, integer):string
---@field default_hyperlink_rules fun():table
