;;; sppowl/util/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +org-heading-to-list-item ()
  "Convert an Org-mode heading to a bullet list item."
  (interactive)
  (beginning-of-line)
  (when (looking-at "^\\*+ ")
    (replace-match "- ")))
(global-set-key (kbd "C-c C-x i") '+org-heading-to-list-item)
