Return-Path: <linus.luessing@web.de>
Date: Mon, 21 Jul 2014 17:29:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140721152912.GW2675@Linus-Debian>
References: <1405391898-5258-1-git-send-email-linus.luessing@web.de>
 <1405391898-5258-2-git-send-email-linus.luessing@web.de>
 <1438357.7uXdXc9RPK@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438357.7uXdXc9RPK@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/2] batman-adv: Add debugfs table for
 mcast flags
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

Hi Marek,

On Sat, Jul 19, 2014 at 06:02:47PM +0800, Marek Lindner wrote:
> On Tuesday 15 July 2014 04:38:18 Linus Lüssing wrote:
> > +#ifdef CONFIG_BATMAN_ADV_MCAST
> > +/**
> > + * batadv_mcast_flags_open - Prepare file handler for reads from mcast_flags
> 
> No upper case please.

k, right

> 
> 
> > +		rcu_read_lock();
> > +		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
> > +			if (!(orig_node->capa_initialized &
> > +			      BATADV_ORIG_CAPA_HAS_MCAST))
> > +				continue;
> 
> Why not printing '-' in this case as well ?

Hm, my intention was to only list primary originators. Which the
capa_initialized can provide.

Every other, secondary interface originator is ignored in the
calculations, too, since these will never provide (and don't need
to) provide a TVLV anyways.

Does this make sense?

> 
> Cheers,
> Marek

Cheers, Linus
