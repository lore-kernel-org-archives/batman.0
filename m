Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 21:01:17 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626190117.GF2120@ritirata.org>
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
 <20130626180217.GC2120@ritirata.org>
 <CAD_CWO0=3LUL6HsZtG3CGSfR5=BXcoJ=ccfdLCFtthhZTUJKzw@mail.gmail.com>
 <CAKON4Oy91hwHS2wupsPYsZQ8iMX0it1SwPPcf-vS=a1HQYr5rA@mail.gmail.com>
 <CAD_CWO0hpqnzdMt9EmyJy85OM=Zw6pz3fZ7z27H1jSJc7vM8Qg@mail.gmail.com>
 <CAKON4OzQpsZdGFoEPDpsZcCyu0pGBWLpuNoQZkgcYX-7CmzKqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline
In-Reply-To: <CAKON4OzQpsZdGFoEPDpsZcCyu0pGBWLpuNoQZkgcYX-7CmzKqA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 02:56:06PM -0400, jonsmirl@gmail.com wrote:
> On Wed, Jun 26, 2013 at 2:49 PM, Steve Song <steve@villagetelco.org> wrot=
e:
> > We use a stock AA OpenWRT distribution (RC1 currently I think).  All
> > modifications to it are contained in the Github repo at
> > https://github.com/villagetelco/vt-firmware  We have instructions on
> > setting up a build environment at
> > http://wiki.villagetelco.org/How_To_Set_Up_a_SECN_Build_Environment
>=20
> Maybe it has gotten broken in OpenWRT trunk. There was a large
> backport recently added to the kernel tree.
>=20
> When I active the alternate interfaces they won't let the other one come =
up.
>=20
> root@OpenWrt:/etc/config#
> root@OpenWrt:/etc/config# ifconfig ap0 up
> ifconfig: SIOCSIFFLAGS: Device or resource busy
> root@OpenWrt:/etc/config#
> root@OpenWrt:/etc/config# ifconfig adhoc0 down
> [ 2510.510000] batman_adv: bat0: Interface deactivated: adhoc0
> root@OpenWrt:/etc/config# ifconfig ap0 up
> root@OpenWrt:/etc/config# ifconfig adhoc0 up
> ifconfig: SIOCSIFFLAGS: Device or resource busy
> root@OpenWrt:/etc/config#
>=20
> In my 'iw phy' output:
>=20
> valid interface combinations:
> * #{ managed, WDS, P2P-client } <=3D 2048, #{ AP, mesh point, P2P-GO }
> <=3D 8, #{ IBSS } <=3D 1,
>   total <=3D 2048, #channels <=3D 1, STA/AP BI must match
> * #{ AP } <=3D 1,
>   total <=3D 1, #channels <=3D 1, STA/AP BI must match, radar detect
> widths: { 20 MHz (no HT), 20 MHz }
>=20
> How do you interpret this? It this saying one IBSS plus up to eight AP?

Seems so.
Maybe you should directly ask on the openwrt mailing list/channel?
They may know what to do.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyzp9AAoJEADl0hg6qKeOSZgQAK+6cDhcC5ew5hKF6TeZOMT4
gEyHwJgH7f05cLsTsTHjZ7NI4J78iKvAzWeVK2bI5/j5l7Lguh05uoEmGsioxueO
bYjHrfqVygT3cGpRK8Yt/0IQuZdYGAw3T/16WlpMtvBxIgljzmdr1uzAwnAFsbN4
qN8ct2vTNsShRuas8QJ+HubEX6d1oSeLOcvIZijJSOPKdpEqfoAFRRhwfHNFkIGV
svscgNkGDS4SUVtGBR3CoxtrBzQ+2B19XTMDnt6fJbMCqeqN/fLpNYcvVyBJLFfX
WuSKTqIq9VcPcLhe6h70u4R4gMrG7mdIKhwr0B73XdjC57Bhhgydw4FaNEe/mJs5
NI6BouKkwtNk9//fOcxs+dzUOv5bQm+pEiAHoW8MtO/VulibsDKsniu4wm/px9bt
Q1gTl73JssJGzUX53Qx6wEdi9sp2QK26k1xPiML1YGADGaTxbPGEH0QfF5UkmeOP
9yIyM3dBwC3tgu7k6rEFTIGEnvWBk+ZXUlL+hSjxuVuLPhcP3TycBJfkOJyGegH3
lIpZI1SjR1eKYNeo9JAeV2OvuT1e4+maf6VkIGcV+BDLhpq0kDZnmYbGEft1CvhK
BOk9xW7JAJucG/aEx3WkGKVQ434b7yKiWY3kDzln48gi6ou40A6NokLRbx0xWr5l
EqRPWnmVVTPgjruh/R5u
=oni1
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
