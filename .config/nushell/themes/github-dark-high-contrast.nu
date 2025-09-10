# GitHub Dark High Contrast theme for Nushell

$env.config.color_config = {
    separator: "#525964"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#09b43a" attr: "b" }
    empty: "#409eff"
    bool: {
        true: { fg: "#09b43a" }
        false: { fg: "#ff6a69" }
    }
    int: "#71b7ff"
    filesize: {
        metric: { fg: "#71b7ff" attr: "b" }
    }
    duration: "#e09b13"
    date: {
        now: { fg: "#09b43a" attr: "b" }
        ago: { fg: "#b780ff" }
    }
    range: "#71b7ff"
    float: "#71b7ff"
    string: "#addcff"
    nothing: "#7a828e"
    binary: "#e09b13"
    cell_path: "#f0f3f6"
    row_index: { fg: "#09b43a" attr: "b" }
    record: "#f0f3f6"
    list: "#f0f3f6"
    block: "#f0f3f6"
    hints: "#7a828e"
    search_result: { fg: "#0a0c10" bg: "#e09b13" }

    shape_and: { fg: "#ff6a69" attr: "b" }
    shape_binary: { fg: "#e09b13" attr: "b" }
    shape_block: { fg: "#409eff" attr: "b" }
    shape_bool: "#71b7ff"
    shape_closure: { fg: "#09b43a" attr: "b" }
    shape_custom: "#09b43a"
    shape_datetime: { fg: "#76e3ea" attr: "b" }
    shape_directory: "#76e3ea"
    shape_external: "#76e3ea"
    shape_externalarg: { fg: "#09b43a" attr: "b" }
    shape_external_resolved: { fg: "#4ae168" attr: "b" }
    shape_filepath: "#76e3ea"
    shape_flag: { fg: "#409eff" attr: "b" }
    shape_float: { fg: "#e09b13" attr: "b" }
    shape_garbage: { fg: "#ffffff" bg: "#ff6a69" attr: "b" }
    shape_glob_interpolation: { fg: "#76e3ea" attr: "b" }
    shape_globpattern: { fg: "#76e3ea" attr: "b" }
    shape_int: { fg: "#e09b13" attr: "b" }
    shape_internalcall: { fg: "#76e3ea" attr: "b" }
    shape_keyword: { fg: "#ff6a69" attr: "b" }
    shape_list: { fg: "#76e3ea" attr: "b" }
    shape_literal: "#409eff"
    shape_match_pattern: "#09b43a"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#71b7ff"
    shape_operator: "#ff6a69"
    shape_or: { fg: "#e09b13" attr: "b" }
    shape_pipe: { fg: "#e09b13" attr: "b" }
    shape_range: { fg: "#e09b13" attr: "b" }
    shape_record: { fg: "#76e3ea" attr: "b" }
    shape_redirection: { fg: "#e09b13" attr: "b" }
    shape_signature: { fg: "#09b43a" attr: "b" }
    shape_string: "#addcff"
    shape_string_interpolation: { fg: "#76e3ea" attr: "b" }
    shape_table: { fg: "#409eff" attr: "b" }
    shape_variable: "#b780ff"
    shape_vardecl: "#b780ff"
    shape_raw_string: { fg: "#f0f3f6" attr: "b" }

    background: "#0a0c10"
    foreground: "#f0f3f6"
    cursor: "#f0f3f6"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#f0f3f6", bg: "#272b33" },
    command_bar_text: { fg: "#f0f3f6" },
    highlight: { fg: "#0a0c10", bg: "#409eff" },
    status: {
        error: "#ff6a69",
        warn: "#e09b13",
        info: "#409eff",
    },
    selected_cell: { bg: "#409eff22" fg: "#f0f3f6" },
}