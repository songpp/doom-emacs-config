;;; sppowl/util/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun owl/org-heading-to-list-item ()
  "Convert an Org-mode heading to a bullet list item."
  (interactive)
  (beginning-of-line)
  (when (looking-at "^\\*+ ")
    (replace-match "- ")))



(defun owl/org-reformat-buffer ()
  "Reformat an Org buffer."
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))


(global-set-key (kbd "C-c C-x i") 'owl/org-heading-to-list-item)
