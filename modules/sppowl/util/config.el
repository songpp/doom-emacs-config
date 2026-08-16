;;; sppowl/util/config.el -*- lexical-binding: t; -*-

(after! org)

(setq org-src-preserve-indentation nil)
(setq org-edit-src-content-indentation 0)
(setq org-src-tab-acts-natively t)



(defun owl/org-reformat-buffer1 ()
  "Reformat an Org buffer."
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))


(defun owl/org-reformat-buffer-skip-src ()
  "Reformat an Org buffer but skip formatting source blocks."
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let* ((parsed-data (org-element-parse-buffer))
           (formatted-content (owl/org-format-element-skip-src parsed-data)))
      (erase-buffer)
      (insert formatted-content)
      (goto-char (point-min)))))

(defun owl/org-format-element-skip-src (element)
  "Recursively format ELEMENT, skipping source blocks."
  (org-element-map element t
    (lambda (el)
      (pcase (org-element-type el)
        ;; Skip formatting for src blocks
        (`src-block
         (org-element-interpret-data el))
        ;; Skip formatting for example blocks
        (`example-block
         (org-element-interpret-data el))
        ;; Process other elements normally
        (_ (org-element-interpret-data el))))))

(defun owl/emacsclient-stdin-buffer ()
  "Convert temporary emacsclient stdin files into ordinary buffers."
  (when (and buffer-file-name
             (string-match-p
              "/__temporary-emacs-read-from-stdin\\.[^/]+\\'"
              buffer-file-name))
    (let ((tmp-file buffer-file-name))
      ;; Detach this buffer from the temporary file.
      (set-visited-file-name nil t)

      ;; Give it a useful buffer name.
      (rename-buffer (generate-new-buffer-name "*stdin*"))

      ;; Try magic-mode/shebang/content based mode detection.
      (normal-mode t)

      ;; Piped input should initially be considered unmodified.
      (set-buffer-modified-p nil)

      ;; The buffer now owns the contents, so the file is unnecessary.
      (ignore-errors
        (delete-file tmp-file)))))

(add-hook 'find-file-hook #'owl/emacsclient-stdin-buffer)
