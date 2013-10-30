Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 31 Oct 2013 00:33:40 +0800
Message-ID: <3955829.tFnjpO9dDf@diderot>
In-Reply-To: <1383141713-15820-3-git-send-email-sw@simonwunderlich.de>
References: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
 <1383141713-15820-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10643591.tCSQcNY1QT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/8] batman-adv: split tq information
	in neigh_node struct
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


--nextPart10643591.tCSQcNY1QT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 30 October 2013 15:01:47 Simon Wunderlich wrote:
> @@ -1559,7 +1661,12 @@ static void batadv_iv_ogm_orig_print(struct
> batadv_priv *bat_priv, if (!neigh_node)
>  				continue;
> 
> -			if (neigh_node->bat_iv.tq_avg == 0)
> +			n_ifinfo = batadv_neigh_ifinfo_get(neigh_node,
> +							   BATADV_IF_DEFAULT);
> +			if (!n_ifinfo)
> +				goto next;
> +
> +			if (n_ifinfo->bat_iv.tq_avg == 0)
>  				goto next;
> 
>  			last_seen_jiffies = jiffies - orig_node->last_seen;
> @@ -1569,17 +1676,12 @@ static void batadv_iv_ogm_orig_print(struct
> batadv_priv *bat_priv,
> 
>  			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
>  				   orig_node->orig, last_seen_secs,
> -				   last_seen_msecs, neigh_node->bat_iv.tq_avg,
> +				   last_seen_msecs, n_ifinfo->bat_iv.tq_avg,
>  				   neigh_node->addr,
>  				   neigh_node->if_incoming->net_dev->name);
> 
> -			hlist_for_each_entry_rcu(neigh_node_tmp,
> -						 &orig_node->neigh_list, list) {
> -				seq_printf(seq, " %pM (%3i)",
> -					   neigh_node_tmp->addr,
> -					   neigh_node_tmp->bat_iv.tq_avg);
> -			}
> -
> +			batadv_iv_ogm_orig_print_neigh(orig_node,
> +						       BATADV_IF_DEFAULT, seq);
>  			seq_puts(seq, "\n");
>  			batman_count++;

Aren't we missing a free_ref(n_ifinfo) here ?


> +/**
> + * batadv_neigh_node_free_ref - decrement the neighbors refcounter
> + * and possibly free it
> + * neigh_node: neigh neighbor to free
> + */
>  void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
>  {
>  	if (atomic_dec_and_test(&neigh_node->refcount))
> -		kfree_rcu(neigh_node, rcu);
> +		call_rcu(&neigh_node->rcu, batadv_neigh_node_free_rcu);
>  }

Isn't there some compat code you can remove as well ?

Cheers,
Marek

--nextPart10643591.tCSQcNY1QT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJScTToAAoJEFNVTo/uthzA25cH/2jd7n726/8LH3KFJYeyFzh+
nUWW5KaTtZplqMJHvFzsSGmDnuRc+pGe+peOyi8hW3EkGxO2SKGz1pXgDAsvD+R7
mdyzkPdjYILIeGvxBajnTTl/vh4ZFs6AT2pnXDiEQabz0stzH1tvXCvZJcXSO6c9
uT//Piq5yE23Yy+n59GNfSuwDSK0Gtxlly6c8ApNwkLeWtLwgc8jIZjHUqvXMgTm
rQsMdA5v5Frnec4VqdrapLdF+YwQ/qQ506oOYAcFb4ccdoAOsSqgKVOT+ICc8+zc
i1oMAi2o7GmjHXoILieZ0WDj0MS9JmzHRBwjcJg9ykUtbmzuETyQzeD70G+jQNc=
=RIUt
-----END PGP SIGNATURE-----

--nextPart10643591.tCSQcNY1QT--

