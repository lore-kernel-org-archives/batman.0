Return-Path: <linus.luessing@web.de>
Date: Fri, 20 Jun 2014 17:57:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140620155712.GU29033@Linus-Debian>
References: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
 <1982917.uLe1stfMfi@diderot> <20140617222414.GG29033@Linus-Debian>
 <6992822.ghf2EUPW9C@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6992822.ghf2EUPW9C@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast optimization
 support for bridged setups
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Wed, Jun 18, 2014 at 12:53:20PM +0800, Marek Lindner wrote:
> Thanks for the clarifications but that does not address my question. To be 
> more precise: In batadv_mcast_mla_update() your code is calling 
> batadv_mcast_mla_softif_get() which queries the bridge interface (if bridged). 
> A couple of lines later batadv_mcast_mla_bridge_get() is called (if bridged). 
> It looks to me the code queries the bridge twice ?
> 
> Then, I am comparing the kernel doc to get the difference but I see none:
> 
>  * batadv_mcast_mla_softif_get - get softif multicast listeners
>  * @dev: the device to collect multicast addresses from
>  * @mcast_list: a list to put found addresses into
>  *
>  * Collect multicast addresses of the local multicast listeners
>  * on the given soft interface, dev, in the given mcast_list.
>  *
>  * If there is a bridge interface on top of dev, collect from that one
>  * instead.
> 
>  ===============================================================
> 
>  * batadv_mcast_mla_bridge_get - get bridged-in multicast listeners
>  * @dev: a bridge slave whose bridge to collect multicast addresses from
>  * @mcast_list: a list to put found addresses into
>  *
>  * Collects multicast addresses of the bridged-in multicast listeners
>  * from the bridge on top of the given soft interface, dev, in the
>  * given mcast_list.
> 
> What is the difference between these calls and why doesn't the code explain 
> that difference ?

Okay, another try, now with pictures :) :


So far we are doing this:

https://metameute.de/~tux/batman-adv/multicast-listener-fetching-no-bridge.png

So we are able to fetch local listeners (with "local" I mean
listeners which are present on the same kernel) from bat0
via batadv_mcast_mla_softif_get(). And are announcing them in the
mesh cloud so that multicast senders know which nodes they need to
send their data to.

This box with the local listener could be an embedded router running
batman-adv receiving music via multicast and playing it directly over
its USB sound card.

---

With this patch batadv_mla_bridge_get() is being added:

https://metameute.de/~tux/batman-adv/multicast-listener-fetching-with-bridge.png

Now we are able to detect bridged-in listeners (with "bridged-in" I
mean listeners behind the bridge of a batman-adv node, some
alien device). For instance this could be a non-Linux laptop
wanting to receive the same or a different multicast music stream.

Also note, that in the bridge-case batadv_mcast_mla_softif_get()
gets its local listener information from a different device now,
marked in orange: Just like you wouldn't use IP addresses+routes
on bat0 anymore but br0 instead, also the local multicast
listeners will be registering to br0 instead of bat0 now. That's
where the "bridge ? bridge : dev" code changes in this patch for
batadv_mcast_mla_softif_get() come from.

---

tl;dr: batadv_mla_softif_get() is for multicast listeners *on* a
batman-adv node, batadv_mla_bridge_get() for multicast listeners
*behind* the bridge of a batman-adv node.


If the pictures are somehow helpful and if others feel this is
worth a new wiki page in the batadv-multicast-docs, I can create
one. (Also, I hope especially the second one isn't too overloaded,
if someone has ideas how to simplify it, I'd be glad to hear about
it.)

Cheers, Linus
