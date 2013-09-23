Return-Path: <antonio@meshcoding.com>
Date: Mon, 23 Sep 2013 09:03:42 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130923070342.GF3911@neomailbox.net>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <1379860946-32669-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batctl: Add missing includes and
 remove unused includes
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
Cc: Sven Eckelmann <sven@narfation.org>


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2013 at 04:42:23PM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat-hosts.c   |  5 +++--
>  bat-hosts.h   |  2 +-
>  bisect_iv.c   |  7 ++++---
>  debug.c       |  5 -----
>  debug.h       |  3 +++
>  debugfs.c     | 10 ++++------
>  debugfs.h     |  3 ---
>  functions.c   |  2 ++
>  functions.h   |  3 ++-
>  ioctl.c       |  3 +--
>  list-batman.h |  3 ---
>  main.c        |  3 ---
>  ping.c        |  5 +++++
>  sys.c         |  1 -
>  sys.h         |  2 ++
>  tcpdump.c     |  6 +++++-
>  tcpdump.h     |  5 ++++-
>  traceroute.c  |  4 ++++
>  translate.c   |  1 -
>  19 files changed, 40 insertions(+), 33 deletions(-)
>=20
> diff --git a/bat-hosts.c b/bat-hosts.c
> index ee862da..9d36531 100644
> --- a/bat-hosts.c
> +++ b/bat-hosts.c
> @@ -21,14 +21,15 @@
> =20
> =20
> =20
> -#include <stdio.h>
>  #include <stdint.h>
> +#include <stdio.h>

why is it important to move stdio.h below stdint.h ? Is there a particular
reason for that?


Cheers,

--=20
Antonio Quartulli

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSP+fOAAoJEADl0hg6qKeO0vEP/RDVdM1zMdZe2+jUG1Fr5o8B
qIRapxcdof/N5lb/+p34znOF1Da9rlqqkHkBTZp/UMW/DM772OUNdFotV4eNwAVK
w2ezh9BRmpun3444mLEO7Jh/XBJb21C3JvoEztMrmuSl3IKSl3ahY3JLzZ7lvvv3
Vupel/aCNMyyQkmN4HRyy1q8mngn/XLFeidFs8tYpm6ZOVG1RFaLJ7BheiCsdkLZ
5b1jCRMSIhitr6GPFGb481SxGnanK1TGwwjrE2o07a41W+ATwNmqZP8WcgXq9arb
KFoaM0avMk/eOwbNVW4srCIp4irg7EHvXlOmfomZc/HxQ3RfmgNhGbWr52unaYkj
XU2P/JzJvjULVGlM2qMcE9Or7o0E27nmImOHQyfI8I8r/pEyslVDEO0Dcu1EfRjE
jLeq8S4NBGbBDrcFJjG10RXbiRmkcpGdVU15g55UaU2jPnbKNtNgV/duO2P05Wpj
QXsk1XvLgtrP1dxwpzbUZsYHcFO30hNErgWWCLYGU22DHv7PT94om0yF51ZyGhGZ
WMLJEer0JyRDV5pxvCr9yWXNv2Fy21H9kcWU76hG8sNDD0vLhTRjQfZ/b3A261+l
T9AC6GhptlzymD+/yX7pMw21OwJSfWkIFrZbrEHO5nbQcp7gjOqRcBdK4whTfbUa
P1PUeBtiTXtM7EqZGit8
=AFyS
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
