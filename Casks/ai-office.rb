cask "ai-office" do
  version "0.29.1"
  sha256 "c634d5b0ce484928fb57a668b25bbe8b6612359e74bfe4199b713e709872a89b"

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
