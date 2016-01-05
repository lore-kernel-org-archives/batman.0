Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 5 Jan 2016 02:50:31 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160105015031.GU2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <1450617490-3544-7-git-send-email-sven@narfation.org>
 <20160105013114.GT2823@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160105013114.GT2823@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 07/30] batman-adv: Drop immediate
 batadv_hardif_neigh_node free function
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

On Tue, Jan 05, 2016 at 02:31:14AM +0100, Linus Lüssing wrote:
> On Sun, Dec 20, 2015 at 02:17:47PM +0100, Sven Eckelmann wrote:
> > @@ -278,8 +258,8 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
> >  					       neigh_node->addr);
> >  	if (hardif_neigh) {
> >  		/* batadv_hardif_neigh_get() increases refcount too */
> > -		batadv_hardif_neigh_free_now(hardif_neigh);
> > -		batadv_hardif_neigh_free_now(hardif_neigh);
> > +		batadv_hardif_neigh_free_ref(hardif_neigh);
> > +		batadv_hardif_neigh_free_ref(hardif_neigh);
> >  	}
> 
> Hm, this trades one bug for an intermediate one, a nested
> call-rcu. Swapping this patch with patch number 9 to avoid this?
> (tried that an the diffs seem cleaner to me after swapping; or am
> I missing something?)

Actually, forget about that. Just noticed, one way or another
there will be one intermediate bug. Don't see another way for that
right now either.
