					;autosave & backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

                                        ;disable interlocks (.#* files)
(setq create-lockfiles nil)

(provide 'setup-autosave-and-backup)
