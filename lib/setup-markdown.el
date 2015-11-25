(package-install 'markdown-mode)

                                        ;markdown (conf for ribbon compatibility)

(add-hook
 'markdown-mode-hook
 '(lambda ()
    (substitute-key-definition 'markdown-promote-subtree 'nil markdown-mode-map)
    (substitute-key-definition 'markdown-demote-subtree 'nil markdown-mode-map)))


(provide 'setup-markdown)
