Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 23 Dec 2009 11:20:06 +0100
References: <20091222231726.GA23462@pandem0nium>
In-Reply-To: <20091222231726.GA23462@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1857022.2qjzcNrG38";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200912231120.10199.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: receive packets directly
	using skbs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1857022.2qjzcNrG38
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Simon Wunderlich wrote:
> +/* receive a packet with the batman ethertype coming on a hard
> + * interface */
> +int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
> +	struct packet_type *ptype, struct net_device *orig_dev)
> +{
> +	struct batman_packet *batman_packet;
> +	struct batman_if *batman_if;
> +	struct net_device_stats *stats;
> +	int ret;
> +
> +    skb =3D skb_share_check(skb, GFP_ATOMIC);
> +
> +    if (skb =3D=3D NULL)
> +		goto err_free;
> +
> +	/* packet should hold at least type and version */
> +	if (unlikely(skb->len < 2))
> +		goto err_free;

Len field includes the length of the data in the main socket buffer and=20
possible fragments attached to the main socket buffer. This length is chang=
ed=20
when you move from layer to layer. So it is ok to test for 2 here to check =
if=20
it is enough data for version and type.

> +
> +	batman_if =3D find_batman_if(skb->dev);
> +	if (!batman_if)
> +		goto err_free;
> +
> +    stats =3D &skb->dev->stats;
> +    stats->rx_packets++;
> +    stats->rx_bytes +=3D skb->len;
> +
> +
> +	/* push back, we want to look at the ethernet header as well. */
> +	skb_push(skb, sizeof(struct ethhdr));
> +	skb_reset_mac_header(skb);
> +
> +	batman_packet =3D (struct batman_packet *)(skb->data
> +					+ sizeof(struct ethhdr));
> +
> +	if (batman_packet->version !=3D COMPAT_VERSION) {
> +		bat_dbg(DBG_BATMAN,
> +			"Drop packet: incompatible batman version (%i)\n",
> +			batman_packet->version);
> +		goto err_free;
> +	}
Here you try to to access data which may be fragmented over different buffe=
rs.=20
This could for example happen if we send our data over a layer which fragme=
nts=20
it.

In the "normal" scenario of sending it directly over ethernet this shouldn'=
t=20
happen, but that doesn't mean that nobody wants to do something "special".

There are different other positions like recv_bat_packet where this is=20
ignored.

Maybe someone knows why this could never happen, but everything I have read=
=20
was more like "you have to deal with it".

> -static void recv_icmp_packet(struct ethhdr *ethhdr,
> -			     unsigned char *packet_buff,
> -			     int result,
> -			     struct batman_if *batman_if)
> +int recv_icmp_packet(struct sk_buff *skb)
>  {
>  	struct icmp_packet *icmp_packet;
> +	struct ethhdr *ethhdr;
>  	struct orig_node *orig_node;
> +	int hdr_size =3D sizeof(struct icmp_packet) + sizeof(struct ethhdr);
> +	int ret;
>=20
> +	/* drop packet if it has not necessary minimum size */
> +	if (skb->len < hdr_size)
> +		return NET_RX_DROP;
> +
> +	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
> +
>  	/* packet with unicast indication but broadcast recipient */
>  	if (is_bcast(ethhdr->h_dest))
> -		return;
> +		return NET_RX_DROP;
>=20
>  	/* packet with broadcast sender address */
>  	if (is_bcast(ethhdr->h_source))
> -		return;
> +		return NET_RX_DROP;
>=20
>  	/* not for me */
>  	if (!is_my_mac(ethhdr->h_dest))
> -		return;
> +		return NET_RX_DROP;
>=20
> -	/* drop packet if it has not necessary minimum size */
> -	if (result < sizeof(struct ethhdr) + sizeof(struct icmp_packet))
> -		return;
> -
>  	icmp_packet =3D (struct icmp_packet *)
> -		(packet_buff + sizeof(struct ethhdr));
> +			(skb->data + sizeof(struct ethhdr));
>=20
>  	/* packet for me */
>  	if (is_my_mac(icmp_packet->dst))
> -		recv_my_icmp_packet(ethhdr, icmp_packet, packet_buff, result);
> +		return recv_my_icmp_packet(skb);
>=20
>  	/* TTL exceeded */
>  	if (icmp_packet->ttl < 2) {
> -		recv_icmp_ttl_exceeded(icmp_packet, ethhdr, packet_buff, result,
> -				       batman_if);
> -		return;
> +		return recv_icmp_ttl_exceeded(skb);
>=20
>  	}
>=20
> +	ret =3D NET_RX_DROP;
> +
>  	/* get routing information */
>  	spin_lock(&orig_hash_lock);
>  	orig_node =3D ((struct orig_node *)
> @@ -725,49 +721,51 @@
>  		icmp_packet->ttl--;

You are modify the data inside the socket buffer (not the control structure=
=20
but the real data), but I cannot see where you created a private copy of it=
=2E=20
Data of cloned copies is not allowed to be changed. You must use (p)skb_cop=
y=20
(it clones the the data too and not only the sk_buff structure).

This is explained in "Understanding Linux Network Internals", "Christian=20
Benvenuti", "December 2005, O'Reilly", "2.1.5.5. Cloning and copying buffer=
s"


Best regards,
	Sven

--nextPart1857022.2qjzcNrG38
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLMe7XAAoJEF2HCgfBJntG21QQALEDroziLGcNkZdLSWD6/WRx
T1b21AbPRIiHxQVPU9ICF79WUudLSFbW2rQoTlOVcEbSdEbxzyOKKKQqwCc5XgwM
dVKzX81+2Xr3qnIxhV9buhplKl5gh84+ewsL/fnlht9ouN3RNZe9/NOpc74X5IAo
8YcvSdKcJo9i8HByAEHiD+srg/Bwi0HfgtcvrdDvMNrUP9xT/7CVEklnAZ6fgt7A
WYBW7G1UmnmyYsHzg1qfGgaWWJVSJn1gusthMZoz0FbG9rwPhIEAin2jBGLql0iQ
FWgMV8GpTxBMD0SEG9nfv2oo1WnB7QlPqxzfXQkrbdtZ3yyoX8YFtJC1JjqnVZXY
5J0jo7CXd0ejd4STPbbbpJYgZsqdH3Fc4HMn+KXJRNZFD43dNzEe9IrQ+WcmYVtI
bPIiKdlvQoTjU+vAuXQS+jwYTc8GvKi2I4LWQUaCAF6nR9APA3rYiLHHCixphF9W
I7znJ5O+fbkijKu11SDj3vzL0Wd5J/KUYupqLHxFS4YCGIL7KF8c9f/qjHfvtrxQ
N/onsDOXmSkE8Em5NTfaC1gobw7W/KKWS2MAjq47Jm8sD8aW6V0aZEpRtI5MyHcg
Oc8FkQSSsvv/ynVI6wDD20nAPaqxBPnE09/kIu5jPA5ksbyOzeCTKTI+kl0W5KKR
4cQrcH+Rfk6XPp9qbKS4
=KYMZ
-----END PGP SIGNATURE-----

--nextPart1857022.2qjzcNrG38--
