Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 17 Jun 2010 09:25:57 +0200
References: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
	<201006170110.19294.sven.eckelmann@gmx.de>
	<20100617054257.GA15420@lunn.ch>
In-Reply-To: <20100617054257.GA15420@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2476727.VzfnARrv6C";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006170925.59150.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use rx_handler_data pointer
	to store net_bridge_port pointer
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

--nextPart2476727.VzfnARrv6C
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> > --- a/batman-adv-kernelland/hard-interface.h
> > +++ b/batman-adv-kernelland/hard-interface.h
> > @@ -38,3 +38,8 @@ int batman_skb_recv(struct sk_buff *skb,
> >=20
> >  				struct net_device *orig_dev);
> > =20
> >  int hardif_min_mtu(void);
> >  void update_min_mtu(void);
> >=20
> > +
> > +#ifndef netdev_isbridged
> > +#define netdev_isbridged(netdev) \
> > +	((net_dev)->priv_flags & IFF_BRIDGE_PORT)
> > +#endif
>=20
> Maybe this could be pushed upstream? Seems like a useful bit of code
> in general?

I don't think so. It is only used in ~7 places in the whole kernel. If you=
=20
want then please feel free to add something like this and submit it to Davi=
d=20
S. Miller.

Best regards,
	Sven

--nextPart2476727.VzfnARrv6C
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMGc4GAAoJEF2HCgfBJntG5FMP/3iPHCbTIN/2wZTiIu9gQftP
O1gqN5JAQrWPdA046K71ml0b6tjjNPCUIAMb+/iziI4Pwllxd5TBBa7JeiJZ4+ep
ZyEeRXsfl2YLxZBifL0amW2dhlidreJEqi7MkDfxIF0cyb8x/DxCHW2VvqHhpTrG
NeliN7ldNOVeMRf4RxaCubTp7DtQcOhbyyA9db48Fx8X7OROUl37MZuEzRKZkjPD
ZPDhyc6fVWPsP+qt9toVyC9yjX9l9Cy2V+TaIB8uqO/IhU9ZInAiUy+dxLJT+nmI
AddCBGoC1wLRHWXcOYEe5lm59v/kKu5aDtiw2k8P8I7ZgucjLa01FrFjjjo8b9B1
5sjMbUsT3k7lKMtGGO4IL4dvnV3qKRr7w05LGsgkGHbUFlKJ2R1q1frRydudbq2x
o1050YOhkkAAzUCkwAwepl6bTeMe+fh8HoJHm3ZJWcLR4SGKDgKJqNEcTGaeVVFe
Y7z0iU4v2DVkQhlTdms7qQb5SSbQqkZIOaou6rM5bl1uuBq6B43QT1VmMdoG1zc3
TRfBG4xpE3GP1XNrUOGmE8MJufDZcnVjNFCaDo9SrbFnWp3o0xx2JN6ec2L689Ky
wEap+IBF2ah0a+Tkz+bYi6gmZriE69z/PvpcMNgZNduaDE+MlD2GAqnL/WypPU7v
s+0WDPyctVYUFAtqH/mn
=qhQB
-----END PGP SIGNATURE-----

--nextPart2476727.VzfnARrv6C--
