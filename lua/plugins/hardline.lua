--- Returns a string with the mode.
--- @return string
local function get_mode()
  local common = require("hardline.common")
  local mode = common.modes[vim.fn.mode()] or common.modes["?"]
  return mode.text
end

-- Returns a string formatted as `{line}:{col}`. Way simpler than the default
-- implementation [1].
--
-- [1]: See `require("hardline.parts.line").get_item`.
local function get_line_and_column()
  local line = vim.fn.line(".")
  local col = string.format("%03d", vim.fn.col("."))
  return line .. ":" .. col
end

--- Lighter Background (Used for status bars)
local base01 = 10
--- Comments, Invisibles, Line Highlighting
local base03 = 8
--- Dark Foreground (Used for status bars)
local base04 = 12
--- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
local base08 = 1
--- Integers, Boolean, Constants, XML Attributes, Markup Link Url
local base09 = 9
--- Classes, Markup Bold, Search Text Background
local base0A = 3
--- Strings, Inherited Class, Markup Code, Diff Inserted
local base0B = 2
--- Functions, Methods, Attribute IDs, Headings
local base0D = 4
--- Keywords, Storage, Selector, Markup Italic, Diff Changed
local base0E = 5
--- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
local base0F = 14

--- Returns a color table in the format expected by _Hardline_.
---
--- ## Observations:
---
--- - I only care about the `cterm` field. I don't use NeoVim from a GUI
---   frontend.
--- - Upon source code inspection (`rg cterm16`), I noticed that the `cterm16`
---   is not used anywhere else in the code.
---
--- Despite this, I think that setting all three to the same value is the safest
--- bet.
---@param color integer
---@return { gui: string, cterm: string, cterm16: string }
local function color_table(color)
  assert(0 <= color, "Parameter `color` must be non-negative.")
  assert(color < 16, "Parameter `color` must be in range {0, 1, ..., 15}.")

  return { gui = color, cterm = color, cterm16 = color }
end

local function lazy_require_and_call(modname, fname)
  return function()
    return require(modname)[fname]()
  end
end

return {
  "ojroques/nvim-hardline",
  commit = "9b85ebf",
  pin = true,
  opts = {
    bufferline = false,

    sections = {
      { class = "mode", item = get_mode },
      { class = "med", item = lazy_require_and_call("hardline.parts.filename", "get_item") },
      -- Spacer to separate left and right groups.
      { class = "med", item = "%=" },
      { class = "error", item = lazy_require_and_call("hardline.parts.lsp", "get_error") },
      { class = "warning", item = lazy_require_and_call("hardline.parts.lsp", "get_warning") },
      { class = "low", item = get_line_and_column },
    },

    --- Use the settings from the `custom_theme` table.
    theme = "custom",

    --- Configuration for the `custom` theme.
    ---
    --- This has a weird format. I had to read the plugin source code [1] to
    --- understand what was going on:
    ---
    --- The `class` key determines the highlight group for each section. Themes
    --- are tables that map classes to colors. The `custom` key is defined in
    --- terms of a reduced set of parameters that don't map to classes in an
    --- obvious way.
    ---
    --- |----------|------------------|-----------------|
    --- | class    | fg parameter     | bg parameter    |
    --- |----------|------------------|-----------------|
    --- | inactive | inactive_comment | inactive_cursor |
    --- |----------|------------------|-----------------|
    --- | normal   | text             | normal          |
    --- | insert   | text             | insert          |
    --- | replace  | text             | replace         |
    --- | visual   | text             | visual          |
    --- | command  | text             | command         |
    --- |----------|------------------|-----------------|
    --- | low      | alt_text         | inactive_cursor |
    --- | med      | alt_text         | inactive_cursor |
    --- | high     | alt_text         | inactive_menu   |
    --- |----------|------------------|-----------------|
    --- | error    | text             | command         |
    --- | warning  | text             | warning         |
    --- |----------|------------------|-----------------|
    ---
    --- [1]: `~/.local/share/nvim/lazy/nvim-hardline/lua/hardline/themes/custom_colors.lua`.
    custom_theme = {
      --- Default background color.
      ---
      --- - Used for: `low`, `med`, and `inactive`.
      --- - Paired with: `inactive_comment`, and `alt_text`.
      inactive_cursor = color_table(base01),

      --- Background color for `high`.
      ---
      --- - Used for: `high`.
      --- - Paired with: `alt_text`.
      ---
      --- Context: I chose `base0F` because it's usually a vibrant color and it
      --- was unused.
      inactive_menu = color_table(base0F),

      --- Default foreground (Despite the name).
      ---
      --- - Used for: `low`, `med`, and `high`.
      --- - Paired with: `inactive_cursor` and `inactive_menu`.
      alt_text = color_table(base04),

      --- Inactive buffer foreground.
      ---
      --- Applied to all section classes when the buffer is not focused.
      ---
      --- - Used for `inactive`.
      --- - Paired with: `inactive_cursor`.
      inactive_comment = color_table(base03),

      --- Foreground for colored sections.
      ---
      --- - Used for: `normal`, `insert`, `replace`, `visual`, `command`,
      ---   `warning` and `error`.
      --- - Paired with: `normal`, `insert`, `replace`, `visual`, `command`, and
      ---   `warning`.
      ---
      --- I found that colors closer to the background color contrast better
      --- than `base04`, which is the default foreground color for status bars
      --- in the tinted-theming standard.
      text = color_table(base01),

      --- Background color for the `warning` class.
      ---
      --- Paired with: `text`.
      warning = color_table(base0A),

      --- Background color for `command` and `error` classes.
      ---
      --- Used for: `command`, `error`.
      --- Paired with: `text`.
      command = color_table(base08), -- Base08 ~ Red.

      --- Background colors for the `mode` class.
      ---
      --- Paired with: `text`.
      normal = color_table(base0D), -- Base0D ~ Blue (_Neutral_, _stable_, _default_).
      insert = color_table(base0B), -- Base0B ~ Green.
      replace = color_table(base09), -- Base09 ~ Orange.
      visual = color_table(base0E), -- Base0E ~ Purple (Good for highlights).
    },
  },
}
