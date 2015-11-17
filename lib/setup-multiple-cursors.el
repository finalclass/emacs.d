(package-install 'multiple-cursors)

					;multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-unset-key (kbd "C-j")) (global-set-key (kbd "C-j") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-`") 'er/expand-region)


(provide 'setup-multiple-cursors)
