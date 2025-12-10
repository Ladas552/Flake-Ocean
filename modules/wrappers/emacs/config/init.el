;; Update user-emacs-directory to use a non store location, so that packages may write there
;; thanks https://github.com/jordanisaacs/emacs-config/blob/3854525333a886c53a1dc966e0b4bb09a088e9fb/init.org?plain=1#L39-L48          
;; stolen from https://nezia.dev/
(setq user-emacs-directory (expand-file-name "emacs/" (getenv "XDG_STATE_HOME")))
(setq custom-file (locate-user-emacs-file "custom.el"))


;; default theme
          ;; (load-theme 'catppuccin :no-confirm)
          ;; (setq catppuccin-flavor 'macchiato)
          ;; (catppuccin-reload)
          ;; more colorschemes
          (require 'doom-themes)
          (load-theme 'doom-oksolar-light :ensure)

          ;; prettify nix/store paths
          (global-pretty-sha-path-mode)
          ;; Icons
          (when (display-graphic-p)
            (require 'all-the-icons))
          ;; Fonts

          ;; dashboard initialisation
          (require 'dashboard)
          (dashboard-setup-startup-hook)
          (require 'page-break-lines)

          ;; Set the title
          (setq dashboard-banner-logo-title "Time-Waste-Mode enabled")

          ;; Set the banner
          (setq dashboard-startup-banner 'logo)

          ;; Content is not centered by default. To center, set
          (setq dashboard-center-content t)

          ;; vertically center content
          (setq dashboard-vertically-center-content t)

          ;; items in dashboard
          (setq dashboard-items '((bookmarks . 15)
                        (agenda    . 5)))

          ;; enable cycle navigation between each section
          (setq dashboard-navigation-cycle t)

          ;; To use icons
          (setq dashboard-icon-type 'all-the-icons)          
          (setq dashboard-set-heading-icons nil) ; not `t` because some bug, idk
          (setq dashboard-set-file-icons t)

          ;; modify the widget heading name
          (setq dashboard-item-names '(("Agenda for the coming week:" . "Agenda:")))
          (setq dashboard-week-agenda t)

          ;; Hide modeline
          (add-hook 'dashboard-mode-hook (lambda () (setq-local mode-line-format nil)))

          ;; Add solaire integration
          (solaire-global-mode +1)
          (add-hook 'dashboard-before-initialize-hook #'solaire-mode)

