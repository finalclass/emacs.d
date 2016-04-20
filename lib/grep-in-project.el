(require 'get-project-root)

(defun grep-in-project (text)
  "greps for the given text in the project (starting from .git directory)"
  (interactive "sSearch for: ")
  (rgrep text "*.*" (get-project-root)))

(global-set-key (kbd "C-c C-s") 'grep-in-project)

(provide 'grep-in-project)
