local M = {}

---@alias ColorSpec string RGB Hex string
---@alias ColorTable table<string, ColorSpec>
---@alias JetbrainsClassicColorsSpec { palette: ColorTable, theme: ColorTable }
---@alias JetbrainsClassicColors { palette: PaletteColors, theme: ThemeColors }

--- default config
---@class JetbrainsClassicConfig
M.config = {
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    colors = { theme = { classic = {}, all = {} }, palette = {} },
    ---@type fun(colors: JetbrainsClassicColorsSpec): table<string, table>
    overrides = function()
        return {}
    end,
    theme = "classic",
    compile = false,
}

local function check_config(config)
    local err
    return not err
end

--- update global configuration with user settings
---@param config? JetbrainsClassicConfig user configuration
function M.setup(config)
    if check_config(config) then
        M.config = vim.tbl_deep_extend("force", M.config, config or {})
    else
        vim.notify("JetbrainsClassic: Errors found while loading user config. Using default config.", vim.log.levels.ERROR)
    end
end

--- load the colorscheme
---@param theme? string
function M.load(theme)
    local utils = require("jetbrains_classic.utils")

    theme = theme or M.config.theme
    M._CURRENT_THEME = theme

    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.g.colors_name = "jetbrains-classic"
    vim.o.termguicolors = true

    if M.config.compile then
        if utils.load_compiled(theme) then
            return
        end

        M.compile()
        utils.load_compiled(theme)
    else
        local colors = require("jetbrains_classic.colors").setup({ theme = theme, colors = M.config.colors })
        local highlights = require("jetbrains_classic.highlights").setup(colors, M.config)
        require("jetbrains_classic.highlights").highlight(highlights, M.config.terminalColors and colors.theme.term or {})
    end
end

function M.compile()
    for theme, _ in pairs(require("jetbrains_classic.themes")) do
        local colors = require("jetbrains_classic.colors").setup({ theme = theme, colors = M.config.colors })
        local highlights = require("jetbrains_classic.highlights").setup(colors, M.config)
        require("jetbrains_classic.utils").compile(theme, highlights, M.config.terminalColors and colors.theme.term or {})
    end
end

vim.api.nvim_create_user_command("JetbrainsClassicCompile", function()
    for mod, _ in pairs(package.loaded) do
        if mod:match("^jetbrains_classic%.") then
            package.loaded[mod] = nil
        end
    end
    M.compile()
    vim.notify("JetbrainsClassic: compiled successfully!", vim.log.levels.INFO)
    M.load(M._CURRENT_THEME)
    vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
end, {})

return M
