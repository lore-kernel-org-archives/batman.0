Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 18 Jun 2010 22:04:51 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100618200451.GA17684@pandem0nium>
References: <1276883644-3828-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1276883644-3828-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: permit setting ogm
	interval	to JITTER*2
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


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Linus, applied in r1701.

On Fri, Jun 18, 2010 at 07:54:04PM +0200, Linus L=C3=BCssing wrote:
> When trying to set the originator interval to 40ms, we are asked to set
> it to a minimum value of 40ms. This patch permits setting an
> originator interval of JITTER*20 (40ms by default) now.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  bat_sysfs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/bat_sysfs.c b/bat_sysfs.c
> index 05703c1..68ce453 100644
> --- a/bat_sysfs.c
> +++ b/bat_sysfs.c
> @@ -259,7 +259,7 @@ static ssize_t store_orig_interval(struct kobject *ko=
bj, struct attribute *attr,
>  		return -EINVAL;
>  	}
> =20
> -	if (orig_interval_tmp <=3D JITTER * 2) {
> +	if (orig_interval_tmp < JITTER * 2) {
>  		printk(KERN_INFO "batman-adv:New originator interval too small: %li (m=
in: %i)\n",
>  		       orig_interval_tmp, JITTER * 2);
>  		return -EINVAL;
> --=20
> 1.7.1
>=20
>=20

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwb0WMACgkQrzg/fFk7axZ5jACfWoeBxaJiyJ1djqMMUB1/0ZKC
ruYAnRluDgYa61YJQAXdRHZFipAodl8G
=x0o9
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
