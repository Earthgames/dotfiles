local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

-- Set leader
vim.g.mapleader = "\\"
-- vim.g.maplocalleader = "\\"

-- Unmap default things
map("n", "<C-q>", "", defaults)
map("n", "<F1>", "", defaults)

-- Map vim.diagnostic
map("n", "<C-n>", ":lua vim.diagnostic.goto_next()<CR>", defaults)
map("n", "<C-p>", ":lua vim.diagnostic.goto_prev()<CR>", defaults)

-- Using H/L to go to the begining and the end of line
-- Note: H will map to _ (the first non-whitespace character of a line)
map({ "n", "v" }, "H", "_", defaults)
map({ "n", "v" }, "L", "$", defaults)

-- auto add closing {, [, (, ', ", <
map("i", "{<cr>", "{<cr>}<ESC>kA<CR>", {})
local closing_pairs = { "}", ")", "]", "\"", "'", ">" }
local opening_pairs = { "{", "(", "[", "\"", "'", "<" }
for key, chr in pairs(opening_pairs) do
    map("i", chr, chr .. closing_pairs[key] .. "<esc>i", {})
end

local function close_floating_windows(opts)
    for _, window_id in ipairs(vim.api.nvim_list_wins()) do
        -- If window is floating
        if vim.api.nvim_win_get_config(window_id).relative ~= "" then
            -- Force close if called with !
            vim.api.nvim_win_close(window_id, opts.bang)
        end
    end
end

-- close floating windows
vim.api.nvim_create_user_command("CloseFloatingWindows", function(opts)
    close_floating_windows(opts)
end, { bang = true, nargs = 0 })

-- vim.api.nvim_create_augroup("MyBufferSwitchGroup", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     pattern = ".*.",
--     group = "MyBufferSwitchGroup",
--     callback = function()
--         if not vim.api.nvim_get_current_win().relative ~= "" then
--             close_floating_windows({})
--         end
--     end,
-- })
