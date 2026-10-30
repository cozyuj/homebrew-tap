class ClaudeAiOffice < Formula
  desc "Isometric office that visualizes Claude Code sessions (web version CLI)"
  homepage "https://github.com/cozyuj/AI-office"
  url "https://registry.npmjs.org/claude-ai-office/-/claude-ai-office-0.37.7.tgz"
  sha256 "021329687aaa36847ea0bc1f810f452261d58c9c61c8d81e854a3557e5bca3c3"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      Run `ai-office` to install hooks into ~/.claude/settings.json, start the server and open the browser.
      Remove the hooks with `ai-office uninstall-hooks`.
    EOS
  end

  test do
    assert_match "node", shell_output("#{bin}/ai-office doctor")
  end
end
