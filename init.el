(setq lib-dir (expand-file-name "lib" user-emacs-directory))
(add-to-list 'load-path lib-dir)

(require 'setup-package)
(require 'setup-org)
(require 'setup-doremi)
(require 'setup-markdown)
(require 'setup-elisp)
(require 'setup-fp)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#a9b7c6" :foreground "#3c3f41" :inverse-video t :box nil :underline t :slant normal :weight normal))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#a9b7c5" :foreground "#3c3f41" :inverse-video t :box nil :underline nil :slant normal :weight normal)))))
