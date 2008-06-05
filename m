From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman-Advanced Kernel land
Date: Thu, 5 Jun 2008 10:10:00 +0200
References: <4846B27B.9020907@csp.it>
	<200806041811.38881.sven.eckelmann@gmx.de>
	<200806051038.19094.lindner_marek@yahoo.de>
In-Reply-To: <200806051038.19094.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2968811.EFgnYu85Y1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200806051010.28794.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart2968811.EFgnYu85Y1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Thursday, 5. June 2008 04:38:13 Marek Lindner wrote:
> Same with me -  I can't reproduce the problem but I use a setup similar
> setup to Simons setup.
I gave Simon my (nearly) complete uml test environment and he was able to k=
ill=20
batman+kernel with a small ping packet.

> Could you try to use 2.6.24 to see whether it=20
> depends on the kernel version ?
Yes, I tried it and it happened again (and this time no warning in dmesg at=
=20
all). The problem seems to be gone when I configure my uml_switch as switch=
=20
instead of hub (removing "-hub" from commandline) - but sometimes it crashe=
s=20
again when all nodes try to send pings to each other (2 -> 1, 3 -> 1 and 1 =
=2D>=20
2). So I am really sure that you know what it looks like :(

Greetings
	Sven

--nextPart2968811.EFgnYu85Y1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhHn1gACgkQqQGwKVlMoDukkACfa1kINrMVCzEPWw45OYMCiKEJ
AwwAoLilj8tcXMUIM6xVXnDSu5gppLGO
=Os9D
-----END PGP SIGNATURE-----

--nextPart2968811.EFgnYu85Y1--
