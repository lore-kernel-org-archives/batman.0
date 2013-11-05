Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Nov 2013 16:48:15 +0800
Message-ID: <3588316.iR9uVHWHD1@diderot>
In-Reply-To: <1382815023-22121-2-git-send-email-linus.luessing@web.de>
References: <1382815023-22121-1-git-send-email-linus.luessing@web.de>
 <1382815023-22121-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5366704.tSzD1yoZdI";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv10 1/5] batman-adv: Multicast Listener
	Announcements via Translation Table
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


--nextPart5366704.tSzD1yoZdI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 26 October 2013 21:16:59 Linus L=FCssing wrote:
> With this patch a node which has no bridge interface on top of its so=
ft
> interface announces its local multicast listeners via the translation=

> table.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  Makefile               |    2 +
>  Makefile.kbuild        |    1 +
>  compat.h               |   41 ++++++++
>  gen-compat-autoconf.sh |    1 +
>  main.c                 |    6 ++
>  main.h                 |    1 +
>  multicast.c            |  243
> ++++++++++++++++++++++++++++++++++++++++++++++++
> multicast.h            |   43 +++++++++
>  translation-table.c    |   22 ++++-
>  types.h                |   23 +++++
>  10 files changed, 379 insertions(+), 4 deletions(-)
>  create mode 100644 multicast.c
>  create mode 100644 multicast.h

Applied in revision a3f5813.

Thanks,
Marek

--nextPart5366704.tSzD1yoZdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSeLDWAAoJEFNVTo/uthzAuTcIAIhPQqdicWT6yrI59jruZrpb
9YS4WcBLeeyUHQyfLSjRvGiSjKMrh8uxs0xldxPXlnAvM0+ZuQU3lITVNjUhMTCm
4JIMCTDscbyfGLk2qQVRtufr/lSod7hszSpF+qykxAe2iJb3Jqg0+OIUGFDWUJUF
kn48+me+5GXYa9IWXChZnf+k5eBLFtxZS1At3XtR+eQRr7qe1DhrXhEhJM+pkqVt
EnPu4D0fEQ+qEA6BUeQozgmYahrd/DOd5DR0uwQ3o5WO5cHJiBZ+6uWVwHlSDcXJ
B+7KPpe+UvKCTRjKzeStH4RECWHQKnIzb2GFdR8DIA82n5ay/zgerKH5G1Pa9Vo=
=6F2X
-----END PGP SIGNATURE-----

--nextPart5366704.tSzD1yoZdI--

