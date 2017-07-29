Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 29 Jul 2017 10:51:07 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170729085107.GG3700@otheros>
References: <20170706050225.24455-1-linus.luessing@c0d3.blue>
 <3105199.cDmPPX3bfG@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3105199.cDmPPX3bfG@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix TT sync flag
 inconsistencies
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

On Sat, Jul 29, 2017 at 10:25:37AM +0200, Sven Eckelmann wrote:
> On Donnerstag, 6. Juli 2017 07:02:25 CEST Linus Lüssing wrote:
> > This patch fixes an issue in the translation table code potentially
> > leading to a TT Request + Response storm. The issue may occur for nodes
> > involving BLA and an inconsistent configuration of the batman-adv AP
> > isolation feature. However, since the new multicast optimizations, a
> > single, malformed packet may lead to a mesh-wide, persistent
> > Denial-of-Service, too.
> [...]
> > This patch fixes this issue by storing the flags used in the CRC
> > calculation on a a per TT orig entry basis to be able to respond with
> > the correct, original flags in an intermediate TT Response for one
> > thing. And to be able to correctly unset sync flags once all nodes
> > announcing a sync flag vanish for another.
> > 
> > Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
> > Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> Simon wanted to have a look at this patch before applying it. But I've already 
> queued it up for openwrt-routing [1]. This should hopefully help people which 
> want to test it.

Ah, funny, did the same for Gluon a few hours ago :D. So I hope
that we might get some test feedback from there, too.

Regards, Linus

https://github.com/freifunk-gluon/gluon/pull/1199
https://github.com/freifunk-gluon/gluon/pull/1200
