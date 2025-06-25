-- mod-version:3 -- lite-xl 2.1

local config = require("core.config")
local common = require("core.common")
local style = require("core.style")
local TreeView = require("plugins.treeview")
local ToolbarView = require("plugins.toolbarview")

local function get_plugin_directory()
	local paths = {
		USERDIR .. PATHSEP .. "plugins" .. PATHSEP .. "maketoolbar",
		DATADIR .. PATHSEP .. "plugins" .. PATHSEP .. "maketoolbar",
	}
	for i, v in ipairs(paths) do
		if system.get_file_info(v) then
			return v
		end
	end
	return nil
end

local Toolbar = ToolbarView:extend()

-- the "command" module will help us register commands for our plugin.
local command = require("core.command")
-- local Terminal = require("plugins.terminal")
-- local TerminalView = require("plugins.terminal")

local executeInBash = function(bashCommand)
	-- Debug
	print("makecommands ejecutado")
	-- Esto asegura que el terminal esté visible
	-- if not core.terminal_view then
	-- 	print("terminal no está abierto, intentando abrirlo...")
	-- 	command.perform("terminal:toggle-drawer")
	-- end
	command.perform("terminal:execute", bashCommand)
end

-- local commandList = { "make clean syn", "make clean c-build", "make config", "make sym", "make clean", "make help" }
--
-- command.add(nil, {
-- 	["make:1"] = function()
-- 		executeInBash(commandList[1])
-- 	end,
-- 	["make:2"] = function()
-- 		executeInBash(commandList[2])
-- 	end,
-- 	["make:3"] = function()
-- 		executeInBash(commandList[3])
-- 	end,
-- 	["make:4"] = function()
-- 		executeInBash(commandList[4])
-- 	end,
-- 	["make:5"] = function()
-- 		executeInBash(commandList[5])
-- 	end,
-- 	["make:6"] = function()
-- 		executeInBash(commandList[6])
-- 	end,
-- })

local commandList = {
	{ label = "synthesis", command = "make clean syn" },
	{ label = "firmware", command = "make clean c-build" },
	{ label = "config", command = "config" },
	{ label = "Simulation", command = "sym" },
	{ label = "diagram", command = "rtl" },
	{ label = "help", command = "help" },
}

command.add(nil, {
	[commandList[1].label] = function()
		executeInBash(commandList[1].command)
	end,
	[commandList[2].label] = function()
		executeInBash(commandList[2].command)
	end,
	[commandList[3].label] = function()
		executeInBash(commandList[3].command)
	end,
	[commandList[4].label] = function()
		executeInBash(commandList[4].command)
	end,
	[commandList[5].label] = function()
		executeInBash(commandList[5].command)
	end,
	[commandList[6].label] = function()
		executeInBash(commandList[6].command)
	end,
	-- ["make:2"] = function()
	-- 	executeInBash(commandList[2])
	-- end,
	-- ["make:3"] = function()
	-- 	executeInBash(commandList[3])
	-- end,
	-- ["make:4"] = function()
	-- 	executeInBash(commandList[4])
	-- end,
	-- ["make:5"] = function()
	-- 	executeInBash(commandList[5])
	-- end,
	-- ["make:6"] = function()
	-- 	executeInBash(commandList[6])
	-- end,
})

function Toolbar:new()
	Toolbar.super.new(self)
	self.toolbar_font =
		renderer.font.load(get_plugin_directory() .. PATHSEP .. "maketoolbar.ttf", style.icon_big_font:get_size())
	self.toolbar_commands = {
		{ symbol = "", command = commandList[1].label },
		{ symbol = "", command = commandList[2].label },
		{ symbol = "", command = commandList[3].label },
		{ symbol = "", command = commandList[4].label },
		{ symbol = "", command = commandList[5].label },
		{ symbol = "", command = commandList[6].label },
	}
end

local toolbar = {}

toolbar.example_toolbar_view = Toolbar()
toolbar.example_toolbar_node = TreeView.node.b:split("up", toolbar.example_toolbar_view, { y = true })

return toolbar
