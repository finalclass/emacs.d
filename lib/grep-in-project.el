(require 'get-project-root)
(require 'thingatpt)

(defun grep-in-project (text)
  "greps for the given text in the project (starting from .git directory)"
  (interactive (list
                (read-string (format "Search for (%s): " (thing-at-point 'symbol))
                             nil nil (thing-at-point 'symbol))))
  (rgrep text "*.*" (get-project-root)))

(defun msg-at-point ()
  (interactive)
  (message (thing-at-point 'symbol)))

(global-set-key (kbd "C-S-x s") 'grep-in-project)

(eval-after-load "grep"
  '(grep-compute-defaults))

(provide 'grep-in-project)
