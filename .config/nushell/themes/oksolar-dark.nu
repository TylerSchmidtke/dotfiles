# OKSolar Dark theme for Nushell
# Palette: https://meat.io/oksolar

$env.config.color_config = {
    separator: "#5B7279"
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
    nothing: "#5B7279"
    binary: "#AC8300"
    cell_path: "#98A8A8"
    row_index: { fg: "#2B90D8" attr: "b" }
    record: "#98A8A8"
    list: "#98A8A8"
    block: "#98A8A8"
    hints: "#5B7279"
    search_result: { fg: "#002D38" bg: "#AC8300" }

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
    shape_garbage: { fg: "#98A8A8" bg: "#F23749" attr: "b" }
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
    shape_raw_string: { fg: "#98A8A8" attr: "b" }

    background: "#002D38"
    foreground: "#98A8A8"
    cursor: "#D56500"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#98A8A8", bg: "#093946" },
    command_bar_text: { fg: "#98A8A8" },
    highlight: { fg: "#002D38", bg: "#AC8300" },
    status: {
        error: "#F23749",
        warn: "#AC8300",
        info: "#2B90D8",
    },
    selected_cell: { bg: "#65737744" fg: "#98A8A8" },
}
