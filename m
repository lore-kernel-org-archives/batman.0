Return-Path: <kuba@kernel.org>
Date: Mon, 30 Nov 2020 18:34:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/2] vxlan: Add needed_headroom for lower device
Message-ID: <20201130183425.7086ae00@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201126125247.1047977-1-sven@narfation.org>
References: <20201126125247.1047977-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Annika Wickert <annika.wickert@exaring.de>

On Thu, 26 Nov 2020 13:52:46 +0100 Sven Eckelmann wrote:
> It was observed that sending data via batadv over vxlan (on top of
> wireguard) reduced the performance massively compared to raw ethernet or
> batadv on raw ethernet. A check of perf data showed that the
> vxlan_build_skb was calling all the time pskb_expand_head to allocate
> enough headroom for:
> 
>   min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len
>   		+ VXLAN_HLEN + iphdr_len;
> 
> But the vxlan_config_apply only requested needed headroom for:
> 
>   lowerdev->hard_header_len + VXLAN6_HEADROOM or VXLAN_HEADROOM
> 
> So it completely ignored the needed_headroom of the lower device. The first
> caller of net_dev_xmit could therefore never make sure that enough headroom
> was allocated for the rest of the transmit path.
> 
> Cc: Annika Wickert <annika.wickert@exaring.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied both, thanks!
