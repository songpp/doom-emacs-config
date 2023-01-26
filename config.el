
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
 (setq doom-font (font-spec :family "PT Mono" :size 14)
       doom-variable-pitch-font (font-spec :family "MonoLisa" :size 14))

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
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
;;(setq fringe-mode minimal)

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
(setq org-use-sub-superscripts '{})

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
  ;; (lsp-idle-delay 0.6)
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
(add-hook! 'org-mode-hook
          (lambda ()
            (kill-local-variable 'line-spacing)
            (setq-local default-text-properties
                        '(line-spacing 0.0
                          line-height 1.1
                          ))))

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

(use-package! vlf
  :config
  (custom-set-variables
   '(vlf-application 'dont-ask))
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
  (org-image-actual-width 300)
  (org-download-screenshot-method "/opt/homebrew/bin/pngpaste %s")
  :bind
  ("C-M-y" . org-download-screenshot)
  :config
  (require 'org-download))


(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(setq org-alphabetical-lists t)
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


(use-package! ob-http
  :commands org-babel-execute:http)

;;(use-package! vlf-setup
;;  :defer-incrementally vlf-tune vlf-base vlf-write vlf-search vlf-occur vlf-follow vlf-ediff vlf)

(setq +zen-text-scale 0.8)
(setq emojify-emoji-set "twemoji-v2")

(use-package! page-break-lines
  :commands page-break-lines-mode
  :init
  (autoload 'turn-on-page-break-lines-mode "page-break-lines")
  :config
  (setq page-break-lines-max-width fill-column)
  (map! :prefix "g"
        :desc "Prev page break" :nv "[" #'backward-page
        :desc "Next page break" :nv "]" #'forward-page))

;; brew install plantuml
(setq org-plantuml-jar-path (expand-file-name "/usr/local/opt/plantuml/libexec/plantuml.jar"))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
