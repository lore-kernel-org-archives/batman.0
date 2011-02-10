Return-Path: <linus.luessing@web.de>
Date: Thu, 10 Feb 2011 12:01:39 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110210110138.GB13038@Sellars>
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-2-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1296832896-30081-2-git-send-email-linus.luessing@ascom.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: Correct rcu refcounting
 for gw_node
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

So, had a second look at the way the gw_node rcu-locking
refcounting stuff is done and looks sane to me with the
rcu_dereference/assign_pointer additions. Just one thing I noticed
in gw_select() which probably is not an issue:

It's not harmful to hold a rcu_read_lock() while calling this as
we are using call_rcu() gw_node_free_ref(), right?
Do we need to increase the new_gw_node refcount? Of course we
cannot call the whole gw_select() without
any rcu locking due to the atomic_inc_not_zero(), but just
wondering if the rcu_read_unlock() should be called earlier.

So if some one can confirm that this is not an issue, then the
gw_node rcu refcount patches get my ok for being applied to the
trunk.

Cheers, Linus

On Fri, Feb 04, 2011 at 04:21:30PM +0100, Linus Lüssing wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> It might be possible that 2 threads access the same data in the same
> rcu grace period. The first thread calls call_rcu() to decrement the
> refcount and free the data while the second thread increases the
> refcount to use the data. To avoid this race condition all refcount
> operations have to be atomic.
> 
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  gateway_client.c |   41 ++++++++++++++++++-----------------------
>  types.h          |    2 +-
>  2 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
> index 429a013..517e001 100644
> --- a/batman-adv/gateway_client.c
> +++ b/batman-adv/gateway_client.c
> @@ -28,20 +28,18 @@
>  #include <linux/udp.h>
>  #include <linux/if_vlan.h>
>  
> -static void gw_node_free_ref(struct kref *refcount)
> -{
> -	struct gw_node *gw_node;
> -
> -	gw_node = container_of(refcount, struct gw_node, refcount);
> -	kfree(gw_node);
> -}
> -
>  static void gw_node_free_rcu(struct rcu_head *rcu)
>  {
>  	struct gw_node *gw_node;
>  
>  	gw_node = container_of(rcu, struct gw_node, rcu);
> -	kref_put(&gw_node->refcount, gw_node_free_ref);
> +	kfree(gw_node);
> +}
> +
> +static void gw_node_free_ref(struct gw_node *gw_node)
> +{
> +	if (atomic_dec_and_test(&gw_node->refcount))
> +		call_rcu(&gw_node->rcu, gw_node_free_rcu);
>  }
>  
>  void *gw_get_selected(struct bat_priv *bat_priv)
> @@ -61,25 +59,26 @@ void gw_deselect(struct bat_priv *bat_priv)
>  	bat_priv->curr_gw = NULL;
>  
>  	if (gw_node)
> -		kref_put(&gw_node->refcount, gw_node_free_ref);
> +		gw_node_free_ref(gw_node);
>  }
>  
> -static struct gw_node *gw_select(struct bat_priv *bat_priv,
> -			  struct gw_node *new_gw_node)
> +static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
>  {
>  	struct gw_node *curr_gw_node = bat_priv->curr_gw;
>  
> -	if (new_gw_node)
> -		kref_get(&new_gw_node->refcount);
> +	if (new_gw_node && !atomic_inc_not_zero(&new_gw_node->refcount))
> +		new_gw_node = NULL;
>  
>  	bat_priv->curr_gw = new_gw_node;
> -	return curr_gw_node;
> +
> +	if (curr_gw_node)
> +		gw_node_free_ref(curr_gw_node);
>  }
>  
>  void gw_election(struct bat_priv *bat_priv)
>  {
>  	struct hlist_node *node;
> -	struct gw_node *gw_node, *curr_gw_tmp = NULL, *old_gw_node = NULL;
> +	struct gw_node *gw_node, *curr_gw_tmp = NULL;
>  	uint8_t max_tq = 0;
>  	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
>  	int down, up;
> @@ -174,14 +173,10 @@ void gw_election(struct bat_priv *bat_priv)
>  				curr_gw_tmp->orig_node->gw_flags,
>  				curr_gw_tmp->orig_node->router->tq_avg);
>  
> -		old_gw_node = gw_select(bat_priv, curr_gw_tmp);
> +		gw_select(bat_priv, curr_gw_tmp);
>  	}
>  
>  	rcu_read_unlock();
> -
> -	/* the kfree() has to be outside of the rcu lock */
> -	if (old_gw_node)
> -		kref_put(&old_gw_node->refcount, gw_node_free_ref);
>  }
>  
>  void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
> @@ -242,7 +237,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
>  	memset(gw_node, 0, sizeof(struct gw_node));
>  	INIT_HLIST_NODE(&gw_node->list);
>  	gw_node->orig_node = orig_node;
> -	kref_init(&gw_node->refcount);
> +	atomic_set(&gw_node->refcount, 1);
>  
>  	spin_lock_bh(&bat_priv->gw_list_lock);
>  	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
> @@ -325,7 +320,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
>  			gw_deselect(bat_priv);
>  
>  		hlist_del_rcu(&gw_node->list);
> -		call_rcu(&gw_node->rcu, gw_node_free_rcu);
> +		gw_node_free_ref(gw_node);
>  	}
>  
>  
> diff --git a/batman-adv/types.h b/batman-adv/types.h
> index e4a0462..ca5f20a 100644
> --- a/batman-adv/types.h
> +++ b/batman-adv/types.h
> @@ -100,7 +100,7 @@ struct gw_node {
>  	struct hlist_node list;
>  	struct orig_node *orig_node;
>  	unsigned long deleted;
> -	struct kref refcount;
> +	atomic_t refcount;
>  	struct rcu_head rcu;
>  };
>  
> -- 
> 1.7.2.3
> 
