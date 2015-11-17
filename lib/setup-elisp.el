                                        ;elisp
;;eval whole buffer and show message
(defun sel-eval-buffer ()
  (interactive)
  (eval-buffer)
  (message "Buffer evaluated"))

(global-set-key (kbd "C-b") 'sel-eval-buffer)

;;autocomplete
;;(setq tab-always-indent 'complete)
;;(add-to-list 'completion-styles 'initials t)

(provide 'setup-elisp)
