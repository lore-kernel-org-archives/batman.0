Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 1 Jan 2010 17:56:19 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100101165619.GD16855@pandem0nium>
References: <20091231033955.GB18781@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20091231033955.GB18781@Sellars>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: No deact of
	aggregation	on wrong input
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

thank you for the patch, applied with minor style changes in svn revision 1=
528.

best regards,
	Simon

On Thu, Dec 31, 2009 at 04:39:55AM +0100, =3D?UTF-8?q?Linus=3D20L=3DC3=3DBC=
ssing?=3D wrote:
> A non-integer changes the aggregation mode. Therefore this patch changes
> the behaviour to explicitly check strict_strtoul()'s return code.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  proc.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/proc.c b/proc.c
> index e7b7bf3..232efe3 100644
> --- a/proc.c
> +++ b/proc.c
> @@ -433,6 +433,7 @@ static ssize_t proc_aggr_write(struct file *file, con=
st char __user *buffer,
>  	char *aggr_string;
>  	int not_copied =3D 0;
>  	unsigned long aggregation_enabled_tmp;
> +	int retval;
> =20
>  	aggr_string =3D kmalloc(count, GFP_KERNEL);
> =20
> @@ -442,22 +443,21 @@ static ssize_t proc_aggr_write(struct file *file, c=
onst char __user *buffer,
>  	not_copied =3D copy_from_user(aggr_string, buffer, count);
>  	aggr_string[count - not_copied - 1] =3D 0;
> =20
> -	strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
> +	retval =3D strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
> =20
> -	if ((aggregation_enabled_tmp !=3D 0) && (aggregation_enabled_tmp !=3D 1=
)) {
> +	if (retval =3D=3D -EINVAL || aggregation_enabled_tmp > 1) {
>  		printk(KERN_ERR "batman-adv:Aggregation can only be enabled (1) or dis=
abled (0), given value: %li\n", aggregation_enabled_tmp);
> -		goto end;
> +	}
> +	else {
> +		printk(KERN_INFO "batman-adv:Changing aggregation from: %s (%i) to: %s=
 (%li)\n",
> +		       (atomic_read(&aggregation_enabled) =3D=3D 1 ?
> +			"enabled" : "disabled"),
> +		       atomic_read(&aggregation_enabled),
> +		       (aggregation_enabled_tmp =3D=3D 1 ? "enabled" : "disabled"),
> +		       aggregation_enabled_tmp);
> +		atomic_set(&aggregation_enabled, (unsigned)aggregation_enabled_tmp);
>  	}
> =20
> -	printk(KERN_INFO "batman-adv:Changing aggregation from: %s (%i) to: %s =
(%li)\n",
> -	       (atomic_read(&aggregation_enabled) =3D=3D 1 ?
> -		"enabled" : "disabled"),
> -	       atomic_read(&aggregation_enabled),
> -	       (aggregation_enabled_tmp =3D=3D 1 ? "enabled" : "disabled"),
> -	       aggregation_enabled_tmp);
> -
> -	atomic_set(&aggregation_enabled, (unsigned)aggregation_enabled_tmp);
> -end:
>  	kfree(aggr_string);
>  	return count;
>  }
> --=20
> 1.6.5.7
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks+KTMACgkQrzg/fFk7axZexACgnzbk7b/XotTAREyW7lJX3uk9
8L4AoMJdCYn0MWmzmWpl1977wp4zP944
=fGbp
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
