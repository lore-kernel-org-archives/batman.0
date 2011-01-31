Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Mon, 31 Jan 2011 19:32:55 +0100
References: <201101282346.16035.clemens-john@gmx.de>
	<1296323152.2725.6.camel@mytilus>
	<201101291900.51081.lindner_marek@yahoo.de>
In-Reply-To: <201101291900.51081.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2535279.TZ6FRBvxWr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201101311933.01581.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

--nextPart2535279.TZ6FRBvxWr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Samstag 29 Januar 2011, 19:00:50 schrieb Marek Lindner:
> Hi,
>=20
> > I think if we don't want to change back our configuration (batman-adv on
> > vpn with its mtu-problems etc.) the simplest way would be connecting a
> > usual router to the wrt54g.
>=20
> I don't think the VPN is the problem here but the fact that you can't
> bridge an interface running in adhoc mode. Ad-hoc is "lacks" a field in
> the wifi header which makes bridging impossible.
> However, I agree with your proposed solution - another router connected to
> the Ethernet of the wrt54g can solve the issue.

This is not possible in this case (I don=C2=B4t have another router).

Is there onother (maybe harder) way or a hack to do get the same result lik=
e=20
when bridging two interfaces? Maybe with iptables?

Or does anyone know what the status of multiple ssid on wrt54g with kernel =
2.6=20
is?

Regards
Clemens

--nextPart2535279.TZ6FRBvxWr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1HAFcACgkQZgdHbA22lqNbPACePDRlVC8MDJADHeuCt7OOcx7g
qawAn2Uxxh0x8+XJ5krIlOZ0LATLEqIT
=d4QR
-----END PGP SIGNATURE-----

--nextPart2535279.TZ6FRBvxWr--
