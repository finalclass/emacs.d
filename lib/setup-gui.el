(package-install 'darcula-theme)


					;GUI config
(tool-bar-mode -1)
(require 'darcula-theme)
(set-frame-font "Inconsolata-12")
(setq-default line-spacing 4)

					;other
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq transient-mark-mode t)
(setq visible-bell nil)
(show-paren-mode t)
(pending-delete-mode t)
(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier nil)


                                        ;menubar
(menu-bar-mode -1)

                                        ;mode-line colors
 

(provide 'setup-gui)
