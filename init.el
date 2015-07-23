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
  (package-install 'js2-mode)
  (package-install 'auto-complete)
  (package-install 'darcula-theme)
  (package-install 'emmet-mode)
  (package-install 'company-restclient)
  (package-install 'ac-js2)
  (package-install 'restclient)
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

					;duplicate line
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))


					;magit

(setq magit-last-seen-setup-instructions "1.4.0")

                                        ;org-babel

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (js . t)
   )
 )

					;server

(require 'server)
(unless (server-running-p)
  (server-start))

					;indent after yanking
(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
						      js2-mode js-mode html-mode css-mode
                                                      plain-tex-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))

					;kill and join forward

(defadvice kill-line (before check-position activate)
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 0)
             (backward-char 1))))

					;shell

(setenv "PATH" (concat "/usr/local/bin:" "/Users/szymon/.nvm/v0.10.38/bin:" (getenv "PATH")))

					;zap-up-to-char
(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.
    \(fn arg char)"
    'interactive)


					;kill whitespace

(defun kill-whitespace ()
          "Kill the whitespace between two non-whitespace characters"
          (interactive "*")
          (save-excursion
            (save-restriction
              (save-match-data
                (progn
                  (re-search-backward "[^ \t\r\n]" nil t)
                  (re-search-forward "[ \t\r\n]+" nil t)
                  (replace-match "" nil nil))))))

					;JavaScript
;; js2-mode
;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-auto-indent-p t)
 '(js2-consistent-level-indent-inner-bracket t)
 '(js2-enter-indents-newline t)
 '(js2-indent-level 4)
 '(js2-indent-on-enter-key t)
 '(js2-mode-show-strict-warnings t)
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-trailing-comma-warning nil)
 '(org-agenda-files (quote ("~/todo-home.org"))))

(setq-default indent-tabs-mode nil)

(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

;; prettify symbls are causing the problem when you place a parentisies after the function name
(defconst prettify-symbols-alist
 '(
   ("function" . ?λ)
   ("return" . ?←)
   ))

(global-prettify-symbols-mode +1)
(add-hook 'js2-mode-hook (lambda () (prettify-symbols-mode t)))

					;company
(eval-after-load 'company 
  '(add-to-list 'company-backends 'company-tern)
  )

					;restclient
(eval-after-load 'company 
  '(add-to-list 'company-backends 'company-restclient))

					;JSON

(add-hook 'json-mode-hook 'lambda () (setq js-indent-level 2))

;; (add-hook 'json-mode-hook ;indentation
	  ;; (lambda ()
	    ;; (make-local-variable 'js-indent-level)
	                ;; (setq js-indent-level 2)))

					;GUI config
(tool-bar-mode -1)
(require 'darcula-theme)
(set-frame-font "Inconsolata-12")
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

					;fipl
(global-set-key (kbd "C-x f") 'fiplr-find-file)

					;Moving between windows (S-<left> etc...)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(setq org-replace-disputed-keys t)

					;kill whitespace
(global-set-key (kbd "C-x j") 'kill-whitespace)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


					;duplicate line
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(put 'upcase-region 'disabled nil)
