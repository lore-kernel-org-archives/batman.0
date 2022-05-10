Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] batman-adv: Don't skb_split skbuffs with frag_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165214561288.15844.2929287601845577779.git-patchwork-notify@kernel.org>
Date: Tue, 10 May 2022 01:20:12 +0000
References: <20220508132110.20451-2-sw@simonwunderlich.de>
In-Reply-To: <20220508132110.20451-2-sw@simonwunderlich.de>
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
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, felix@kaechele.ca

Hello:

This patch was applied to netdev/net.git (master)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Sun,  8 May 2022 15:21:10 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The receiving interface might have used GRO to receive more fragments than
> MAX_SKB_FRAGS fragments. In this case, these will not be stored in
> skb_shinfo(skb)->frags but merged into the frag list.
> 
> batman-adv relies on the function skb_split to split packets up into
> multiple smaller packets which are not larger than the MTU on the outgoing
> interface. But this function cannot handle frag_list entries and is only
> operating on skb_shinfo(skb)->frags. If it is still trying to split such an
> skb and xmit'ing it on an interface without support for NETIF_F_FRAGLIST,
> then validate_xmit_skb() will try to linearize it. But this fails due to
> inconsistent information. And __pskb_pull_tail will trigger a BUG_ON after
> skb_copy_bits() returns an error.
> 
> [...]

Here is the summary with links:
  - [1/1] batman-adv: Don't skb_split skbuffs with frag_list
    https://git.kernel.org/netdev/net/c/a063f2fba3fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


