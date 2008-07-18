Date: Fri, 18 Jul 2008 13:47:32 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Don't process the icmp packet further when
	we could not read it
Message-ID: <20080718114732.GA28639@hrz.tu-chemnitz.de>
References: <20080718111828.GA30595@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20080718111828.GA30595@sven-desktop.lazhur.ath.cx>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sven,

thanks for the patches! Both of them look good so i applied them. By the
way, if anyone knows something like "git am" for svn (applying patches
directly from a mailbox), please tell me. :D

regards,
	Simon

On Fri, Jul 18, 2008 at 01:18:28PM +0200, Sven Eckelmann wrote:
> __copy_from_user returns the number of bytes it could not read when it
> fails. It makes no sense to process the data further if we don't have it
> in a complete form.
> access_ok will only check if it may be valid but not if it is definitly v=
alid.
>=20
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  batman-adv-kernelland/batman-core/device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/batman-core/device.c b/batman-adv-kern=
elland/batman-core/device.c
> index 6608f13..c401634 100644
> --- a/batman-adv-kernelland/batman-core/device.c
> +++ b/batman-adv-kernelland/batman-core/device.c
> @@ -229,7 +229,9 @@ ssize_t bat_device_write(struct file *file, const cha=
r __user *buff, size_t len,
>  	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
>  		return -EFAULT;
> =20
> -	__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet));
> +	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet))) {
> +		return -EFAULT;
> +	}
> =20
>  	if ((icmp_packet.packet_type =3D=3D BAT_ICMP) && (icmp_packet.msg_type =
=3D=3D ECHO_REQUEST)) {
> =20
> --=20
> 1.5.6.3
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIgILUrzg/fFk7axYRAsiIAJ48Utqf9qOhDznri5UGQOLcI+PQMgCgnPla
jVyA2X/CJd9TgcRhS0U1BgA=
=3kyb
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
