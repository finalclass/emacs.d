(package-install 'exec-path-from-shell)

                                        ;fix PATH env variable on mac
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

					;shell
(setenv "PATH" (concat "/usr/local/bin:" "/Users/szymon/.nvm/v0.10.38/bin:" (getenv "PATH")))


					;home/end
(global-unset-key (kbd "<end>"))
(global-unset-key (kbd "<home>"))

(provide 'setup-mac)
