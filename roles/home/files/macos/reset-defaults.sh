#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"*  ]]; then
  echo "OS X config step will be skipped"
  exit 0
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
#sudo -v

# Keep-alive: update existing `sudo` time stamp until it has finished
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

defaults delete com.apple.LaunchServices LSQuarantine
sudo defaults delete /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
defaults delete NSGlobalDomain NSAutomaticCapitalizationEnabled
defaults delete NSGlobalDomain NSAutomaticDashSubstitutionEnabled
defaults delete NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled
defaults delete NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled
defaults delete NSGlobalDomain NSAutomaticSpellingCorrectionEnabled
defaults delete com.apple.Music "userWantsPlaybackNotifications"
defaults delete NSGlobalDomain KeyRepeat
defaults delete NSGlobalDomain InitialKeyRepeat
sudo defaults delete /Library/Preferences/com.apple.loginwindow showInputMenu
defaults delete com.apple.screensaver askForPassword
defaults delete com.apple.screensaver askForPasswordDelay
defaults delete com.apple.screencapture location
defaults delete com.apple.screencapture type
defaults delete NSGlobalDomain AppleShowAllExtensions
defaults delete com.apple.finder ShowPathbar
defaults delete com.apple.finder _FXShowPosixPathInTitle
defaults delete com.apple.finder _FXSortFoldersFirst
defaults delete com.apple.finder FXDefaultSearchScope
defaults delete com.apple.finder FXEnableExtensionChangeWarning
defaults delete com.apple.desktopservices DSDontdeleteNetworkStores
defaults delete com.apple.desktopservices DSDontdeleteUSBStores
defaults delete com.apple.finder WarnOnEmptyTrash
defaults delete com.apple.dock tilesize
defaults delete com.apple.dock show-process-indicators
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.Dock size-immutable
defaults delete com.apple.dock contents-immutable
defaults delete com.apple.dock expose-animation-duration
defaults delete com.apple.dock show-recents
defaults delete com.apple.Safari UniversalSearchEnabled
defaults delete com.apple.Safari SuppressSearchSuggestions
defaults delete com.apple.Safari HomePage
defaults delete com.apple.Safari AutoOpenSafeDownloads
defaults delete com.apple.Safari ShowFavoritesBar
defaults delete com.apple.Safari ShowSidebarInTopSites
defaults delete com.apple.Safari IncludeInternalDebugMenu
defaults delete com.apple.Safari FindOnPageMatchesWordStartsOnly
defaults delete com.apple.Safari ProxiesInBookmarksBar
defaults delete com.apple.Safari IncludeDevelopMenu
defaults delete com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey
defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled
defaults delete NSGlobalDomain WebKitDeveloperExtras
defaults delete com.apple.Safari WebContinuousSpellCheckingEnabled
defaults delete com.apple.Safari WebAutomaticSpellingCorrectionEnabled
defaults delete com.apple.Safari WarnAboutFraudulentWebsites
defaults delete com.apple.Safari WebKitPluginsEnabled
defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled
defaults delete com.apple.Safari WebKitJavaEnabled
defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled
defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles
defaults delete com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically
defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically
defaults delete com.apple.Safari WebKitMediaPlaybackAllowsInline
defaults delete com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline
defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback
defaults delete com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback
defaults delete com.apple.Safari SendDoNotTrackHTTPHeader
defaults delete com.apple.Safari InstallExtensionUpdatesAutomatically
defaults delete com.apple.terminal StringEncodings
defaults delete com.apple.terminal SecureKeyboardEntry
defaults delete com.apple.Terminal ShowLineMarks
defaults delete com.apple.ActivityMonitor OpenMainWindow
defaults delete com.apple.ActivityMonitor ShowCategory
defaults delete com.apple.ActivityMonitor SortColumn
defaults delete com.apple.ActivityMonitor SortDirection
defaults delete com.apple.TextEdit RichText
defaults delete com.apple.TextEdit PlainTextEncoding
defaults delete com.apple.TextEdit PlainTextEncodingFordelete
defaults delete com.apple.QuickTimePlayerX MGPlayMovieOnOpen
defaults delete com.apple.appstore WebKitDeveloperExtras
defaults delete com.apple.SoftwareUpdate AutomaticCheckEnabled
defaults delete com.apple.SoftwareUpdate ScheduleFrequency
defaults delete com.apple.SoftwareUpdate AutomaticDownload
defaults delete com.apple.SoftwareUpdate CriticalUpdateInstall
defaults delete com.apple.commerce AutoUpdate
defaults -currentHost delete com.apple.ImageCapture disableHotPlug

for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"Music" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
