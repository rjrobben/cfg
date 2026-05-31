(local pick (require :mini.pick))

(var state {:grep {:history [] :idx 0} :files {:history [] :idx 0}})

(var current nil)

(fn hist-prev []
  (let [s (. state current)]
    (when (> (length s.history) 0)
      (set s.idx (math.min (+ s.idx 1) (length s.history)))
      (pick.set_picker_query (vim.split (. s.history s.idx) "")))))

(fn hist-next []
  (let [s (. state current)]
    (when (> s.idx 1)
      (set s.idx (- s.idx 1))
      (pick.set_picker_query (vim.split (. s.history s.idx) "")))))

(fn open-picker [name builtin-fn]
  (set current name)
  (set (. state name :idx) 0)
  (builtin-fn {}
              {:mappings {:hist_prev {:char :<C-p> :func hist-prev}
                          :hist_next {:char :<C-n> :func hist-next}}}))

(fn setup []
  (vim.api.nvim_create_autocmd :User
                               {:pattern :MiniPickStop
                                :callback (fn []
                                            ;; (print (.. "current: "
                                            ;;            (vim.inspect current)))
                                            ;; (print (.. "query: "
                                            ;;            (vim.inspect (pick.get_picker_query))))
                                            (let [q (pick.get_picker_query)]
                                              (when (and current q)
                                                (let [s (table.concat q "")]
                                                  (when (not= s "")
                                                    (table.insert (. state
                                                                     current
                                                                     :history)
                                                                  1 s))))))})
  (vim.api.nvim_create_user_command :PickGrepLive
                                    #(open-picker :grep pick.builtin.grep_live)
                                    {})
  (vim.api.nvim_create_user_command :PickFiles
                                    #(open-picker :files pick.builtin.files) {}))

{: setup}
