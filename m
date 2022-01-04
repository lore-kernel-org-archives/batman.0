Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] batman-adv: mcast: don't send link-local multicast to
 mcast routers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164126881175.32247.1012598310655037825.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jan 2022 04:00:11 +0000
References: <20220103171203.1124980-2-sw@simonwunderlich.de>
In-Reply-To: <20220103171203.1124980-2-sw@simonwunderlich.de>
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
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linus.luessing@c0d3.blue, sven@narfation.org

Hello:

This patch was applied to netdev/net.git (master)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Mon,  3 Jan 2022 18:12:03 +0100 you wrote:
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> The addition of routable multicast TX handling introduced a
> bug/regression for packets with a link-local multicast destination:
> These packets would be sent to all batman-adv nodes with a multicast
> router and to all batman-adv nodes with an old version without multicast
> router detection.
> 
> [...]

Here is the summary with links:
  - [1/1] batman-adv: mcast: don't send link-local multicast to mcast routers
    https://git.kernel.org/netdev/net/c/938f2e0b57ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


