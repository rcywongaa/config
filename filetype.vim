if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.launch setfiletype xml
    au! BufRead,BufNewFile *.world setfiletype xml
augroup END
