Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 23 Oct 2010 17:19:21 +0200
References: <1287846695-17402-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1287846695-17402-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1897570.duAHV5ARoZ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010231719.23353.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete flags
	variable to avoid kernel warnings
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1897570.duAHV5ARoZ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  batman-adv/bat_debugfs.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
> index 11e5f65..934c879 100644
> --- a/batman-adv/bat_debugfs.c
> +++ b/batman-adv/bat_debugfs.c
> @@ -57,7 +57,6 @@ static int fdebug_log(struct debug_log *debug_log, char
> *fmt, ...) va_list args;
>  	static char debug_log_buf[256];
>  	char *p;
> -	unsigned long flags;
>=20
>  	if (!debug_log)
>  		return 0;
> @@ -113,7 +112,6 @@ static ssize_t log_read(struct file *file, char __user
> *buf, struct debug_log *debug_log =3D bat_priv->debug_log;
>  	int error, i =3D 0;
>  	char c;
> -	unsigned long flags;
>=20
>  	if ((file->f_flags & O_NONBLOCK) &&
>  	    !(debug_log->log_end - debug_log->log_start))

Correct. Forgot them because I only build it in non-debug mode.

Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

--nextPart1897570.duAHV5ARoZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMwvz6AAoJEF2HCgfBJntGLzwP/3ytqQ/4ZWqrIgQqeK6YlL2W
IkjL1eSy06KLv0gaJX+VCqwmyhIwyTVK7nuRYHi8+FAtC2o5uifzClI3DVWYN6Tu
M0R/IHjjnEwz3Y4stx4XY3lagHutzS9Z+2HPMy+0GwkK2PKfqtjMjbnsK7dL6eUL
Hs5Aco/iIv1daox/ukyIgfVKfAjeEyNP4etqKgfT95GVmhQoo+vKzUVQTa8kdQfi
Fev3vb1bSC7/NuBnE8DYaE04d+Ejql/L1/E4GymEy0UVAxdlTFwAN19QYqD7Wj0c
ammWLZ5D7rmSmxbkMogsEKeumNykcah5aEmCho/CIyJkJE5Et6rUPbifaMP7mWYD
H6xafR308GTntEwSlh6mJ5nE4LRteB8X+FB4iEf1CjDPVwc/QcwQBAJU4H61XU6P
RypZ9NOXpEgE3SIMhuthN0kmGCrNzJ80DPaTvF2+Cyj2CsBdJuV7osr6zXoCojd5
8mO/BiawiSy7EywIMpDFajdY1b26Jl2Z7hZwya4Bwj0/ftQ2hlW1gj/JcEGJbStd
WJuWeIn0mXy2VfB4H6T88jMtcZDrBKCDnibOI9J2EQU7psZShlamOBG9IkvLegPr
imNDaqBaCg6yZFO5yGane6qZBXeCyzid5a1lCNHxPBylLpeWsWfjPEWKXjZWNHD2
k50+Fa6YB6RZUWur7/uz
=kyXq
-----END PGP SIGNATURE-----

--nextPart1897570.duAHV5ARoZ--
