---@class PaletteColors
local palette = {

    -- Bg Shades
    bg0        = "#1E1E1E",
    bg1        = "#242424",
    bg2        = "#2B2B2B",
    bg3        = "#313335",
    bg4        = "#3C3F41",
    bg5        = "#4E5254",
    bg6        = "#515658",

    -- Fg Shades
    fg         = "#A9B7C6",
    fgDim      = "#808080",
    fgDark     = "#606366",
    fgBright   = "#BBBBBB",

    -- Selection & Search
    selection   = "#214283",
    search      = "#32593D",
    searchCur   = "#155221",

    -- Syntax
    keyword     = "#CC7832",
    string      = "#6A8759",
    number      = "#6897BB",
    comment     = "#808080",
    func        = "#FFC66D",
    constant    = "#9876AA",
    annotation  = "#BBB529",
    docComment  = "#629755",
    markup      = "#A5C261",
    punct       = "#A9B7C6",
    operator    = "#A9B7C6",
    type        = "#A9B7C6",
    preproc     = "#CC7832",
    deprecated  = "#606366",
    regex       = "#646695",
    todo        = "#A8C023",

    -- Diff
    diffAdd     = "#294436",
    diffDelete  = "#3C2C2C",
    diffChange  = "#385570",
    diffText    = "#43698D",

    -- VCS
    vcsAdded    = "#629755",
    vcsRemoved  = "#D25252",
    vcsChanged  = "#6897BB",

    -- Diagnostics
    error       = "#BC3F3C",
    warning     = "#BE9117",
    info        = "#6897BB",
    hint        = "#A8C023",
    ok          = "#629755",

    -- UI extras
    whitespace  = "#505050",
    nontext     = "#606366",
    floatBg     = "#3C3F41",
    floatBorder = "#555555",
    matchParen  = "#FFEF28",
}

local M = {}
--- Generate colors table:
--- * opts:
---   - colors: Table of personalized colors and/or overrides of existing ones.
---   - theme: Use selected theme. Defaults to "classic".
---@param opts? { colors?: table, theme?: string }
---@return { theme: ThemeColors, palette: PaletteColors}
function M.setup(opts)
    opts = opts or {}
    local override_colors = opts.colors or require("jetbrains_classic").config.colors
    local theme = opts.theme or require("jetbrains_classic")._CURRENT_THEME or "classic"

    -- Add to and/or override palette_colors
    local updated_palette_colors = vim.tbl_extend("force", palette, override_colors.palette or {})

    -- Generate the theme according to the updated palette colors
    local theme_colors = require("jetbrains_classic.themes")[theme](updated_palette_colors)

    -- Add to and/or override theme_colors
    local theme_overrides = vim.tbl_deep_extend("force", override_colors.theme["all"] or {}, override_colors.theme[theme] or {} )
    local updated_theme_colors = vim.tbl_deep_extend("force", theme_colors, theme_overrides)

    return {
        theme = updated_theme_colors,
        palette = updated_palette_colors,
    }
end

return M
