let theme = {
  black: "#393b44"
  red: "#c94f6d"
  green: "#81b29a"
  yellow: "#dbc074"
  blue: "#719cd6"
  magenta: "#9d79d6"
  cyan: "#63cdcf"
  white: "#dfdfe0"
  orange: "#f4a261"
  pink: "#d67ad2"
  comment: "#738091"
  bg0: "#131a24"
  bg1: "#192330"
  bg2: "#212e3f"
  bg3: "#29394f"
  bg4: "#39506d"
  fg0: "#d6d6d7"
  fg1: "#cdcecf"
  fg2: "#aeafb0"
  fg3: "#71839b"
  sel0: "#2b3b51"
  sel1: "#3c5372"
}

let scheme = {
  recognized_command: $theme.blue
  unrecognized_command: $theme.fg1
  constant: $theme.orange
  punctuation: $theme.fg2
  operator: $theme.cyan
  string: $theme.green
  virtual_text: $theme.comment
  variable: { fg: $theme.pink attr: i }
  filepath: $theme.yellow
}

$env.config.color_config = {
  separator: { fg: $theme.bg4 attr: b }
  leading_trailing_space_bg: { fg: $theme.cyan attr: u }
  header: { fg: $theme.fg0 attr: b }
  row_index: $theme.comment
  record: $theme.fg1
  list: $theme.fg1
  hints: $theme.fg3
  search_result: { fg: $theme.bg0 bg: $theme.yellow }
  shape_closure: $theme.cyan
  closure: $theme.cyan
  shape_flag: { fg: $theme.red attr: i }
  shape_matching_brackets: { attr: u }
  shape_garbage: $theme.red
  shape_keyword: $theme.magenta
  shape_match_pattern: $theme.green
  shape_signature: $theme.cyan
  shape_table: $scheme.punctuation
  cell-path: $scheme.punctuation
  shape_list: $scheme.punctuation
  shape_record: $scheme.punctuation
  shape_vardecl: $scheme.variable
  shape_variable: $scheme.variable
  empty: { attr: n }
  filesize: {||
    if $in < 1kb {
      $theme.cyan
    } else if $in < 10kb {
      $theme.green
    } else if $in < 100kb {
      $theme.yellow
    } else if $in < 10mb {
      $theme.orange
    } else if $in < 100mb {
      $theme.red
    } else if $in < 1gb {
      $theme.red
    } else {
      $theme.magenta
    }
  }
  duration: {||
    if $in < 1day {
      $theme.cyan
    } else if $in < 1wk {
      $theme.green
    } else if $in < 4wk {
      $theme.yellow
    } else if $in < 12wk {
      $theme.orange
    } else if $in < 24wk {
      $theme.red
    } else if $in < 52wk {
      $theme.red
    } else {
      $theme.magenta
    }
  }
  date: {|| (date now) - $in |
    if $in < 1day {
      $theme.cyan
    } else if $in < 1wk {
      $theme.green
    } else if $in < 4wk {
      $theme.yellow
    } else if $in < 12wk {
      $theme.orange
    } else if $in < 24wk {
      $theme.red
    } else if $in < 52wk {
      $theme.red
    } else {
      $theme.magenta
    }
  }
  shape_external: $scheme.unrecognized_command
  shape_internalcall: $scheme.recognized_command
  shape_external_resolved: $scheme.recognized_command
  shape_block: $scheme.recognized_command
  block: $scheme.recognized_command
  shape_custom: $theme.pink
  custom: $theme.pink
  background: $theme.bg1
  foreground: $theme.fg1
  cursor: { bg: $theme.white fg: $theme.bg1 }
  shape_range: $scheme.operator
  range: $scheme.operator
  shape_pipe: $scheme.operator
  shape_operator: $scheme.operator
  shape_redirection: $scheme.operator
  glob: $scheme.filepath
  shape_directory: $scheme.filepath
  shape_filepath: $scheme.filepath
  shape_glob_interpolation: $scheme.filepath
  shape_globpattern: $scheme.filepath
  shape_int: $scheme.constant
  int: $scheme.constant
  bool: $scheme.constant
  float: $scheme.constant
  nothing: $scheme.constant
  binary: $scheme.constant
  shape_nothing: $scheme.constant
  shape_bool: $scheme.constant
  shape_float: $scheme.constant
  shape_binary: $scheme.constant
  shape_datetime: $scheme.constant
  shape_literal: $scheme.constant
  string: $scheme.string
  shape_string: $scheme.string
  shape_string_interpolation: $theme.pink
  shape_raw_string: $scheme.string
  shape_externalarg: $scheme.string
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: $theme.fg1, bg: $theme.bg2 },
    command_bar_text: { fg: $theme.fg1 },
    highlight: { fg: $theme.bg1, bg: $theme.yellow },
    status: {
        error: $theme.red,
        warn: $theme.yellow,
        info: $theme.blue,
    },
    selected_cell: { bg: $theme.blue fg: $theme.bg1 },
}
