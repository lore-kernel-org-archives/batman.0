Return-Path: <linus.luessing@web.de>
Date: Wed, 12 Jun 2013 14:27:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130612122714.GA27583@Linus-Debian>
References: <1370848318-18755-1-git-send-email-linus.luessing@web.de>
 <20130612101411.GA13323@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130612101411.GA13323@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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

On Wed, Jun 12, 2013 at 12:14:11PM +0200, Simon Wunderlich wrote:
> Hello Linus,
> 
> I gave it a try - but there seems something off. What I did is:
>  * apply your patches on 3b38a80 - multicast was enabled by default
>  * start 2 VMs directly connected
>  * ping6 -I bat0 ff02::1
> 
> I only got a reply locally, but not from the peer. When I disabled
> multicast, I got two replies from the local host and the peer.
> 
> As far as I have tracked the problem down, it appears that
> batadv_mcast_forw_mode() returns 1 correctly, but the packet is dropped

Ok, found a bug - the return 1 is actually incorrect. You've
chosen the one multicast address where no optimization is
conceptually possible. ff02::1 is the only link-local IPv6
multicast address which should return a BATADV_FORW_ALL (0)
instead.

(Conceptually impossible because for ff02::1 is the one multicast
address which by the IPv6 standard every host listens to, without
performing any MLD.)

I'll add another check next to the scope check in
mcast_forw_mode().

> later in the process - I would guess that this happens in
> batadv_send_generic_unicast_skb() where we try to select the gateway
> when the destination mac is multicast instead of looking it up in the
> tt table. But I leave the details to you. :)

Hm, but still, you're right, with this single destination, the
other VM, the ICMPv6 request and reply should have arrived because
the according MAC (33:33:00:00:00:01) is in the global translation table.

I didn't have that issue in my tests so far, I'll try to reproduce
that issue.

> 
> The rest looks good, but I'll review more deeply again when it's
> actually working. It does compile without problems now.
> 
> Cheers,
> 	Simon
> 

Thanks for the feedback again!

Cheers, Linus
