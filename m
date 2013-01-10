Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 11 Jan 2013 01:16:27 +0800
References: <1357837761-30461-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1357837761-30461-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301110116.28005.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: postpone sysfs removal
	when unregistering
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

On Friday, January 11, 2013 01:09:21 Simon Wunderlich wrote:
> +static void batadv_hardif_remove_interface_finish(struct work_struct
> *work) +{
> +	struct batadv_hard_iface *hard_iface;
> +
> +	hard_iface = container_of(work, struct batadv_hard_iface,
> +				  cleanup_work);
> +
> +	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> +	batadv_hardif_free_ref(hard_iface);
> +}

Kernel doc ?


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

Kernel doc ?

The rest looks good.  :)

Cheers,
Marek
