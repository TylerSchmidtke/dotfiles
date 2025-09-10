# GitHub Dark theme for Nushell

$env.config.color_config = {
    separator: "#30363d"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#3fb950" attr: "b" }
    empty: "#58a6ff"
    bool: {
        true: { fg: "#3fb950" }
        false: { fg: "#ff7b72" }
    }
    int: "#79c0ff"
    filesize: {
        metric: { fg: "#79c0ff" attr: "b" }
    }
    duration: "#d29922"
    date: {
        now: { fg: "#3fb950" attr: "b" }
        ago: { fg: "#bc8cff" }
    }
    range: "#79c0ff"
    float: "#79c0ff"
    string: "#a5d6ff"
    nothing: "#6e7681"
    binary: "#d29922"
    cell_path: "#e6edf3"
    row_index: { fg: "#3fb950" attr: "b" }
    record: "#e6edf3"
    list: "#e6edf3"
    block: "#e6edf3"
    hints: "#6e7681"
    search_result: { fg: "#0d1117" bg: "#d29922" }

    shape_and: { fg: "#ff7b72" attr: "b" }
    shape_binary: { fg: "#d29922" attr: "b" }
    shape_block: { fg: "#58a6ff" attr: "b" }
    shape_bool: "#79c0ff"
    shape_closure: { fg: "#3fb950" attr: "b" }
    shape_custom: "#3fb950"
    shape_datetime: { fg: "#39c5cf" attr: "b" }
    shape_directory: "#39c5cf"
    shape_external: "#39c5cf"
    shape_externalarg: { fg: "#3fb950" attr: "b" }
    shape_external_resolved: { fg: "#56d364" attr: "b" }
    shape_filepath: "#39c5cf"
    shape_flag: { fg: "#58a6ff" attr: "b" }
    shape_float: { fg: "#d29922" attr: "b" }
    shape_garbage: { fg: "#ffffff" bg: "#ff7b72" attr: "b" }
    shape_glob_interpolation: { fg: "#39c5cf" attr: "b" }
    shape_globpattern: { fg: "#39c5cf" attr: "b" }
    shape_int: { fg: "#d29922" attr: "b" }
    shape_internalcall: { fg: "#39c5cf" attr: "b" }
    shape_keyword: { fg: "#ff7b72" attr: "b" }
    shape_list: { fg: "#39c5cf" attr: "b" }
    shape_literal: "#58a6ff"
    shape_match_pattern: "#3fb950"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#79c0ff"
    shape_operator: "#ff7b72"
    shape_or: { fg: "#d29922" attr: "b" }
    shape_pipe: { fg: "#d29922" attr: "b" }
    shape_range: { fg: "#d29922" attr: "b" }
    shape_record: { fg: "#39c5cf" attr: "b" }
    shape_redirection: { fg: "#d29922" attr: "b" }
    shape_signature: { fg: "#3fb950" attr: "b" }
    shape_string: "#a5d6ff"
    shape_string_interpolation: { fg: "#39c5cf" attr: "b" }
    shape_table: { fg: "#58a6ff" attr: "b" }
    shape_variable: "#bc8cff"
    shape_vardecl: "#bc8cff"
    shape_raw_string: { fg: "#e6edf3" attr: "b" }

    background: "#0d1117"
    foreground: "#e6edf3"
    cursor: "#e6edf3"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#e6edf3", bg: "#161b22" },
    command_bar_text: { fg: "#e6edf3" },
    highlight: { fg: "#0d1117", bg: "#58a6ff" },
    status: {
        error: "#ff7b72",
        warn: "#d29922",
        info: "#58a6ff",
    },
    selected_cell: { bg: "#1f6feb22" fg: "#e6edf3" },
}