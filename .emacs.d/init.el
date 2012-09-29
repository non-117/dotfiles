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
(setq load-path(cons "/Users/non/.emacs.d/site-lisp/" load-path))
;; transient-mark-mode
(transient-mark-mode t)

;; install-elisp
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/site-lisp/")
;; Autoinstall
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/site-lisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

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
;;(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
;; ghc-flymake.el などがあるディレクトリ ghc-mod を ~/.emacs.d 以下で管理することにした
(add-to-list 'load-path "~/.emacs.d/site-lisp/ghc-mod") 

(autoload 'ghc-init "ghc" nil t)

(add-hook 'haskell-mode-hook  (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
