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
	{ label = "build_firmware", command = "make c-clean c-build" },
	{ label = "config", command = "make config" },
	{ label = "Simulation", command = "make sim" },
	{ label = "diagram", command = "make rtl" },
	{ label = "help", command = "make help" },
}

-- local symbolList = {
-- 	{ name = "play", icon = "" }, -- 1
-- 	{ name = "download", icon = "" },
-- 	{ name = "trash", icon = "" },
-- 	{ name = "restart", icon = "" },
-- 	{ name = "scissors", icon = "" }, -- 5
-- 	{ name = "search", icon = "" },
-- 	{ name = "check", icon = "" },
-- 	{ name = "build", icon = "" },
-- 	{ name = "wrench", icon = "" },
-- 	{ name = "gear", icon = "" }, -- 10
-- 	{ name = "eject", icon = "" },
-- 	{ name = "stop", icon = "" },
-- 	{ name = "pause", icon = "" },
-- 	{ name = "docs", icon = "" },
-- 	{ name = "checkbox", icon = "" }, -- 15
-- 	{ name = "upload", icon = "" },
-- 	{ name = "download1", icon = "" },
-- 	{ name = "keyboard", icon = "" },
-- 	{ name = "merge", icon = "" },
-- 	{ name = "download2", icon = "" }, -- 20
-- 	{ name = "git1", icon = "" },
-- 	{ name = "branch", icon = "" },
-- 	{ name = "git2", icon = "" },
-- 	{ name = "git3", icon = "" },
-- 	{ name = "git4", icon = "" }, -- 25
-- 	{ name = "terminal_dark", icon = "" },
-- 	{ name = "magic", icon = "" },
-- 	{ name = "oddometer", icon = "" },
-- 	{ name = "git5", icon = "" },
-- 	{ name = "terminal_light", icon = "" }, -- 30
-- 	{ name = "question", icon = "" },
-- 	{ name = "block", icon = "" },
-- 	{ name = "penguin", icon = "" },
-- 	{ name = "bug", icon = "" },
-- 	{ name = "pdf", icon = "" }, -- 35
-- 	{ name = "img", icon = "" },
-- 	{ name = "git", icon = "" },
-- 	{ name = "connect", icon = "" },
-- 	{ name = "desktop", icon = "" },
-- 	{ name = "usb", icon = "" }, -- 40
-- 	{ name = "hash", icon = "" },
-- 	{ name = "bluetooth", icon = "" },
-- 	{ name = "chip", icon = "" },
-- }

local symbolList = {
	play = "", -- 1
	download = "",
	trash = "",
	restart = "",
	scissors = "", -- 5
	search = "",
	check = "",
	build = "",
	wrench = "",
	gear = "", -- 10
	eject = "",
	stop = "",
	pause = "",
	docs = "",
	checkbox = "", -- 15
	upload = "",
	download1 = "",
	keyboard = "",
	merge = "",
	download2 = "", -- 20
	git1 = "",
	branch = "",
	git2 = "",
	git3 = "",
	git4 = "", -- 25
	terminal_dark = "",
	magic = "",
	oddometer = "",
	git5 = "",
	terminal_light = "", -- 30
	question = "",
	block = "",
	penguin = "",
	bug = "",
	pdf = "", -- 35
	img = "",
	git = "",
	connect = "",
	desktop = "",
	usb = "", -- 40
	hash = "",
	bluetooth = "",
	chip = "",
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
		{ symbol = symbolList.chip, command = commandList[1].label },
		{ symbol = symbolList.build, command = commandList[2].label },
		{ symbol = symbolList.download, command = commandList[3].label },
		{ symbol = symbolList.bug, command = commandList[4].label },
		{ symbol = symbolList.block, command = commandList[5].label },
		{ symbol = symbolList.question, command = commandList[6].label },
	}
end

local toolbar = {}

toolbar.example_toolbar_view = Toolbar()
toolbar.example_toolbar_node = TreeView.node.b:split("up", toolbar.example_toolbar_view, { y = true })

return toolbar
