Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Apr 2011 10:02:43 +0200
References: <1302891416-31451-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1302891416-31451-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6550406.u4z63IOEfL";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104161002.44105.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: orig_hash_find() manages
	rcu_lock/unlock internally
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

--nextPart6550406.u4z63IOEfL
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> orig_hash_find() manages rcu_lock/unlock internally and doesn't need to
> be surrounded by rcu_read_lock() / rcu_read_unlock() anymore
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Valid point, but incorrect implementation


> ---
>  routing.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>=20
> diff --git a/routing.c b/routing.c
> index f6c6422..634a44d 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -1310,14 +1310,11 @@ int route_unicast_packet(struct sk_buff *skb,
> struct hard_iface *recv_if) }
>=20
>  	/* get routing information */
> -	rcu_read_lock();
>  	orig_node =3D orig_hash_find(bat_priv, unicast_packet->dest);
>=20
>  	if (!orig_node)
>  		goto unlock;
>=20
> -	rcu_read_unlock();
> -

You forgot to fix the rcu_read_unlock after the label unlock.

>  	/* find_router() increases neigh_nodes refcount if found. */
>  	neigh_node =3D find_router(bat_priv, orig_node, recv_if);
>=20
> @@ -1464,14 +1461,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct
> hard_iface *recv_if) if (bcast_packet->ttl < 2)
>  		goto out;
>=20
> -	rcu_read_lock();
>  	orig_node =3D orig_hash_find(bat_priv, bcast_packet->orig);
>=20
>  	if (!orig_node)
>  		goto rcu_unlock;
>=20
> -	rcu_read_unlock();
> -
>  	spin_lock_bh(&orig_node->bcast_seqno_lock);
>=20
>  	/* check whether the packet is a duplicate */

You forgot to fix the rcu_read_unlock after the label rcu_unlock.

Kind regards,
	Sven


--nextPart6550406.u4z63IOEfL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNqU0jAAoJEF2HCgfBJntGzqMQALriGOLons83lNoiA90uZUoL
UGoJczcBfD1lYeGw/q+UUq5hnTehv9hU0Jpdey09ujK7V8EyFmSJdj+Gyv725/kQ
dQt48v11NixS0nMeQwlPk6gWcgMpDVO80zX0zSKnOIPQltV9WUTEPBBpA4gSHEq9
1ksp96mg0V4SanmZ2ARRTDxVgs0UI6ZNyE8Brp7rWltL1K9Mrf+q+ttUQ1LTz1hJ
zqWOBRmXRSwGjs57ER6FnAUUbcV8EoKJH4wPBswOHSIqP1Be3yOy1JpuA5nqkw8f
xkTH6zqQOXg4w36s3zc2uftWukHFO0fKiB/haF94D1V2CFyAlqAunVYMGG5lGZtO
iOiWWbf9oWjBCUO2sE18/i3gjuNolC07fZoGR2CotgPYUlXU7lvuL6Xsvz1/CSOv
9dZpurSDvNEHKhH00UGPDpTnsZQrT40Dm7ScQ322iXrMvLcguqj5pMoiiTeUdnGf
idkSrIgd2TkG4XPLaGpN23GNi83kckjY34GvHB1RIKIj3TC+i6E/Kmk4bFJpBBO8
6c5rtNuhj9f4NEnelqq4TnOlTCzVBjPrnvTA6xlRpbfVZP8RtonWQC/MZxNJLgS9
gP/NG7HAebLQzBleEc20SRLOx2TldVrGxYadS1Zl8JvLGfmRyWQZUHzoHkSgek2K
TDqW1ym3tM5T3XQFQsNk
=jK1z
-----END PGP SIGNATURE-----

--nextPart6550406.u4z63IOEfL--
