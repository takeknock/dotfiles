(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;基本設定
;モードラインに行番号表示
(column-number-mode t)
;タブの表示幅
(setq-default tab-width 4)
;横の行番号の表示
(global-linum-mode t)

;;cl-libエラーへの対処（http://stackoverflow.com/questions/20678847/cannot-load-cl-lib-at-emacs-startup）
(add-to-list 'load-path "~/.emacs.d/elisp/cl-lib/")
(require 'cl-lib)

;elispフォルダをパスに追加
(add-to-list 'load-path
	     (expand-file-name "~/.emacs.d/elisp/"))

;;auto-installの設定（『Emacs実践入門』、http://d.hatena.ne.jp/rubikitch/20091221/autoinstall）
(require 'auto-install)
;インストール場所の指定
(setq auto-install-directory "~/.emacs.d/elisp/")
;emacswikiに記載されてるelist名取得
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;;Auto Completeの設定（『Emacs実践入門』）
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
;(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(ac-config-default)

;;yasnippetの設定（http://fukuyama.co/yasnippet）
;yasnippetを置いているフォルダにパスを通す
(add-to-list 'load-path
	     (expand-file-name "~/.emacs.d/elisp/yasnippet"))
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;自作スニペット置くとこ
        "~/.emacs.d/elisp/yasnippet/snippets";デフォルトのスニペット置き場
))
;global-modeで起動
(yas-global-mode 1)
;TABキーで展開する
(custom-set-variables '(yas-trigger-key "TAB"))
;既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)


;;Anythingの設定
(require 'anything)
;emacsコマンドを表示する
(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-dource-emacs-commands);anything-sources(標準のソース一覧)にanything-c-source-emacs-commands(emacsコマンドを表示するためのソース)を追加


;;********anything interface（anythingとyasnippetの連携）;;まだ対応できてない+内容理解できてない（内容に関して参考文献：http://d.hatena.ne.jp/sugyan/20120111/1326288445）
;（http://ochiailab.blogspot.jp/2012/12/yasnippet.html）
(eval-after-load "anything-config"
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
        (let* ((names (loop for choice in choices
			    collect (or (and display-fn (funcall display-fn choice))
					choice)))
	       (selected (anything-other-buffer
			  '(((name . ,(format "%s" prompt))
			     (candidates . names)
			     (action . (("Insert snippet" . (lambda (arg) arg))))))
			  "*anything yas/prompt*")))
	  (if selecter
	      (let ((n (position selected names :test 'equal)))
		(nth n choices))
	    (signal 'quit "user quit!"))))
  (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
  (define-key anything-command-map (kbd "y") 'yas/insert-snipper)))


;;smart-compileの設定
(require 'smart-compile)
(setq smart-compile-alist
      (append
       '(("\\.rb$" . "ruby %f"))
       smart-compile-alist))
(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))


;;;flymakeの設定
;;*******Ruby用flymakeの設定（書いてある内容わかってない）

(defun flymake-ruby-init()
  (list "ruby" (list "-c" (flymake-init-create-temp-buffer-copy
					 'flymake-create-temp-inplace))))
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.rb\\'" flymake-ruby-init))
(add-to-list 'flymake-err-line-patterns
			 '("\\(.*\\):(\\([0-9]+\\)): \\(.*\\)" 1 2 nil 3))

;;;矩形関係の設定
;;cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;


;;;C-x bでミニバッファにバッファ候補を表示
;（http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html）
(iswitchb-mode t)


;;;todo
;デバッグ機能追加
;smartcompile追加(c++にも)
