Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 20 Jun 2013 05:33:13 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306200533.13727.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: add per VLAN interface
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

On Thursday, June 13, 2013 02:04:19 Antonio Quartulli wrote:
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -643,6 +643,8 @@ static int batadv_hard_if_event(struct notifier_block
> *this,
> 
>  	if (batadv_softif_is_valid(net_dev) && event == NETDEV_REGISTER) {
>  		batadv_sysfs_add_meshif(net_dev);
> +		bat_priv = netdev_priv(net_dev);
> +		batadv_softif_create_vlan(bat_priv, BATADV_NO_FLAGS);
>  		return NOTIFY_DONE;
>  	}

When is this entry ever removed ? Did you try to rmmod the module with these 
patches enabled ?


> +       /* explicitly remove the associated TT local entry because it is 
marked
> +        * with the NOPURGE flag
> +        */
> +       batadv_tt_local_remove(bat_priv, dev->dev_addr, vid,
> +                              "vlan interface destroyed", false);

Curious. In batadv_interface_add_vid() you force the BATADV_VLAN_HAS_TAG tag 
onto each batadv_tt_local_add() call but on removal we don't have the flag 
set. Are you certain that is correct ?


> @@ -613,6 +632,8 @@ struct batadv_priv {
>  	struct work_struct cleanup_work;
>  	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
>  	struct batadv_algo_ops *bat_algo_ops;
> +	struct list_head softif_vlan_list;
> +	spinlock_t softif_vlan_list_lock; /* protects softif_vlan_list */
>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	struct batadv_priv_bla bla;
>  #endif

Why do we need a full blown list ? Isn't hlist sufficient ?

Cheers,
Marek
