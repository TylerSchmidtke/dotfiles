# OKSolar Sky theme for Nushell
# Palette: https://meat.io/oksolar (variant from https://github.com/dieghernan/oksolar-theme)

$env.config.color_config = {
    separator: "#8FAAAE"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#2B90D8" attr: "b" }
    empty: "#2B90D8"
    bool: {
        "true": { fg: "#259D94" }
        "false": { fg: "#D56500" }
    }
    int: "#DD459D"
    filesize: {
        metric: { fg: "#2B90D8" attr: "b" }
    }
    duration: "#AC8300"
    date: {
        now: { fg: "#2B90D8" attr: "b" }
        ago: { fg: "#7D80D1" }
    }
    range: "#DD459D"
    float: "#DD459D"
    string: "#259D94"
    nothing: "#8FAAAE"
    binary: "#AC8300"
    cell_path: "#796E66"
    row_index: { fg: "#2B90D8" attr: "b" }
    record: "#796E66"
    list: "#796E66"
    block: "#796E66"
    hints: "#8FAAAE"
    search_result: { fg: "#EFF9FE" bg: "#AC8300" }

    shape_and: { fg: "#819500" attr: "b" }
    shape_binary: { fg: "#DD459D" attr: "b" }
    shape_block: { fg: "#2B90D8" attr: "b" }
    shape_bool: "#DD459D"
    shape_closure: { fg: "#2B90D8" attr: "b" }
    shape_custom: "#2B90D8"
    shape_datetime: { fg: "#259D94" attr: "b" }
    shape_directory: "#2B90D8"
    shape_external: "#259D94"
    shape_externalarg: { fg: "#819500" attr: "b" }
    shape_external_resolved: { fg: "#259D94" attr: "b" }
    shape_filepath: "#2B90D8"
    shape_flag: { fg: "#D56500" attr: "b" }
    shape_float: { fg: "#DD459D" attr: "b" }
    shape_garbage: { fg: "#EFF9FE" bg: "#F23749" attr: "b" }
    shape_glob_interpolation: { fg: "#259D94" attr: "b" }
    shape_globpattern: { fg: "#259D94" attr: "b" }
    shape_int: { fg: "#DD459D" attr: "b" }
    shape_internalcall: { fg: "#2B90D8" attr: "b" }
    shape_keyword: { fg: "#819500" attr: "b" }
    shape_list: { fg: "#259D94" attr: "b" }
    shape_literal: "#2B90D8"
    shape_match_pattern: "#819500"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#DD459D"
    shape_operator: "#819500"
    shape_or: { fg: "#819500" attr: "b" }
    shape_pipe: { fg: "#819500" attr: "b" }
    shape_range: { fg: "#AC8300" attr: "b" }
    shape_record: { fg: "#259D94" attr: "b" }
    shape_redirection: { fg: "#D56500" attr: "b" }
    shape_signature: { fg: "#2B90D8" attr: "b" }
    shape_string: "#259D94"
    shape_string_interpolation: { fg: "#259D94" attr: "b" }
    shape_table: { fg: "#2B90D8" attr: "b" }
    shape_variable: "#7D80D1"
    shape_vardecl: "#7D80D1"
    shape_raw_string: { fg: "#796E66" attr: "b" }

    background: "#EFF9FE"
    foreground: "#796E66"
    cursor: "#D56500"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#796E66", bg: "#D4EEF9" },
    command_bar_text: { fg: "#796E66" },
    highlight: { fg: "#EFF9FE", bg: "#AC8300" },
    status: {
        error: "#F23749",
        warn: "#AC8300",
        info: "#2B90D8",
    },
    selected_cell: { bg: "#98A7A944" fg: "#796E66" },
}
