Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 4 Jan 2016 17:04:00 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160104160400.GM2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <1450617490-3544-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-3-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 03/30] batman-adv: Avoid recursive
 call_rcu for batadv_nc_node
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

On Sun, Dec 20, 2015 at 02:17:43PM +0100, Sven Eckelmann wrote:
> The reference drop of orig_node was done in the call_rcu function
> batadv_nc_node_free_rcu but should actually be done in the
> batadv_claim_release function to avoid nested call_rcus. This is important
> because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will not
> detect the inner call_rcu as relevant for its execution. Otherwise this
> barrier will most likely be inserted in the queue before the callback of
> the first call_rcu was executed. The caller of rcu_barrier will therefore
> continue to run before the inner call_rcu callback finished.

batadv_nc_node_release instead of batadv_claim_release?
