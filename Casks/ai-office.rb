cask "ai-office" do
  version "0.28.0"
  sha256 "10b263546905e2dbb6ae1e8f71c4118667ffe0d29fa172666ea37616b198d09f"

  url "https://github.com/cozyuj/AI-office/releases/download/v#{version}/AI.Office_#{version}_aarch64.dmg"
  name "AI Office"
  desc "Isometric office that visualizes Claude Code sessions in real time"
  homepage "https://github.com/cozyuj/AI-office"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "AI Office.app"

  # 서명·공증 전이라 Gatekeeper 격리 속성을 지운다 (없으면 macOS 15+ 에서 열리지 않음)
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/AI Office.app"], must_succeed: false
  end

  uninstall quit: "io.bigxdata.aioffice"

  zap trash: [
    "~/.ai-office",
    "~/Library/Application Support/io.bigxdata.aioffice",
    "~/Library/Caches/io.bigxdata.aioffice",
    "~/Library/WebKit/io.bigxdata.aioffice",
  ]

  caveats <<~EOS
    AI Office registers Claude Code hooks in ~/.claude/settings.json on first launch.
    To remove them: npx claude-ai-office uninstall-hooks
  EOS
end
