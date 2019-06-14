(packages-require 'auto-complete)
(packages-require 'cl)                                                          
(packages-require 'clang-format)
(packages-require 'cmake-mode)
(require-package 'command-log-mode)
(require-package 'company)
(packages-require 'color-theme-sanityinc-solarized)
(packages-require 'color-theme-sanityinc-tomorrow)
(require-package 'dumb-jump)
(packages-require 'f)
(require-package 'flycheck)
(require-package 'flycheck-rust)
(packages-require 'fill-column-indicator)
(packages-require 'ggtags)                                                      
(packages-require 'golden-ratio)
(packages-require 'helm)
(packages-require 'helm-descbinds)
(packages-require 'helm-gtags)
(packages-require 'helm-projectile)
(packages-require 'helm-swoop)
(packages-require 'highlight-symbol)
(packages-require 'markdown-mode)
(packages-require 'paredit)                                                     
(packages-require 'projectile)
(require-package 'racer)
(require-package 'rust-mode)
(packages-require 'rainbow-delimiters)                                          
(packages-require 'undo-tree)
(packages-require 'use-package)
(packages-require 'yasnippet)
(packages-require 'auto-complete-c-headers)
(packages-require 'flycheck-pycheckers)
(packages-require 'format-all)

;; Enable use-package
(eval-when-compile
  (require 'use-package))

(provide 'emacs.packages)
