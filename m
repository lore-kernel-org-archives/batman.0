Return-Path: <ordex@autistici.org>
Date: Thu, 5 Sep 2013 15:15:05 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130905131505.GD1570@ritirata.org>
References: <1378383407-13460-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <1378383407-13460-1-git-send-email-marco.dallato@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6] batctl: add sys framework for VLAN
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


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2013 at 02:16:47PM +0200, Marco Dalla Torre wrote:
> +/**
> + * get_basedev_vid - given a valid VLAN interface, identifies the batman=
 device
> + *	on top of which the VLAN is sitting and its VLAN ID
> + * @mesh_iface: name of the VLAN network interface
> + * @base_dev: output argument, pointer to the base device name
> + * @vid: output argument, pointer to the VLAN ID number
> + *
> + * Returns 0 if execution is successful, -1 if an error occurred
> + */
> +static int get_basedev_vid(const char *mesh_iface, char **base_dev, unsi=
gned short *vid)
> +{
> +	char *vdev;
> +	char *line_ptr;
> +	size_t len;
> +	FILE *fp;
> +	char *fpath;
> +
> +	int size =3D strlen(PROC_VLAN_PATH) + strlen(mesh_iface) + 1;
> +	fpath =3D malloc(size);

the declaration of "size" should not be separated from the others. The blan=
k line
should go after "int size =3D ..." not before.


> +	if (!fpath) {
> +		fprintf(stderr, "Error - could not allocate path buffer: out of memory=
 ?\n");
> +		return EXIT_FAILURE;
> +	}
> +	/* prepare path file path: /proc/net/vlan/$mesh_iface*/
> +	snprintf(fpath, size, "%s%s", PROC_VLAN_PATH, mesh_iface);
> +
> +	fp =3D fopen(fpath, "r");
> +	if (!fp) {
> +		fprintf(stderr, "Error - could not open file '%s': %s\n",
> +			fpath, strerror(errno));
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (fscanf(fp, "%ms %*s %hu %*s %*d %*s %*d", &vdev, vid) !=3D 2)

this is ok, but as I suggested in chan I think you can force the shape of t=
he
strings you want to skip, e.g. "%ms VID: %hu". In this way you are sure to =
be
matching the line you were looking for, no? I think we can assume that the =
file
you are reading is not going to change anymore, so I leave to you the decis=
ion
of which format string to use.

> +		return EXIT_FAILURE;
> +
> +	*base_dev =3D NULL;
> +	while (getline(&line_ptr, &len, fp) !=3D -1) {

should line_ptr be initialised to NULL before invoking getline for the first
time? From the getline man:

       If  *lineptr  is NULL, then getline() will allocate a buffer for sto=
ring
       the line

therefore it is better to ensure it is NULL for real the first time.

> +		if (sscanf(line_ptr, "Device: %ms", base_dev) =3D=3D 1)
> +			break;
> +	}
> +	fclose(fp);
> +	free(line_ptr);
> +	/* handle base device not found case */
> +	if (*base_dev =3D=3D NULL)

I know in the rest of the code does something different, but we should stic=
k to
one stile (at least in the very same function), so please use (!*base_dev) =
as
you have done for fp above.

> +		return EXIT_FAILURE;
> +
> +	return EXIT_SUCCESS;
> +}
> +
>  int handle_sys_setting(char *mesh_iface, int setting, int argc, char **a=
rgv)
>  {
>  	int optchar, res =3D EXIT_FAILURE;
>  	char *path_buff;
>  	const char **ptr;
> +	unsigned short vid;
> +	char *base_dev;
> +	ssize_t path_length;
> =20
>  	while ((optchar =3D getopt(argc, argv, "h")) !=3D -1) {
>  		switch (optchar) {
> @@ -388,10 +441,40 @@ int handle_sys_setting(char *mesh_iface, int settin=
g, int argc, char **argv)
>  		}
>  	}
> =20
> -	path_buff =3D malloc(PATH_BUFF_LEN);
> -	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
> -	path_buff[PATH_BUFF_LEN - 1] =3D '\0';
> +	path_length =3D strlen(SYS_BATIF_PATH_FMT) + strlen(mesh_iface) + 1;
> +	path_buff =3D malloc(path_length);
> +	if (!path_buff) {
> +		fprintf(stderr, "Error - could not allocate path buffer: out of memory=
 ?\n");
> +		return EXIT_FAILURE;
> +	}
> +	snprintf(path_buff, path_length, SYS_BATIF_PATH_FMT, mesh_iface);

How is this change above related to your patch?
Did you introduce this change in this version?
If you want to change this, please send another patch (and maybe fix all the
other spots where this behaviour has been replicated).

> =20
> +	if (access(path_buff, F_OK) !=3D 0) {
> +		if (errno =3D=3D ENOENT) {
> +			/* path does not exist, no lan interface: check vlan */
> +			if (get_basedev_vid(mesh_iface, &base_dev, &vid) =3D=3D EXIT_SUCCESS)=
 {
> +				/* free for previous allocation */
> +				free(path_buff);
> +				path_length =3D strlen(SYS_VLAN_PATH)
> +					+ strlen(base_dev)
> +					+ VLAN_ID_MAX_LEN + 1;

freestyle indentation again?

> +				path_buff =3D malloc(path_length);

I think you can squeeze the free+malloc with one invocation to realloc()?

> +				if (!path_buff) {
> +					fprintf(stderr, "Error - could not allocate path buffer: out of mem=
ory ?\n");
> +					return EXIT_FAILURE;
> +				}
> +				snprintf(path_buff, path_length, SYS_VLAN_PATH,
> +					base_dev, vid);
> +			} else {
> +				return EXIT_FAILURE;
> +			}

This is not a mistake, but I think it is a good suggestion for you and your=
 next
patches: In case like this, where the else branch contains a single instruc=
tion
that is a return, I'd rather suggest to invert the condition in the if and
simplify the code and the indentation.
Now you have

if (A =3D=3D x) {
	bla;
	bla;
	bla;
} else {
	return B;
}

what about:

if (A !=3D x)
	return B;

bla;
bla;
bla;

This is a very frequent pattern that you will find in the kernel module. It=
 is
used to avoid indentation to grow up too much and so it makes the code easi=
er
to read. Don't you think?

> +		} else if (errno =3D=3D ENOTDIR) {
> +			/* not a directory, something wrong here */
> +			fprintf(stderr, "Error - expected directory at '%s'\n",
> +				path_buff);
> +			return EXIT_FAILURE;
> +		}
> +	}
>  	if (argc =3D=3D 1) {
>  		res =3D read_file(path_buff, (char *)batctl_settings[setting].sysfs_na=
me,
>  				NO_FLAGS, 0, 0, 0);


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSKIPZAAoJEADl0hg6qKeORH4P/0EzX2h7qMD8/H6a2dgtb597
NzoTjcL1idrXmo97jcK8pcmYlLdgsmUkQvT/pxVBbtUWwbwGPDmcFNJe3yXFhNcQ
ZT59Vuze0w8RatVA4OVEvjqtpx7NXld4LnVA7aJ/k+2FIrGGTqm4ixT2dCp2J/JM
AQkxRVA4Y5RW7U3oav8zJa2tqA5T+mC3R/8pSccTK/HH7XQmGRpnBdLLotwpQRhN
deSTkMKhvKK2VKro2TVA9X9wPOtRv/U0oyj7Y36WoJpBndi593VZ3Q1WhntwBXXo
YQ83ArK3ESqjqvOXaKzM/tiyqxN7+lA1hnIxhEurHPvYCQmkN6FzrlKMwhG4p5xE
1n7mzbvhUhi6QkYua57SDgaA2JGTSLsgynys3G0PUGp/xxVZTK2nmKK5tZmnvFjT
kutUR4pj+sonLCanz/7ssZy9PuaM9ghP8rrK4mgrD2QuIC9VzP1xGxWg0mikkzxL
RoIeCdy1wwtJcBJaRFKWxSxm8tYyH9u5yZgDZrm52LP/kCyOt31T32OIDxRgKMLu
BSa3mMtcyezcZQ795MBfxVYVTq1Hg4RYaixWv1wAhmMsMQzbyNpXE4awcMWZR61f
yrz0CMqLZlk5UQXuM73bLNnlL8/AbsBmJCWsoc2lX6O9i6f7Gt1WQdLAEw08laA7
ZqkTuxV7urJDZ7JKXoXs
=i3PM
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
