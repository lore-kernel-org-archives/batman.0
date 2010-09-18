Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 17:21:43 +0200
References: <1284738065-8715-10-git-send-email-sven.eckelmann@gmx.de>
	<1284744426-12239-1-git-send-email-sven.eckelmann@gmx.de>
	<201009181642.08297.lindner_marek@yahoo.de>
In-Reply-To: <201009181642.08297.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2312415.fQcPMjeaYu";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009181721.44244.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 9/9] batman-adv: count batman_if list
	queries as reference
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

--nextPart2312415.fQcPMjeaYu
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Friday 17 September 2010 19:27:06 Sven Eckelmann wrote:
> > The return of get_batman_if_by_netdev and get_active_batman_if leaks a
> > pointer from the rcu protected list of interfaces. We must protect it to
> > prevent a too early release of the memory. Those functions must increase
> > the reference counter before rcu_read_unlock or it may be to late to
> > prevent a free.
>=20
> It seems this patch does not properly deal with bat_priv->primary_if.
> Please review my revised patch and let me know if you think it is ok.

As said before, this patch should not count primary_if by design (see the=20
commit message). I would say that your changes should be an extra patch.

I will split that stuff and send it as extra patches. Your patch itself has=
=20
the problem that it increases the refcnt through get_active_batman_if, but=
=20
doesn't reduce it at the end.

Best regards,
	Sven

--nextPart2312415.fQcPMjeaYu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMlNkHAAoJEF2HCgfBJntGpbsQALTjvkCzWQjo6KzvybnEQXpE
W0aZIXimvGD6gor7TKKPCpd2/LMjnAS1XoU4tOr1n54Y3H7lACpAzFqV7KHOYhCK
2U2XglHeDJDiVhMeNfHsdAoVmCAw0GjKhqHGkNyuvKsMXmy3SctJW7GTQob+e2Pg
ANuZvrLf8sOi/N+FdHatvLbL9tap5HMGospPnDnlVYcjPGcN5zGLrX16TgtLtqo8
dLxkbJkZdf4ZWiea8piAP/VtQou+/no/1hkelGPLP2PVpovHdAevb70f7Hbn3kQ/
WTdKynS6LOGCPVOFtMqwrVo9fIx34bV5MwcuUA2wQXDuMHvOBnDgKwDQ2E9uUbDV
yD2peLiUMnx7FD0sXBciPYpxTeSXixmpY4jZnJ/J56dBx5d+oelUhIJ1WSM/MtOy
dIO24KiOrxtRSTooRUermbuwwdYaO/o6l3L1PnUjCWZDdp2FJTdgUDmUYQ0YBcAJ
Af3Ir44vj3SaumoC+b/JDOiiP/MlA60U0u11/1pjI7QugCRj8P+zGT34rUeF8jDU
ru11ULW8ufKbfzFbqlM636wOVe00ztr5fQZOL8Pgc8m2AKBSFaRxxtSntY8gqQvn
oZaUxHaMcjVCyArxb7yXiLbjiferI51OJndoo57EQsQfZb/harqSawzqH4+0y3H5
36AJzkI1j5HrsRKXnwnN
=K87q
-----END PGP SIGNATURE-----

--nextPart2312415.fQcPMjeaYu--
