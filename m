Return-Path: <andrew@lunn.ch>
Date: Sat, 16 Apr 2022 16:21:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] batman-adv: Don't skb_split skbuffs with frag_list
Message-ID: <YlrQ306LD4luXaeJ@lunn.ch>
References: <20220416122434.33061-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416122434.33061-1-sven@narfation.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Sven Eckelmann <sven@narfation.org>, Felix Kaechele <felix@kaechele.ca>

On Sat, Apr 16, 2022 at 02:24:34PM +0200, Sven Eckelmann wrote:
> The receiving interface might have used GRO to receive more fragments than
> MAX_SKB_FRAGS fragments. In this case, these will not be stored in
> skb_shinfo(skb)->frags but merged into the frag list.
> 
> batman-adv relies on the function skb_split to split packets up into
> multiple smaller packets which are not larger than the MTU on the outgoing
> interface. But this function cannot handle frag_list entries and is only
> operating on skb_shinfo(skb)->frags. If it is then still trying to split
> such an skb and xmit'ing it on an interface without support for
> NETIF_F_FRAGLIST then validate_xmit_skb() will try to linearize it. But
> this fails due to inconsistent information and __pskb_pull_tail will
> trigger a BUG_ON after skb_copy_bits() returns an error.
> 
> In case of entries in frag_list, just linearize the skb before operating on
> it with skb_split().

Hi Sven

This is not an area of the kernel i'm very familiar with. But i'm
wondering, is this a BATMAN specific problem, or a generic problem?
Should the fix be in BATMAN, or the core?

       Andrew
