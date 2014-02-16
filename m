Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:23 +0800
Message-ID: <26278039.q4ydkmULZj@diderot>
In-Reply-To: <1392482874-9024-2-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1710389.J6CgHjbgcf";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 1/6] batman-adv: Multicast Listener
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


--nextPart1710389.J6CgHjbgcf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:49 Linus L=FCssing wrote:
> With this patch a node which has no bridge interface on top of its so=
ft
> interface announces its local multicast listeners via the translation=

> table.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  Makefile               |    2 +
>  Makefile.kbuild        |    1 +
>  compat.h               |   37 ++++++++
>  gen-compat-autoconf.sh |    1 +
>  main.c                 |    6 ++
>  main.h                 |    1 +
>  multicast.c            |  242
> ++++++++++++++++++++++++++++++++++++++++++++++++
> multicast.h            |   38 ++++++++
>  translation-table.c    |   22 ++++-
>  types.h                |   24 +++++
>  10 files changed, 370 insertions(+), 4 deletions(-)

Applied in revision e368857.

Thanks,
Marek

--nextPart1710389.J6CgHjbgcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFlEAAoJEFNVTo/uthzACy4H/3I+iZHlz2btMvI2TTMdQnIn
M2OGLl0ul8pHq6HPK5/8XZJrcgx+/MrC8j6HW4ZDmsSlgXZFAj93fQEQunK7INq3
Q3KlSjDCvO1BMK1EDGq/czzCZ1vrkHZJH/Le8OPRe7iPEPQtEJBll6EFJVIrxgn/
YE8/DQpEYlNQA0luSDX6cypDKceFsWoKlK8+pevN+gZ8dBMlPwcoma0rl2PDwxT2
q/LAcExfBoZZko/hXEWhaGW+Q9UGvdRTxCwq80frsKsIGljZZxtjCHr0loopCS2m
LZgi5kFK/39CcCbC1iAbiT3aC9X5VqP6/6X0F5UN2m+9zicpnS87As5M8cX2Dsw=
=5NoU
-----END PGP SIGNATURE-----

--nextPart1710389.J6CgHjbgcf--

