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
})
