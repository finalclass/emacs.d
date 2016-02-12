(setq lib-dir (expand-file-name "lib" user-emacs-directory))
(add-to-list 'load-path lib-dir)

(require 'setup-package)
(require 'setup-org)
(require 'setup-doremi)
(require 'setup-markdown)
(require 'setup-elisp)
(require 'setup-fc-bin)
(require 'setup-mac)
(require 'setup-winner)
(require 'setup-html)
(require 'setup-ribbon)
(require 'setup-dired)
(require 'setup-yasnippet)
(require 'setup-ido)
(require 'setup-duplicate-line)
(require 'setup-typescript)
(require 'setup-magit)
(require 'setup-coffeescript)
;; (require 'setup-server)
(require 'setup-window-configuration-registry)
(require 'setup-paredit)
(require 'setup-indent-after-yanking)
(require 'setup-kill-line)
(require 'setup-zap-up-to-char)
(require 'setup-kill-whitespace)
(require 'setup-javascript)
(require 'setup-restclient)
(require 'setup-json)
(require 'setup-gui)
(require 'setup-smart-beginning-of-line)
(require 'setup-autosave-and-backup)
(require 'setup-comments)
(require 'setup-move-line)
(require 'setup-multiple-cursors)
(require 'setup-scrolling)
(require 'setup-moving)
(require 'setup-windmove)
(require 'setup-fiplr)
(require 'setup-repeat)
(require 'setup-selection)
(require 'setup-folding)
(require 'setup-smartparens)
(require 'setup-jade)
(require 'strings)
(require 'editor-keyboard-shortcuts)
(require 'setup-kbd-projects)

(defun prelude-google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

; TAB autocomplete after indent
;; (setq tab-always-indent 'complete)
;; (add-to-list 'completion-styles 'initials t)

(setq compile-command "fc-deploy.sh")

;;Install these 24 packages (yasnippet-0.8.0, web-mode-20151218.1400, typescript-mode-20150830.1828, tss-20150913.708, tern-20151228.511, smartparens-20151226.1556, restclient-20151128.1512, paredit-20150217.713, multiple-cursors-20151205.1225, magit-20151226.439, js2-mode-20150909, jade-mode-20150801.944, ido-vertical-mode-20151003.1833, ido-at-point-20151021.57, flymake-coffee-20140809.324, flx-ido-20151030.1112, fiplr-20140723.2345, exec-path-from-shell-20151125.1133, emmet-mode-20151213.738, doremi-frm-20150727.1354, doremi-cmd-20150104.1352, doremi-20150815.738, darcula-theme-20150629.235, coffee-mode-0.4.1.1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(coffee-tab-width 4)
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(js2-auto-indent-p t)
 '(js2-consistent-level-indent-inner-bracket t)
 '(js2-enter-indents-newline t)
 '(js2-indent-level 4)
 '(js2-indent-on-enter-key t)
 '(js2-mode-show-strict-warnings t)
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-trailing-comma-warning nil)
 '(mode-line-in-non-selected-windows t)
 '(org-agenda-files (quote ("~/todo-home.org"))))

(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))

(ad-activate 'pop-to-buffer)

;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

;; Press [pause] key in each window you want to "freeze"
(global-set-key (kbd "C-c C-l") 'toggle-window-dedicated)

(global-unset-key (kbd "C-q"))

(defun camel-case-to-dash-case ()
  "Toggle between camcelcase and underscore notation for the symbol at point."
  (interactive)
  (save-excursion
    (let* ((bounds (bounds-of-thing-at-point 'symbol))
           (start (car bounds))
           (end (cdr bounds))
           (currently-using-underscores-p (progn (goto-char start)
                                                 (re-search-forward "_" end t))))
      (if currently-using-underscores-p
          (progn
            (upcase-initials-region start end)
            (replace-string "_" "" nil start end)
            (downcase-region start (1+ start)))
        (replace-regexp "\\([A-Z]\\)" "-\\1" nil (1+ start) end)
        (downcase-region start end)))))

(global-set-key (kbd "C-q C-d")  'camel-case-to-dash-case)


;Kill the process in "list-processes"

(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)

(defun joaot/delete-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process
                (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error "no process at point!")))))


                                        ;saved macros
(fset 'dash-to-camel-case
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([19 45 return 67108896 right 24 21 left backspace] 0 "%d")) arg)))


;; (defun my-paredit-nonlisp ()
  ;; "Turn on paredit mode for non-lisps."
  ;; (interactive)
  ;; (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       ;; '((lambda (endp delimiter) nil)))
  ;; (paredit-mode 1))

;; (add-hook 'js-mode-hook 'my-paredit-nonlisp)


                                        ;prompt before closing

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(setq-default show-trailing-whitespace t)
(global-set-key (kbd "C-c C-x C-w") 'delete-trailing-whitespace)

                                        ;smart-mode-line
(smart-mode-line-enable)
(setq sml/no-confirm-load-theme t)
(sml/apply-theme 'powerline)
(sml/setup)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t (:background "gray99" :foreground "gray24" :inverse-video t :underline nil :slant normal :weight normal)))))
