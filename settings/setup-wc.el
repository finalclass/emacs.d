(setq wc-list '())
(setq wc-position 0)

(defun wc-list-length ()
  "Returns wc-list list length"
  (interactive)
  (list-length wc-list))

(defun wc-save ()
  "Saves current window configuration to the end of the 'wc-list"
  (interactive)
  (setcar (nthcdr wc-position wc-list) (current-window-configuration))
  ;;(add-to-list 'wc-list (current-window-configuration) t)
  ;;(setq wc-position (- wc-position 1))
  (message "set conf %s" wc-position))

(defun wc-remove ()
  "Removes one window configuration at current wc-position"
  (interactive)
  (wc-set-to-current)
  (message "open conf %s" wc-position)
  ;(setq wc-list (delete (nth wc-position wc-list) wc-list))
  ;(message (concat "Window Configuration Removed @ " (number-to-string wc-position)))
;  (wc-dec)
  )

(defun wc-inc ()
  "Increases wc-position"
  (interactive)
  (setq wc-position (+ wc-position 1))
  (if (>= wc-position (wc-list-length))
      (setq wc-position 0)))

(defun wc-set-to-current ()
  "Sets window-configuration to current (by wc-position) element from wc-list list"
  (interactive)
  (message "loading %s" wc-position)
  (if (nth wc-position wc-list)
      (set-window-configuration (nth wc-position wc-list))))

(defun wc-next ()
  "Sets window-configuration to the next element of wc-list"
  (interactive)
  (wc-inc)
  ;;(wc-set-to-current)
  (message "conf %s" wc-position)
  )

(defun wc-dec ()
  "Decreases wc-position (position of the wc-list list)"
  (interactive)
  (setq wc-position (- wc-position 1))
  (if (< wc-position 0)
      (setq wc-position (- (wc-list-length) 1))))

(defun wc-prev ()
  "Sets window-configuration to the previous element of wc-list current position element"
  (interactive)
  (wc-dec)
  (message "conf %s" wc-position)
  ;(wc-set-to-current)
  )

(provide 'setup-wc)

(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)
(add-to-list 'wc-list (current-window-configuration) t)


