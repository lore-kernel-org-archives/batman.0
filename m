Return-Path: <ordex@autistici.org>
Date: Wed, 28 Aug 2013 17:05:23 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130828150523.GH2896@ritirata.org>
References: <y>
 <521C9BB4.2010306@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <521C9BB4.2010306@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add sys framework for VLAN
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


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 02:29:40PM +0200, Marco Dalla Torre wrote:
> Version 2 - code style fixes

Next time, specify the version of the patch in the subject, e.g. [PATCHv2].

>=20
> If no directory entry corresponding to the user-selected device is found=
=20
> at the
> standard location for non VLAN interfaces (/sys/class/net/${base_device}),
> 'batctl' now looks into directory:
>       /sys/devices/virtual/net/${base_device}/mesh/vlan${vid}
> Where:
>      -${base_device}: the batman device on top of which the VLAN is sitti=
ng
>      -${device}: the device interface for the VLAN,
>      -${vid}: the identifier assigned to the VLAN.
>=20
> Information on VLAN devices (base device, vid) necessary to construct the
> directory path is acquired by parsing /proc/net/vlan/${device}.
>=20
> If the user-selected command is not supported by the VLAN, an appropriate
> error is shown.

good explanation of how it works, thanks, but in the commit message you sho=
uld
state in a few lines what this change is bringing.
It is not clear what the new feature is from what you wrote. Don't you thin=
k the
same?

Then a Signed-off-by line is missing. The patch cannot be accepted without =
it :)

> ---
>   functions.c |  3 +++
>   sys.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
>=20
> diff --git a/functions.c b/functions.c
> index cc05a48..ed010ea 100644
> --- a/functions.c
> +++ b/functions.c
> @@ -135,6 +135,9 @@ static void file_open_problem_dbg(char *dir, char=20
> *fname, char *full_path)
>   			fprintf(stderr, "Error - the folder '/sys/' was not found on the=20
> system\n");
>   			fprintf(stderr, "Please make sure that the sys filesystem is=20
> properly mounted\n");
>   			return;
> +		} else if (strstr(dir, "/sys/devices/virtual/")) {
> +			fprintf(stderr, "The selected feature '%s' is not supported for=20
> vlans\n", fname);
> +			return;
>   		}
>   	}
>   diff --git a/sys.c b/sys.c
> index b1d7ea8..942ead0 100644
> --- a/sys.c
> +++ b/sys.c
> @@ -371,6 +371,37 @@ static void settings_usage(int setting)
>   	fprintf(stderr, " \t -h print this help\n");
>   }
>   +int get_basedev_vid(char *mesh_iface, char **base_dev, unsigned short=
=20
> *vid)

please put a short comment on top of the function explaining what it does a=
nd
what it returns. This way it is easier to re-use it in the future.

> +{
> +	char *vdev;
> +	char line[100];
> +	const char path[] =3D "/proc/net/vlan/";
> +	int size =3D sizeof(path) + sizeof(mesh_iface);

be careful here: mesh_iface is a char*, sizeof(mesh_iface) will give you the
size of the pointer, not the length of the string. Did you mean strlen() ?
sizeof() works as you expected only for fixed size arrays (e.g. path[]).

> +	FILE *fp =3D NULL;

This doe snot need to be initialised...(it's just a minor remark..)

> +
> +	char *fpath =3D malloc(size);
> +	strcpy(fpath, path);
> +	/* prepare path file path: /proc/net/vlan/$mesh_iface*/
> +	strcat(fpath, mesh_iface);

why not directly using one call to sprintf() to compose the fpath? I think =
it is
also easier to read, no?

> +
> +	fp =3D fopen(fpath, "r");
> +	if (fp =3D=3D NULL)
> +		return 1;

Is this a "success" or a "failure"? At the beginning I thought it was a fai=
lure,
but then I saw you return 1 also at the very end, which is a success...
what about returning 0 on success and -1 on failure and keep this behaviour=
 all
over? or is there a particular reason for returning 1 here?

> +
> +	if (fscanf(fp, "%ms %*s %hu %*s %*d %*s %*d", &vdev, vid) =3D=3D 0)
> +		return 0;
> +
> +	while (fgets(line, sizeof(line), fp) !=3D NULL) {
> +		if (sscanf(line, "Device: %ms", base_dev) =3D=3D 1)
> +			break;
> +	}
> +	// handle base device not found case

Use C standard comments please: /* like this */

> +	if (*base_dev =3D=3D NULL)

I know there are some spots in the code where this has been done already...=
=2Ebut
don't you think it is clearer if you do transform the check above in:

if (!*base_dev)

? (this applies to the fp check above too).

> +		return 0;
> +
> +	return 1;
> +}
> +
>   int handle_sys_setting(char *mesh_iface, int setting, int argc, char=20
> **argv)
>   {
>   	int optchar, res =3D EXIT_FAILURE;
> @@ -392,6 +423,26 @@ int handle_sys_setting(char *mesh_iface, int=20
> setting, int argc, char **argv)
>   	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
>   	path_buff[PATH_BUFF_LEN - 1] =3D '\0';
>   +	if (access(path_buff, F_OK) !=3D 0) {

explicitly check for < 0 not !=3D. The man says that -1 is returned in case=
 of
error. In the future it could be possible that positive values are used for
other purposes, so better to literally stick to what the man says.


> +		if (errno =3D=3D ENOENT) {
> +			// path does not exist, no lan interface: check vlan

comment style

> +			unsigned short vid =3D 0;
> +			char *base_dev =3D NULL;

please declare all the variables at the top of the function. This helps to =
avoid
erroneous variable hiding in future changes.

> +			if (get_basedev_vid(mesh_iface, &base_dev, &vid) =3D=3D 1) {

to reduce the indentation here you could revert the condition and then chan=
ge
the value of res and "goto out;" if true.

In this way the code following can have one tab less. This is an hint to re=
duce
indentation and make the code less difficult to read (this is something we =
were
discussing offline)

> +				free(path_buff);
> +				char sys_vlan_path[] =3D "/sys/devices/virtual/net/%s/mesh/vlan%d/";
> +				int size =3D sizeof(sys_vlan_path) + sizeof(base_dev);

same for these vars (move to the top)

You can also define constants like this using a define at the top of the fi=
le. This
helps to easily change them (if needed) later and make the code nicer :)

> +				path_buff =3D malloc(size);
> +				sprintf(path_buff, sys_vlan_path, base_dev, vid);
> +			}
> +		}
> +		if (errno =3D=3D ENOTDIR) {
> +			// not a directory, something wrong here
> +			fprintf(stderr, "Error - expected directory at '%s'\n",
> +				path_buff);
> +			return EXIT_FAILURE;

you have to goto out here, otherwise we have a memory leak due to path_buff
being not free'd. I'd suggest to change res and goto out;

> +		}
> +	}
>   	if (argc =3D=3D 1) {
>   		res =3D read_file(path_buff, (char *)batctl_settings[setting].sysfs_n=
ame,
>   				NO_FLAGS, 0, 0, 0);
> --=20
> 1.8.3.2
>=20


Nice job so far :-) For being your first patch this is for sure a good one!

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSHhGzAAoJEADl0hg6qKeOAsgQAKb7eaI1qmb66Wf0oUf9tIrn
1SHBEQJ7KSmz2jf6PEGDhP8gyZc+UY/nmmpBL0Cae1fwDO+LISwfdVsqcE4UnsG6
y6TmPhzp+7XwN332ymGeScS0TuHkYLA1p0SG2LyzJsv1rVFaYsjMINTZRa+HQ27T
hv0iXKqEVEHS4xA8I/8ltc6shNB3OZwAmKrh0fpMSIqAz2tCdmxUZd0WU2OT2Qho
BOT602THL9xLaJP/ny1EzFLSCdxpcEcIpxWrrKjjWCuvk5Qs7/A/XhCvUIWtOBFC
7gwG29zXzPUzOxPzrIAlczTP/8eaG6gfQjHCH5gP2fP6mT6OD0OuPzDGs3pIG2l3
poV92yMmBk7jmO5oLEkUbtgDx4igrI5P5b6fD8yFsqQ7iBBksYtV00cObgSIOfZt
FSvi2JrIMAzuTqMsC5I6HYdvMIymkfpM+60YSyvCgy7vKosbmJFWaBjsl4F8aupI
L8vMI8/SfennRbqM6zP0+99MDGlz/EhYQKtrO+rXHy+eWvgUaZF5TylbBp8UKWWh
si8x8JprXNi8jPvl1x3w+nbJUBUiYq9w/4cabsr5LmTCgC0EPt1vHcNB7a2J1vmP
fvkTYsd2a4kltaMGjDZ9UkdKAMVVlfQAhAiQ70LSiWpOjl/RyU858cC7Vo9OpdVb
vME3l9zPQDgIqheCNTf4
=jfBA
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
