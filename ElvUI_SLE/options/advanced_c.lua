﻿local SLE, _, E, L = unpack(select(2, ...))

--GLOBALS: unpack, select, tinsert
local tinsert = tinsert

L["SLE_CYR_COM_DESC"] = [[
- /rl
- /in
- /ec
- /elvui
- /bgstats
- /hellokitty
- /hellokittyfix
- /harlemshake
- /egrid
- /moveui
- /resetui
- /kb]]
L["SLE_CYR_DEVCOM_DESC"] = [[
- /luaerror
- /frame
- /framelist
- /texlist
- /cpuimpact
- /cpuusage
- /enableblizzard]]

local function configTable()
	if not SLE.initialized then return end
	--Main options group
	E.Options.args.sle.args.advanced = {
		type = "group",
		name = L["Advanced Options"],
		order = 100,
		get = function(info) return E.global.sle.advanced[ info[#info] ] end,
		set = function(info, value) E.global.sle.advanced[ info[#info] ] = value; end,
		args = {
			header = E.Libs.ACH:Header(L["Advanced Options"], 1),
			info = {
				order = 2,
				type = "description",
				name = L["SLE_Advanced_Desc"],
			},
			general = {
				order = 3,
				type = "toggle",
				name = L["Allow Advanced Options"],
				set = function(info, value)
					if value == true and not E.global.sle.advanced.confirmed then E:StaticPopup_Show("SLE_ADVANCED_POPUP"); return end
					E.global.sle.advanced[ info[#info] ] = value;
				end,
			},
			optionsLimits = {
				order = 4,
				type = "toggle",
				name = L["Change Elv's options limits"],
				desc = L["Allow |cff9482c9Shadow & Light|r to change some of ElvUI's options limits."],
				disabled = function() return not E.global.sle.advanced.general end,
				set = function(info, value) E.global.sle.advanced[ info[#info] ] = value; E:StaticPopup_Show("GLOBAL_RL") end,
			},
			gameMenu = {
				order = 10,
				type = "group",
				name = L["Game Menu Buttons"],
				guiInline = true,
				hidden = function() return not E.global.sle.advanced.general end,
				disabled = function() return not E.global.sle.advanced.gameMenu.enable end,
				get = function(info) return E.global.sle.advanced.gameMenu[ info[#info] ] end,
				set = function(info, value) E.global.sle.advanced.gameMenu[ info[#info] ] = value; E:StaticPopup_Show("GLOBAL_RL") end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Adds |cff9482c9Shadow & Light|r buttons to main game menu."],
						disabled = false,
					},
					reload = {
						order = 2,
						type = "toggle",
						name = L["Reload UI"],
					},
				},
			},
			cyrillics = {
				order = 20,
				type = "group",
				name = L["Cyrillics Support"],
				guiInline = true,
				hidden = function() return not E.global.sle.advanced.general end,
				get = function(info) return E.global.sle.advanced.cyrillics[ info[#info] ] end,
				set = function(info, value) E.global.sle.advanced.cyrillics[ info[#info] ] = value; E:StaticPopup_Show("GLOBAL_RL") end,
				args = {
					info = {
						order = 1,
						type = "description",
						name = L["SLE_CYR_DESC"],
					},
					commands = {
						order = 2,
						type = "toggle",
						name = L["Commands"],
						desc = L["SLE_CYR_COM_DESC"],
						descStyle = "inline",
						width = "full",
					},
					devCommandsInfo = {
						order = 3,
						type = "description",
						name = L["SLE_CYR_DEV_DESC"],
					},
					devCommands = {
						order = 4,
						type = "toggle",
						name = L["Dev Commands"],
						desc = L["SLE_CYR_DEVCOM_DESC"],
						descStyle = "inline",
						width = "full",
					},
				},
			},
		},
	}
end

tinsert(SLE.Configs, configTable)