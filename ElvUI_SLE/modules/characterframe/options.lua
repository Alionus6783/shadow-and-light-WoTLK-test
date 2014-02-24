local E, L, V, P, G, _ = unpack(ElvUI);
local CFO = E:GetModule('CharacterFrameOptions')

local function configTable()
	E.Options.args.sle.args.characterframeoptions = {
		type = "group",
		name = L["Character Frame"],
		order = 12,
		args = {
			header = {
				order = 1,
				type = "header",
				name = L["Character Frame Options"],
			},
			intro = {
				order = 2,
				type = 'description',
				name = L['CFO_DESC'],
			},
			enable = {
				order = 3,
				type = "toggle",
				name = L["Enable"],
				desc = L["Enable/Disable Character Frame Options"],
				get = function(info) return E.private.sle.characterframeoptions.enable end,
				set = function(info, value) E.private.sle.characterframeoptions.enable = value; E:StaticPopup_Show("PRIVATE_RL") end
			},
			decoration = {
				type = "group",
				name = L["Decoration"],
				order = 55,
				guiInline = true,
				disabled = function() return not E.private.sle.characterframeoptions.enable end,
				args = {
					normalgradient = {
						order = 1,
						type = 'toggle',
						name = L["Show Equipment Gradients"],
						desc = L["Shows gradient effect for all equipment slots."],
						get = function(info) return E.db.sle.characterframeoptions.shownormalgradient end,
						set = function(info, value) E.db.sle.characterframeoptions.shownormalgradient = value; CFO:ChangeGradiantVisibility(); end,
					},
					errorgradient = {
						order = 2,
						type = 'toggle',
						name = L["Show Error Gradients"],
						desc = L["Highlights equipment slot if an error has been found."],
						disabled = function() return not E.private.sle.characterframeoptions.enable or not E.db.sle.characterframeoptions.shownormalgradient end,
						get = function(info) return E.db.sle.characterframeoptions.showerrorgradient end,
						set = function(info, value) E.db.sle.characterframeoptions.showerrorgradient = value; CFO:ArmoryFrame_DataSetting(); end,
					},
					bgimage = {
						order = 3,
						type = 'toggle',
						name = L["Show Background Image"],
						--desc = L["Highlights equipment slot if an error has been found."],
						get = function(info) return E.db.sle.characterframeoptions.showimage end,
						set = function(info, value) E.db.sle.characterframeoptions.showimage = value; CFO:ArmoryFrame_DataSetting(); end,
					},
				},
			},
			itemlevel = {
				type = "group",
				name = STAT_AVERAGE_ITEM_LEVEL,
				order = 66,
				guiInline = true,
				disabled = function() return not E.private.sle.characterframeoptions.enable end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						--desc = L["Show/Hide Item Levels"],
						get = function(info) return E.db.sle.characterframeoptions.itemlevel.enable end,
						set = function(info, value) E.db.sle.characterframeoptions.itemlevel.enable = value; CFO:ToggleCFO() end
					},
					fontGroup = {
						order = 2,
						type = 'group',
						guiInline = true,
						disabled = true,
						--disabled = function() return not E.db.sle.characterframeoptions.itemlevel.enable end,
						name = L['Font'],
						args = {
							font = {
								type = "select", dialogControl = 'LSM30_Font',
								order = 1,
								--name = L["Fonts"],
								name = L["Font"],
								desc = L["The font that the item level will use."],
								values = AceGUIWidgetLSMlists.font,	
								get = function(info) return E.db.sle.characterframeoptions.itemlevel.font end,
								set = function(info, value) E.db.sle.characterframeoptions.itemlevel.font = value; CFO:UpdateItemLevelFont(); end,
							},
							fontSize = {
								order = 2,
								name = L["Font Size"],
								desc = L["Set the font size that the item level will use."],
								type = "range",
								min = 6, max = 22, step = 1,
								get = function(info) return E.db.sle.characterframeoptions.itemlevel.fontSize end,
								set = function(info, value) E.db.sle.characterframeoptions.itemlevel.fontSize = value; CFO:UpdateItemLevelFont(); end,
							},
							fontOutline = {
								order = 3,
								name = L["Font Outline"],
								desc = L["Set the font outline that the item level will use."],
								type = "select",
								values = {
									['NONE'] = L['None'],
									['OUTLINE'] = 'OUTLINE',
									['MONOCHROME'] = 'MONOCHROME',
									['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
									['THICKOUTLINE'] = 'THICKOUTLINE',
								},
								get = function(info) return E.db.sle.characterframeoptions.itemlevel.fontOutline end,
								set = function(info, value) E.db.sle.characterframeoptions.itemlevel.fontOutline = value; CFO:UpdateItemLevelFont(); end,
							},
						},
					},
				},
			},
			itemdurabilty = {
				type = "group",
				--name = L["Item Durability"],
				name = DURABILITY,
				order = 77,
				guiInline = true,
				disabled = function() return not E.private.sle.characterframeoptions.enable end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						--desc = L["Show/Hide Item Durability"],
						get = function(info) return E.db.sle.characterframeoptions.itemdurability.enable end,
						set = function(info, value) E.db.sle.characterframeoptions.itemdurability.enable = value; CFO:ToggleCFO() end,
					},
					fontGroup = {
						order = 2,
						type = 'group',
						guiInline = true,
						disabled = true,
						--disabled = function() return not E.db.sle.characterframeoptions.itemdurability.enable end,
						name = L['Font'],
						args = {
							font = {
								type = "select", dialogControl = 'LSM30_Font',
								order = 1,
								name = L["Font"],
								desc = L["The font that the item durability will use."],
								values = AceGUIWidgetLSMlists.font,	
								get = function(info) return E.db.sle.characterframeoptions.itemdurability.font end,
								set = function(info, value) E.db.sle.characterframeoptions.itemdurability.font = value; CFO:UpdateItemDurabilityFont(); end,
							},
							fontSize = {
								order = 2,
								name = L["Font Size"],
								desc = L["Set the font size that the item durability will use."],
								type = "range",
								min = 6, max = 22, step = 1,
								get = function(info) return E.db.sle.characterframeoptions.itemdurability.fontSize end,
								set = function(info, value) E.db.sle.characterframeoptions.itemdurability.fontSize = value; CFO:UpdateItemDurabilityFont(); end,
							},
							fontOutline = {
								order = 3,
								name = L["Font Outline"],
								desc = L["Set the font outline that the item durability will use."],
								type = "select",
								values = {
									['NONE'] = L['None'],
									['OUTLINE'] = 'OUTLINE',
									['MONOCHROME'] = 'MONOCHROME',
									['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
									['THICKOUTLINE'] = 'THICKOUTLINE',
								},
								get = function(info) return E.db.sle.characterframeoptions.itemdurability.fontOutline end,
								set = function(info, value) E.db.sle.characterframeoptions.itemdurability.fontOutline = value; CFO:UpdateItemDurabilityFont(); end,
							},
						},
					},
				},
			},
			itemenchant = {
				type = "group",
				name = L["Enchanting"],
				--name = DURABILITY,
				order = 88,
				guiInline = true,
				disabled = function() return not E.private.sle.characterframeoptions.enable end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						--desc = L["Show/Hide Item Durability"],
						get = function(info) return E.db.sle.characterframeoptions.itemenchant.enable end,
						set = function(info, value) E.db.sle.characterframeoptions.itemenchant.enable = value; CFO:ToggleCFO() end,
					},
					fontGroup = {
						order = 2,
						type = 'group',
						guiInline = true,
						disabled = true,
						--disabled = function() return not E.db.sle.characterframeoptions.itemenchant.enable end,
						name = L['Font'],
						args = {
							font = {
								type = "select", dialogControl = 'LSM30_Font',
								order = 1,
								name = L["Font"],
								desc = L["The font that the enchant notification will use."],
								values = AceGUIWidgetLSMlists.font,	
								get = function(info) return E.db.sle.characterframeoptions.itemenchant.font end,
								set = function(info, value) E.db.sle.characterframeoptions.itemenchant.font = value; CFO:UpdateItemEnchantFont(); end,
							},
							fontSize = {
								order = 2,
								name = L["Font Size"],
								desc = L["Set the font size that the enchant notification will use."],
								type = "range",
								min = 6, max = 22, step = 1,
								get = function(info) return E.db.sle.characterframeoptions.itemenchant.fontSize end,
								set = function(info, value) E.db.sle.characterframeoptions.itemenchant.fontSize = value; CFO:UpdateItemEnchantFont(); end,
							},
							fontOutline = {
								order = 3,
								name = L["Font Outline"],
								desc = L["Set the font outline that the enchant notification will use."],
								type = "select",
								values = {
									['NONE'] = L['None'],
									['OUTLINE'] = 'OUTLINE',
									['MONOCHROME'] = 'MONOCHROME',
									['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
									['THICKOUTLINE'] = 'THICKOUTLINE',
								},
								get = function(info) return E.db.sle.characterframeoptions.itemenchant.fontOutline end,
								set = function(info, value) E.db.sle.characterframeoptions.itemenchant.fontOutline = value; CFO:UpdateItemEnchantFont(); end,
							},
						},
					},
					warningGroup = {
						order = 3,
						type = 'group',
						guiInline = true,
						--disabled = function () return not E.db.sle.characterframeoptions.itemenchant.enable end,
						name = L['Enchant Warning'],
						args = {
							showwarning = {
								order = 1,
								type = "toggle",
								name = L["Show Enchant Warning"],
								get = function(info) return E.db.sle.characterframeoptions.itemenchant.showwarning end,
								set = function(info, value) E.db.sle.characterframeoptions.itemenchant.showwarning = value; CFO:ArmoryFrame_DataSetting(); end,
							},
							warningsize = {
								order = 2,
								name = L["Warning Size"],
								desc = L["Set the icon size that the warning notification will use."],
								type = "range",
								min = 8, max = 18, step = 1,
								get = function(info) return E.db.sle.characterframeoptions.itemenchant.warningSize end,
								set = function(info, value) E.db.sle.characterframeoptions.itemenchant.warningSize = value; CFO:ResizeErrorIcon(); end,
							},
						},
					},
				},
			},
			itemgem = {
				type = "group",
				name = L["Gem Sockets"],
				order = 99,
				guiInline = true,
				disabled = function() return not E.private.sle.characterframeoptions.enable end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						--desc = L["Show/Hide Item Durability"],
						get = function(info) return E.db.sle.characterframeoptions.itemgem.enable end,
						set = function(info, value) E.db.sle.characterframeoptions.itemgem.enable = value; --[[CFO:ToggleCFO()]] end,
					},
					warningGroup = {
						order = 2,
						type = 'group',
						guiInline = true,
						disabled = function () return not E.db.sle.characterframeoptions.itemgem.enable end,
						name = L['Socket Warning'],
						args = {
							showwarning = {
								order = 1,
								type = "toggle",
								name = L["Show Gem Warning"],
								get = function(info) return E.db.sle.characterframeoptions.itemgem.showwarning end,
								set = function(info, value) E.db.sle.characterframeoptions.itemgem.showwarning = value; CFO:ArmoryFrame_DataSetting(); end,
							},
							warningsize = {
								order = 2,
								name = L["Warning Size"],
								desc = L["Set the icon size that the warning notification will use."],
								type = "range",
								min = 8, max = 18, step = 1,
								get = function(info) return E.db.sle.characterframeoptions.itemgem.warningSize end,
								set = function(info, value) E.db.sle.characterframeoptions.itemgem.warningSize = value; CFO:ResizeErrorIcon(); end,
							},
						},
					},
				},
			},
		},
	}
end

table.insert(E.SLEConfigs, configTable)