Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 6 Oct 2016 05:14:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161006031456.GF19216@otheros>
References: <20160929152258.8217-1-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160929152258.8217-1-sven.eckelmann@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Modify neigh_list only
 with rcu-list functions
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

On Thu, Sep 29, 2016 at 05:22:58PM +0200, Sven Eckelmann wrote:
> The batadv_hard_iface::neigh_list is accessed via rcu based primitives.
> Thus all operations done on it have to fulfill the requirements by RCU. So
> using non-RCU mechanisms like hlist_add_head is not allowed because it
> misses the barriers required to protect concurrent readers when accessing
> the data behind the pointer.
> 
> Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors per hard-interface")
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
