Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 22 Jan 2010 11:51:34 +0100
References: <20100122100238.GL24649@lunn.ch>
In-Reply-To: <20100122100238.GL24649@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2082034.9WZSogfEs6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001221151.37245.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] State of batman-adv in mainline
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

--nextPart2082034.9WZSogfEs6
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> 4) We should review what is currently in subversion but not yet pushed
>    to GregKH ready for 2.6.34. eg gateway support, vis server startup
>    fix, bonding, etc. In another email i will produce a list of
>    patches we should consider.

Most of the stuff you mentioned are experimental things targeted for 0.3. A=
s=20
it was decided that all development is first done in trunk/master, nothing=
=20
like that should come in maint until we had enough time to test the=20
experimental patches (aka 0.3 is released). And the stuff in maint should b=
e=20
the things we prepare to send to GregKH (with some minor stuff for kernel=20
integration).

The interesting patches were already cherry-picked to maint by Marek.

As said before, there is still the issue that we still depend on PACKET=20
instead of NET in Kconfig after the skb patch.

Best regards,
	Sven

--nextPart2082034.9WZSogfEs6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLWYM2AAoJEF2HCgfBJntGsbwP/jkZEzCQ4df2h6dMLMWlKb0F
AxZPHvM6HeDpAI9uHf6/YPj/Y3kMao4P5FdJrpBGrb0opPkIKLlTIUm3m4QzcuSW
TsEk1eI6fY1N9UMHzEj3habzF4eUZQzbb/lOl3Yf1QI9THqJvI7ih4qonMHoDb+G
ShN/w/DLnQIuLO05dNemeqmxZekmD5gGSO9ihH67C2LoOs3+4yk394M3TvxT4C1+
fD4/5SIp4f6vAqyLPazWdl++gXVTAMhDBwDUbXLCT+Bai/9D4m4YG8+Vy3sxF7Fn
PpDLtWEyDQWrSMMFF5TZfz7N9+l0ZkrAiyEkFaVfCylHlgE1CTxmRVWpg6QGw47T
QVr6wINEGe/ypHR+6GoLyW4J0BmLENFDXisk6uFHoaOLtl46YT58zmqsu4x1bA4w
2NTuCYOba/0mt9TOS7kfhx86qDXUGGAQv2R/fVeh89dsznvcSO5UB89Y2Yzhktld
ni+yynYisvs8MpIWok/j+LcHgUYW1H8RSGYp5wko5YEs4AXWjuPYRAfkJejDlfEu
4/n2Db2u17BPt4nflmanFDODyrp3HgIsenL3cwbdlZcHjcnwOVNTQ03EeRW5EM50
J4TlCYStYa69fVnxdHXeTMO2nhuAnQBVgIcygIO8Bz6r2bL8mTXxXgytfXaK7NFG
2nmveDyH5ZYAspQ1b3AV
=j8Pr
-----END PGP SIGNATURE-----

--nextPart2082034.9WZSogfEs6--
