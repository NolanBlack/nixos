local colors_name = "gruvbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
	palette = util.palette_extend({
		bg = hsluv "#fbf1c7",
		fg = hsluv "#3c3836",
		rose = hsluv "#9d0006",
		leaf = hsluv "#79740e",
		wood = hsluv "#b57614",
		water = hsluv "#076678",
		blossom = hsluv "#8f3f71",
		sky = hsluv "#427b58",
	}, bg)
else
	palette = util.palette_extend({
		bg = hsluv "#282828", -- black
		fg = hsluv "#ebdbb2", -- tan
		rose = hsluv "#fb4934", -- light red
		leaf = hsluv "#b8bb26", -- light green
		wood = hsluv "#fabd2f", -- light yellow
		water = hsluv "#83a598", -- light blue
		blossom = hsluv "#d3869b", -- light purple
		sky = hsluv "#83c07c", -- green
	}, bg)
	-- palette = util.palette_extend({
	-- 	bg = hsluv "#282828", -- black
	-- 	fg = hsluv "#ebdbb2", -- tan
	-- 	rose = hsluv "#cc241d", -- light red
	-- 	leaf = hsluv "#98971a", -- light green
	-- 	wood = hsluv "#d79921", -- light yellow
	-- 	water = hsluv "#458588", -- light blue
	-- 	blossom = hsluv "#b16286", -- light purple
	-- 	sky = hsluv "#83c07c", -- green
	-- }, bg)
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { base_specs.Statement, fg = palette.rose },
		Special { fg = palette.water },
		Type { fg = palette.sky, gui = "italic" },
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)

vim.cmd("colorscheme gruvbones")

