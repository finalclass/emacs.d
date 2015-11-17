(package-install 'flx-ido)
(package-install 'ido-vertical-mode)
(package-install 'ido-at-point)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

(provide 'setup-ido)
