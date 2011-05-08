Return-Path: <ordex@autistici.org>
Date: Sun, 8 May 2011 20:44:40 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110508184431.GA4631@ritirata.org>
References: <1304583702-23969-1-git-send-email-ordex@autistici.org>
	<201105051420.10634.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201105051420.10634.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move
 neigh_node->if_incoming->if_status check in find_router()
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

On gio, mag 05, 2011 at 02:20:10 +0200, Marek Lindner wrote:
> On Thursday 05 May 2011 10:21:42 Antonio Quartulli wrote:
> >  return_router:
> > +       if (router && router->if_incoming->if_status != IF_ACTIVE)
> > +               router = NULL;
> > +
> >         rcu_read_unlock();
> >         return router;
> 
> You are breaking the reference counting of 'router' here. While looking at 
> your patch I found another refcount imbalance. Check the patch I just posted 
> (Fix refcount imbalance in find_router).

I see :)
And thanks for reviewing.

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
