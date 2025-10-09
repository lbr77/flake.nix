{ pkgs, ... }:
{
  security.pam.services.sudo_local.touchIdAuth = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  system = {
    stateVersion = 6;

    defaults = {
      # menuExtraClock.Show24Hour = true;  # show 24 hour clock
      
      # customize dock
      dock = {
        autohide = false;
        show-recents = false;  # disable recent apps

        # customize Hot Corners(触发角, 鼠标移动到屏幕角落时触发的动作)
        wvous-tl-corner = 2;  # top-left - Mission Control
        wvous-bl-corner = 3;  # bottom-left - Application Windows
        wvous-br-corner = 4;  # bottom-right - Desktop
      };

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true;  # show full path in finder title
        AppleShowAllExtensions = true;  # show all file extensions
        FXEnableExtensionChangeWarning = false;  # disable warning when changing file extension
        QuitMenuItem = true;  # enable quit menu item
        ShowPathbar = true;  # show path bar
        ShowStatusBar = true;  # show status bar
      };

      # customize trackpad
      trackpad = {
        # tap - 轻触触摸板, click - 点击触摸板
        Clicking = true;  # enable tap to click(轻触触摸板相当于点击)
        TrackpadRightClick = true;  # enable two finger right click
        TrackpadThreeFingerDrag = true;  # enable three finger drag
      };

      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = true;  # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0;  # disable beep sound when pressing volume up/down key
        AppleInterfaceStyle = "Dark";  # dark mode
        AppleKeyboardUIMode = 3;  # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = true;  # enable press and hold

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15;  # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts. 
        KeyRepeat = 3;  # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false;  # disable auto capitalization(自动大写)
        NSAutomaticDashSubstitutionEnabled = false;  # disable auto dash substitution(智能破折号替换)
        NSAutomaticPeriodSubstitutionEnabled = false;  # disable auto period substitution(智能句号替换)
        NSAutomaticQuoteSubstitutionEnabled = false;  # disable auto quote substitution(智能引号替换)
        NSAutomaticSpellingCorrectionEnabled = false;  # disable auto spelling correction(自动拼写检查)
        NSNavPanelExpandedStateForSaveMode = true;  # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode2 = true;

        "com.apple.keyboard.fnState" = true;  # enable F1, F2, etc. keys as standard function keys
      };

      CustomUserPreferences = {
        ".GlobalPreferences" = {
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "com.apple.CrashReporter" = {
          DialogType = "none"; # disable crash report dialog
          UseUNC = false; # do not send crash report to Apple
          AutoSubmit = false;
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
          StandardHideDesktopIcons = 0; # Show items on desktop
          HideDesktop = 0; # Do not hide items on desktop & stage manager
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.ImageCapture".disableHotPlug = true;
      };

      loginwindow = {
        GuestEnabled = false;  # disable guest user
        SHOWFULLNAME = false;  # show full name in login window
      };
    };

    keyboard = {
      enableKeyMapping = false;

      remapCapsLockToControl = false;
      remapCapsLockToEscape  = false;

      swapLeftCommandAndLeftAlt = false;  
    };
  };

  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];

  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome

      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
    ];
  };

  
}