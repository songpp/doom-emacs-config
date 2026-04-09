;;; common.el -*- lexical-binding: t; -*-
;; Enable Rust for Org Babel
(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((rust . t)))  ;; Enable Rust execution
  ;; Optional: don't prompt for confirmation before executing code
  (setq org-confirm-babel-evaluate nil)
  (setq org-export-with-smart-quotes t
        org-export-with-toc nil
        org-export-with-section-numbers nil
        org-export-with-broken-links 'mark
        org-md-image-link-type "relative")
  (setq org-src-preserve-indentation nil)
  (setq org-edit-src-content-indentation 0)
  (setq org-src-tab-acts-natively t)
)



(add-hook! org-mode :append
           #'visual-line-mode
           #'variable-pitch-mode
           #'org-appear-mode)
(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode #'solaire-mode)
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package! org-special-block-extras
  :ensure t
  :hook
    (org-mode . org-special-block-extras-mode)
    (org-mode . +org-pretty-mode)
  :config
  (setq org-use-sub-superscripts '{})
  (setq org-export-with-smart-quotes t)
  (setq org-export-coding-system 'utf-8)
  (setq org-fold-catch-invisible-edits 1)
  ;; (setq org-src-tab-acts-natively t)
  (setq org-src-fontify-natively t
        org-src-window-setup 'current-window ;; edit in current window
        org-src-strip-leading-and-trailing-blank-lines t
  ;;      org-src-preserve-indentation t ;; do not put two spaces on the left
  ;;      org-src-tab-acts-natively t
  ;;      org-src-preserve-indentation nil
  ;;      org-edit-src-content-indentation 0
  )

  ;; All relevant Lisp functions are prefixed ‘o-’; e.g., `o-docs-insert'.
  :custom
    (o-docs-libraries
     '("~/org-special-block-extras/documentation.org")
     "The places where I keep my '#+documentation'")
  )


(use-package! ox-hugo
;;  :ensure t   ;Auto-install the package from Melpa
;;  :pin melpa  ;`package-archives' should already have ("melpa" . "https://melpa.org/packages/")
  :after ox)


(use-package! protobuf-mode
  :mode ("\\.proto\\'" . protobuf-mode)
  :config
  ;; 可选配置
  (setq protobuf-indent-level 2))
