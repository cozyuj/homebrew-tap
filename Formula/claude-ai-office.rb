class ClaudeAiOffice < Formula
  desc "Isometric office that visualizes Claude Code sessions (web version CLI)"
  homepage "https://github.com/cozyuj/AI-office"
  url "https://registry.npmjs.org/claude-ai-office/-/claude-ai-office-0.25.6.tgz"
  sha256 "668a6ebf005b8f01b0d4705f5fecce64079a7b67f1c84d572750f2c81dfd9ef1"
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
