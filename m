Return-Path: <sven.eckelmann@gmx.de>
Date: Mon, 5 Jul 2010 02:37:11 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100705003711.GB18699@sven-atom.lazhur.ath.cx>
References: <20100630205846.230b2112@rechenknecht>
	<1277924436-29528-2-git-send-email-an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1277924436-29528-2-git-send-email-an.langer@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
 fragmentation
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
Cc: b.a.t.m.a.n@lists.open-mesh.net


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 30, 2010 at 09:00:36PM +0200, Andreas Langer wrote:
> diff --git a/batman-adv/fragmentation.c b/batman-adv/fragmentation.c
> new file mode 100644
> index 0000000..f36ad0e
> --- /dev/null
> +++ b/batman-adv/fragmentation.c
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:\

Can you please explain why the copyright already starts in 2007?

> +	/* skb is alsways the first packet,tmp_skb always the second */

alsways -> always?

> +
> +	/* move free entry to end */
> +	tfp->skb =3D NULL;
> +	tfp->seqno =3D 0;
> +	list_move_tail(&tfp->list, head);
> +
> +	skb_pull(tmp_skb, sizeof(struct unicast_frag_packet));
> +	pskb_expand_head(skb, 0, tmp_skb->len, GFP_ATOMIC);

pskb_expand_head can fail (return !=3D 0). You cannot just write data in not
allocated memory.

> +	memcpy(skb_put(skb, tmp_skb->len), tmp_skb->data, tmp_skb->len);
> +	kfree_skb(tmp_skb);
> +	return skb;
> +}
> +


> diff --git a/batman-adv/fragmentation.h b/batman-adv/fragmentation.h
> new file mode 100644
> index 0000000..d0acf73
> --- /dev/null
> +++ b/batman-adv/fragmentation.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:

Can you please explain why the copyright already starts in 2007?

> --- a/batman-adv/hard-interface.c
> +++ b/batman-adv/hard-interface.c
> @@ -166,16 +166,18 @@ int hardif_min_mtu(void)
>  	/* allow big frames if all devices are capable to do so
>  	 * (have MTU > 1500 + BAT_HEADER_LEN) */
>  	int min_mtu =3D ETH_DATA_LEN;
> +	/* FIXME: each batman_if will be attached to a softif */
> +	struct bat_priv *bat_priv =3D netdev_priv(soft_device);
> =20
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(batman_if, &if_list, list) {
>  		if ((batman_if->if_status =3D=3D IF_ACTIVE) ||
>  		    (batman_if->if_status =3D=3D IF_TO_BE_ACTIVATED))
> -			min_mtu =3D MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
> -				      min_mtu);
> +			min_mtu =3D atomic_read(&bat_priv->frag_enabled) ?
> +				ETH_DATA_LEN : MIN(batman_if->net_dev->mtu -
> +				BAT_HEADER_LEN, min_mtu);
>  	}
>  	rcu_read_unlock();

Why do you go through all devices if you already decided that the min_mtu is
ETH_DATA_LEN when bat_priv->frag_enabled !=3D 0. The atomic_read ? x : y st=
uff
doesn't make the last statement more readable.

> -
>  	return min_mtu;
>  }

Is there a good reason to remove the newline?
> =20
> @@ -265,8 +267,30 @@ int hardif_enable_interface(struct batman_if *batman=
_if)
>  	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
> =20
>  	atomic_set(&batman_if->seqno, 1);
> +	atomic_set(&batman_if->frag_seqno, 1);
>  	bat_info(soft_device, "Adding interface: %s\n", batman_if->dev);
> =20
> +	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
> +		ETH_DATA_LEN + BAT_HEADER_LEN)
> +		bat_info(soft_device,
> +			"The MTU of interface %s is too small (%i) to handle "
> +			"the transport of batman-adv packets. Packets going "
> +			"over this interface will be fragmented on layer2 "
> +			"which could impact the performance. Setting the MTU "
> +			"to %i would solve the problem.\n",
> +			batman_if->dev, ETH_DATA_LEN + BAT_HEADER_LEN,
> +			ETH_DATA_LEN + BAT_HEADER_LEN);
> +
> +	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
> +		ETH_DATA_LEN + BAT_HEADER_LEN)
> +		bat_info(soft_device,
> +			"The MTU of interface %s is too small (%i) to handle "
> +			"the transport of batman-adv packets. If you experience"
> +			" problems getting traffic through try increasing the "
> +			"MTU to %i.\n",
> +			batman_if->dev, ETH_DATA_LEN + BAT_HEADER_LEN,
> +			ETH_DATA_LEN + BAT_HEADER_LEN);
> +

BAT_HEADER_LEN has implicit the type size_t. So please adjust the 4 %i to %=
zi.

> diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
> index 0d89597..ccc97c6 100644
> --- a/batman-adv/soft-interface.c
> +++ b/batman-adv/soft-interface.c
> @@ -216,20 +220,72 @@ int interface_tx(struct sk_buff *skb, struct net_de=
vice *dev)
>  		if (batman_if->if_status !=3D IF_ACTIVE)
>  			goto dropped;
> =20
> -		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
> -			goto dropped;
> +		if (atomic_read(&bat_priv->frag_enabled) &&
> +		   data_len + sizeof(unicast_packet) >
> +		   batman_if->net_dev->mtu) {
> +
> +			hdr_len =3D sizeof(struct unicast_frag_packet);
> +
> +			frag_skb =3D dev_alloc_skb(data_len / 2 + hdr_len + 1);

Where does the "+ 1" come from? If it used to compensate uneven data_len, t=
hen
maybe the calculation should be changed to something like=20

data_len - (data_len / 2) + hdr_len

> +			skb_split(skb, frag_skb, data_len/2);
> +
> +			if (!(my_skb_push(frag_skb, hdr_len) >=3D 0 &&
> +				my_skb_push(skb, hdr_len) >=3D 0)) {

Didn't you wanted to check if one of the my_skb_push failed and not if both
failed?

> +
> +				kfree_skb(frag_skb);
> +				goto dropped;
> +			}
> +
> +			ucast_frag1 =3D (struct unicast_frag_packet *)skb->data;
> +			ucast_frag2 =3D
> +				(struct unicast_frag_packet *)frag_skb->data;
> +
> +			ucast_frag1->version =3D COMPAT_VERSION;
> +			ucast_frag1->packet_type =3D BAT_UNICAST_FRAG;
> +			ucast_frag1->ttl =3D TTL;
> +			memcpy(ucast_frag1->orig,
> +				batman_if->net_dev->dev_addr, ETH_ALEN);
> +			memcpy(ucast_frag1->dest, orig_node->orig, ETH_ALEN);
> +
> +			memcpy(ucast_frag2, ucast_frag1,
> +			       sizeof(struct unicast_frag_packet));
> +
> +			ucast_frag1->flags |=3D UNI_FRAG_HEAD;
> +			ucast_frag2->flags &=3D ~UNI_FRAG_HEAD;
> +
> +			/* no zero at seqno */
> +			if (atomic_read(&batman_if->frag_seqno) =3D=3D FRAG_MAX_SEQ)
> +				atomic_set(&batman_if->frag_seqno, 0);

It is not a good idea to split two atomic_ operations which depends on each=
 other.

Best regards,
	Sven

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMMSk2AAoJEF2HCgfBJntGEd4QAKWn26YlrCeMqVtl+ZJ19Nz/
3xzmE8a72P0ceSUziiMLZACerRpNl00eRu1aJHppJozwAq6hjKWpSIPvYdxK9kok
pAShTO4B46EikLAbKW9sfOkdBMoSjkPakz7sohCEaM2uLJVJzo3uajnYpdjz15da
7HSOJ0EIg+cjZwj+v2MlppwsHKybRYOSFG1oz5JiCj3kSfJHs0lJo9njnb58ckQG
0tkSKkZpCw/lvhXH8q6BfDL5jt5MfLAdHAB+ngnVDk0juk+U0PyqCC7rZYHYAS2r
vdTgKpKlqi38oMqc9nn3xe/+ELQSFlCSILDovcwJREBh7YpOEq9q4xUdUHHOjjRt
VqXwCOME0lYvZ7Ek9Cds1AHjlAoE/lnmWq/58nw+wjyvWNHfL9jyn/BFr7fD9eAw
wBSm2vxEYrBUcqwE3cCqHAvPMYfPCFy+AgndsUEE8ujuKWhhkI8TRu8FOGsFDIzm
kCzCPn0h6y4WRMP6JHAuhdbbOmK7P9UtCOtSodD4+qGyEvWyN98JLm/BwSeQ0WeV
ZvCs26GxHRzMAjbPaE53Oqgr6N6Yw/Vha+rmjiy+y9VUgbqIurz00asQCmWYEWCg
T3y5FkqZuN1VDgip3U64zOHz+V4j6hz0JHHkqA0QFI9fYNCk83NdYPn68Ody+vdB
bVmQivR0LBiQw7lqN2Wh
=+abc
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
