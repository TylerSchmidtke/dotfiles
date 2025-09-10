# GitHub Light theme for Nushell

$env.config.color_config = {
    separator: "#d0d7de"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#1a7f37" attr: "b" }
    empty: "#0969da"
    bool: {
        true: { fg: "#1a7f37" }
        false: { fg: "#cf222e" }
    }
    int: "#0550ae"
    filesize: {
        metric: { fg: "#0550ae" attr: "b" }
    }
    duration: "#9a6700"
    date: {
        now: { fg: "#1a7f37" attr: "b" }
        ago: { fg: "#8250df" }
    }
    range: "#0550ae"
    float: "#0550ae"
    string: "#0a3069"
    nothing: "#6e7781"
    binary: "#9a6700"
    cell_path: "#24292f"
    row_index: { fg: "#1a7f37" attr: "b" }
    record: "#24292f"
    list: "#24292f"
    block: "#24292f"
    hints: "#6e7781"
    search_result: { fg: "#ffffff" bg: "#9a6700" }

    shape_and: { fg: "#cf222e" attr: "b" }
    shape_binary: { fg: "#9a6700" attr: "b" }
    shape_block: { fg: "#0969da" attr: "b" }
    shape_bool: "#0550ae"
    shape_closure: { fg: "#1a7f37" attr: "b" }
    shape_custom: "#1a7f37"
    shape_datetime: { fg: "#1b7c83" attr: "b" }
    shape_directory: "#1b7c83"
    shape_external: "#1b7c83"
    shape_externalarg: { fg: "#1a7f37" attr: "b" }
    shape_external_resolved: { fg: "#055d20" attr: "b" }
    shape_filepath: "#1b7c83"
    shape_flag: { fg: "#0969da" attr: "b" }
    shape_float: { fg: "#9a6700" attr: "b" }
    shape_garbage: { fg: "#000000" bg: "#cf222e" attr: "b" }
    shape_glob_interpolation: { fg: "#1b7c83" attr: "b" }
    shape_globpattern: { fg: "#1b7c83" attr: "b" }
    shape_int: { fg: "#9a6700" attr: "b" }
    shape_internalcall: { fg: "#1b7c83" attr: "b" }
    shape_keyword: { fg: "#cf222e" attr: "b" }
    shape_list: { fg: "#1b7c83" attr: "b" }
    shape_literal: "#0969da"
    shape_match_pattern: "#1a7f37"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "#0550ae"
    shape_operator: "#cf222e"
    shape_or: { fg: "#9a6700" attr: "b" }
    shape_pipe: { fg: "#9a6700" attr: "b" }
    shape_range: { fg: "#9a6700" attr: "b" }
    shape_record: { fg: "#1b7c83" attr: "b" }
    shape_redirection: { fg: "#9a6700" attr: "b" }
    shape_signature: { fg: "#1a7f37" attr: "b" }
    shape_string: "#0a3069"
    shape_string_interpolation: { fg: "#1b7c83" attr: "b" }
    shape_table: { fg: "#0969da" attr: "b" }
    shape_variable: "#8250df"
    shape_vardecl: "#8250df"
    shape_raw_string: { fg: "#24292f" attr: "b" }

    background: "#ffffff"
    foreground: "#24292f"
    cursor: "#24292f"
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: "#24292f", bg: "#f6f8fa" },
    command_bar_text: { fg: "#24292f" },
    highlight: { fg: "#ffffff", bg: "#0969da" },
    status: {
        error: "#cf222e",
        warn: "#9a6700",
        info: "#0969da",
    },
    selected_cell: { bg: "#0969da22" fg: "#24292f" },
}