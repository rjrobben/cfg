(fn hello []
  (print "Hello World Fennel!"))

(fn setup []
  (vim.api.nvim_create_user_command :HelloFennel hello {}))

;; 將 setup 函式對外匯出，讓 init.vim 可以呼叫
{: setup}
