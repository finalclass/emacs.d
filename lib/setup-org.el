                                        ;org-mode (for ribbon and windmove compatibility)
(setq org-replace-disputed-keys t)
(eval-after-load "org"
  '(progn
     ;;(define-key org-mode-map (kbd "<M-S-left>") nil)
     ;;(define-key org-mode-map (kbd "<M-S-right>") nil)
     (define-key org-mode-map (kbd "<M-left>") nil)
     (define-key org-mode-map (kbd "<M-right>") nil)))

(defun org-mode-is-intrusive ()
  ;; Make something work in org-mode:
  ;; (local-unset-key (kbd "something I use"))
  (local-unset-key (kbd "M-n"))
  (local-unset-key (kbd "M-p")))
(add-hook 'org-mode-hook 'org-mode-is-intrusive)

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
