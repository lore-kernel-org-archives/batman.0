Return-Path: <linus.luessing@web.de>
Date: Tue, 9 Nov 2010 09:32:04 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101109083204.GA450@Sellars>
References: <1289260381-6415-1-git-send-email-sven.eckelmann@gmx.de>
	<1289260381-6415-2-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1289260381-6415-2-git-send-email-sven.eckelmann@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use kernel functions to
 identify broadcasts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

> is_broadcast_ether_addr(x) => is_multicast_ether_addr(x)
> 
> or when looking more at the implementation:
> 
> (FF:FF:FF:FF:FF:FF == x) => [(01:00:00:00:00:00 & x) != 00:00:00:00:00:00]
> 
[...]
> -	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
> +	if (is_broadcast_ether_addr(ethhdr->h_dest)) {
>  		ret = gw_is_target(bat_priv, skb);

So, shouldn't that be the other way round?
is_multicast_ether_addr() instead?

Cheers,
Linus
