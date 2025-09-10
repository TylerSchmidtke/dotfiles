# GitHub Dark Dimmed theme for Nushell

$env.config.color_config = {
    separator: "#444c56"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#57ab5a" attr: "b" }
    empty: "#539bf5"
    bool: {
        true: { fg: "#57ab5a" }
        false: { fg: "#f47067" }
    }
    int: "#6cb6ff"
    filesize: {
        metric: { fg: "#6cb6ff" attr: "b" }
    }
    duration: "#c69026"
    date: {
        now: { fg: "#57ab5a" attr: "b" }
        ago: { fg: "#b083f0" }
    }
    range: "#6cb6ff"
    float: "#6cb6ff"
    string: "#96d0ff"
    nothing: "#636e7b"
    binary: "#c69026"
    cell_path: "#adbac7"
    row_index: { fg: "#57ab5a" attr: "b" }
    record: "#adbac7"
    list: "#adbac7"
    block: "#adbac7"
    hints: "#636e7b"
    search_result: { fg: "#22272e" bg: "#c69026" }

    shape_and: { fg: "#f47067" attr: "b" }
    shape_binary: { fg: "#c69026" attr: "b" }
    shape_block: { fg: "#539bf5" attr: "b" }
    shape_bool: "#6cb6ff"
    shape_closure: { fg: "#57ab5a" attr: "b" }
    shape_custom: "#57ab5a"
    shape_datetime: { fg: "#39c5cf" attr: "b" }
    shape_directory: "#39c5cf"
    shape_external: "#39c5cf"
    shape_externalarg: { fg: "#57ab5a" attr: "b" }
    shape_external_resolved: { fg: "#6bc46d" attr: "b" }
    shape_filepath: "#39c5cf"
    shape_flag: { fg: "#539bf5" attr: "b" }
    shape_float: { fg: "#c69026" attr: "b" }
    shape_garbage: { fg: "#ffffff" bg: "#f47067" attr: "b" }
    shape_glob_interpolation: { fg: "#39c5cf" attr: "b" }
    shape_globpattern: { fg: "#39c5cf" attr: "b" }
    shape_int: { fg: "#c69026" attr: "b" }
    shape_internalcall: { fg: "#39c5cf" attr: "b" }
    shape_keyword: { fg: "#f47067" attr: "b" }
    shape_list: { fg: "#39c5cf" attr: "b" }
    shape_literal: "#539bf5"
    shape_match_pattern: "#57ab5a"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#6cb6ff"
    shape_operator: "#f47067"
    shape_or: { fg: "#c69026" attr: "b" }
    shape_pipe: { fg: "#c69026" attr: "b" }
    shape_range: { fg: "#c69026" attr: "b" }
    shape_record: { fg: "#39c5cf" attr: "b" }
    shape_redirection: { fg: "#c69026" attr: "b" }
    shape_signature: { fg: "#57ab5a" attr: "b" }
    shape_string: "#96d0ff"
    shape_string_interpolation: { fg: "#39c5cf" attr: "b" }
    shape_table: { fg: "#539bf5" attr: "b" }
    shape_variable: "#b083f0"
    shape_vardecl: "#b083f0"
    shape_raw_string: { fg: "#adbac7" attr: "b" }

    background: "#22272e"
    foreground: "#adbac7"
    cursor: "#adbac7"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#adbac7", bg: "#2d333b" },
    command_bar_text: { fg: "#adbac7" },
    highlight: { fg: "#22272e", bg: "#539bf5" },
    status: {
        error: "#f47067",
        warn: "#c69026",
        info: "#539bf5",
    },
    selected_cell: { bg: "#539bf522" fg: "#adbac7" },
}