(setq fc-projects-init-file-path "~/.emacs.d/projects.el")

(defun read-lines (file-path)
  "Return a list of lines of a file at file-path."
  (with-temp-buffer
    (insert-file-contents file-path)
    (split-string (buffer-string) "\n" t)))

(defun kbd-project (path key)
  (interactive argument-passing-info)
  (global-set-key (kbd (concat "C-x p " key)) '(lambda () (interactive) (dired path))))

(defun kbd-projects-load-init-file (file-path)
  "Loads ~/.emacs.d/projects.el file"
  (interactive)
  (with-temp-buffer
    (insert-file-contents file-path)
    (eval-buffer)))

(defun kbd-projects-initialize ()
  (interactive)
  (if (file-exists-p fc-projects-init-file-path)
      (kbd-projects-load-init-file fc-projects-init-file-path)))

(kbd-load-projects-file)

(provide 'setup-kbd-projects)
