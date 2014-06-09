Return-Path: <antonio@meshcoding.com>
Message-ID: <53962199.4060202@meshcoding.com>
Date: Mon, 09 Jun 2014 23:05:29 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <53957653.5000406@meshcoding.com>
 <1402334059-28681-1-git-send-email-gaul@web-yard.de>
In-Reply-To: <1402334059-28681-1-git-send-email-gaul@web-yard.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OE0tMmpdgA7VV97e5oXmD6eSF4cWmeNF4"
Subject: Re: [B.A.T.M.A.N.] [PATCH] remove unnecessary logspam
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
To: =?UTF-8?B?QW5kcsOpIEdhdWw=?= <gaul@web-yard.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OE0tMmpdgA7VV97e5oXmD6eSF4cWmeNF4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 09/06/14 19:14, Andr=C3=A9 Gaul wrote:
> This patch removes unnecessary logspam which resulted from superfluous
> calls to net_ratelimit(). With the supplied patch, net_ratelimit() is
> called after the loglevel has been checked.
>=20
> Signed-off-by: Andr=C3=A9 Gaul <gaul@web-yard.de>

Andr=C3=A9,

I'd suggest you to check this patch with checkpatch.pl --strict. Here I
get many errors due to non-printable chars at the end of various lines.

Here[1] you find our guidelines (which is a set of complementary rules
to the guidelines you find in the kernel tree[2]).

Moreover, the subject must start with "batman-adv: ", because this patch
will end up in the kernel and it requires this format to easily
distinguish the subsystem that the patch is touching.

A couple of things to keep in mind while sending new versions of the
same patch:
- don't reply to an existing thread
- write [PATCHvN] (with N =3D version of the patch - 2 in this case) in
the subject


Cheers,


[1]
http://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-pa=
tches
[2]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/SubmittingPatches

--=20
Antonio Quartulli


--OE0tMmpdgA7VV97e5oXmD6eSF4cWmeNF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTliGiAAoJEJgn97Bh2u9eRkQP+wYyFL3flo6aPXBAw8dBqjfY
/mMRRK33U8KW30CpFcCo10Hv5YYGGzixupwIBla1J9wkQRkyLy61mkJyE7U5Pt2d
SSGAF5M23HY/mxL0jZ7McbL9cHSHIgXYdxUFG9ds9izUy6Zdij+HNBx3rFwHk+lJ
i9wIGByPdu6dnuM7BX+qsMh1/bQmkSFQ29NIRxOC0Ol28Tjd+ZoG7CYDY9Y2kmM0
8WlH7WvbGAot8itllKqmLBoGdmJNBLesVfQnuznXqVqhoD/jKlbZO8tkMiNIOCXE
UDKmnTaaCxnBaVJhV9K+N85YRxMZgkxv2Nd5iw0gyZriL/MRT3CbFwumYwLKGrbY
Zb1yqjn3Rx34KZqnirSjX4ivgLUSr4NZ0uhchuNM/Mp8tSokIYiuVpXKFkXjmvtk
cRmIRyBoj8Z59W1fH23shMVyxSyNVdduuOll54XCHOo5hFEVDXIZ2VmG/aQAN0TZ
ygdBBwjhUWrTzPhXKHj3lIyMvRd6fgyhrDrEgD1+WBOiOrqQScHhRjkaFv0Nn19Y
KZ5nSarLgsCr7ylBYCi+ASoYkQhwWZft4BSXx54w90UXB54OXnlig1D6/4PPwYfY
depmmqEuXT0OTkKLg9BT+TwqSIRAY8sNYgrZAEVWvlpyesByBmNxlQ0hfGxqMrbC
QOMznrJY3jFNadifqJf1
=Tp7A
-----END PGP SIGNATURE-----

--OE0tMmpdgA7VV97e5oXmD6eSF4cWmeNF4--
