Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 14:23:41 +0800
References: <1369340122-2660-1-git-send-email-ordex@autistici.org>
 <1369340122-2660-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1369340122-2660-7-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305241423.42027.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 6/7] batman-adv: add per VLAN interface
	attribute framework
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

On Friday, May 24, 2013 04:15:21 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Since batman-adv is now fully VLAN-aware, a proper framework
> able to handle per-vlan-interface attributes is now needed.

We have "now" twice in the same sentence. :)


> diff --git a/compat.c b/compat.c
> index da556a4..b99d505 100644
> --- a/compat.c
> +++ b/compat.c
> @@ -27,6 +27,15 @@
> 
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
> 
> +void batadv_free_rcu_priv_vlan(struct rcu_head *rcu)
> +{
> +	struct batadv_priv_vlan *vlan;
> +
> +	vlan = container_of(rcu, struct batadv_priv_vlan, rcu);
> +
> +	kfree(vlan);
> +}

I bet you didn't try to compile that on an older kernel ...


> +/**
> + * batadv_get_priv_vlan - get VLAN priv data

The naming could be better. Following your initial scheme this function should 
be called "batadv_priv_vlan_get". How about replacing "priv" with "softif" ? 
We'd end up with: 
 * batadv_softif_vlan_free_ref()
 * batadv_softif_vlan_get()


> +/**
> + * batadv_add_vid - ndo_add_vid API implementation

Again, the naming .. didn't we introduce a naming convention for each file ? 
soft-interface.c uses "interface" a lot. Why not using it ? For example,
batadv_interface_vid_add() ?


> + * @dev: the netdev of the mesh interface
> + * @vid: identifier of the new VLAN
> + *
> + * Set up all the internal structures for handling the new VLAN on top of 
the
> + * mesh interface
> + */

Returns ?


> +/**
> + * batadv_kill_vid - ndo_kill_vid API implementation

Same here. It should be batadv_interface_vid_kill() or something similar.


> + * @dev: the netdev of the mesh interface
> + * @vid: identifier of the deleted VLAN
> + *
> + * Destroy all the internal structures used to handle the VLAN identified
> by vid + * on top of the mesh interface
> + */

Returns ?


> +static int batadv_kill_vid(struct net_device *dev, unsigned short vid)
> +{
> +	struct batadv_priv *bat_priv = netdev_priv(dev);
> +	struct batadv_priv_vlan *vlan, *vlan_tmp = NULL;
> +
> +	list_for_each_entry_rcu(vlan, &bat_priv->priv_vlan_list, list) {
> +		if (vlan->vid != vid)
> +			continue;
> +		vlan_tmp = vlan;
> +		break;
> +	}

How about re-using your get() function from above ?


> +/*
> + * struct batadv_priv_vlan - per VLAN attributes set
> + * @vid: VLAN identifier
> + * @kobj: kobject for sysfs vlan subdirectory
> + * @list: list node for bat_priv::priv_vlan_list
> + * @refcount: number of context where this object is currently in use
> + * @rcu: struct used for freeing in a RCU-safe manner
> + */
> +struct batadv_priv_vlan {
> +	unsigned short vid;
> +	struct kobject *kobj;
> +	struct list_head list;
> +	atomic_t refcount;
> +	struct rcu_head rcu;
> +};

I am not so happy about the choice regarding the name again. The "batadv_priv" 
prefix has been introduced for bat_priv sub structs. Clearly, this isn't one 
but an element for a list. 


>  /**
>   * struct batadv_priv - per mesh interface data
>   * @mesh_state: current status of the mesh (inactive/active/deactivating)
> @@ -573,6 +589,9 @@ struct batadv_priv_nc {
>   * @primary_if: one of the hard interfaces assigned to this mesh interface
>   *  becomes the primary interface
>   * @bat_algo_ops: routing algorithm used by this mesh interface
> + * @priv_vlan_list: a list of priv_vlan structs, one per VLAN created on
> top of + *  the mesh interface represented by this object
> + * @priv_vlan_list_lock: lock protecting priv_vlan_list
>   * @bla: bridge loope avoidance data
>   * @debug_log: holding debug logging relevant data
>   * @gw: gateway data
> @@ -620,6 +639,8 @@ struct batadv_priv {
>  	struct work_struct cleanup_work;
>  	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
>  	struct batadv_algo_ops *bat_algo_ops;
> +	struct list_head priv_vlan_list;
> +	spinlock_t priv_vlan_list_lock; /* protects priv_vlan_list */
>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	struct batadv_priv_bla bla;
>  #endif

This leads to weird code like: bat_priv->priv_vlan_list_lock (priv twice) ..

Cheers,
Marek

