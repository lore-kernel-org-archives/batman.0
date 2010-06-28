Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 28 Jun 2010 14:30:31 +0200
References: <20100627172416.62e7554d@rechenknecht>
In-Reply-To: <20100627172416.62e7554d@rechenknecht>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5738340.MWGtjUAcjn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006281430.32776.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] PATCH fragmentation of unicast packets
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

--nextPart5738340.MWGtjUAcjn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek has published some patches for the debugging infrastructure. Please=20
adjust your patch for that.

Andreas Langer wrote:
> +	if (frag_enabled_tmp < 0) {
> +		if (buff[count - 1] =3D=3D '\n')
> +			buff[count - 1] =3D '\0';
> +
> +		printk(KERN_ERR "batman-adv:Invalid parameter for 'frag' setting on=20
mesh
> %s received: %s\n",
> +		       net_dev->name, buff);

Please change the printk to a bat_err (remove the batman-adv: and the=20
information on which mesh it happened).

> +	if (atomic_read(&bat_priv->frag_enabled) =3D=3D frag_enabled_tmp)
> +		return count;
> +
> +	printk(KERN_INFO "batman-adv:Changing frag from: %s to: %s on mesh:
> %s\n", +	       atomic_read(&bat_priv->frag_enabled) =3D=3D 1 ?
> +	       "enabled" : "disabled",
> +	       frag_enabled_tmp =3D=3D 1 ? "enabled" : "disabled",
> +	       net_dev->name);

That printk to a bat_err (remove the batman-adv: and the information on whi=
ch=20
mesh it happened).

>  	atomic_set(&batman_if->seqno, 1);
> +	atomic_set(&batman_if->frag_seqno, 1);
>  	printk(KERN_INFO "batman-adv:Adding interface: %s\n", batman_if->dev);

Please rebase your patch on top of the current trunk. Otherwise we have an=
=20
merge failure here.

> +			if (!orig_node) {
> +				printk(KERN_WARNING
> +					"frag: couldn't find orig node\n");
> +				return NET_RX_DROP;
> +			}

Please change the printk to pr_warning.

Best regards,
	Sven

--nextPart5738340.MWGtjUAcjn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMKJXoAAoJEF2HCgfBJntG3fkP/A3vCB5VsxluHFNgl1UlFDWr
/ByzDkRPu00B+uQm8FFAJl3h46fYjnWExzpxRv1E7io7omDPuGSB12n5EYVAI5Ai
RT3syzd3T0siZEETVpNW4616+w7NTKdF6hO98NCRdxzhfusCOAdD2wNr62gnI7UF
n5/ACftiScevsheE6g+UMcMgiba5y5eKkKJ8+y1CFjwjOxOPrrdUnYn8EO1wIyHW
V1w05TgM2NU7CamRIgShXHlRDsSlDyfkN7Q127tu0wqBB7/9hs+SaeSjMXOQxd6R
dd9hgisjUW51ex9lYdEvz67Udg39HHit7axNwVQogkUVe0G64wDdK8KnsNupEknT
/61l4crvEpwzC8lEDkorGxRNlPOX4i7nSOkhKWuG9MLFyGQIX9x0RdDEAVQ/Xj5p
gmHn7/uavS1gyyKJdoBEBg0HdMtQSUo4yIAOO7fWIyTAt4903A3o2CAwrfcWbdIi
zdhsa9Gxwt4VvAHsIYHEIKOr4Cq9a9STw4kuisCFMttHk3kj1C8FNnS1pGLGnOLd
57aNbOLXL6if2OL85/B/1kccyAw8oyucyQAB0QaCmICBaCN8pbyD6kcKANZm++XX
J2lF/125fx8wbigKqid+aFX2PN3v7yvlFUGliJHDHkItVUXegaE0l4qUdtDAg8MO
Km2HIMblK1X0khRBYvBr
=ZjEl
-----END PGP SIGNATURE-----

--nextPart5738340.MWGtjUAcjn--
