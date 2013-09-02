Return-Path: <ordex@autistici.org>
Date: Mon, 2 Sep 2013 09:03:17 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130902070317.GF1871@ritirata.org>
References: <201308292018.28480.lindner_marek@yahoo.de>
 <1377801814-28182-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <1377801814-28182-1-git-send-email-marco.dallato@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: add sys framework for VLAN
 support
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


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2013 at 08:43:34PM +0200, Marco Dalla Torre wrote:
>=20
> *sorry for messing up format in previous message, re-sending*

This message should not be here, otherwise it will get included in the comm=
it
messages. Any out of band message should go immediately after the ---.

>=20
> Allow the batctl tool to take advantage of changes from commit
> e4ff5c153dab054a6cd1c4132f87bc5e77127456 ("add sys framework for VLAN")
> recently added to batman-adv, so that users can execute commands in
> a per VLAN fashion.
>=20
> If no directory entry corresponding to the user-selected device is found
> at the standard location for non VLAN interfaces
> (/sys/class/net/${base_device}), 'batctl' now looks into directory:
>      /sys/devices/virtual/net/${base_device}/mesh/vlan${vid}
> Where:
>     -${base_device}: the batman device on top of which the VLAN is sitting
>     -${device}: the device interface for the VLAN,

${device} ? I don't see it in the text.

>     -${vid}: the identifier assigned to the VLAN.
>=20
> Information on VLAN devices (base device, vid) necessary to construct the
> directory path is acquired by parsing /proc/net/vlan/${device}.

Ah it is here..what about moving the description below?

>=20
> If the user-selected command is not supported by the VLAN, an appropriate
> error is shown.
>=20
> Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
> ---
>  functions.c  |  3 +++
>  main.c       |  2 +-
>  man/batctl.8 |  2 +-
>  sys.c        | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 2 deletions(-)
>=20
> diff --git a/sys.c b/sys.c
> index b1d7ea8..00d2ed1 100644
> --- a/sys.c
> +++ b/sys.c
> @@ -371,6 +371,37 @@ static void settings_usage(int setting)
>  	fprintf(stderr, " \t -h print this help\n");
>  }
> =20
> +int get_basedev_vid(char *mesh_iface, char **base_dev, unsigned short *v=
id)
> +{
> +	char *vdev;
> +	char line[100];
> +	const char path[] =3D "/proc/net/vlan/";
> +	int size =3D sizeof(path) + sizeof(mesh_iface);
> +	FILE *fp =3D NULL;
> +
> +	char *fpath =3D malloc(size);
> +	strcpy(fpath, path);
> +	/* prepare path file path: /proc/net/vlan/$mesh_iface*/
> +	strcat(fpath, mesh_iface);

I think I asked you before: why don't you use a unique (and more clear) snp=
rintf
here rather than one strcpy and one strcat ?

> +
> +	fp =3D fopen(fpath, "r");
> +	if (fp =3D=3D NULL)
> +		return 1;
> +
> +	if (fscanf(fp, "%ms %*s %hu %*s %*d %*s %*d", &vdev, vid) =3D=3D 0)
> +		return 0;
> +
> +	while (fgets(line, sizeof(line), fp) !=3D NULL) {
> +		if (sscanf(line, "Device: %ms", base_dev) =3D=3D 1)
> +			break;
> +	}
> +	/* handle base device not found case */
> +	if (*base_dev =3D=3D NULL)
> +		return 0;
> +
> +	return 1;
> +}

The return value of this function is not clear: you return 1 both on error =
(if
fp =3D=3D NULL) and on success (at the end). I'd suggest you fix this and t=
o rather
use -1 for error and 0 on success (like standard unix processes/c functions=
).

Please, provide a comment on top of this function describing what it does, =
what
do its parameters mean and what it returns. For example of the style to use=
 you
can have a look at most of the functions in the batman-adv kernel module (t=
his
is the so called kernel-doc). It makes much easier to understand functions.


> +
>  int handle_sys_setting(char *mesh_iface, int setting, int argc, char **a=
rgv)
>  {
>  	int optchar, res =3D EXIT_FAILURE;
> @@ -392,6 +423,26 @@ int handle_sys_setting(char *mesh_iface, int setting=
, int argc, char **argv)
>  	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
>  	path_buff[PATH_BUFF_LEN - 1] =3D '\0';
> =20
> +	if (access(path_buff, F_OK) !=3D 0) {
> +		if (errno =3D=3D ENOENT) {
> +			/* path does not exist, no lan interface: check vlan */
> +			unsigned short vid =3D 0;
> +			char *base_dev =3D NULL;
> +			if (get_basedev_vid(mesh_iface, &base_dev, &vid) =3D=3D 1) {
> +				free(path_buff);
> +				char sys_vlan_path[] =3D
> +					"/sys/devices/virtual/net/%s/mesh/vlan%d/";
> +				int size =3D sizeof(sys_vlan_path) + sizeof(base_dev);
> +				path_buff =3D malloc(size);
> +				sprintf(path_buff, sys_vlan_path, base_dev, vid);
> +			}
> +		} else if (errno =3D=3D ENOTDIR) {
> +			/* not a directory, something wrong here */
> +			fprintf(stderr, "Error - expected directory at '%s'\n",
> +				path_buff);

I'd rather change this message to something different: ENOTDIR tells you th=
at
something inside the pathname is not a dire while it was supposed to be suc=
h.
E.g. /a/b/c/d -> ENOTDIR is set if one of a, b or c is NOT a directory. d i=
s the
file you want to access so that is not checked. This is what "man access" s=
ays.


Thanks!

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSJDg1AAoJEADl0hg6qKeOxXAP/iX5R9EVQBRj5Wn1+od6OGmh
nitQwLtdYYayUUc1juHAtfGxucJIWrENYKQQ16ajGORoYc0Xt+Xwy0hHS9kCRO7R
590Qfd43o5iDFre98kH+kPIsek2c4vvoC0mVhaAVhchy9URDg/jliU9nKZLdPr7M
ppsS0BFDCxLJYdOZymd1EfHqGQZbvDQvZVknmuzk8Cayf/G/czvB1IfYCdOBjDho
iw48bHr5d11KPMOpDuRtSo0kIbScS/xeewjMgKGra85pEpWo59XviiJlCj8qiZko
i0m++LMUH3Wtb0qtp26PCO0wPFtpmkiiV9FZSbAVXZ9z3kJDeFHDXh3bWUGirsW7
nhLM6f2NF+AynZZ1iu8HF3395LSpycVt6/dSSzpmwip2zMwHwfdwe9BWZqGLUjIT
Uoretue6MabXNfwAqw6qOGwYoFJqmd/vRfZ3fyXQNSRFaiw6vH4Pow00rdPWuVCY
4ivP+Q8trWcHgX5rdzwPf2BY9nz4Guf5KSNKaA5PhMgyA+fiJUysvKw8wpUvrolt
KO1EEogCwXk7/7a7//fTskp6xg9VudVEYeLLnfdObLiJUOc28vqBLEDs7dQexyzP
sbZGw49xqiZDJd3x8Nhoo+NAp7SDRkfMBr954UJ1ZW6p3t5KyaeNELz09rEHPOd9
IXnQ7vV1vgg5lQ0SUJeA
=37HM
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
