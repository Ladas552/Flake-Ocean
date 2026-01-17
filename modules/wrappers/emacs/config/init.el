;; Update user-emacs-directory to use a non store location, so that packages may write there
;; thanks https://github.com/jordanisaacs/emacs-config/blob/3854525333a886c53a1dc966e0b4bb09a088e9fb/init.org?plain=1#L39-L48          
;; stolen from https://nezia.dev/
(setq user-emacs-directory (expand-file-name "emacs/" (getenv "XDG_STATE_HOME")))
(setq custom-file (locate-user-emacs-file "custom.el"))


;; default theme
(use-package catppuccin-theme
             :demand t
             :config
             (load-theme 'catppuccin :no-confirm)
             :custom 
             (catppuccin-flavor 'macchiato))

(use-package pretty-sha-path)

(use-package magit)

(use-package nix-ts-mode
             :mode (("\\.nix\\'" . nix-ts-mode)))

(use-package which-key
             :hook (after-init . which-key-mode))

(use-package dired
             :custom
             (dired-dwim-target t)
             (dired-listing-switches "-AGhlv --group-directories-first --time-style=long-iso")
             (dired-kill-when-opening-new-dired-buffer t))

(use-package page-break-lines)
;; dashboard initialisation
(use-package dashboard
             :ensure t
             :init
             (dashboard-setup-startup-hook)
             :custom


             ;; Set the title
             ( dashboard-banner-logo-title "Time-Waste-Mode enabled")

             ;; Set the banner
             ( dashboard-startup-banner 'logo)

             ;; Content is not centered by default. To center, set
             ( dashboard-center-content t)

             ;; vertically center content
             (dashboard-vertically-center-content t)

             ;; items in dashboard
             ( dashboard-items '((bookmarks . 15)
                                 (agenda    . 5)))

             ;; enable cycle navigation between each section
             ( dashboard-navigation-cycle t)

             ;; To use icons
             ( dashboard-set-heading-icons nil) ; not `t` because some bug, idk
             ( dashboard-set-file-icons t)

             ;; modify the widget heading name
             ( dashboard-item-names '(("Agenda for the coming week:" . "Agenda:")))
             ( dashboard-week-agenda t))
;; Add solaire integration
(use-package solaire-mode
             :hook
             (dashboard-before-initialize-hook . solaire-mode)
             :custom
             (solaire-global-mode +1))
