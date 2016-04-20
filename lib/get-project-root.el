;; SOURCE: https://github.com/grizzl/fiplr

(defun fiplr-anyp (pred seq)
  "True if any value in SEQ matches PRED."
  (catch 'found
    (cl-map nil (lambda (v)
                  (when (funcall pred v)
                    (throw 'found v)))
            seq)))


(defvar *fiplr-default-root-markers* '(".git" ".svn" ".hg" ".bzr")
  "A list of files/directories to look for that mark a project root.")

(defcustom fiplr-root-markers *fiplr-default-root-markers*
  "A list of files or directories that are found at the root of a project."
  :type    '(repeat string)
  :group   'fiplr)

(defun fiplr-root ()
  "Locate the root of the project by walking up the directory tree.
The first directory containing one of fiplr-root-markers is the root.
If no root marker is found, the current working directory is used."
  (let ((cwd (if (buffer-file-name)
                 (directory-file-name
                  (file-name-directory (buffer-file-name)))
               (file-truename "."))))
    (or (fiplr-find-root cwd fiplr-root-markers)
        cwd)))

(defun fiplr-find-root (path root-markers)
  "Tail-recursive part of project-root."
  (let* ((this-dir (file-name-as-directory (file-truename path)))
         (parent-dir (expand-file-name (concat this-dir "..")))
         (system-root-dir (expand-file-name "/")))
    (cond
     ((fiplr-root-p path root-markers) this-dir)
     ((equal system-root-dir this-dir) nil)
     (t (fiplr-find-root parent-dir root-markers)))))

(defun fiplr-anyp (pred seq)
  "True if any value in SEQ matches PRED."
  (catch 'found
    (cl-map nil (lambda (v)
                  (when (funcall pred v)
                    (throw 'found v)))
            seq)))

(defun fiplr-root-p (path root-markers)
  "Predicate to check if the given directory is a project root."
  (let ((dir (file-name-as-directory path)))
    (fiplr-anyp (lambda (marker)
                  (file-exists-p (concat dir marker)))
                root-markers)))

(defun get-project-root ()
  (interactive)
  (fiplr-root))

(provide 'get-project-root)
