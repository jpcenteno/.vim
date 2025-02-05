local M = {}

M.insert_link = function()
  local opts = { title = "I want to insert a link to ..." }
  local strategies = {
    {
      name = "An external URL",
      f = function(_)
        vim.ui.input({ prompt = "Link URL: " }, function(url)
          if url then
            M.insert_link_to_note_visual(url)
          end
        end)
      end
    },
    {
      name = "A new note",
      f = function(_)
        vim.ui.input({ prompt = "New note title: " }, function(title)
          if title then
            local nm = require("kasten.cli").note_new({ title = title })
            M.insert_link_to_note_visual("./" .. nm.relativePath)
          end
        end)
      end
    },
    {
      name = "An existing note",
      f = function(_)
        require("kasten.telescope").insert_link()
      end
    },
  }

  require("kasten.telescope.strategy_picker").strategy_picker(opts, strategies, nil)
end

M.insert_link_to_note_visual = function(url)
  -- Get the range of the visual selection.
  local _, start_row, start_col = unpack(vim.fn.getpos("'<"))
  local _, end_row, end_col = unpack(vim.fn.getpos("'>"))

  -- Get the text from the visual selection.
  local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
  local text = table.concat(lines, "\n")

  -- Get the text from the visual selection.
  local link = "[" .. text .. "](" .. url .. ")"

  local new_lines = {}
  for line in link:gmatch("[^\n]+") do
    table.insert(new_lines, line)
  end

  vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, new_lines)
end

return M
