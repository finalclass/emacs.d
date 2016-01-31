(defun fc-shell-command (cmd)
  (substring
   (shell-command-to-string (fc-init-command cmd))
  0
  -1))

(defun fc-init-command (cmd)
  (concat "source ~/bin/fc-variables.sh && " cmd))

(defun fc-deploy ()
  (interactive)
  (let ((command (fc-init-command "fc-deploy.sh&")))
    (message command)
    (shell-command command "*Messages*" "*Messages*")))

(global-set-key (kbd "C-c C-b") 'fc-deploy)

(defun fc-deploy-cloud ()
  (interactive)
  (let ((command (fc-init-command "EID=$CLOUD_EID DS=$CLOUD_DS fc-deploy.sh&")))
    (message command)
    (shell-command command "*Messages*" "*Messages*")))

(global-set-key (kbd "C-c C-x b") 'fc-deploy-cloud)

(defun fc-ip ()
  (interactive)
  (insert (fc-shell-command "fc-ip.sh")))

(defun fc-env (shell-environment-variable-name)
  (fc-shell-command
   (concat "echo $" shell-environment-variable-name)))

(provide 'setup-fc-bin)

