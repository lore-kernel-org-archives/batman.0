Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: make use of helper
 netif_is_bridge_master()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163455901121.7340.10701802688930426386.git-patchwork-notify@kernel.org>
Date: Mon, 18 Oct 2021 12:10:11 +0000
References: <20211016112137.18858-1-acadx0@gmail.com>
In-Reply-To: <20211016112137.18858-1-acadx0@gmail.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Kyungrok Chung <acadx0@gmail.com>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Oct 2021 20:21:36 +0900 you wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
> ---
> 
> v1->v2:
>   - Apply fixes to batman-adv, core too.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: make use of helper netif_is_bridge_master()
    https://git.kernel.org/netdev/net-next/c/254ec036db11

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


