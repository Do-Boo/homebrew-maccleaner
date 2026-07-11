cask "maccleaner" do
  version "1.3.1"
  sha256 "f560ba726f53fa37f9a638a3f0ef8b9de3eb5f512fac45475cdbc891eacddd22"

  url "https://github.com/Do-Boo/maccleaner/releases/download/v#{version}/MacCleaner-#{version}.zip"
  name "MacCleaner"
  desc "SwiftUI utility for storage cleanup and system maintenance"
  homepage "https://github.com/Do-Boo/maccleaner"

  depends_on macos: :sonoma

  app "MacCleaner.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MacCleaner.app"]
  end

  uninstall quit: "com.doyoukim.maccleaner"

  zap trash: [
    "~/Library/Preferences/com.doyoukim.maccleaner.plist",
    "~/Library/Saved Application State/com.doyoukim.maccleaner.savedState",
  ]

  caveats <<~EOS
    MacCleaner is currently distributed without Apple notarization.
    This cask removes the quarantine attribute after verifying the release SHA-256.
    Review the source and cask before installation:
      https://github.com/Do-Boo/maccleaner
  EOS
end
