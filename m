Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] batman-adv: Fix order of kernel doc in batadv_priv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161791741422.16984.11272846748570435794.git-patchwork-notify@kernel.org>
Date: Thu, 08 Apr 2021 21:30:14 +0000
References: <20210408115401.16988-2-sw@simonwunderlich.de>
In-Reply-To: <20210408115401.16988-2-sw@simonwunderlich.de>
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
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linus.luessing@c0d3.blue, sven@narfation.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu,  8 Apr 2021 13:53:59 +0200 you wrote:
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> During the inlining process of kerneldoc in commit 8b84cc4fb556
> ("batman-adv: Use inline kernel-doc for enum/struct"), some comments were
> placed at the wrong struct members. Fixing this by reordering the comments.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> [...]

Here is the summary with links:
  - [1/3] batman-adv: Fix order of kernel doc in batadv_priv
    https://git.kernel.org/netdev/net-next/c/549750babea1
  - [2/3] batman-adv: Drop unused header preempt.h
    https://git.kernel.org/netdev/net-next/c/5fc087ff96fd
  - [3/3] batman-adv: Fix misspelled "wont"
    https://git.kernel.org/netdev/net-next/c/35796c1d3438

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


