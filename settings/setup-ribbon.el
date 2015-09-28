(defun ribbon-init-data-structures ()
  ;;reset
  (setq ribbon-windows ())
  (setq ribbon-buffers-hash (make-hash-table))
  (setq ribbon-buffer-no 0)
  
  ;;populate ribbon-windows and ribbon-buffers-hash
  (add-to-list 'ribbon-windows (selected-window))
  (puthash 0 (window-buffer (nth 0 ribbon-windows)) ribbon-buffers-hash)
  
  (add-to-list 'ribbon-windows (next-window (selected-window)))
  (puthash 1 (window-buffer (nth 1 ribbon-windows)) ribbon-buffers-hash)
  
  (add-to-list 'ribbon-windows (next-window (next-window (selected-window))))
  (puthash 2 (window-buffer (nth 2 ribbon-windows)) ribbon-buffers-hash)
  )

(defun ribbon-save-current-state ()
  (puthash ribbon-buffer-no (window-buffer (nth 0 ribbon-windows)) ribbon-buffers-hash)
  (puthash (+ ribbon-buffer-no 1) (window-buffer (nth 1 ribbon-windows)) ribbon-buffers-hash)
  (puthash (+ ribbon-buffer-no 2) (window-buffer (nth 2 ribbon-windows)) ribbon-buffers-hash))

(defun ribbon-set-keyboard-shortcuts ()
  (global-set-key (kbd "<S-M-right>") 'ribbon-move-right)
  (global-set-key (kbd "<S-M-left>") 'ribbon-move-left))

(defun ribbon-split ()
  (split-window-right)
  (split-window-right)
  (balance-windows))

(defun ribbon-mode-start ()
  (interactive)
  (ribbon-split)
  (ribbon-init-data-structures)
  (ribbon-set-keyboard-shortcuts))

(defun update-windows-buffers ()
  (set-window-buffer (nth 0 ribbon-windows) (gethash ribbon-buffer-no ribbon-buffers-hash))
  (set-window-buffer (nth 1 ribbon-windows) (gethash (+ ribbon-buffer-no 1) ribbon-buffers-hash))
  (set-window-buffer (nth 2 ribbon-windows) (gethash (+ ribbon-buffer-no 2) ribbon-buffers-hash)))

(defun ribbon-ensure-buffers-exist ()
  (unless (gethash ribbon-buffer-no ribbon-buffers-hash)
    (puthash ribbon-buffer-no (get-buffer "*scratch*") ribbon-buffers-hash))
  (unless (gethash (+ ribbon-buffer-no 1) ribbon-buffers-hash)
    (puthash (+ ribbon-buffer-no 1) (get-buffer "*scratch*") ribbon-buffers-hash))
  (unless (gethash (+ ribbon-buffer-no 2) ribbon-buffers-hash)
    (puthash (+ ribbon-buffer-no 2) (get-buffer "*scratch*") ribbon-buffers-hash)))

(defun ribbon-describe-buffer (buffer-no)
  (concat
   "(" (number-to-string buffer-no) ")"
   (buffer-name (gethash buffer-no ribbon-buffers-hash))))
  
(defun ribbon-describe-buffers ()
  (message (concat
            (ribbon-describe-buffer (+ ribbon-buffer-no 0)) "   "
            (ribbon-describe-buffer (+ ribbon-buffer-no 1)) "   "
            (ribbon-describe-buffer (+ ribbon-buffer-no 2))) "   "
            ))

(defun ribbon-selected-window-no ()
  (position (selected-window) ribbon-windows))

(defun ribbon-next-window ()
  (nth (- (ribbon-selected-window-no) 1) ribbon-windows))

(defun ribbon-prev-window ()
  (nth (+ (ribbon-selected-window-no) 1) ribbon-windows))

(defun ribbon-select-left-window ()
  (if (ribbon-prev-window)
      (select-window (ribbon-prev-window))))
  
(defun ribbon-select-right-window ()
  (if (ribbon-next-window)
      (select-window (ribbon-next-window))))

(defun ribbon-move-left ()
  (interactive)
  (ribbon-save-current-state)
  (setq ribbon-buffer-no (- ribbon-buffer-no 1))
  (ribbon-ensure-buffers-exist)
  (update-windows-buffers)
  (ribbon-select-left-window)
  (ribbon-describe-buffers))

(defun ribbon-move-right ()
  (interactive)
  (ribbon-save-current-state)
  (setq ribbon-buffer-no (+ ribbon-buffer-no 1))
  (ribbon-ensure-buffers-exist)
  (update-windows-buffers)
  (ribbon-select-right-window)
  (ribbon-describe-buffers))

(defun ribbon-clone-buffer-to-right ()
  (interactive)
  (set-window-buffer (ribbon-next-window) (current-buffer)))

(defun ribbon-clone-buffer-to-left ()
  (interactive)
  (set-window-buffer (ribbon-prev-window) (current-buffer)))

(global-set-key (kbd "C-x r r") 'ribbon-mode-start)
(global-set-key (kbd "C-x r <right>") 'ribbon-clone-buffer-to-right)
(global-set-key (kbd "C-x r <left>") 'ribbon-clone-buffer-to-left)

(provide 'setup-ribbon)
