-- This is the list of words I use to generate random filenames. It consists of
-- 2048 words taken from the english BIP39 word list.
--
-- Due to it's lenght, I decided against hard-coding it here. While reading a
-- `16k` txt file is not an expensive operation for today standards, it's
-- something that adds up to startup time. For that reason, I implemented the
-- following procedure:
--
-- - A `nil`-initialized list called `_id_words` is used to memoize the contents
--   of the file. DO NOT TOUCH THIS VARIABLE OUTSIDE `id_words()`.
-- - The function `id_words()` returns the list of random words to use. This
--   function is in charge of reading the word list from the file system the
--   first time it gets called.
local _id_words = nil
local id_words = function()
  -- Lazy load implementation, the `if` statement ensures that the "expensive"
  -- part of this procedure gets evaluated only once.
  if not _id_words then
    local path = vim.fn.stdpath('config') .. '/etc/bip39-word-list.txt'
    local file = assert(
      io.open(path, "r"),
      "Failed to open note id word list: " .. path
    )

    _id_words = {}
    for line in file:lines() do
      table.insert(_id_words, line)
    end

    file:close()
  end

  return _id_words
end

--[[
  Generates a title for a note based on its frontmatter or aliases.

  Parameters:
    note (table): A table representing the note, which may include:
      - frontmatter.title (string): The title defined in the note's frontmatter.
      - aliases (table): A list of alternative titles or headings for the note.
      - id (string): A unique identifier for the note.

  Returns:
    string: A title derived from the note's content in the following order of priority:
      1. The title explicitly defined in the frontmatter.
      2. The first alias, which may include a heading from the note's content.
      3. A placeholder title generated from the note's ID.
]]
local function generate_title(note)
  -- I'm being extra defensive here because I'm not sure that my mental model of
  -- the `note` structure holds 100% of the time.

  if type(note.metadata) == "table" and type(note.metadata.title) == "string" then
    return note.metadata.title
  end

  if type(note.aliases) == "table" and type(note.aliases[1]) == "string" then
    return note.aliases[1]
  end

  return string.format("Untitled (%s)", note.id)
end

require("obsidian").setup({
  dir = "~/Documents/Notes/",

  completion = {
    nvim_cmp = true,
    min_chars = 2,
    prepend_note_path = true,
  },

  note_id_func = function(_) -- Ignores title parameter.
    local total_word_count = #id_words()
    local words_per_id = 4

    local random_words = {}
    for _ = 1, words_per_id, 1 do
      local random_i = math.random(total_word_count)
      local random_word = id_words()[random_i]
      table.insert(random_words, random_word)
    end

    return table.concat(random_words, "-")
  end,

  follow_url_func = function(url)
    if vim.fn.has("macunix") == 1 then
      print("this is macunix")
      vim.fn.jobstart({ "open", url })
    elseif vim.fn.has("linux") == 1 and vim.fn.executable("xdg-open") == 1 then
      vim.fn.jobstart({ "xdg-open", url }) -- linux
    else
      error("Unable to find URL opener for this system. Edit 'follow_url_func' to fix this issue.")
    end
  end,

  -- Transforms the frontmatter before writing the buffer to disk.
  ---@return table
  note_frontmatter_func = function(note)
    local frontmatter = {}

    -- Shallow copy `note.metadata` into `frontmatter`.
    if type(note.metadata) == "table" then
      for k, v in pairs(note.metadata) do
        frontmatter[k] = v
      end
    end

    frontmatter.id = note.id
    frontmatter.tags = note.tags

    local title = generate_title(note)
    frontmatter.title = title
    frontmatter.aliases = { title }

    return frontmatter
  end,

})
