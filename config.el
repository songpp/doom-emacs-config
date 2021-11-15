
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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
 (setq doom-font (font-spec :family "PT Mono" :size 13 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "Consolas for Powerline" :size 13))

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

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)

(setq +ivy-buffer-preview t)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

(setq which-key-idle-delay 0.3)
(setq iedit-toggle-key-default nil)

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
  ;;  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-eldoc-render-all t)
  ;;  (lsp-rust-analyzer-cargo-watch-command "clippy")
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

;;(require 'magit)
(xterm-mouse-mode 1)
(global-subword-mode 1)

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)

;; scala sbt and metals
;; (use-package! scala-mode
;;   :interpreter ("scala". scala-mode))

;; (use-package! sbt-mode
;; ;;  :command sbt-start sbt-command
;;   :config
;;   (substitute-key-definition
;;    'minibuffer-complete-word
;;    'self-insert-command
;;    minibuffer-local-completion-map)

;;   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package! clipetty
  :hook (after-init . global-clipetty-mode)
  )


;;(global-clipetty-mode)
(setq clipetty-assume-nested-mux nil)
(setq clipetty-tmux-ssh-tty "tmux show-environment SSH_TTY")


;; (use-package! lsp-metals
;;  :config (setq lsp-metals-treeview-show-when-views-received))
(unless window-system
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  (global-set-key (kbd "<home>") 'execute-extended-command))

;;(use-package! company-lsp
;;  :hook
;;  (lsp-mode . (push 'company-lsp company-backends))
;;  )

;;(setq lsp-prefer-capf t)
;;(setq lsp-completion-provider :capf)
;;(setq lsp-completion-enable t)

;;;; imenu-list
(use-package! imenu-list
  :commands imenu-list-smart-toggle)

(after! treemacs
  (set-popup-rule! "^ \\*Treemacs"
    :side 'left
    :size 0.30
    :quit nil
    :ttl 0))

;;(use-package! rtags)
;;(cmake-ide-setup)

(when (daemonp)
  (exec-path-from-shell-initialize))
