Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 1 Jan 2010 17:38:41 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100101163841.GB16855@pandem0nium>
References: <20091231170753.GA27707@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20091231170753.GA27707@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Coccinelle tests?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Andrew,

thanks for forwarding! I've commited a patch, revision 1527, which should
fix these things. See some comments inline below.

best regards,
	Simon


On Thu, Dec 31, 2009 at 06:07:53PM +0100, Andrew Lunn wrote:
> ***dev->dev_addr is a pointer.  The size of an address is probably 6.  dev
> has an addr_len field that might be initialized.

fixed in r1527.

> *** Use kzalloc instead of kmalloc + memset.  Also consider testing the r=
esult
> of the kmaloc for NULL.

kzalloc is a good suggestion, done in r1527.
kmalloc checking should be fixed in r1520, r1521, r1524.

> *** As far as I can tell, in the following, the if after the out label is=
 not
> needed.

correct, this was already fixed in r1493.
=20
> *** the result of kmalloc should be tested for NULL

correct, but not needed anymore as we have changed to static initialization=
 in=20
r1499.

> diff -u -p /var/linuxes/linux-next/drivers/staging/batman-adv/translation=
-table.c /tmp/nothing
> --- /var/linuxes/linux-next/drivers/staging/batman-adv/translation-table.=
c	2009-12-19 09:38:58.000000000 +0100
> @@ -322,7 +322,6 @@ void hna_global_add_orig(struct orig_nod
>  	if (orig_node->hna_buff_len > 0) {
>  		orig_node->hna_buff =3D kmalloc(orig_node->hna_buff_len,
>  					      GFP_ATOMIC);
> -		memcpy(orig_node->hna_buff, hna_buff, orig_node->hna_buff_len);
>  	} else {
>  		orig_node->hna_buff =3D NULL;
>  	}
this one again: kmalloc checking should be fixed in r1520, r1521, r1524.

>=20
> returns.cocci
>=20
> *** Perhaps there is no point to put a return by itself at the end of a
> function.

okay, done in r1527.
>=20
> diff -u -p a/routing.c b/routing.c
> --- a/routing.c 2009-12-19 09:38:58.000000000 +0100
> +++ b/routing.c 2009-12-31 14:59:41.000000000 +0100
> @@ -627,7 +626,6 @@ static void recv_my_icmp_packet(struct e
>  	}
> =20
>  	spin_unlock(&orig_hash_lock);
> -	return;
>  }

I did not find this return (probably due to the skb restructuring),
but all the other useless returns; should be gone now (r1527).

> =20
>  static void recv_icmp_ttl_exceeded(struct icmp_packet *icmp_packet,
>=20
> txok.cocci
>=20
> *** I saw in some patch that functions store in the field .ndo_start_xmit
> ought to return NETDEV_TX_OK rather than 0.  I haven't submitted any patc=
hes
> of my own for this situation, so I don't know for sure what the rule is.
>=20

OK, most drivers seem to do this, so we'll do the same (r1527)

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks+JREACgkQrzg/fFk7axZg5gCePxu/ay73hDVeNcDn1lESjNZS
QTYAoMo70Bq7tPYxADzzhiokFleMWgHo
=pMfG
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
