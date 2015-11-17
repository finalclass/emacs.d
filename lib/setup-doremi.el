(package-install 'doremi)
(package-install 'doremi-frm)
(package-install 'doremi-cmd)

(require 'doremi)
(require 'doremi-frm)
(require 'doremi-cmd)

(global-set-key (kbd "C-x w <right>") 'doremi-window-width+)
(global-set-key (kbd "C-x w <left>") 'doremi-window-width+)
(global-set-key (kbd "C-x w <up>") 'doremi-window-height+)
(global-set-key (kbd "C-x w <down>") 'doremi-window-height+)

(provide 'setup-doremi)
