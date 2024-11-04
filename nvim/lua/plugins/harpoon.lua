local harpoon = require("harpoon")
local extensions = require("harpoon.extensions")

harpoon:setup({})

-- leader + j + number to navigate to a specific harpoon item
harpoon:extend(extensions.builtins.navigate_with_number());
vim.keymap.set("n", "<leader>jk", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon window" })

vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end, { desc = "Add current buffer to harpoon" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
        results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<leader>sj", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-d>", function() harpoon:list():prev() end, { desc = "Navigate to previous harpoon item" })
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "Navigate to next harpoon item" })

