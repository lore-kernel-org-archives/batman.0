Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 6 Aug 2016 03:11:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160806011112.GC4299@otheros>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <20160803212552.GB16866@otheros> <20160803234329.GD16866@otheros>
 <1877539.fInDOEgoYM@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1877539.fInDOEgoYM@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Simple (re)broadcast
 avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Aug 04, 2016 at 07:56:44AM +0200, Sven Eckelmann wrote:
> Ok, looks like the neigh_list edge in my graph is incorrectly there. But what 
> about last_bonding_candidate? This definitely has a reference counter (and 
> needs it) and thus your code would cause problems when bonding is enabled.

One more tiny thing, that I noticed during rereading & playing
with that part of the code:

The usage of orig_node->last_bonding_candidate looks a lot like
rcu-pointer style. However it is read & set without any
rcu_dereference() / rcu_assign() wrappers.

Is something else protecting a simultaneous read (for instance from
the neighbor table output) of last_bonding_candidate while being
changed via batadv_last_bonding_replace()?
