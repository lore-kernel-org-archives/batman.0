Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 7 Jul 2019 23:47:43 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH] batman-adv: Fix deletion of RTR(4|6) mcast list entries
Message-ID: <20190707214743.GA2466@otheros>
References: <20190707210457.20892-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190707210457.20892-1-sven@narfation.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Jul 07, 2019 at 11:04:57PM +0200, Sven Eckelmann wrote:
> The multicast code uses the lists bat_priv->mcast.want_all_rtr*_list to
> store all all originator nodes which don't have the flag no-RTR4 or no-RTR6
> set. When an originator is purged, it has to be removed from these lists.
> 
> Since all entries without the BATADV_MCAST_WANT_NO_RTR4/6 are stored in
> these lists, they have to be handled like entries which have these flags
> set to force the update routines to remove them from the lists when purging
> the originator.
> 
> Not doing so will leave a pointer to a freed memory region inside the list.
> Trying to operate on these lists will then cause an use-after-free error:
> 
>   BUG: KASAN: use-after-free in batadv_mcast_want_rtr4_update+0x335/0x3a0 [batman_adv]
>   Write of size 8 at addr ffff888007b41a38 by task swapper/0/0
> 
> Fixes: 0a7733468f95 ("batman-adv: mcast: detect, distribute and maintain multicast router presence")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> See https://www.open-mesh.org/issues/395
> ---

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
