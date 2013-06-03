;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)
;; 文字位置
(column-number-mode 1)
;; スタートアップページを表示しない
(setq inhibit-startup-message t)
;; optinをメタキーにする
(setq mac-option-modifier 'meta)
;; site-lisp directory
(setq load-path(cons "~/.emacs.d/site-lisp/" load-path))
;; transient-mark-mode
(transient-mark-mode t)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get/")
(setq el-get-dir "~/.emacs.d/site-lisp/el-get/")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(put 'upcase-region 'disabled nil)

;; anything
(require 'anything)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
;; anything keybind
(define-key global-map (kbd "C-l") 'anything)

;; python-mode
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; python-mode
(add-hook 'python-mode-hook
    '(lambda()
       (setq indent-tabs-mode t)
       (setq indent-level 4)
       (setq python-indent 4)
       (setq tab-width 4)))

;; template-python
(require 'autoinsert)
(setq auto-insert-directory "~/.emacs.d/template")
(setq auto-insert-alist
      (nconc '((".py$"."python-template.txt")
	       ) auto-insert-alist))
(add-hook 'python-mode-hook 'auto-insert)

;; jedi
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-deferred")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-epc")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-ctable")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-jedi")
(require 'auto-complete-config)
(require 'python)
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(define-key python-mode-map (kbd "<C-tab>") 'jedi:complete)

;; js2
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" .js2-mode))

;; haskell
(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode")

(require 'haskell-mode)
(require 'haskell-cabal)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode)) 
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode))

(load-library "haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; ghc-mod
;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
(add-to-list 'exec-path "~/Library/Haskell/bin")
;; ghc-flymake.el などがあるディレクトリ ghc-mod を ~/.emacs.d 以下で管理することにした
(add-to-list 'load-path "~/.emacs.d/site-lisp/ghc-mod") 

(autoload 'ghc-init "ghc" nil t)

(add-hook 'haskell-mode-hook  (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

;;slime
(setq inferior-lisp-program "/usr/local/bin/clisp")
(add-to-list 'load-path "/Applications/slime")
(require 'slime)
(slime-setup)

;; nyan-mode
;;(when (eq window-system 'ns)
;;  (require 'nyan-mode)
;;  (nyan-mode)
;;  (nyan-start-animation)
;;  )
