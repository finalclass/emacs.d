(package-install 'restclient)
                                        ;company
(eval-after-load 'company 
  '(add-to-list 'company-backends 'company-restclient))

(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))

(provide 'setup-restclient)
