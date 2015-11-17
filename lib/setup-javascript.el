(package-install 'js2-mode)
(package-install 'tern)

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
 '(js2-strict-trailing-comma-warning nil))



(setq-default indent-tabs-mode nil)

(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)


;; prettify symbls are causing the problem when you place a parentisies after the function name
(defconst prettify-symbols-alist
  '(
    ("function" . ?λ)
    ("return" . ?←)
    ))

(eval-after-load 'tern
  '(setq tern-command (append tern-command '("--no-port-file"))))

(defun delete-tern-process ()
  (interactive)
  (delete-process "Tern"))

(global-prettify-symbols-mode +1)
(add-hook 'js2-mode-hook
          (lambda ()
            (hs-minor-mode +1)
            (prettify-symbols-mode t)
            (auto-complete-mode t)
            (tern-mode t)
            (tern-ac-setup)))


;; (add-hook 'json-mode-hook ;indentation
;; (lambda ()
;; (make-local-variable 'js-indent-level)
;; (setq js-indent-level 2)))


(provide 'setup-javascript)
