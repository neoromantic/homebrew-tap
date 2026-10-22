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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.1/ai-usage_darwin_arm64"
      sha256 "1b2edd83ac649359632b42cfced8a3dbbef8aa7d28ba25d4e61cef30bdd165a3"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.1/ai-usage_darwin_amd64"
      sha256 "0e2adeb748fb948f5b0a8e3ca29c464c129682b353ec0d8917f691640eff4b6d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.1/ai-usage_linux_arm64"
      sha256 "a6672f1c8a2db4e3fb11bd5444af0a232496a1e1fd17d668569473fa6726eae0"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.1/ai-usage_linux_amd64"
      sha256 "f865923af4d015547bc42142bf680c2f3cc0027a198808898a6e475d4c9ebd8c"
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
