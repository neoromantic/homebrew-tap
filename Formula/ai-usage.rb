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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.1/ai-usage_darwin_arm64"
      sha256 "e79f4604bd34b1322ef3af927c77d98640a7a2479569f11939d44b9059bd4d76"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.1/ai-usage_darwin_amd64"
      sha256 "9cffb01dec32e7a3c384e280af4050e8eda31542d3353b980494b91e4e37c744"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.1/ai-usage_linux_arm64"
      sha256 "49d64b0d9ce26f261c51820d5f79ea536a4ef2104080872b5182a4e097a26234"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.1/ai-usage_linux_amd64"
      sha256 "28971fe41057f1d72dfc7564740037b270d68386c71d4d75d47f561f5371853a"
    end
  end

  # A static binary: no Homebrew glibc or gcc on an older Linux.
  def add_global_deps_to_spec(*); end

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
