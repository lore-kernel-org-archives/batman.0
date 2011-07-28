Return-Path: <sven@narfation.org>
Date: Thu, 28 Jul 2011 14:46:19 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20110728124618.GA23072@sven-atom.home.narfation.org>
References: <CAOaDhSSaTKxP96NfHhv+aBDjOE9sm4u1fpJGoegcHeXKnsJ-Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CAOaDhSSaTKxP96NfHhv+aBDjOE9sm4u1fpJGoegcHeXKnsJ-Rw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] per interface hop penalty
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2011 at 02:31:49PM +0200, Gioacchino Mazzurco wrote:
> Hey all reading batman-adv documentation I have found the option hop
> penalty that seems quite good for example with vpn links
>=20
> The problem is that actual hop penalty is per node but not per
> interface, the fact to have per interface hop penalty could be useful
> on nodes that have both vpn and real interface and someone want to
> penalize only vpn interfaces
>=20
> it is possible to have that implemented soon ?

Yes, you can propose a patch and we can check it to get it in batman-adv
2011.4.0 (which will be released in ~3-4 month) and linux 3.2. But you have=
 to
hurry a little bit, because deadline for those patches is in 3 weeks.

Kind regards,
	Sven

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJOMVoaAAoJEF2HCgfBJntGCT4P/0Teraw/K+Wy5nqCmBxUgRK+
Qn8P2TgfvAYLikjUQBvUiWF9CoVCPgaKNjxnOwljbZSPYB+z+qlYvFbSYoEEw91B
FeV0fWrQ30SaVBhNDUCiAcUfUcAyiG8L11HAFaPFZYhAaewhOZcq9jaO2wZ9SZIO
21//Xz5wa3n59vQJyWKus5f6+mbDMb6yrDNt7GHOjqZVYcS5KFoYbkW5pdfIGd0c
mIkNSpvpPp1dZo8BfVU5luMQEgsujLdawRTeCacqelljI3oVnGXXhV7OOH3/CXn4
HbrWD0NEXU+Y9UtRgP+IE9z4MztELtO8xT3Tc5vnOe8TKODX7BRGAAHu7tj55u48
tmUZ2rjzVgpLWmbokX33jHXOZISsxvG8C1qkbBdomk9+imb2r+z+KMy5YiATElrC
zjEMRnzuEq2nWLqKDhtvDNpSQrr0mpeOWuJyt3fmN/IIx3eke+Y0cKPVw4KjWLoF
bD7avCjKvAfog90bGvltiQxCU19oyST3bW6hycYe1I0936fkF3fIwih9/dhmHEYg
xeEcotY6/wOiP8Pfr7lu52vzIxST26IJm7y94MOB8BXKBU3hKerSZF9+4XjgL9V2
xvY7qXI4fL4ppunZN76e1rIJIny2zirBKZBSOIMq+gliOm8gd5T4CHaPVnWcf7UM
rZHUipj8f2tuHcLtVI0B
=etdJ
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
