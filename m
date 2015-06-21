Return-Path: <davem@davemloft.net>
Date: Sun, 21 Jun 2015 09:37:13 -0700 (PDT)
Message-Id: <20150621.093713.572451264516042062.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1434481584-1275-2-git-send-email-antonio@meshcoding.com>
References: <1434481584-1275-1-git-send-email-antonio@meshcoding.com>
 <1434481584-1275-2-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Avoid u32 overflow
 during gateway select
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
To: antonio@meshcoding.com
Cc: ruben@vfn-nrw.de, mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 16 Jun 2015 21:06:23 +0200

> @@ -133,7 +133,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
>  	struct batadv_neigh_node *router;
>  	struct batadv_neigh_ifinfo *router_ifinfo;
>  	struct batadv_gw_node *gw_node, *curr_gw = NULL;
> -	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
> +	uint64_t max_gw_factor = 0, tmp_gw_factor = 0;
>  	uint32_t gw_divisor;

Divides are performed using these variables, so if you make
them 64-bit the build will fail.  You have to use one of the
routines in include/linux/math64.h in this situation, but
realize that this operation is now going to be quite expensive.

