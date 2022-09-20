Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] batman-adv: Fix hang up with small MTU hard-interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166363681491.30260.14164726870306150299.git-patchwork-notify@kernel.org>
Date: Tue, 20 Sep 2022 01:20:14 +0000
References: <20220916160931.1412407-2-sw@simonwunderlich.de>
In-Reply-To: <20220916160931.1412407-2-sw@simonwunderlich.de>
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
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, syoshida@redhat.com, sven@narfation.org

Hello:

This patch was applied to netdev/net.git (master)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 16 Sep 2022 18:09:31 +0200 you wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> 
> The system hangs up when batman-adv soft-interface is created on
> hard-interface with small MTU.  For example, the following commands
> create batman-adv soft-interface on dummy interface with zero MTU:
> 
>   # ip link add name dummy0 type dummy
>   # ip link set mtu 0 dev dummy0
>   # ip link set up dev dummy0
>   # ip link add name bat0 type batadv
>   # ip link set dev dummy0 master bat0
> 
> [...]

Here is the summary with links:
  - [1/1] batman-adv: Fix hang up with small MTU hard-interface
    https://git.kernel.org/netdev/net/c/b1cb8a71f1ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


