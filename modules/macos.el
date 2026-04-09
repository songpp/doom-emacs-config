;;; macos.el -*- lexical-binding: t; -*-

(cond (IS-MAC
       (setq mac-command-modifier       'meta
             mac-option-modifier        'alt
             mac-right-option-modifier  'meta
             mac-pass-control-to-system nil)))

;;(unless (display-graphic-p)
;;  (corfu-terminal-mode +1))
