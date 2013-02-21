(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(unless (eq window-system 'mac)
  (setq default-input-method "japanese-anthy"))

(setq load-path (cons (expand-file-name "~/.emacs.d/") load-path))
(server-start)

;;ファイル名の設定（Mac）
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
;;-----------

;;カラム番号の表示
(column-number-mode t)
;;行番号の表示
(line-number-mode t)
;;行番号を常に左に表示
(global-linum-mode t)

(setq c-tab-always-indent t)
(setq default-tab-width 4)
(setq indent-line-function 'indent-relative-maybe) ; 前と同じ行の幅にインデント

(setq mac-allow-anti-aliasing nil)  ; mac 固有の設定
(setq mac-option-modifier 'meta) ; mac 用の command キーバインド
;; (mac-key-mode 1) ; MacKeyModeを使う

(global-set-key "\C-x\C-i" 'indent-region) ; 選択範囲をインデント
(global-set-key "\C-m" 'newline-and-indent) ; リターンで改行とインデント
(global-set-key "\C-j" 'newline)  ; 改行

(global-set-key "\C-cc" 'comment-region)    ; C-c c を範囲指定コメントに
(global-set-key "\C-cu" 'uncomment-region)  ; C-c u を範囲指定コメント解除に

(define-key global-map (kbd "C-c l") 'toggle-truncate-lines);折り返しtoggleコマンド
(define-key global-map (kbd "C-t") 'other-window);;"C-x o"→"C-t"。初期値はtranspose-cars

;;ハイライト設定
(setq show-paren-delay 0)
(show-paren-mode t) ; 対応する括弧を光らせる。
(setq show-paren-style 'expression);expressionで括弧内も強調表示
(set-face-background 'show-paren-match-face "color-52")
(transient-mark-mode t) ; 選択部分のハイライト

(setq require-final-newline t)          ; always terminate last line in file
(setq default-major-mode 'text-mode)    ; default mode is text mode

(setq completion-ignore-case t) ; file名の補完で大文字小文字を区別しない
(setq partial-completion-mode 1) ; 補完機能を使う

(set-frame-parameter nil 'alpha 85)
;;(set-frame-parameter nil 'fullscreen 'fullboth) ;;フルスクリーン

;; スタートアップメッセージを非表示
(setq inhibit-startup-message t)
(if window-system (progn
										; ツールバーの非表示
					(tool-bar-mode nil)))

;;タイトルバーにフルパス表示
(setq frame-title-format "%f")

;;(if (eq window-system 'mac) (require 'carbon-font))
;;(fixed-width-set-fontset "osaka" 10)

(if window-system (progn
					(setq initial-frame-alist '((width . 190) (height . 55)
												(top . 0) (left . 30)))
					(set-cursor-color "Gray")
					))

;;バックアップの設定 ;;c++ファイルがセーブ出来なくなったので、この設定を一時凍結中→凍結解除
(add-to-list 'backup-directory-alist
	  (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
	  `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;(setq backup-inhibited t)
;(setq make-backup-files nil)
;;~を作らない↑#を作らない
;(setq auto-save-default nil)

;;~/.emacs.d/elispディレクトリをロードパスに追加する
(add-to-list 'load-path "~/.emacs.d/elisp")

;;load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
	(dolist (path paths paths)
	  (let ((default-directory
			  (expand-file-name (concat user-emacs-directory path))))
		(add-to-list 'load-path default-directory)
		(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
			(normal-top-level-add-subdirs-to-load-path))))))

;;引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;;http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf");設定ファイルのあるディレクトリ指定

;;PATHの設定
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")


;;package.elの設定
(when (require 'package nil t)
  (add-to-list 'package-archives
			   '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))

;;auto-install.elの設定
;(require 'auto-install)
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/") ;インストールディレクトリの設定
  (auto-install-update-emacswiki-package-name t)    ;EmacsWikiに登録されているelispの名前を取得する
  ;(setq url-proxy-services '(("http" . "localhost:8339"))) ;プロキシの設定
  (auto-install-compatibility-setup))

;;common style
(add-hook 'c-mode-common-hook
		  (lambda()
			(set-face-foreground 'font-lock-function-name-face "brightcyan");関数名を水色に
			(c-set-style "stroustrup")))

;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
			 (c-set-offset 'arglist-intro'+) ;'+はc-basic-offsetの値を利用する設定
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
			 ;(set-face-foreground 'font-lock-preprocessor-face "color-24");#includeを濃い青を薄くした色に
             ))

;; tex の設定
;;(require 'tex-site)
;;(setq TeX-default-mode 'japanese-latex-mode)
;;(setq japanese-TeX-command-default "pTeX")
;;(setq japanese-LaTeX-command-default "pLaTeX")
;;(setq japanese-LaTeX-default-style "jsarticle")
;;(setq-default TeX-master nil)
;;(setq TeX-parse-self t)
;;(add-to-list 'TeX-output-view-style
;;'("^dvi$" "." "dvipdfmx %dS %d && open %s.pdf"))

;; erlangの設定
(setq load-path (cons  "/opt/local/lib/erlang/lib/tools-2.6.6.2/emacs"
					   load-path))
(setq erlang-root-dir "/opt/local")
(setq exec-path (cons "/opt/local/bin" exec-path))
;;      (require 'erlang-start)

;;emacs-lisp-modeの設定
(defun elisp-mode-hooks()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))

;;face-listの設定
;;(require 'face-list)

;;zen-codingの設定
;;(require 'zencoding-mode)
;;(add-hook 'xml-mode-hook 'zencoding-mode)
;;(add-hook 'sgml-mode-hook 'zencoding-mode)
;;(add-hook 'html-mode-hook 'zencoding-mode)
;;(define-key zencoding-mode-keymap (kbd "<C-return>") nil)
;;(define-key zencoding-mode-keymap (kbd "<S-return>") 'zencoding-expand-line)

;;yasnippetの設定
;;(require 'yasnippet)
;;(yas/initialize)
;;(yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets/")

;;redo+の設定
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))

;;anythingの設定
(when (require 'anything nil t)
  (setq
   anything-idle-delay 0.3
   anything-input-idle-delay 0.2
   anything-candidate-number-limit 100
   anything-quick-update t
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
	;;root権限でアクションを実行するときのコマンド。デフォルトは"su"
	(setq anything-su-or-sudo "sudo"))

  (require 'match-plugin nil t)

  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(require 'anything-migemo nil t))

  (when (require 'anythng-complete nil t)
	(anything-lisp-complete-symbol-set-timer 150));;lispシンボルの補完候補の再検索時間

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
	(require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
	(descbinds-anything-install)));;describe-bindingsをAnythingに置き換える

;;auto-completeの設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;cua-modeの設定 ;;←なんか反応しない
(cua-mode t);cua-modeをオン
(setq cua-enable-cua-keys nil) ;CUAキーバインドを無効にする


