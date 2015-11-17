                                        ;org-mode (for ribbon and windmove compatibility)
(setq org-replace-disputed-keys t)
(eval-after-load "org"
  '(progn
     ;;(define-key org-mode-map (kbd "<M-S-left>") nil)
     ;;(define-key org-mode-map (kbd "<M-S-right>") nil)
     (define-key org-mode-map (kbd "<M-left>") nil)
     (define-key org-mode-map (kbd "<M-right>") nil)))

                                        ;org-babel
(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (js . t)
   )
 )

(custom-set-variables
 '(org-agenda-files (quote ("~/todo-home.org"))))

(provide 'setup-org)
