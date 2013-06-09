Return-Path: <ordex@autistici.org>
Date: Sun, 9 Jun 2013 16:20:48 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130609142048.GB3347@ritirata.org>
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
 <1370340711-1399-9-git-send-email-ordex@autistici.org>
 <201306092213.59813.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <201306092213.59813.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 08/13] batman-adv: treat bat0 like yet
 another VLAN
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2013 at 10:13:59PM +0800, Marek Lindner wrote:
> On Tuesday, June 04, 2013 18:11:46 Antonio Quartulli wrote:
> > To make the code simpler and easier to extend, treat the
> > normal LAN (bat0) like any other VLAN having vid 0
> > (untagged).
> >=20
> > This change makes things simpler since bat0 is not a
> > particular case anymore but it is treated like any other
> > VLAN.
>=20
> What makes you think "vid 0" is not a valid vlan tag ? If this patch is=
=20
> applied how can I create a VLAN 0 on top of batX ?

The commit message talks about the value of the vid variable (used to keep =
the
value of the VID, of course) and as introduced in a previous patch, if the
HAS_TAG bit is not set, then we don't consider the this variable to represe=
nt a
real VID.

VLAN 0 on top of batX will generate vid =3D (HAS_TAG | 0), while in this ca=
se I am
talking about vid =3D 0.

This is implicit in the vid variables semantic previously introduced and th=
is
is what I meant with that "untagged" at the end of the sentence.

Maybe we should substitute "having vid 0" with "having vid with no HAS_TAG =
bit
set" ?


Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRtI9AAAoJEADl0hg6qKeOfCUQALWoxKxiWyc/uDCuHbRyBJey
tMdn1LE2VlOaI/b0zx6m5NtifmzQwSIizZUeRbq20UuE7UNLt+SiK+pH4lKRpQku
RnJ39v2LVzlGCmpJs3fwQq/5/TkRERmQRujPPwIE/rKGpT0RibA2zv309LjlWHQg
f9ijRZL1Nq/zvBs3Tn0Aq0OZBf+HoiNvg7KpCGho3j4FViYyVDMNqWWi0lZcPvcI
AVv+rT4yy3EbWbMi4od701XzxW+AnQ4jAl+s/razogdc9ygA6sOHiRA/qs6Pxx/Y
hW3+UxYBBPd7e4PtUXoIpLAXi7LH009oCB6NYf/9W00KFpeX6pR/HRtVYFifd13b
WxWKfGUBFkojoKI28vebqkd9YL+zuBYJu07mxjZ8qhBQIYKt8Rx36Aitc2lnMckY
4JfbSXp1JnrtD+Zm2RM4zlFiZFrZyN8tf8W+4y+BFUHIHqLu4JKEt0/Bjx0Sp9UG
GFiKJwrX0/cY9XdRR8Ujfq7NPT+ClPLMz4V9RVjG02AyimSu3yyr4i/jBhQ8ALby
IC+2Nm7Q3N2kCX8uLnvJzTpZYP/lkEd8ZnEomtD1pqbldP41NOMVjNiw0duriC5W
bQbKNZ3SH1s5WvCr6Og+H6M4ydXzx0y60a+El64kLCucoJSVCKYyHu1X6LbkmlnZ
sJO/CoVm4YhATnaCrto1
=YazV
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
