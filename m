Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] batman-adv: Avoid WARN_ON timing related checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162318000377.7737.11699354745969828257.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jun 2021 19:20:03 +0000
References: <20210608152947.30833-2-sw@simonwunderlich.de>
In-Reply-To: <20210608152947.30833-2-sw@simonwunderlich.de>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, penguin-kernel@i-love.sakura.ne.jp, syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue,  8 Jun 2021 17:29:47 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The soft/batadv interface for a queued OGM can be changed during the time
> the OGM was queued for transmission and when the OGM is actually
> transmitted by the worker.
> 
> But WARN_ON must be used to denote kernel bugs and not to print simple
> warnings. A warning can simply be printed using pr_warn.
> 
> [...]

Here is the summary with links:
  - [1/1] batman-adv: Avoid WARN_ON timing related checks
    https://git.kernel.org/netdev/net/c/9f460ae31c44

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


