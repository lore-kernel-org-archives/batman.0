Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 28 Apr 2010 23:01:35 +0200
References: <20100425165152.GA1577@pandem0nium>
	<1272271670-27667-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1272271670-27667-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5689768.Ej2rUQHzE6";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004282301.36228.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: 32bit sequence number and
	TTL for broadcasts
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

--nextPart5689768.Ej2rUQHzE6
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
[...]
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> [sven.eckelmann@gmx.de: Change atomic64_* back to atomic_*]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
> Simon Wunderlich:
> These changes required to increase the compatibility level once again.
> It should therefore only applied to the upcoming 0.3 branch.
>=20
> Sven Eckelmann:
> Please don't apply this patch unless we got a "save to assume 32 bit for
> atomic_t after linux 2.6.3" message from kernel maintainers.

As it seems these comments were obsolete in the kernel and the code=20
documentation will be changed in an upcoming kernel version. Patches on the=
=20
lkml were already acked by different arch developers.

As result we can use atomic_t as datatype with a 32 bit range since 2.6.3. =
I=20
would like to promote the patch version with atomic_t instead of atomic64_t=
=20
for 32 bit seqno. Marek already declared that he would prefer the version w=
ith=20
atomic_t. Maybe you can check too if you can ack this change.

Best regards,
	Sven

--nextPart5689768.Ej2rUQHzE6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL2KIvAAoJEF2HCgfBJntGY4AP/1gm4AO0EHy9knlzmxVR2a3p
atMrv2qFLLrjJJiSpr8u9KtA7ztQgVHzRLgz2+KceN/I8lzlaKLkP+D9ZitGkyae
bg6hlCToOZZ4FqZV7awL0iqmHMCQDf+ioDwI0W+siatuQn3IjU/X8kMxCLVlURHu
pXxkMxKd5FvCmYLyqS/RW4wbSIZAqJ7eS0LTmDD/AJf5O50IaZeJD2YZwiAUhidv
vNRZZukNEF3HBqrx7vy+EGf1nFtaWriiDE2Lbcfj1rYpozv+yrMuDcw3Bua+MZDg
IsCVLRLRatNsBxz6ojRwLSAHjhTTDzBHu3nY1Pm95Bo3S/CAMpN8HQNveua1CLge
z17XDo6XvUOPtDWsr74q4HucNy1v4E44b+iXBAOzDzZYkErj+oQr4L7qArWAS0Vu
DmHNsCTiJhwL73fch/TdF/bCg+e9xw1gvFqpV6q5UkxUBUX5Mst4z7cd1dg+NBjs
D/FVsK9zjCgwydAeUlyu9XjRRo4oOEC/01P0qTeSxFQJSQouWcfVj8JzXJJdlHee
JlSY9R675eXxnan21mRdhjbOKbdYn2YbSXVmaPKiHkvc10IiAReNDV0tq/FWxamm
ZJj1luOrX8EeVxvIr/BHfZJyhcZyxf6F+yiY65/6a6E65jjSSG0BX7HgP20SWf+f
hJgJMwnxMDDhcq6b0lIz
=vUbQ
-----END PGP SIGNATURE-----

--nextPart5689768.Ej2rUQHzE6--
