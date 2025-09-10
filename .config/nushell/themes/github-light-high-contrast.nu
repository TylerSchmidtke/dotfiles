# GitHub Light High Contrast theme for Nushell

$env.config.color_config = {
    separator: "#20252c"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#024c1a" attr: "b" }
    empty: "#023b95"
    bool: {
        true: { fg: "#024c1a" }
        false: { fg: "#a0111f" }
    }
    int: "#023b95"
    filesize: {
        metric: { fg: "#023b95" attr: "b" }
    }
    duration: "#744500"
    date: {
        now: { fg: "#024c1a" attr: "b" }
        ago: { fg: "#622cbc" }
    }
    range: "#023b95"
    float: "#023b95"
    string: "#032563"
    nothing: "#4b535d"
    binary: "#744500"
    cell_path: "#0e1116"
    row_index: { fg: "#024c1a" attr: "b" }
    record: "#0e1116"
    list: "#0e1116"
    block: "#0e1116"
    hints: "#4b535d"
    search_result: { fg: "#ffffff" bg: "#744500" }

    shape_and: { fg: "#a0111f" attr: "b" }
    shape_binary: { fg: "#744500" attr: "b" }
    shape_block: { fg: "#023b95" attr: "b" }
    shape_bool: "#023b95"
    shape_closure: { fg: "#024c1a" attr: "b" }
    shape_custom: "#024c1a"
    shape_datetime: { fg: "#055d20" attr: "b" }
    shape_directory: "#055d20"
    shape_external: "#055d20"
    shape_externalarg: { fg: "#024c1a" attr: "b" }
    shape_external_resolved: { fg: "#013d14" attr: "b" }
    shape_filepath: "#055d20"
    shape_flag: { fg: "#023b95" attr: "b" }
    shape_float: { fg: "#744500" attr: "b" }
    shape_garbage: { fg: "#000000" bg: "#a0111f" attr: "b" }
    shape_glob_interpolation: { fg: "#055d20" attr: "b" }
    shape_globpattern: { fg: "#055d20" attr: "b" }
    shape_int: { fg: "#744500" attr: "b" }
    shape_internalcall: { fg: "#055d20" attr: "b" }
    shape_keyword: { fg: "#a0111f" attr: "b" }
    shape_list: { fg: "#055d20" attr: "b" }
    shape_literal: "#023b95"
    shape_match_pattern: "#024c1a"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#023b95"
    shape_operator: "#a0111f"
    shape_or: { fg: "#744500" attr: "b" }
    shape_pipe: { fg: "#744500" attr: "b" }
    shape_range: { fg: "#744500" attr: "b" }
    shape_record: { fg: "#055d20" attr: "b" }
    shape_redirection: { fg: "#744500" attr: "b" }
    shape_signature: { fg: "#024c1a" attr: "b" }
    shape_string: "#032563"
    shape_string_interpolation: { fg: "#055d20" attr: "b" }
    shape_table: { fg: "#023b95" attr: "b" }
    shape_variable: "#622cbc"
    shape_vardecl: "#622cbc"
    shape_raw_string: { fg: "#0e1116" attr: "b" }

    background: "#ffffff"
    foreground: "#0e1116"
    cursor: "#0e1116"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#0e1116", bg: "#e7ecf0" },
    command_bar_text: { fg: "#0e1116" },
    highlight: { fg: "#ffffff", bg: "#023b95" },
    status: {
        error: "#a0111f",
        warn: "#744500",
        info: "#023b95",
    },
    selected_cell: { bg: "#023b9522" fg: "#0e1116" },
}