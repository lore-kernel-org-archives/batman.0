Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 12:01:50 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201110150.GI24115@ritirata.org>
References: <cover.1354287613.git.martin@hundeboll.net>
 <2a90563738c699d122040dde59841e4eb7750f0b.1354287613.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <2a90563738c699d122040dde59841e4eb7750f0b.1354287613.git.martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Save overheard and tx
 packets for decoding.
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Fri, Nov 30, 2012 at 04:08:34PM +0100, Martin Hundeb=C3=B8ll wrote:
> @@ -47,8 +48,9 @@ static void batadv_nc_start_timer(struct batadv_priv *b=
at_priv)
>  int batadv_nc_init(struct batadv_priv *bat_priv)
>  {
>  	bat_priv->nc.timestamp_fwd_flush =3D jiffies;
> +	bat_priv->nc.timestamp_sniffed_purge =3D jiffies;
> =20
> -	if (bat_priv->nc.coding_hash)
> +	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
>  		return 0;
> =20
>  	bat_priv->nc.coding_hash =3D batadv_hash_new(128);
> @@ -58,6 +60,13 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
>  	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
>  				   &batadv_nc_coding_hash_lock_class_key);
> =20
> +	bat_priv->nc.decoding_hash =3D batadv_hash_new(128);
> +	if (!bat_priv->nc.decoding_hash)
> +		goto err;

the label err brings the flow to a lonely "return -ENOMEM". However if you =
it
the case above it means that you already allocated "bat_priv->nc.coding_has=
h"
successfully. May you need another label so that you can free "coding_hash"
and avoid memory leak?

[...]

> =20
>  /**
> + * batadv_nc_sniffed_purge - Checks whether the given sniffed (overheard=
) nc
> + *  packet has hit its buffering timeout. If so, the packet is no longer=
 kept
> + *  and the entry deleted from the queue. Has to be called with the appr=
opriate
> + *  locks.

Same as the previous patches..Move the core of the description below please.

> + * @bat_priv: the bat priv with all the soft interface information
> + * @nc_path: the nc path the packet belongs to
> + * @nc_packet: the nc packet to be checked
> + *
> + * Returns false as soon as the entry in the fifo queue has not been tim=
ed out
> + * yet and true otherwise.
> + */
> +static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
> +				    struct batadv_nc_path *nc_path,
> +				    struct batadv_nc_packet *nc_packet)
> +{
> +	unsigned long timeout =3D bat_priv->nc.max_buffer_time;
> +	bool res =3D false;
> +
> +	/* Packets are added to tail, so the remaining packets did not time
> +	 * out and we can stop processing the current queue
> +	 */

This is very nice :)

> +	if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_ACTIVE &&
> +	    !batadv_has_timed_out(nc_packet->timestamp, timeout))
> +		goto out;
> +
> +	/* purge nc packet */
> +	list_del(&nc_packet->list);
> +	batadv_nc_packet_free(nc_packet);
> +
> +	res =3D true;
> +
> +out:
> +	return res;
> +}
> +

[...]

> diff --git a/routing.c b/routing.c
> index d7bd4d1..59e1894 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -1053,8 +1053,14 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
>  	if (is4addr)
>  		hdr_size =3D sizeof(*unicast_4addr_packet);
> =20
> -	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
> +	if (batadv_check_unicast_packet(skb, hdr_size) < 0) {
> +		/* Even though the packet is to be dropped, we might save
> +		 * it to use for decoding a later received coded packet
> +		 */

Even if the packet is not well shaped? In the end this packet should not be
forwarded by anybody so maybe we should prevent this kind of packet to be
enqueued for coding on the sender side?


> +		batadv_nc_skb_store_sniffed_unicast(bat_priv, skb);
> +
>  		return NET_RX_DROP;
> +	}
> =20


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQueOeAAoJEADl0hg6qKeOW4YP/j7YYwoVvNBeIKtthnnKgk1E
WqM1op0Z46gRPoFej/CzdV9qXxwwc5TGeupalwhJ0tiSmwHS6fL2C5W/RuW3OAap
pZpbisB4+NatLQs5Si6qVxfZk4fmFQIhhAA/tW7cKkbw220VLp2E+/OsfX6JoVR4
6IWEMtZisWWtopB9ZRX0BIHJjAlyqeMUBU2LTfmqNIHupDf6xeo2lm6ZPbS6D+IZ
if/YOzTRuvoAZY2z5HqrgX9jJ159FVjZQJkuU3LrmemfkxGFX00nrIFh5vYhm3FV
0nhe4V4ZlzAVHC0X7ByULxFRJGM5T1lI4piD7Q58Po9q4I63fONY1GUOwW8ukOXU
srHvsGHA7Z5+QlSs/CMREyjzThFDv3FfGton3/zlZhPacBzLk4vi5iS+uneW4qDk
OP7Whj4ny51JmSt6lDZzINVq/t3ENkIfXf3qTunh2Ux7xRxz/7BKaryODR1bU9wR
1+6/S7hK9xT/henQExaZemqAmWO2XbEWkjkXtLgmbTWQs5pqQqKQGKXOzRVbcmMA
ObLTL1gbHlSGZm5Q+0spDwbsJFeqxaCNUugy2cZLLbftGrqz8JF8Oi/DuCVHRfQy
kIMnzPmXcJwOzl1BZ5Gv3VagcKDV7I5xJ5ndw2uUjjDBKor+mzPxewIIUoMYchZN
awVeAVJn60KSBeG+mthF
=WGHU
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
