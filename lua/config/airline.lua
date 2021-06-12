local g = vim.g

g.airline_powerline_fonts = 1

g.airline_left_sep = '›' -- Slightly fancier than '>'
g.airline_right_sep = '‹' -- Slightly fancier than '<'

g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
g['airline#extensions#tabline#enabled'] = 1
g['airline#extensions#tabline#left_sep'] = ' '
g['airline#extensions#tabline#left_alt_sep'] = ' '
g['airline#extensions#tabline#buffer_nr_format'] = '%s '
g['airline#extensions#tabline#buffer_nr_show'] = 1
