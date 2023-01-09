if exists('g:plug_installing_plugins')

    Plug 'bkad/CamelCaseMotion'

    finish

endif

map <silent> b          <Plug>CamelCaseMotion_b
map <silent> e          <Plug>CamelCaseMotion_e
map <silent> ge         <Plug>CamelCaseMotion_ge
map <silent> w          <Plug>CamelCaseMotion_w
sunmap w
sunmap b
sunmap e
sunmap ge

omap <silent> ib        <Plug>CamelCaseMotion_ib
omap <silent> ie        <Plug>CamelCaseMotion_ie
omap <silent> iw        <Plug>CamelCaseMotion_iw
xmap <silent> ib        <Plug>CamelCaseMotion_ib
xmap <silent> ie        <Plug>CamelCaseMotion_ie
xmap <silent> iw        <Plug>CamelCaseMotion_iw

imap <silent> <S-Left>  <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w
