Return-Path: <linus.luessing@web.de>
Date: Tue, 9 Mar 2010 22:35:01 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100309213501.GA30949@Linus-Debian>
References: <201003030640.16085.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <201003030640.16085.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] reorganized kernel interface patches (version 2)
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

those patches look quite good to me now, seems to work here as
expected.
Just one note: One of those warnings has gone now with the
_GNU_SOURCE stuff. However, getline is also being used in
funcitions.c:174 (so adding the define to functions.c too, got rid
of the second warning for instance).

Cheers, Linus

On Wed, Mar 03, 2010 at 06:40:15AM +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> I merged the feedback given so far into the patchset and post them again =
to=20
> offer you the chance of generating even more feedback.  :-)
>=20
> Changes since version1:
> * the known issue from version1 turned out to be a bug in the used kernel
> * batctl sysfs path has been changed to /sys/class/net/ since older kerne=
ls=20
> don't provide the "virtual" subdirectory
> * the year of the copyright notice was corrected
> * In case the erroneous of input contains a newline it will not be printe=
d to=20
> avoid printing 2 subsequent newlines
> * the function calls which used global variables before now receive the=
=20
> bat_priv struct as an argument
> * added _GNU_SOURCE to bat-hosts.c to avoid compile warning
> * batctl gets bonding mode support
>=20
> Cheers,
> Marek
>=20

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLlr8FAAoJEBKw7u43QNpfC8EP/2OlQpaikCwSQY1iR9MJ9Ifl
RSu7RWg/KU61YJykMLbuJiKsltdgP6ZcNs37+yNUf0tYcL0TNpBEJK+lXtuG5+7r
P6e6+7Xb3pIYsGHpBtDy187d5ClD5j7juxzoI86XvdS5uaXGiJUd6npFAsv918Vu
wKIhyz0Ha7Bqva+P4TmjcDMQWwea/53mJRLY49kqr8jvvHQ9xto2XgByTyK/n5RO
wvs6THwTUCTw/QI/fmYcmKmcjOYTQUehMkelHXz1wnvRFIYQGvFTy1CIF5HhcGNW
jv+sqMUWPuBDWo6/VSuoEI4+mOm6TRlYKEKxlDXkEIAJVV0ZLt123Qt4h6ffWuaK
FsOe43+pNl4Np0qGsNPGVnwEOJJkG6UNFtZc11DOmXphP2Sr31rDPXFz/rt/IKwk
HtntNDy7RD5ugfW4tlXOH6LOXB69EM0obrRe3o6TbV49oQC2uOSkI/WOHFvF0TMm
7Wu17wr4AVtDuoqlYN35ZGPnA8LO6OH7uYzmNwelrIZdA0nvG4E6P+YjA4qESDVw
++/A1W9i1ldDa/FI4g0bCyQwEi751RiT5U0Pg6bxGV6WiXFPe6fvmRCpyXohrlT4
594y1h2+5Aj1909PDYGeuHpa/vMToRH3suJDuTGqgpvR5C3GKFS3Mn1PRSjzLgpN
AdqXPQTPyisfKYiCjMCK
=hy5U
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
