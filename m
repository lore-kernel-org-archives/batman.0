Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 20:46:36 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626184636.GE2120@ritirata.org>
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
 <20130626180217.GC2120@ritirata.org>
 <CAD_CWO0=3LUL6HsZtG3CGSfR5=BXcoJ=ccfdLCFtthhZTUJKzw@mail.gmail.com>
 <CAKON4Owj1rZdzPxbiSq6__YxXpg8Yy8rQrg=LZWoKRy7-CSwCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <CAKON4Owj1rZdzPxbiSq6__YxXpg8Yy8rQrg=LZWoKRy7-CSwCw@mail.gmail.com>
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


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 02:38:16PM -0400, jonsmirl@gmail.com wrote:
> On Wed, Jun 26, 2013 at 2:18 PM, Steve Song <steve@villagetelco.org> wrot=
e:
> > On 26 June 2013 15:02, Antonio Quartulli <ordex@autistici.org> wrote:
> >> On Wed, Jun 26, 2013 at 01:30:18PM -0400, jonsmirl@gmail.com wrote:
> >>> I'd like to setup batman up on single radio routers. I've installed
> >>> openwrt on three different chipsets now (RT3050, RT5350, AR9331) and
> >>> none of these wireless drivers implements support for simultaneous
> >>> adhoc and ap mode on virtual interfaces.
>=20
> Is it a bad idea to run batman over the STA/AP mode type interfaces?

batman-adv supports it. From the batman-adv prospective there is no problem=
=2E The
important thing is that you know what you are doing and that you take care =
of
properly configuring the underlying layer (e.g. Isolation of the client sho=
uld
be enabled, imho).


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyzcMAAoJEADl0hg6qKeOrs4QAJMRddwV6ff94Dy/5PoN0OPb
EwH8PP/qdrV/QX9nP8mWqyDzKbwajVi3rrFScaoKirtDy3eh3mrcfbcKTEt9Po3N
+SI3suXOJM4hb36rFIq4NDSmO7R90WEYaZwpyQaxuJvyfFqNgXK5Q90IFJENIBlK
7pkeWJzIDreqhLT6fDrSlB2AN3+r3YpXnR38ZH+4/6guN0SC4ra2pVpqcN9zWg9g
JDzUDIG/NbgY/X95n693DCRHTfH8q3ShSU7pIl1Xqb/Dnx8VqaWvwldjfYkWdt79
FYnAG7oEMCiJG+A7U+lyro439XdcE6vGv7Edj15xI1NecSwZQ5HwCjALz6gxb+xB
f6rMhpITyOvojEG9RnvdVCMx4Ye0u0z4AQRYDIEDD1rquO2P3xU1p30oQfMT0Y7n
TFjcdsMLeLLR8gi9OMM4JzCwXd9s0zXzgSxvFd610TP51kCPtj1bcGxFmURfEPwn
pY9JmXcMY7Ra5P6s0irA/EVa4qZP1u8+0spMcfCo4mVpMVLtu8oIMZ7QyCuwE2G5
Sw/KEs+eksZG3/q2Fr4/4Lrfx3aWZUZMOMz6jKeMw2V4nb9PPl2k6U6CJd+/dc7U
SZaJx8rC1L2QN6e8d+Sgumf1JQo1BcVJMltKXNu58Nb+XH5yeQXT02jLsdZT9GpM
cxa/xoNELbq1rHun5Q57
=xaez
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
