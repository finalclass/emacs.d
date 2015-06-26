;; (when (>= emacs-major-version 24)
  ;; (require 'package)
  ;; (add-to-list
   ;; 'package-archives
   ;; '("melpa" . "http://melpa.org/packages/")
   ;; t)
    ;; (package-initialize))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)


					;packages
;; Setup packages
(require 'setup-package)

(defun init--install-packages ()
  (package-install 'magit)
  (package-install 'flx-ido)
  (package-install 'yasnippet)
  (package-install 'smartparens)
  (package-install 'ido-vertical-mode)
  (package-install 'ido-at-point)
  (package-install 'multiple-cursors)
  (package-install 'tern)
  (package-install 'tern-auto-complete)
  (package-install 'js3-mode)
  (package-install 'auto-complete)
  (package-install 'darcula-theme)
  (package-install 'smart-tab)
  (package-install 'emmet-mode)
  )

(init--install-packages)

					;setup extensions
(require 'setup-yasnippet)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

					;server

(require 'server)
(unless (server-running-p)
  (server-start))


					;zap-up-to-char
(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.
    \(fn arg char)"
    'interactive)

					;JavaScript
;; js3-mode
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(custom-set-variables
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js3-indent-level 4)
 '(js3-auto-indent-p t)
 '(js3-strict-trailing-comma-warning nil)
 '(js3-indent-on-enter-key t)
 '(js3-enter-indents-newline t)
 '(js3-consistent-level-indent-inner-bracket t))

; prettify symbls are causing the problem when you place a parentisies after the function name
;(defconst prettify-symbols-alist
;  '(
;    ("function" . ?λ)
;    ("return" . ?←)
;    ))

;(global-prettify-symbols-mode +1)
;(add-hook 'js3-mode-hook (lambda () (prettify-symbols-mode t)))

					;tern
(global-auto-complete-mode t)
(add-hook 'js3-mode-hook (lambda () (tern-mode t)))
(add-hook 'js3-mode-hook (lambda () (auto-complete-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
           (tern-ac-setup)))
		
					;JSON
(add-hook 'json-mode-hook ;indentation
	  (lambda ()
	    (make-local-variable 'js-indent-level)
	                (setq js-indent-level 2)))

					;GUI config
(tool-bar-mode -1)
(require 'darcula-theme)
(set-frame-font "Inconsolata-18")
(setq-default line-spacing 4)

					;other
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq transient-mark-mode t)
(setq visible-bell t)
(show-paren-mode t)
(pending-delete-mode t)
(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier nil)

					;moving
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

					;autosave & backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

					;smart-tab
(global-smart-tab-mode 1)

					;comment

(defun toggle-comment-on-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;keyboard shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

					;home/end
(global-unset-key (kbd "<end>"))
(global-unset-key (kbd "<home>"))

					;commenting
(global-set-key (kbd "C-\\") 'toggle-comment-on-region-or-line) 

					;multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-unset-key (kbd "C-j")) (global-set-key (kbd "C-j") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-`") 'er/expand-region)

					;scrolling
(global-set-key (kbd "M-<down>") `scroll-up-line)
(global-set-key (kbd "M-<up>") `scroll-down-line)

					;windows
(global-set-key (kbd "C-x -") 'shrink-window-if-larger-than-buffer)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-x +") 'balance-windows)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)
(global-set-key (kbd "C-x ^") 'enlarge-window)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)

					;moving
(global-set-key (kbd "C-<up>") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-<down>") (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

					;other
(global-set-key (kbd "C-x z") 'repeat)

					;selection
(global-set-key (kbd "C-x h") 'mark-whole-buffer)

					;indent
(global-set-key (kbd "C-M-\\") 'indent-region)

					;emmet
(global-set-key (kbd "C-;") 'emmet-expand-line)

					;zap-up-to-char replacement
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-M-z") 'repeat)
