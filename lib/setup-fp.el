(defun fp-get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun fp-eid-file-path ()
  (concat temporary-file-directory "/fp-eid"))

(defun fp-set-eid (eid)
  (interactive "sEID: ")
  (with-temp-buffer
    (insert eid)
    (write-file (fp-eid-file-path))))

(defun fp-get-eid ()
  (interactive)
  (fp-get-string-from-file (fp-eid-file-path)))

(defun fp-deploy ()
  (interactive)
  (let ((command (concat "fp deploy " (fp-get-eid))))
    (message command)
    (shell-command command "*fp*" "*fp-errors*")))
     
(provide 'setup-fp)
