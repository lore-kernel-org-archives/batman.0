Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 28 Sep 2010 23:23:03 +0200
References: <201009262057.36382.lindner_marek@yahoo.de>
	<1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20417101.LOAAkMJGBs";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009282323.07115.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: softif lan loop avoidance
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart20417101.LOAAkMJGBs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> +static void softif_neigh_hold(struct softif_neigh *softif_neigh)
> +{
> +       if (!softif_neigh)
> +               return;
> +
> +       atomic_inc(&softif_neigh->refcnt);
> +}
> +
> +static void softif_neigh_put(struct softif_neigh *softif_neigh)
> +{
> +       if (!softif_neigh)
> +               return;
> +
> +       if (atomic_dec_and_test(&softif_neigh->refcnt))
> +               kfree(softif_neigh);
> +}

Do you want to change the other _hold and _put functions to make it consist=
ent=20
in batman-adv regarding the NULL pointer checks?

> +void softif_neigh_purge(struct bat_priv *bat_priv)
> +{
> +	struct softif_neigh *softif_neigh;
> +	struct hlist_node *node, *node_tmp;
> +
> +	hlist_for_each_entry_safe(softif_neigh, node, node_tmp,
> +				  &bat_priv->softif_neigh_list, list) {
> +
> +		if (!time_after(jiffies, softif_neigh->last_seen +
> +				msecs_to_jiffies(SOFTIF_NEIGH_TIMEOUT)))
> +			continue;
> +
> +		spin_lock(&bat_priv->softif_neigh_lock);
> +		hlist_del_rcu(&softif_neigh->list);
> +		spin_unlock(&bat_priv->softif_neigh_lock);
> +
> +		if (bat_priv->softif_neigh =3D=3D softif_neigh) {
> +			bat_priv->softif_neigh =3D NULL;
> +			bat_dbg(DBG_ROUTES, bat_priv,
> +				 "Current mesh exit point '%pM' vanished "
> +				 "(vid: %d).\n",
> +				 softif_neigh->addr, softif_neigh->vid);
> +			softif_neigh_put(bat_priv->softif_neigh);
> +		}
> +
> +		synchronize_rcu();
> +		softif_neigh_put(softif_neigh);
> +	}

You must protect the whole loop and not only the hlist_del_rcu with the=20
bat_priv->softif_neigh_lock, And it must be with spin_lock_irqsave because =
you=20
use it in context were irq is disabled and in some with enabled irq=20
contexts... or am I wrong?

> +void softif_batman_recv(struct sk_buff *skb, struct net_device *dev, sho=
rt
> vid) +{
> +	struct bat_priv *bat_priv =3D netdev_priv(dev);
> +	struct ethhdr *ethhdr =3D (struct ethhdr *)skb->data;
> +	struct batman_packet *batman_packet;
> +	struct softif_neigh *softif_neigh;
> +
> +	if (ntohs(ethhdr->h_proto) =3D=3D ETH_P_8021Q)
> +		batman_packet =3D (struct batman_packet *)
> +					(skb->data + ETH_HLEN + VLAN_HLEN);
> +	else
> +		batman_packet =3D (struct batman_packet *)(skb->data + ETH_HLEN);
> +
> +	if (batman_packet->version !=3D COMPAT_VERSION)
> +		goto err;
> +
> +	if (batman_packet->packet_type !=3D BAT_PACKET)
> +		goto err;
> +
> +	if (!(batman_packet->flags & PRIMARIES_FIRST_HOP))
> +		goto err;
> +
> +	if (is_my_mac(batman_packet->orig))
> +		goto err;
> +
> +	softif_neigh =3D softif_neigh_get(bat_priv, batman_packet->orig, vid);
> +
> +	if (!softif_neigh)
> +		goto err;
> +
> +	if (bat_priv->softif_neigh =3D=3D softif_neigh)
> +		goto out;
> +
> +	/* we got a neighbor but its mac is 'bigger' than ours  */
> +	if (memcmp(bat_priv->primary_if->net_dev->dev_addr,
> +		   softif_neigh->addr, ETH_ALEN) < 0)
> +		goto out;
> +
> +	/* switch to new 'smallest neighbor' */
> +	if ((bat_priv->softif_neigh) &&
> +	    (memcmp(softif_neigh->addr, bat_priv->softif_neigh->addr,
> +							ETH_ALEN) < 0)) {
> +		bat_dbg(DBG_ROUTES, bat_priv,
> +			"Changing mesh exit point from %pM (vid: %d) "
> +			"to %pM (vid: %d).\n",
> +			 bat_priv->softif_neigh->addr,
> +			 bat_priv->softif_neigh->vid,
> +			 softif_neigh->addr, softif_neigh->vid);
> +		softif_neigh_put(bat_priv->softif_neigh);
> +		bat_priv->softif_neigh =3D softif_neigh;
> +		/* we need to hold the additional reference */
> +		goto err;
> +	}
> +
> +	/* close own batX device and use softif_neigh as exit node */
> +	if ((!bat_priv->softif_neigh) &&
> +	    (memcmp(softif_neigh->addr,
> +		    bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN) < 0)) {
> +		bat_dbg(DBG_ROUTES, bat_priv,
> +			"Setting mesh exit point to %pM (vid: %d).\n",
> +			softif_neigh->addr, softif_neigh->vid);
> +		bat_priv->softif_neigh =3D softif_neigh;
> +		/* we need to hold the additional reference */
> +		goto err;
> +	}
> +
> +out:
> +	softif_neigh_put(softif_neigh);
> +err:
> +	kfree_skb(skb);
> +	return;
> +}

Can you mark that function as static?

Best regards,
	Sven

--nextPart20417101.LOAAkMJGBs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMoly5AAoJEF2HCgfBJntGs0QP/AhQe5b68ij/7IkYaOccwdxk
Ydp4Tz5jfw0OKkPUxueDhCQHCyWfeviBsPd2+LIK3erwuMGw2EJPK5X4RmVZ1br0
rRXydHCWOy1LBBvyK2MLddFJCXz8v0HwSRUPTlj8Aj7oBqYzwRe8OgIVQjxBMnhS
zg4nzgnrIibLFOa5VbykdGdTG5Wy1ibjD4GCtkB8mRpoGe/VqL5o5Hv3Y/ovwOkE
2QprBqnAYHGItM7SoYQy/iBeqqLGhSpUXqvL8Qzzoa6Ayv+9DciuEu/SXjzG1+7y
ziVmbhU/ovjB/KWEIGkeEtEOzBJ49QiFUx43jAoJTcMQAGS9XIk+D39FkECaBYQq
1XrL+xVuk+SlECLPichQJfR3JiNtkJHr9b/nDoIHN8jBj3yU5M6lCEyKwBtcMqFk
z5XenpAWcwfdYDGZ9iSaWEY7RDrHGKy4Heklyaord08rE6QtnzZdJaugeG/vzXcR
9FNjRfqSvu/JLt4bEmwRhcBP12Ot2/r/rxcXah0YicLAPBDzB4MwvsW/tUkxdQHr
uKBIIW+CR7YRgUsROkqw8gHtsFBojwSSj0ZjcnIYvpmnW7hHwszLqTdKqgUijyMZ
2MZByOal0sR0abVWzLZJaHldCj5VXNpwZq0WOwrthUD0iDeNaEc/VRtsYzGLedAJ
enG4h7NOgChuoLxkZl1v
=8P0O
-----END PGP SIGNATURE-----

--nextPart20417101.LOAAkMJGBs--
