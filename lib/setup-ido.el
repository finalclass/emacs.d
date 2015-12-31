(package-install 'flx-ido)
(package-install 'ido-vertical-mode)
(package-install 'ido-at-point)

(require 'flx-ido)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

(provide 'setup-ido)
