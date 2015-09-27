(defun grid-init-data-structures ()
  ;;reset
  (setq grid-windows ())
  (setq grid-buffers-hash (make-hash-table))
  (setq grid-buffer-no 0)
  
  ;;populate grid-windows and grid-buffers-hash
  (add-to-list 'grid-windows (selected-window))
  (puthash 0 (window-buffer (nth 0 grid-windows)) grid-buffers-hash)
  
  (add-to-list 'grid-windows (next-window (selected-window)))
  (puthash 1 (window-buffer (nth 1 grid-windows)) grid-buffers-hash)
  
  (add-to-list 'grid-windows (next-window (next-window (selected-window))))
  (puthash 2 (window-buffer (nth 2 grid-windows)) grid-buffers-hash)
  )

(defun grid-save-current-state ()
  (puthash grid-buffer-no (window-buffer (nth 0 grid-windows)) grid-buffers-hash)
  (puthash (+ grid-buffer-no 1) (window-buffer (nth 1 grid-windows)) grid-buffers-hash)
  (puthash (+ grid-buffer-no 2) (window-buffer (nth 2 grid-windows)) grid-buffers-hash))

(defun grid-set-keyboard-shortcuts ()
  (global-set-key (kbd "<S-M-right>") 'grid-move-right)
  (global-set-key (kbd "<S-M-left>") 'grid-move-left))

(defun grid-split ()
  (split-window-right)
  (split-window-right)
  (balance-windows))

(defun grid-mode-start ()
  (interactive)
  (grid-split)
  (grid-init-data-structures)
  (grid-set-keyboard-shortcuts))

(defun update-windows-buffers ()
  (set-window-buffer (nth 0 grid-windows) (gethash grid-buffer-no grid-buffers-hash))
  (set-window-buffer (nth 1 grid-windows) (gethash (+ grid-buffer-no 1) grid-buffers-hash))
  (set-window-buffer (nth 2 grid-windows) (gethash (+ grid-buffer-no 2) grid-buffers-hash)))

(defun grid-ensure-buffers-exist ()
  (unless (gethash grid-buffer-no grid-buffers-hash)
    (puthash grid-buffer-no (get-buffer "*scratch*") grid-buffers-hash))
  (unless (gethash (+ grid-buffer-no 1) grid-buffers-hash)
    (puthash (+ grid-buffer-no 1) (get-buffer "*scratch*") grid-buffers-hash))
  (unless (gethash (+ grid-buffer-no 2) grid-buffers-hash)
    (puthash (+ grid-buffer-no 2) (get-buffer "*scratch*") grid-buffers-hash)))

(defun grid-describe-buffer (buffer-no)
  (concat
   "(" (number-to-string buffer-no) ")"
   (buffer-name (gethash buffer-no grid-buffers-hash))))
  
(defun grid-describe-buffers ()
  (message (concat
            (grid-describe-buffer (+ grid-buffer-no 0)) "   "
            (grid-describe-buffer (+ grid-buffer-no 1)) "   "
            (grid-describe-buffer (+ grid-buffer-no 2))) "   "
            ))

(defun grid-move-left ()
  (interactive)
  (grid-save-current-state)
  (setq grid-buffer-no (- grid-buffer-no 1))
  (grid-ensure-buffers-exist)
  (update-windows-buffers)
  (grid-describe-buffers))

(defun grid-move-right ()
  (interactive)
  (grid-save-current-state)
  (setq grid-buffer-no (+ grid-buffer-no 1))
  (grid-ensure-buffers-exist)
  (update-windows-buffers)
  (grid-describe-buffers))


(global-set-key (kbd "C-x r") 'grid-mode-start)

(provide 'setup-grid)
