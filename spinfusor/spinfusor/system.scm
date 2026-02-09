
(define-module (spinfusor system)
  #:use-module (gnu)
  #:use-module (gnu system nss)
  #:use-module (gnu system accounts)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module (gnu services networking)
  #:use-module (gnu services pm)
  #:use-module (gnu services containers)
  #:use-module (guix channels)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(define %channels
  (cons* (channel
           (name 'nonguix)
           (url "https://gitlab.com/nonguix/nonguix")
           (introduction
            (make-channel-introduction
             "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
             (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
         %default-channels))

(define-public os
  (operating-system
    (kernel linux)
    (initrd microcode-initrd)
    (firmware (list linux-firmware))

    (host-name "spinfusor")
    (timezone "America/Sao_Paulo")
    (locale "en_US.utf8")

    ;; hehe
    (keyboard-layout
     (keyboard-layout
      "us" "dvorak"
      #:options '("grp:lctrl_toggle"
		  "caps:ctrl_modifier"
		  "keypad:pointerkeys"
		  "shift:both_capslock")))

    (bootloader (bootloader-configuration
                  (bootloader grub-efi-bootloader)
                  (targets '("/boot/efi"))
		  (keyboard-layout keyboard-layout)))

    (file-systems '())

    (users (cons (user-account
                   (name "lvds")
                   (group "users")
                   (supplementary-groups '("wheel" "netdev"
                                           "audio" "video"
                                           "cgroup")))
                 %base-user-accounts))

    (packages (append (list
                       i3-wm i3status i3lock dmenu emacs
                       xterm ntfs-3g brightnessctl)
                      %base-packages))

    (services
     (cons*
      (service iptables-service-type)
      (service rootless-podman-service-type
               (rootless-podman-configuration
                 (subgids
                  (list (subid-range (name "lvds"))))
                 (subuids
                  (list (subid-range (name "lvds"))))))
      (service tlp-service-type
	       (tlp-configuration
	         (start-charge-thresh-bat0 80)
	         (stop-charge-thresh-bat0 85)
	         (disks-devices '())))
      (service bluetooth-service-type)
      (set-xorg-configuration
       (xorg-configuration
         (keyboard-layout keyboard-layout)))
      (modify-services %desktop-services
        (guix-service-type
         config => (guix-configuration
		     (inherit config)
		     (guix (guix-for-channels %channels))
		     (substitute-urls
		      ;; (append (list "https://substitutes.nonguix.org")
		      (append (list "https://nonguix-proxy.ditigal.xyz")
			      %default-substitute-urls))
		     (authorized-keys
		      (append (list (plain-file "signing-key.pub"
					        "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
			      %default-authorized-guix-keys)))))))

    (name-service-switch %mdns-host-lookup-nss)))

