---@class SyntaxElements
---@field string ColorSpec
---@field variable ColorSpec
---@field number ColorSpec
---@field constant ColorSpec
---@field identifier ColorSpec
---@field parameter ColorSpec
---@field fun ColorSpec
---@field statement ColorSpec
---@field keyword ColorSpec
---@field operator ColorSpec
---@field preproc ColorSpec
---@field type ColorSpec
---@field regex ColorSpec
---@field deprecated ColorSpec
---@field comment ColorSpec
---@field punct ColorSpec
---@field special1 ColorSpec
---@field special2 ColorSpec
---@field special3 ColorSpec

---@class DiagnosticsElements
---@field error ColorSpec
---@field ok ColorSpec
---@field warning ColorSpec
---@field info ColorSpec
---@field hint ColorSpec
--
---@class DiffElements
---@field add ColorSpec
---@field delete ColorSpec
---@field change ColorSpec
---@field text ColorSpec

---@class VCSElements
---@field added ColorSpec
---@field removed ColorSpec
---@field changed ColorSpec

---@class UiElements
---@field fg ColorSpec Default foreground
---@field fg_dim ColorSpec Dimmed foreground
---@field fg_reverse ColorSpec
---@field bg_dim ColorSpec Dimmed background
---@field bg_m3 ColorSpec
---@field bg_m2 ColorSpec
---@field bg_m1 ColorSpec
---@field bg ColorSpec Default background
---@field bg_p1 ColorSpec Lighter background ColorColumn, Folded, Gutter
---@field bg_p2 ColorSpec Lighter background Cursor{Line,Column}, TabLineSel (Selected Items)
---@field bg_gutter ColorSpec {Sign,Fold}Column, LineNr
---@field special ColorSpec SpecialKey
---@field nontext ColorSpec LineNr, NonText
---@field whitespace ColorSpec Whitespace
---@field bg_search ColorSpec
---@field bg_visual ColorSpec
---@field pmenu MenuElements
---@field float FloatElements

---@class FloatElements
---@field fg ColorSpec
---@field bg ColorSpec
---@field fg_border ColorSpec
---@field bg_border ColorSpec

---@class MenuElements
---@field bg ColorSpec
---@field fg ColorSpec
---@field fg_sel ColorSpec
---@field bg_sel ColorSpec
---@field bg_sbar ColorSpec
---@field bg_thumb ColorSpec

---@class ThemeColors
---@field syn SyntaxElements
---@field diag DiagnosticsElements
---@field vcs VCSElements
---@field diff DiffElements
---@field ui UiElements
---@field term ColorSpec[]

return {
    ---@param palette PaletteColors
    ---@return ThemeColors
    classic = function(palette)
        return {
            ui = {
                fg         = palette.fg,
                fg_dim     = palette.fgDim,
                fg_reverse = palette.bg0,

                bg_dim     = palette.bg1,
                bg_gutter  = palette.bg3,

                bg_m3      = palette.bg0,
                bg_m2      = palette.bg1,
                bg_m1      = palette.bg1,
                bg         = palette.bg2,
                bg_p1      = palette.bg3,
                bg_p2      = palette.bg5,

                special    = palette.fgDark,
                nontext    = palette.nontext,
                whitespace = palette.whitespace,

                bg_search  = palette.search,
                bg_visual  = palette.selection,

                pmenu      = {
                    fg       = palette.fg,
                    fg_sel   = "none", -- This is important to make highlights pass-through
                    bg       = palette.bg4,
                    bg_sel   = palette.selection,
                    bg_sbar  = palette.bg4,
                    bg_thumb = palette.bg5,
                },
                float      = {
                    fg        = palette.fg,
                    bg        = palette.floatBg,
                    fg_border = palette.floatBorder,
                    bg_border = palette.floatBg,
                },
            },
            syn = {
                string     = palette.string,     -- #6A8759 green
                variable   = "none",
                number     = palette.number,     -- #6897BB blue
                constant   = palette.constant,   -- #9876AA purple
                identifier = palette.constant,   -- #9876AA purple (instance fields)
                parameter  = palette.fg,         -- #A9B7C6
                fun        = palette.func,       -- #FFC66D gold
                statement  = palette.keyword,    -- #CC7832 orange
                keyword    = palette.keyword,    -- #CC7832 orange
                operator   = palette.keyword,    -- #CC7832 orange (IntelliJ: operators like -> are orange)
                preproc    = palette.keyword,    -- #CC7832 orange
                type       = palette.number,     -- #6897BB blue (class/type references)
                regex      = palette.regex,      -- #646695
                deprecated = palette.deprecated, -- #606366
                comment    = palette.comment,    -- #808080
                punct      = palette.fg,         -- #A9B7C6
                special1   = palette.annotation, -- #BBB529 yellow-green
                special2   = palette.keyword,    -- #CC7832 orange (builtin vars)
                special3   = palette.keyword,    -- #CC7832 orange (return, throw)
            },
            vcs = {
                added   = palette.vcsAdded,
                removed = palette.vcsRemoved,
                changed = palette.vcsChanged,
            },
            diff = {
                add    = palette.diffAdd,
                delete = palette.diffDelete,
                change = palette.diffChange,
                text   = palette.diffText,
            },
            diag = {
                ok      = palette.ok,
                error   = palette.error,
                warning = palette.warning,
                info    = palette.info,
                hint    = palette.hint,
            },
            term = {
                palette.bg0,        -- black
                palette.vcsRemoved, -- red
                palette.vcsAdded,   -- green
                palette.keyword,    -- yellow
                palette.number,     -- blue
                palette.constant,   -- magenta
                palette.number,     -- cyan
                palette.fg,         -- white
                palette.fgDark,     -- bright black
                palette.error,      -- bright red
                palette.string,     -- bright green
                palette.func,       -- bright yellow
                palette.info,       -- bright blue
                palette.fgDim,      -- bright magenta
                palette.hint,       -- bright cyan
                palette.fgBright,   -- bright white
                palette.keyword,    -- extended color 1
                palette.annotation, -- extended color 2
            },
        }
    end,
}
