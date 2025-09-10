let theme = {
  black: "#131313"
  red: "#DD6F61"
  green: "#76BA53"
  yellow: "#857F5C"
  blue: "#81A9F6"
  magenta: "#AE30C2"
  cyan: "#3DB6B0"
  white: "#CACCCA"
  orange: "#E1D797"
  pink: "#D86DE9"
  comment: "#5BDFD8"
  bg0: "#131313"
  bg1: "#161616"
  bg2: "#1A1A1A"
  bg3: "#202020"
  bg4: "#5A5A5A"
  fg0: "#CACCCA"
  fg1: "#B0B2B0"
  fg2: "#9E9E9E"
  fg3: "#7A7A7A"
  sel0: "#2A3F5F"
  sel1: "#3A4F6F"
}

let scheme = {
  recognized_command: $theme.blue
  unrecognized_command: $theme.fg2
  constant: $theme.blue
  punctuation: $theme.fg1
  operator: $theme.cyan
  string: $theme.green
  virtual_text: $theme.bg4
  variable: { fg: $theme.fg1 attr: n }
  filepath: $theme.orange
}

$env.config.color_config = {
  separator: { fg: $theme.bg4 attr: b }
  leading_trailing_space_bg: { fg: $theme.cyan attr: u }
  header: { fg: $theme.fg0 attr: b }
  row_index: $scheme.virtual_text
  record: $theme.fg1
  list: $theme.fg1
  hints: $scheme.virtual_text
  search_result: { fg: $theme.bg0 bg: $theme.sel1 }
  shape_closure: $theme.cyan
  closure: $theme.cyan
  shape_flag: { fg: $theme.red attr: n }
  shape_matching_brackets: { attr: u }
  shape_garbage: $theme.red
  shape_keyword: $theme.blue
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
  shape_custom: $theme.magenta
  custom: $theme.magenta
  background: $theme.bg0
  foreground: $theme.fg0
  cursor: { bg: $theme.fg0 fg: $theme.bg0 }
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
  bool: $theme.red
  float: $scheme.constant
  nothing: $scheme.constant
  binary: $scheme.constant
  shape_nothing: $scheme.constant
  shape_bool: $theme.red
  shape_float: $scheme.constant
  shape_binary: $scheme.constant
  shape_datetime: $scheme.constant
  shape_literal: $theme.magenta
  string: $scheme.string
  shape_string: $scheme.string
  shape_string_interpolation: $theme.pink
  shape_raw_string: $scheme.string
  shape_externalarg: $scheme.string
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: $theme.fg0, bg: $theme.bg3 },
    command_bar_text: { fg: $theme.fg0 },
    highlight: { fg: $theme.bg0, bg: $theme.sel0 },
    status: {
        error: $theme.red,
        warn: $theme.yellow,
        info: $theme.blue,
    },
    selected_cell: { bg: $theme.sel0 fg: $theme.fg0 },
}