					;moving
(global-set-key (kbd "C-<up>") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-<down>") (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))

(provide 'setup-moving)
