# type: ignore
with section('format'):
    line_width = 80
    tab_size = 2
    separate_ctrl_name_with_space = False
    separate_fn_name_with_space = False
    dangle_parens = True

with section('lint'):
    disabled_codes = ['C0113', 'C0103']
    function_pattern = '[0-9a-z_]+'
    max_statement_spacing = 2
