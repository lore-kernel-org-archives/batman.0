Return-Path: <linus.luessing@web.de>
Date: Mon, 10 Jun 2013 09:06:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130610070614.GA18177@Linus-Debian>
References: <1370845701-18481-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1370845701-18481-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hrm, forgot to add the v3 an the patch naming. And forgot to
actually add
-static inline batadv_forw_mode
+static inline enum batadv_forw_mode
to the according commit.

Will send a v4 in a sec.

Cheers, Linus

On Mon, Jun 10, 2013 at 08:28:18AM +0200, Linus Lüssing wrote:
> This is the third revision of the basic multicast optimization patches.
> It includes one functional and some compat fixes, and some style improvements,
> thanks to Simons feedback:
> 
> PATCHv3 1/3:
> * the pmc_rcu functions got removed - they weren't actually used in the
>   submitted revision - so there's no more patch for net to export
>   for_each_pmc_rcu() needed anymore. Should also fix Simon's compat error.
> * Compat code for netdev_for_each_mc_addr() added.
>   (I needed to introduce a batadv_hw_addr because I wasn't able to achieve
>   backwards compatibility with a netdev_hw_addr - my "official reasoning" will
>   be that netdev_hw_addr is unnecessarily bloated, struct batadv_hw_addr
>   has just the right size to do the job)
> * Compat fix for IFF_BRIDGE_PORT
> * Removed primary_if->soft_iface in batadv_mcast_mla_tt_update() as we
>   can always use bat_priv->soft_iface instead.
> 
> PATCHv3 2/3
> * Renamed num_non_aware to a more specific num_no_mla - because we will need
>   things like a num_no_tracker for instance with the multicast tracker feature
>   in the future.
> * Fixed removal of orig_node's without BATADV_MCAST_LISTENER_ANNOUNCEMENT
>   flag, update num_no_mla properly now.
> 
> PATCHv3 3/3
> * Renamed batadv_mcast_flood() to batadv_mcast_forw_mode() because it does not
>   only show whether to flood or not (=drop), but also whether to forward via
>   unicast. In the future with the multicast tracker feature a fourth return value
>   is going to be added, making the name "batadv_mcast_flood()" even less fitting.
> * Simon's style suggestions for batadv_mcast_forw_mode() and
>   batadv_interface_tx().
> * batadv_mcast_forw_mode() now returns an enum (thanks to Marek and Antonio for
>   the suggestion).
> 
> I did not change:
> > I don't quite understand why you return -1, maybe the packet could still
> > be forwarded even if it could not be pulled?
> 
> Because if it returns -1 then something is wrong, for instance we could be
> out of memory. If we are out of memory then we probably won't be able to
> forward any packet. Also we shouldn't allocate any more memory for one thing
> but I think it is also better to drop/free packets to save some memory
> to increase the possibility of the system to recover without crashing.
> 
> Cheers, Linus
> 
