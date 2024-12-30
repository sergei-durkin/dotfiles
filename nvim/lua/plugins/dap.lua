require('dapui').setup()
require('dap-go').setup()
require('nvim-dap-virtual-text').setup()

local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
local namespace = vim.api.nvim_create_namespace("dap-hlng")

vim.api.nvim_set_hl(namespace, 'DapBreakpoint', { fg='#993939', bg='#31353f' })
vim.api.nvim_set_hl(namespace, 'DapLogPoint', { fg='#61afef', bg='#31353f' })
vim.api.nvim_set_hl(namespace, 'DapStopped', { fg='#98c379', bg='#31353f' })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

vim.api.nvim_set_keymap("n", "<leader>bp", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>fs", ":GoFillStruct<CR>", {silent = true, noremap=true})

local runCurrentFile = function()
  local command

  if vim.fn.expand('%'):match(".http$") then
    command = "Rest run"
    vim.cmd(command)
    return
  end

  if vim.fn.expand('%'):match("_test.go$") then
    command = "GoTestFunc -v"
    vim.cmd(command)
    return
  end

  if vim.fn.expand('%'):match("main.go$") then

    if vim.fn.search("func main") then
      command = string.format("GoRun %s -v", vim.fn.expand('%'))
      vim.cmd(command)
      return
    end

    print("No main function found")

    return
  end

  print("Nothing to run")
end

vim.keymap.set({"n", "i", "v"}, "<F3>", function() runCurrentFile() end, {silent = true, noremap=true})
vim.keymap.set({"n", "i", "v"}, "⌘r", function() runCurrentFile() end, {silent = true, noremap=true})

vim.keymap.set("n", "<F4>", ":GoDebug<CR>", {noremap=true})
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F9>', ":GoDebug -s<CR>", {noremap=true})
vim.keymap.set('n', '<F10>', ":DapUiToggle<CR>", {noremap=true})
vim.keymap.set('n', '<ESC>', ":GoTermClose<CR>", {silent = true, noremap=true})
