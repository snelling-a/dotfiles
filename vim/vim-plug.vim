" Source all the plugin files again, this time loading their configuration.
for file in split(glob(g:vimdir . '/plugins/*.vim'), '\n')
  exe 'source' file
endfor

for file in split(glob(g:vimdir . '/plugins/custom/*.vim'), '\n')
  exe 'source' file
endfor
