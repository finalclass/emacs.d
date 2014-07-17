(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(load-file "~/.emacs.d/better-defaults/better-defaults.el")
(require 'better-defaults)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(require 'yasnippet)
(yas-global-mode 1)
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include/"))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
(global-ede-mode 1)
(ede-cpp-root-project "main" :file "~sel/main.cpp")
(global-semantic-idle-scheduler-mode 1)
(require 'multiple-cursors)
(global-set-key (kbd "C-M-l") 'mc/edit-lines)
(global-set-key (kbd "C-j") 'mc/mark-next-like-this)
(global-set-key (kbd "C-u") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-j") 'mc/mark-all-like-this)

(require 'sr-speedbar)
(global-set-key (kbd "M-1") 'sr-speedbar-toggle)
(setq sr-speedbar-right-side nil)
(custom-set-variables '(speedbar-show-unknown-files t))

(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(require 'tss)
(setq tss-popup-help-key "C-:")
(setq tss-jump-to-definition-key "C->")
;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "tss")
;; Do setting recommemded configuration
(tss-config-default)

(require 'org)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

(require 'stylus-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))

(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(setq js-indent-level 2)
(setq typescript-indent-level 2)

