return {
    "jpalardy/vim-slime",
    config = function()
        vim.g.slime_target = "tmux"
        vim.g.slime_default_config = {
            socket_name = "default",
            target_pane = "1",
        }
        vim.keymap.set("n", "<C-C><C-R>", ":execute 'SlimeSend1 python ' . shellescape(expand('%'))<CR>")
    end,
}
