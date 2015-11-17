					;zap-up-to-char
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.
    \(fn arg char)"
  'interactive)


					;zap-up-to-char replacement
(global-set-key (kbd "M-z") 'zap-up-to-char)


(provide 'setup-zap-up-to-char)
