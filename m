Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 5 Jun 2010 19:47:48 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100605174748.GB9284@pandem0nium>
References: <20100603100437.GS5483@bicker>
	<1275564807-8725-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <1275564807-8725-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: return -EFAULT
	on	copy_to_user errors
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


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you, applied in svn r1689.

On Thu, Jun 03, 2010 at 01:33:27PM +0200, Sven Eckelmann wrote:
> From: Dan Carpenter <error27@gmail.com>
>=20
> copy_to_user() returns the number of bites remaining but we want to
> return a negative error code here.
>=20
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> [sven.eckelmann@gmx.de: Move change from device.c to icmp_socket.c]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  This patch is already applied in maint and must be applied in master.
>=20
>  batman-adv-kernelland/icmp_socket.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/icmp_socket.c b/batman-adv-kernelland/=
icmp_socket.c
> index bad87fd..08cca22 100644
> --- a/batman-adv-kernelland/icmp_socket.c
> +++ b/batman-adv-kernelland/icmp_socket.c
> @@ -148,7 +148,7 @@ static ssize_t bat_socket_read(struct file *file, cha=
r __user *buf,
>  	kfree(socket_packet);
> =20
>  	if (error)
> -		return error;
> +		return -EFAULT;
> =20
>  	return packet_len;
>  }
> --=20
> 1.7.1
>=20
>=20

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwKjcQACgkQrzg/fFk7axZ+OgCfRwCnUmDHg88yHSRktB1OsBXH
HQ0AoIH2O5q6wr4THfhNO3XQo9bKerJi
=WC0v
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
