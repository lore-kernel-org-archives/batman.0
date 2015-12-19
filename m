Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 19 Dec 2015 23:14:18 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151219221418.GA9322@otheros>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
 <20151219080405.GJ30160@otheros> <1831238.xY0O8bfIys@bentobox>
 <56753ACE.1070302@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56753ACE.1070302@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
 doing mcast_free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: Simon Wunderlich <simon@open-mesh.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sat, Dec 19, 2015 at 07:09:02PM +0800, Antonio Quartulli wrote:
> Am I wrong or also the commit message is misleading? Looks like it is
> "fixing" a bogus lockdep check...

Yes and no. The lockdep checks placed are not bogus as is. They
are fine for batadv_iv_ogm_schedule() vs. batadv_update_mtu(), so
no need to remove it.

> but as far as I can say this patch is
> making sure that the lock is held in that particular point.

There is no locking issue from batadv_mcast_free() here as it is
in the freeing phase of the soft-iface. The soft-iface is supposed
to be out-of-scope for anything else by now. This patch therefore
can't be a fix for a race regarding mcast.mla_list.

However it does fix an issue with a lockdep warning. Which
makes it suitable for stable to at least remove that splat for
v4.3 users.

Regards, Linus
