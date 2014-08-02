Return-Path: <linus.luessing@web.de>
Date: Sat, 2 Aug 2014 21:43:32 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140802194331.GE2392@Linus-Debian>
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

On Sat, Jul 19, 2014 at 06:02:47PM +0800, Marek Lindner wrote:
> On Tuesday 15 July 2014 04:38:18 Linus Lüssing wrote:
> > +		rcu_read_lock();
> > +		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
> > +			if (!(orig_node->capa_initialized &
> > +			      BATADV_ORIG_CAPA_HAS_MCAST))
> > +				continue;
> 
> Why not printing '-' in this case as well ?

Had been giving a reason on IRC already, but maybe it's better to
write it here again so that the reason doesn't get lost:

The idea was, to only have one entry per batman-adv node. Not per
originator. Secondary interface originators aren't considered in
the multicast logic anyways, so they might be confusing for the
user when doing manual checking and counting.

In other words, '-' is supposed to mean that this is an outdated
node not supporting multicast optimizations and not having the
according TVLV and that people should consider upgrading it.

Cheers, Linus
