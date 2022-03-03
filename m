Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] batman-adv: Request iflink once in batadv-on-batadv
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164628721191.27095.7549108056265161167.git-patchwork-notify@kernel.org>
Date: Thu, 03 Mar 2022 06:00:11 +0000
References: <20220302163049.101957-2-sw@simonwunderlich.de>
In-Reply-To: <20220302163049.101957-2-sw@simonwunderlich.de>
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
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org

Hello:

This series was applied to netdev/net.git (master)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed,  2 Mar 2022 17:30:47 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> There is no need to call dev_get_iflink multiple times for the same
> net_device in batadv_is_on_batman_iface. And since some of the
> .ndo_get_iflink callbacks are dynamic (for example via RCUs like in
> vxcan_get_iflink), it could easily happen that the returned values are not
> stable. The pre-checks before __dev_get_by_index are then of course bogus.
> 
> [...]

Here is the summary with links:
  - [1/3] batman-adv: Request iflink once in batadv-on-batadv check
    https://git.kernel.org/netdev/net/c/690bb6fb64f5
  - [2/3] batman-adv: Request iflink once in batadv_get_real_netdevice
    https://git.kernel.org/netdev/net/c/6116ba09423f
  - [3/3] batman-adv: Don't expect inter-netns unique iflink indices
    https://git.kernel.org/netdev/net/c/6c1f41afc1db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


