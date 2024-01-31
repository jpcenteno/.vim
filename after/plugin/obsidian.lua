require("obsidian").setup({
    dir = "~/notes",

    completion = {
        nvim_cmp = true,
        min_chars = 2,
        prepend_note_path = true,
    },

    note_id_func = function(title)
      -- I was unable to find an option to make titles mandatory.
      if title == nil then error("Title must be non-nil") end
      return title:gsub(" ", "-"):gsub("_", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    end,

    follow_url_func = function(url)
      if vim.fn.has("macunix") == 1 then
        print("this is macunix")
        vim.fn.jobstart({"open", url})
      elseif vim.fn.has("linux") == 1 and vim.fn.executable("xdg-open") == 1 then
        vim.fn.jobstart({"xdg-open", url})  -- linux
      else
        error("Unable to find URL opener for this system. Edit 'follow_url_func' to fix this issue.")
      end
    end,
})
