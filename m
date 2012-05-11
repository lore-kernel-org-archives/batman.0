Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 12 May 2012 03:50:20 +0800
References: <201205081359.26707.lindner_marek@yahoo.de>
	<ebf1a5f57c2b4069b177913c3a7ee3d7e0b8db3d.1336509029.git.mschiffer@universe-factory.net>
	<5459592.26kVfpJHA4@sven-desktop.home.narfation.org>
In-Reply-To: <5459592.26kVfpJHA4@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205120350.20936.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix locking in hash_add()
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

On Wednesday, May 09, 2012 04:38:58 Sven Eckelmann wrote:
> Details
> 
>   On Tuesday 08 May 2012 22:31:57 Matthias Schiffer wrote:
> > To ensure an entry isn't added twice all comparisons have to be protected
> > by the hash line write spinlock. This doesn't really hurt as the case
> > that it is tried to add an element already present to the hash shouldn't
> > occur very often, so in most cases the lock would have have to be taken
> > anyways.
> >
> > 
> >[..]
> >
> > -err_unlock:
> > -     rcu_read_unlock();
> > +unlock:
> > +     spin_unlock_bh(list_lock);
> >
> >  out:
> >       return ret;
> >  }
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 41c5874.

Thanks,
Marek
