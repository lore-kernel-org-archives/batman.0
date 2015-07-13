Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 14 Jul 2015 00:05:22 +0800
Message-ID: <3846505.HTcyTpK9ms@voltaire>
In-Reply-To: <1435317085-31015-1-git-send-email-sw@simonwunderlich.de>
References: <1435317085-31015-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2600136.nRvFsmIkOM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: remove obsolete deleted
	attribute for gateway node
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart2600136.nRvFsmIkOM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 26, 2015 13:11:25 Simon Wunderlich wrote:
> @@ -537,14 +530,26 @@ void batadv_gw_node_update(struct batadv_priv
> *bat_priv, /* Note: We don't need a NULL check here, since curr_gw never
>  		 * gets dereferenced.
>  		 */
> +		spin_lock_bh(&bat_priv->gw.list_lock);
> +		hlist_for_each_entry_safe(gw_node_tmp, node_tmp,
> +					  &bat_priv->gw.list, list) {
> +			if (gw_node_tmp != gw_node)
> +				continue;
> +
> +			hlist_del_rcu(&gw_node->list);
> +			batadv_gw_node_free_ref(gw_node);
> +		}
> +		spin_unlock_bh(&bat_priv->gw.list_lock);

An entire hlist_for_each_entry_safe() loop isn't necessary. 
hlist_del_init_rcu() should suffice.


>  		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
>  		if (gw_node == curr_gw)
>  			batadv_gw_reselect(bat_priv);
> +
> +		if (curr_gw)
> +			batadv_gw_node_free_ref(curr_gw);
>  	}
> 
>  out:
> -	if (curr_gw)
> -		batadv_gw_node_free_ref(curr_gw);
>  	if (gw_node)
>  		batadv_gw_node_free_ref(gw_node);
>  }

After the batadv_gw_node_free_ref() 'bat_priv->gw.curr_gw' points to random 
memory ...



> @@ -562,37 +567,21 @@ void batadv_gw_node_delete(struct batadv_priv
> *bat_priv,
> 
>  void batadv_gw_node_purge(struct batadv_priv *bat_priv)
>  {
> -	struct batadv_gw_node *gw_node, *curr_gw;
> +	struct batadv_gw_node *gw_node;
>  	struct hlist_node *node_tmp;
> -	unsigned long timeout = msecs_to_jiffies(2 * BATADV_PURGE_TIMEOUT);
> -	int do_reselect = 0;
> 
> -	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
> +	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE)
> +		return;

Why checking for BATADV_MESH_ACTIVE if the function only ever gets called from 
batadv_mesh_free() which sets BATADV_MESH_DEACTIVATING ?

If you change the meaning of the function you could also rename it to 
batadv_gw_node_free() to be consistent with the other cleanup functions we 
have.



>  	spin_lock_bh(&bat_priv->gw.list_lock);
> -
>  	hlist_for_each_entry_safe(gw_node, node_tmp,
>  				  &bat_priv->gw.list, list) {
> -		if (((!gw_node->deleted) ||
> -		     (time_before(jiffies, gw_node->deleted + timeout))) &&
> -		    atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE)
> -			continue;
> -
> -		if (curr_gw == gw_node)
> -			do_reselect = 1;
> 
>  		hlist_del_rcu(&gw_node->list);
>  		batadv_gw_node_free_ref(gw_node);
>  	}
> 
>  	spin_unlock_bh(&bat_priv->gw.list_lock);
> -
> -	/* gw_reselect() needs to acquire the gw_list_lock */
> -	if (do_reselect)
> -		batadv_gw_reselect(bat_priv);
> -
> -	if (curr_gw)
> -		batadv_gw_node_free_ref(curr_gw);
>  }

At this point 'bat_priv->gw.curr_gw' points to random memory if I am not 
mistaken.

Cheers,
Marek

--nextPart2600136.nRvFsmIkOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVo+HDAAoJEFNVTo/uthzAkiQIALXZoXGnZB89LcszwOFOL2+b
c84lLurf0Q1ZcOIYCSs+4dPw0heRY3yfhAree0PyGHuhuCBoeYFcxWMs+jqSzAL6
4K3XiEq1mYp8StS0+D14uCMDbktPzgDknaaxjua4BbiwdDNJ2FaU/MRnOn4EbhCR
9Afa6ktm6EhWB+YoPM03+RoUoykCXNg0zEfG34VaZOFux+4Tf6QNhXjfgGb9FZZf
dcNqDlI3WjVz/qP0XtOt7FIIrTbcBDWygumr/4pBFUlwa8lhdLMZ3eBvnRpPO7nB
+JOjUNhJAE8KKS1ZNytQLNA8hrXch3zUb56Qu8yM/kKo8OqoLg7y52MqC7cqB3k=
=UMKG
-----END PGP SIGNATURE-----

--nextPart2600136.nRvFsmIkOM--

