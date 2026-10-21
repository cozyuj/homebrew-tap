class ClaudeAiOffice < Formula
  desc "Isometric office that visualizes Claude Code sessions (web version CLI)"
  homepage "https://github.com/cozyuj/AI-office"
  url "https://registry.npmjs.org/claude-ai-office/-/claude-ai-office-0.25.1.tgz"
  sha256 "b222b001b8f580283cd5891af00fdbb03bb781c5675999271876fd7c878ccdaa"
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
