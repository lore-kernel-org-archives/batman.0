Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] batman-adv: Use netif_rx_any_context().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161567520939.31370.1035945046701206897.git-patchwork-notify@kernel.org>
Date: Sat, 13 Mar 2021 22:40:09 +0000
References: <20210312154724.14980-2-sw@simonwunderlich.de>
In-Reply-To: <20210312154724.14980-2-sw@simonwunderlich.de>
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
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bigeasy@linutronix.de, sven@narfation.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 12 Mar 2021 16:47:24 +0100 you wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The usage of in_interrupt() in non-core code is phased out. Ideally the
> information of the calling context should be passed by the callers or the
> functions be split as appropriate.
> 
> The attempt to consolidate the code by passing an arguemnt or by
> distangling it failed due lack of knowledge about this driver and because
> the call chains are hard to follow.
> 
> [...]

Here is the summary with links:
  - [1/1] batman-adv: Use netif_rx_any_context().
    https://git.kernel.org/netdev/net-next/c/b1de0f01b011

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


