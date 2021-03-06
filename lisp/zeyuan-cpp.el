;;----------------------------------
;; CC modes (C, C++, Java)
;;----------------------------------

(require 'cc-mode)
(setq c-default-style "bsd"); DB2 coding style
(setq-default c-basic-offset 2)

(define-key c-mode-base-map (kbd "<f6>") 'ggtags-find-reference)
(define-key c-mode-base-map (kbd "<f5>") 'ggtags-find-tag-dwim)

(provide 'zeyuan-cpp)
