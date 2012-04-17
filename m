Return-Path: <ordex@autistici.org>
Date: Tue, 17 Apr 2012 14:28:32 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120417122830.GB3377@ritirata.org>
References: <CAKLmikMcCspLyMs_ub==LZ-rUtxo2QjT650s8atwp2nUnYD-vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <CAKLmikMcCspLyMs_ub==LZ-rUtxo2QjT650s8atwp2nUnYD-vQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman as a kernel module
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


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 02:05:40PM +0200, Mitar wrote:
> Hi!
>=20
> What are the reasons (except for performance) of Batman being a kernel
> module? Is there a way for running it in user-space? We have some
> servers where we get donated bandwidth, but as people are running also
> other stuff on those servers they do not really like adding kernel
> modules and probably even rebooting servers for upgrading to newer
> Batman versions.

Why not using the out-of-the-tree batman-adv package? You can compile the l=
atest
batman-adv module against the running kernel (it must be >=3D2.6.29). You c=
an find
more details in the README.external file that you will find in the batman-a=
dv
out-of-the-tree package.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjWHuAAoJEFMQTLzJFOZFK48H/324/tEX4TNWDRgzvdZTXKVQ
+9wjp572N0K0hrFS3xbEo+Uk7bH2wrqEuTybF5fzOk1wKbPcLnqgf2hpQ6jQiGoF
6KV/DyO1n7W4XV/6aENt6q1j5AflSvBqNWgytTP+PN2DjHZusXI9ZS568veelLJD
Y8bpqfWpcg5BEPiaJM/K9zvqpGx6TSm0LaHYaaHvi9C2HjtehLkYkT6P+yw6Zj0P
PKnPciXv0UXeNx85ybdbAEH911yg0MbnuV9kxGNRkfA218r9Tc1xx+nsuS7zzqV1
VYotq1BC4rgIkiGjTNK1iW5JvaaWJqxJ+bE/UWzX7nJeI2rXzYwrZ/LgfP3nRVM=
=C+kI
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
