;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name    "Emma Griffin"
      user-mail-address "eagriffin@usf.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq org-latex-create-formula-image-program 'dvisvgm)

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(after! org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.2)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;(setq tramp-use-ssh-controlmaster-options nil)

(setq python-indent-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-basic-offset 2)
;; Fix OpenMP #pragma warnings
(setq flycheck-gcc-openmp t)

(elpy-enable)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; thanks Elijah!!
(defun vpn-netcluster ()
  "USF can leave me the hell alone"
  (interactive)
  (let* ((default-directory "/sudo::/")
         (process (start-file-process
                   "vpn.sh"
                   "*vpn.sh*"
                   (expand-file-name "/home/emma/vpn.sh")))
         (password (read-passwd "USF Password: ")))
    (with-current-buffer (process-buffer process)
      (doom-mark-buffer-as-real-h)
      (comint-mode))
    (process-send-string process password)
    (process-send-string process "\n")
    (process-send-eof process)))

(defun ssh-netcluster ()
  "ahaha ssh a lot to type out"
  (interactive)
  (find-file "/ssh:netcluster:/home/e/eagriffin/"))

;; Bind the keys!
(map! :leader
      "v p n"
      #'vpn-netcluster)

(map! :leader
      "s h"
      #'ssh-netcluster)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'org-mode-hook 'rainbow-delimiters-mode)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
