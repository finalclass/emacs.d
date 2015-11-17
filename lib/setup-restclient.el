(package-install 'restclient)
                                        ;company
(eval-after-load 'company 
  '(add-to-list 'company-backends 'company-restclient))

(provide 'setup-restclient)
