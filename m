Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 20 Jun 2016 03:59:01 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160620015901.GE3029@otheros>
References: <1463310915-7111-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1463310915-7111-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: use kmem_cache for translation
 table
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

On Sun, May 15, 2016 at 01:15:15PM +0200, Sven Eckelmann wrote:
> TODO statistics, batadv_tt_roam_node?, batadv_tt_change_node?,
> batadv_tt_req_node?, ....

Some statistics here:

https://www.open-mesh.org/projects/batman-adv/wiki/Kmalloc-kmem-cache-tests


In a nutshell, on a small TP-Link TL-841NDv8 wireless router
(MIPS/AR9341), I was able to achieve 34% more global TT entries
(or 25% less RAM usage).


Regarding SLAB_HWCACHE_ALIGN, it did not seem to make much of a
difference. There is a slight tendency for less RAM usage without
this flag. But it is so small, that it might be a coincident, too.
And it is definitely negligable. At least for this architecture.

Regards, Linus


PS: I might make some more, pretty graphs for the other test
variables, too. But for now, there is just this one raw table for
that.
