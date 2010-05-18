Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 18 May 2010 22:35:14 +0200
References: <201005171951.21349.sven.eckelmann@gmx.de>
In-Reply-To: <201005171951.21349.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart74971968.WJQVX5dp78";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005182235.22328.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Converting from /dev to debugfs
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

--nextPart74971968.WJQVX5dp78
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Unfortunately I am not able to continue it today, but don't want to stop
> other people working on similar things. I will attach v0 (aka works for
> me, but maybe not perfect/good enough) versions of these patches to
> support them. Please feel free to discuss the patches.

I converted the remaining files from sysfs to debugfs, but I noticed that=20
there is a problem with the output functions (see  "BUG" comments in patch =
3).=20
The problem is that we may sleep during the prints in the output functions,=
=20
but we disabled interrupts.... which is bad. This problem was also their=20
before we converted from /proc to /sys. It seems that it was first introduc=
ed=20
in r1517. The old way for hna_global_fill_buffer_text=20
hna_local_fill_buffer_text solved it, but restricted the output to 4096 byt=
es.=20
So we could either stay with a "slow" and maybe inconsistent output or=20
restricted output length or copy the data to a local buffer and then creati=
ng=20
the output without spinlock or something completely different.

The patches are for trunk, but I would provide backported versions when the=
=20
patches are discussed and we could solve the problem in a sane way.

Best regards,
	Sven

--nextPart74971968.WJQVX5dp78
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL8voDAAoJEF2HCgfBJntG33wP/RyBOom+ESKG/hGMDX3uGVQc
QCTo+9MfI9j+gJlBQgGkMxNxOgIHJRAXB3LPv0TqHnAVlLP7FumLtjdegkGF/xaJ
j2pu64wddvQSC/Kv4XUSwG23q92eZ/Rwwnk8FRukESxv+zKatPjPQJO6YNpBeelN
ZTC1P0bSAgNJGcTzH43kGRqChQ7IVmbBFzKjEf8Op7WsxcmVMiobcYLFAOSC9XK/
ZpepV+xLV+7APrIEf1q6MoKG/1jD07I4f7YLrV5kAJZs2AWMuM1lJDlIZeHooU4w
VPiKFVO+sWjWWLN80r2FUxj1JGFtQSWy0lMR0LWL+Nxt5pbywkLpcirDq2HpKPvL
o0WuSwfp5FGKYgaE4Y7o6LWxWQN2Vl+tnAv3kKM/g1Tx8ieMeyFbH2QPafrBcYDh
fwI5RoGQguXi2eWBHoJ4mZXWip09kzWMcYGMzcgY1pwXwDaNcPCe5Jjn620mVnJ0
IxADW/pBAjSist4vK/fdKhrNWIps50P5buvKBo14U5uqSz5cuQnWKze8T8+PoZOA
Y8QKQwJKOXnb2QEt6fKGlqdM1UCLfdBJXRfLhkv2OjpEbI6cQhwvyW52BpVXNnmI
e5HrRnIo/4CxZUwPQFoRbH59A7ErPkm6Jf9x2T7FMK8ZfTmPIa7wgAFUVIE/ynQb
6LxPxsrwhV2jYAQhj9nd
=A7Kr
-----END PGP SIGNATURE-----

--nextPart74971968.WJQVX5dp78--
