# GitHub Dark Colorblind theme for Nushell

$env.config.color_config = {
    separator: "#30363d"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#58a6ff" attr: "b" }
    empty: "#58a6ff"
    bool: {
        true: { fg: "#58a6ff" }
        false: { fg: "#ec8e2c" }
    }
    int: "#79c0ff"
    filesize: {
        metric: { fg: "#79c0ff" attr: "b" }
    }
    duration: "#d29922"
    date: {
        now: { fg: "#58a6ff" attr: "b" }
        ago: { fg: "#bc8cff" }
    }
    range: "#79c0ff"
    float: "#79c0ff"
    string: "#a5d6ff"
    nothing: "#6e7681"
    binary: "#d29922"
    cell_path: "#c9d1d9"
    row_index: { fg: "#58a6ff" attr: "b" }
    record: "#c9d1d9"
    list: "#c9d1d9"
    block: "#c9d1d9"
    hints: "#6e7681"
    search_result: { fg: "#0d1117" bg: "#d29922" }

    shape_and: { fg: "#ec8e2c" attr: "b" }
    shape_binary: { fg: "#d29922" attr: "b" }
    shape_block: { fg: "#58a6ff" attr: "b" }
    shape_bool: "#79c0ff"
    shape_closure: { fg: "#58a6ff" attr: "b" }
    shape_custom: "#58a6ff"
    shape_datetime: { fg: "#76e3ea" attr: "b" }
    shape_directory: "#76e3ea"
    shape_external: "#76e3ea"
    shape_externalarg: { fg: "#58a6ff" attr: "b" }
    shape_external_resolved: { fg: "#79c0ff" attr: "b" }
    shape_filepath: "#76e3ea"
    shape_flag: { fg: "#58a6ff" attr: "b" }
    shape_float: { fg: "#d29922" attr: "b" }
    shape_garbage: { fg: "#ffffff" bg: "#ec8e2c" attr: "b" }
    shape_glob_interpolation: { fg: "#76e3ea" attr: "b" }
    shape_globpattern: { fg: "#76e3ea" attr: "b" }
    shape_int: { fg: "#d29922" attr: "b" }
    shape_internalcall: { fg: "#76e3ea" attr: "b" }
    shape_keyword: { fg: "#ec8e2c" attr: "b" }
    shape_list: { fg: "#76e3ea" attr: "b" }
    shape_literal: "#58a6ff"
    shape_match_pattern: "#58a6ff"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#79c0ff"
    shape_operator: "#ec8e2c"
    shape_or: { fg: "#d29922" attr: "b" }
    shape_pipe: { fg: "#d29922" attr: "b" }
    shape_range: { fg: "#d29922" attr: "b" }
    shape_record: { fg: "#76e3ea" attr: "b" }
    shape_redirection: { fg: "#d29922" attr: "b" }
    shape_signature: { fg: "#58a6ff" attr: "b" }
    shape_string: "#a5d6ff"
    shape_string_interpolation: { fg: "#76e3ea" attr: "b" }
    shape_table: { fg: "#58a6ff" attr: "b" }
    shape_variable: "#bc8cff"
    shape_vardecl: "#bc8cff"
    shape_raw_string: { fg: "#c9d1d9" attr: "b" }

    background: "#0d1117"
    foreground: "#c9d1d9"
    cursor: "#c9d1d9"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#c9d1d9", bg: "#161b22" },
    command_bar_text: { fg: "#c9d1d9" },
    highlight: { fg: "#0d1117", bg: "#58a6ff" },
    status: {
        error: "#ec8e2c",
        warn: "#d29922",
        info: "#58a6ff",
    },
    selected_cell: { bg: "#58a6ff22" fg: "#c9d1d9" },
}