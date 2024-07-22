
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pengpeng Song"
      user-mail-address "sun.april.moon@gmail.com")

;; Doom exposesf five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "PT Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "MonoLisa ss-4-8-15" :size 14))
(setq doom-symbol-font (font-spec :familly "Fira Mono"))

;; (cond (IS-MAC
;;        (setq mac-command-modifier       'meta
;;              mac-option-modifier        'alt
;;              mac-right-option-modifier  'alt
;;              mac-pass-control-to-system nil)))

(setq auto-save-default t
      make-backup-files t)      

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'monokai-pro-spectrum)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq undo-limit 80000000)
(display-time-mode 1)
;;(global-subword-mode 1)
(setq org-export-coding-system 'utf-8)
;;(prefer-coding-system 'utf-8)
;;(set-charset-priority 'unicode)
;;(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(global-prettify-symbols-mode 1)
;;(global-hl-line-mode)
;;(use-package golden-ratio)
;;(golden-ratio-mode 1)
(setq org-export-with-smart-quotes t)
(global-set-key (kbd "M-/") 'company-manual-begin)

;;(setq fringe-mode minimal)
(fringe-mode 0)

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)

;;(setq +ivy-buffer-preview t)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

(require 'cl)
(setq which-key-idle-delay 0.3)
(setq iedit-toggle-key-default nil)
(setq org-use-sub-superscripts '{})
(xterm-mouse-mode 1)
(setq clipetty-assume-nested-mux nil)
(setq clipetty-tmux-ssh-tty "tmux show-environment SSH_TTY")
(setq org-alphabetical-lists t)
(setq +zen-text-scale 0.8)
(setq doom-modeline-enable-word-count t)
(setq mixed-pitch-variable-pitch-cursor nil)
;;(setq emojify-emoji-set "twemoji-v2")


;; (setq org-emphasis-alist
;;   '(("*" (bold :foreground "Orange" ))
;;     ("/" italic)
;;     ("_" underline)
;;     ("=" (:background "maroon" :foreground "white"))
;;     ("~" (:background "deep sky blue" :foreground "MidnightBlue"))
;;     ("@" (:strike-through t))))

;;(use-package! ox-zola
;;  :after 'ox)


;;(setq lsp-rust-server 'rust-analyzer)
(use-package! lsp-mode
  ;;:custom
;;  (lsp-ui-doc-mode 1)
;;  (lsp-lens-mode 1)
  :config
  (setq lsp-rust-server 'rust-analyzer)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-mode . lsp-lens-mode)
  (lsp-ui-mode . lsp-ui-doc-mode)
  ;;(lsp-idle-delay 0.6)
  ;;(lsp-rust-analyzer-server-display-inlay-hints t)
  ;;(lsp-eldoc-render-all t)
  ;;(lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; (scala-mode . lsp)
  )

;;
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-hook! org-mode :append
           #'visual-line-mode
           #'variable-pitch-mode)
(add-hook! org-mode :append #'org-appear-mode)
(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode #'solaire-mode)
(add-hook! org-mode (electric-indent-local-mode -1))
(add-hook! 'org-mode-hook
          (lambda ()
            (kill-local-variable 'line-spacing)
            (setq-local default-text-properties
                        '(line-spacing 0.0
                          line-height 1.1
                          ))))


(use-package! clipetty
  :hook (after-init . global-clipetty-mode)
  )

(unless window-system
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  (global-set-key (kbd "<home>") 'execute-extended-command))

;;(setq lsp-prefer-capf t)
;;(setq lsp-completion-provider :capf)
;;(setq lsp-completion-enable t)

(setq org-download-link-format "[[file:%s]]\n"
      org-download-abbreviate-filename-function #'file-relative-name)
(setq org-download-link-format-function #'org-download-link-format-function-default)


(use-package! org
  :custom
  (setq org-catch-invisible-edits 1)
  )

(use-package! org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "images")
  (org-download-heading-lvl nil)
  (org-download-timestamp "%Y%m%d-%H%M%S_")
  (org-image-actual-width 500)
  (org-download-screenshot-method "/opt/homebrew/bin/pngpaste %s")
  :bind
  ("C-M-y" . org-download-screenshot)
  :config
  (require 'org-download))


(require 'ox-html)
(require 'ox-latex)
(require 'ox-ascii)

(use-package! org-special-block-extras
  :hook (org-mode . org-special-block-extras-mode)
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package! lsp-grammarly                     ;;
;;   :ensure t                                     ;;
;;   :hook (text-mode . (lambda ()                 ;;
;;                        (require 'lsp-grammarly) ;;
;;                        (lsp)))                  ;;
;;   )                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! treemacs
  (set-popup-rule! "^ \\*Treemacs"
    :side 'left
    :size 0.30
    :quit nil
    :ttl 0))

(setq org-plantuml-jar-path (expand-file-name "/opt/homebrew/opt/plantuml/libexec/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages
                             '(
                               (plantuml . t)
                               (dot . t)
                               (org . t)
                               (latex .t)
                               ))


;;(use-package! rtags)
;;(cmake-ide-setup)

(when (daemonp)
  (exec-path-from-shell-initialize))


(use-package! org-transclusion
  :after org
  :custom
  (setq org-use-sub-superscripts '{})
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))


(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))

(use-package! org-ml
  :after org)
(use-package! org-ql
  :after org)

(use-package! ob-http
  :commands org-babel-execute:http)

(use-package! page-break-lines
  :commands page-break-lines-mode
  :init
  (autoload 'turn-on-page-break-lines-mode "page-break-lines")
  :config
  (setq page-break-lines-max-width fill-column)
  (map! :prefix "g"
        :desc "Prev page break" :nv "[" #'backward-page
        :desc "Next page break" :nv "]" #'forward-page))

(use-package git-timemachine)

(defun zz/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

(use-package! graphviz-dot-mode)


(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))
