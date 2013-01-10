Return-Path: <ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Jan 2013 04:34:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
In-Reply-To: <1356910850-17542-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1356910850-17542-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Message-ID: <cbd56d4714a87d66c4f8a81af5fe1081@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: postpone sysfs removal when
 unregistering
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Hello Simon,

thanks a lot for taking care of this and sorry for my very late reply..


Il 31.12.2012 01:40 Simon Wunderlich ha scritto:
> diff --git a/hard-interface.c b/hard-interface.c
> index f1d37cd..eb3a12d 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -506,6 +506,17 @@ out:
>  	return NULL;
>  }
>
> +static void batadv_hardif_remove_interface_finish(struct work_struct 
> *work)
> +{
> +	struct batadv_hard_iface *hard_iface;
> +
> +	hard_iface = container_of(work, struct batadv_hard_iface,
> +				  cleanup_work);
> +
> +	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> +	batadv_hardif_free_ref(hard_iface);
> +}
> +
>  static void batadv_hardif_remove_interface(struct batadv_hard_iface
> *hard_iface)
>  {
>  	ASSERT_RTNL();
> @@ -518,8 +529,9 @@ static void batadv_hardif_remove_interface(struct
> batadv_hard_iface *hard_iface)
>  		return;
>
>  	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
> -	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> -	batadv_hardif_free_ref(hard_iface);
> +	INIT_WORK(&hard_iface->cleanup_work,
> +		  batadv_hardif_remove_interface_finish);
> +	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
>  }
>

why do we need to postpone the invocation of
batadv_hardif_remove_interface_finish() ? Is it also creating a 
possible
deadlock? As far as I understood only rtnl_lock() would create the 
problem, but it
is not invoked in batadv_hardif_remove_interface_finish(). It seems I 
am missing
something?

Other than this, remember that the INIT_WORK macro does not need to be 
invoked
each and every time you want to enqueue the work. It should be invoked 
once only
(A patch fixing this "issue" for all the delayed works we have in the 
code has
been recently applied). However it is not a real issue, but we want to 
keep the
code consistent :)

> +static void batadv_softif_destroy_finish(struct work_struct *work)
> +{
> +	struct batadv_priv *bat_priv;
> +	struct net_device *soft_iface;
> +
> +	bat_priv = container_of(work, struct batadv_priv,
> +				cleanup_work);
> +	soft_iface = bat_priv->soft_iface;
> +
> +	batadv_debugfs_del_meshif(soft_iface);
> +	batadv_sysfs_del_meshif(soft_iface);
> +
> +	rtnl_lock();
> +	unregister_netdevice(soft_iface);
> +	rtnl_unlock();
> +}
> +
>  void batadv_softif_destroy(struct net_device *soft_iface)
>  {
> -	batadv_debugfs_del_meshif(soft_iface);
> -	batadv_sysfs_del_meshif(soft_iface);
> +	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
> +
>  	batadv_mesh_free(soft_iface);
> -	unregister_netdevice(soft_iface);
> +
> +	INIT_WORK(&bat_priv->cleanup_work, batadv_softif_destroy_finish);
> +	queue_work(batadv_event_workqueue, &bat_priv->cleanup_work);
>  }
>

Same as above (Assuming we really need two scheduled tasks).

>  int batadv_softif_is_valid(const struct net_device *net_dev)
> diff --git a/types.h b/types.h
> index d8061ac..a9800ee 100644
> --- a/types.h
> +++ b/types.h
> @@ -63,6 +63,7 @@ struct batadv_hard_iface {
>  	struct net_device *soft_iface;
>  	struct rcu_head rcu;
>  	struct batadv_hard_iface_bat_iv bat_iv;
> +	struct work_struct cleanup_work;
>  };
>

kernel doc :)

>  /**
> @@ -266,6 +267,7 @@ struct batadv_priv_dat {
>
>  struct batadv_priv {
>  	atomic_t mesh_state;
> +	struct net_device *soft_iface;
>  	struct net_device_stats stats;
>  	uint64_t __percpu *bat_counters; /* Per cpu counters */
>  	atomic_t aggregated_ogms;	/* boolean */
> @@ -302,6 +304,7 @@ struct batadv_priv {
>  	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
>  	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
>  	struct delayed_work orig_work;
> +	struct work_struct cleanup_work;
>  	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected 
> pointer */
>  	struct batadv_algo_ops *bat_algo_ops;
>  #ifdef CONFIG_BATMAN_ADV_BLA

here too :)


Cheers,

-- 
Antonio Quartulli
