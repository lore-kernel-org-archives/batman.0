Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 21 Mar 2014 16:37:02 +0800
Message-ID: <1843670.KWHXdhPAui@diderot>
In-Reply-To: <1395251855-30765-5-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-5-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1422469.ArBXOBPEAG";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next 09/11] batman-adv: fix code style
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1422469.ArBXOBPEAG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 19 March 2014 18:57:33 Antonio Quartulli wrote:
> - don't split lines if shorter than 80 chars
> - don't use goto if there is no cleanup to perform
>=20
> Introduced by 90ad6a40c80323805be1e86504385de2bd861f0a
> ("batman-adv: Modified forwarding behaviour for multicast packets")
>=20
> Cc: Linux L=FCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  multicast.c         | 3 +--
>  multicast.h         | 8 ++++----
>  translation-table.c | 5 ++---
>  3 files changed, 7 insertions(+), 9 deletions(-)

Applied in revision bc45afd.

Thanks,
Marek

--nextPart1422469.ArBXOBPEAG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTK/ouAAoJEFNVTo/uthzAkUYH/i6BNj79OgFD8F+G/AqzqQEA
DFP9nf2nwH7g3W7whN8yr6wSro7YyzSrt2/mz1geC5xWt1MDOWw4c8pQFyJ5VyEM
/ci73ns/K3H+2cLEWAwX58ozUTHaivdLJMZocyqnOdM6CSaA29oKRREJ4B61olQj
5q5ixeWoMHlBiNWyxJ8T67//FUPZZzLiWZV1d2yHu5MaEAQP5+IUjbPOZwgr1sED
5D7kynQ6ThHl/0LtBhD5XgMAoUPBQN92C8/mfbeuoAWmQdUlu3wOreyV/9GyvWEY
2py2DdZjUH7iWecJ+V4Q1J7iHQ+rlQHYJjGkoc+0FLhULpbG+1Bp4QznT3mCP38=
=Muyj
-----END PGP SIGNATURE-----

--nextPart1422469.ArBXOBPEAG--

