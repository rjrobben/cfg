(local pick (require :mini.pick))

(var history [])
(var idx 0)

(fn history-prev []
  (when (> (length history) 0)
    (set idx (math.min (+ idx 1) (length history)))
    (pick.set_picker_query (vim.split (. history idx) ""))))

(fn history-next []
  (when (> idx 1)
    (set idx (- idx 1))
    (pick.set_picker_query (vim.split (. history idx) ""))))

(fn save-current []
  (let [q (table.concat (pick.get_picker_query) "")]
    (when (not= q "")
      (table.insert history 1 q))))

(fn grep-live []
  (set idx 0)
  (pick.builtin.grep_live {}
                          {:mappings {:hist_prev {:char :<C-p>
                                                  :func history-prev}
                                      :hist_next {:char :<C-n>
                                                  :func history-next}}}))

(fn setup []
  (vim.api.nvim_create_autocmd :User
                               {:pattern :MiniPickStop
                                :callback (fn []
                                            (let [q (pick.get_picker_query)]
                                              (when q
                                                (let [s (table.concat q "")]
                                                  (when (not= s "")
                                                    (table.insert history 1 s))))))})
  (vim.api.nvim_create_user_command :PickGrepLive grep-live {}))

{: setup : grep-live : history : save-current}
