Return-Path: <linus.luessing@web.de>
Date: Fri, 2 May 2014 06:50:27 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140502045026.GS4593@Linus-Debian>
References: <1398281948-3415-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1398281948-3415-1-git-send-email-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix NULL pointer dereferences
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Signed-off-by: Linus Lüssing <linus.luessing@web.de>


On Thu, Apr 24, 2014 at 03:39:08AM +0800, Marek Lindner wrote:
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  multicast.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/multicast.c b/multicast.c
> index 8c7ca81..96b66fd 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -415,7 +415,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
>  	hlist_for_each_entry_rcu(tmp_orig_node,
>  				 &bat_priv->mcast.want_all_ipv4_list,
>  				 mcast_want_all_ipv4_node) {
> -		if (!atomic_inc_not_zero(&orig_node->refcount))
> +		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
>  			continue;
>  
>  		orig_node = tmp_orig_node;
> @@ -442,7 +442,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
>  	hlist_for_each_entry_rcu(tmp_orig_node,
>  				 &bat_priv->mcast.want_all_ipv6_list,
>  				 mcast_want_all_ipv6_node) {
> -		if (!atomic_inc_not_zero(&orig_node->refcount))
> +		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
>  			continue;
>  
>  		orig_node = tmp_orig_node;
> @@ -493,7 +493,7 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
>  	hlist_for_each_entry_rcu(tmp_orig_node,
>  				 &bat_priv->mcast.want_all_unsnoopables_list,
>  				 mcast_want_all_unsnoopables_node) {
> -		if (!atomic_inc_not_zero(&orig_node->refcount))
> +		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
>  			continue;
>  
>  		orig_node = tmp_orig_node;
> -- 
> 2.0.0.rc0
> 
