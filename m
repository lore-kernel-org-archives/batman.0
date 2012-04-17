Return-Path: <ordex@autistici.org>
Date: Tue, 17 Apr 2012 14:22:58 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120417122257.GA3377@ritirata.org>
References: <CAKLmikPvKjzTL5CghzBZYWgPAhxVQVw3_usaTo0GGT26Z29mHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CAKLmikPvKjzTL5CghzBZYWgPAhxVQVw3_usaTo0GGT26Z29mHA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Determining on which node a client is connected
	to
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
Cc: Jernej Kos <kostko@unimatrix-one.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 02:15:49PM +0200, Mitar wrote:
> Hi!
>=20
> Is it possible to determine from central location (for example
> gateway) to which node a client is currently connected to?=20

Hello Mitar,
if I correctly got your question, you want to know what the Global Translat=
ion
Table of each node already contains.
Using "batctl tg" or directly inspecting the sysfs you will get such table =
with
all the client entries.=20

> So from
> DHCP you can get MAC-IP translation, but how to get from MAC on which
> node client currently is?

However, I didn't get why you need the node MAC.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjWChAAoJEFMQTLzJFOZFj2sH+QHpFntNcLDOjop2bN4Tk3hF
/bBmVHcwHSfz5Bp8l0JBa9MaHI9YlnKgDmKgchZCY5ZpJxoTe4nAvJ7geNTEcYyE
vmcun4YsNZkz6APfxqFG4BCpmUinnDp7bFK/cfNhyf/a0DrbrfUxNlwviDRhAGu2
ohS2lrNHIhQaHDYY24XNdvMftDK859To3rQ5SizM8YuDD9wQCMHismkpKTVWuzyt
bDe2hGHucw95wkZfhVAmHqjCV6kNq2V3xeYGfgiUGXhAwfdzJCCVGLensnR8vrDa
yFE734qtVK31iH3MSFV4jiZsyITVLLLys3SfGRbwdds8L+K0PjOMPC4jHZ1+y0c=
=IwCp
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
