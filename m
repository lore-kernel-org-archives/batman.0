Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 4 Jan 2016 17:03:02 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160104160302.GL2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 01/30] batman-adv: Fix list removal of
 batadv_hardif_neigh_node
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

On Sun, Dec 20, 2015 at 02:17:41PM +0100, Sven Eckelmann wrote:
> The neigh_list with batadv_hardif_neigh_node objects is accessed with only
> rcu_read_lock in batadv_neigh_node_get and batadv_iv_neigh_print. Thus it
> is not allowed to kfree the object before the rcu grace period ends (which
> may still protects context accessing this object). Therefore the object has
> first to be removed from the neigh_list and then it has either wait with
> synchronize_rcu or call_rcu till the grace period ends before it can be
> freed.

Urgh, could catch, that's a nasty one! Should be put into maint at
least thrice ;).

Nit: I think you mean "batadv_hardif_neigh_get" instead of
"batadv_neigh_node_get" in the commit message?
