Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 6 Oct 2016 03:55:21 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161006015520.GC19216@otheros>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-2-linus.luessing@c0d3.blue>
 <7378987.EkNMrEAytt@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7378987.EkNMrEAytt@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Store and transmit own
 neighborhood hash
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

On Thu, Sep 29, 2016 at 05:31:27PM +0200, Sven Eckelmann wrote:
> First you have to use hlist_add_head_rcu and hlist_add_behind_rcu here because
> the readers use RCU to access the list. I think it would also be more
> appropriate to replace the rcu_read_lock in the batadv_hardif_neigh_get_pre
> function and instead use lockdep to mark the function as "requires
> hard_iface->neigh_list_lock".

Hm, I'm currently wondering... isn't this a bug we already have
now, then? Shouldn't this have been an hlist_add_head_rcu() in the
first place?
