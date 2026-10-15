class AiUsage < Formula
  desc "Quota left and token use for Claude Code, Codex, and Grok, per machine and team"
  homepage "https://github.com/neoromantic/ai-usage"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.0/ai-usage_darwin_arm64"
      sha256 "0f753c31617c15d097138eeb2f4664c6f614e2aa4844ae8c9a8ef0ba41a038c9"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.0/ai-usage_darwin_amd64"
      sha256 "f07f136995cbdeb9f65ec851c35c9a3996e54095a175ceb021c1a2dac6a5dee7"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.0/ai-usage_linux_arm64"
      sha256 "5a4b2358018389f59fefa9f606985211907dc58b517639497921abf8175fe8f6"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.0/ai-usage_linux_amd64"
      sha256 "772fa59a5c8b93902fb4258a710247f3d742f028b44e0864d3d4b5f9fb90dbd1"
    end
  end

  def install
    bin.install Dir["ai-usage_*"].first => "ai-usage"
  end

  def caveats
    <<~EOS
      To join a team, run `ai-usage team join` first and paste the key.
      Then run `ai-usage` once: it collects and registers a 15-minute run
      with launchd or cron. If you once ran `ai-usage schedule remove`,
      run `ai-usage schedule install` instead.
      On macOS 14 or later, `ai-usage app install` adds the menu bar app.
      Update with `brew upgrade neoromantic/tap/ai-usage` or `ai-usage update`.
      If you installed with the script before, remove that copy, such as
        rm ~/.local/bin/ai-usage
      If brew could not link ai-usage over an old copy in its bin folder:
        brew link --overwrite neoromantic/tap/ai-usage
      Before `brew uninstall`, run `ai-usage schedule remove`; see
        https://github.com/neoromantic/ai-usage#uninstall
    EOS
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/ai-usage version").strip
  end
end
