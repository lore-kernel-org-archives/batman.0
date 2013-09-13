Return-Path: <antonio@meshcoding.com>
Date: Fri, 13 Sep 2013 13:52:59 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130913115259.GB896@neomailbox.net>
References: <1378391941-6018-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <1378391941-6018-1-git-send-email-marco.dallato@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7] batctl: add sys framework for VLAN
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


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2013 at 04:39:01PM +0200, Marco Dalla Torre wrote:
> Allow the batctl tool to take advantage of changes from commit
> e4ff5c153dab054a6cd1c4132f87bc5e77127456 "add sys framework for VLAN"
> recently added to batman-adv, so that users can execute commands in
> a per VLAN fashion.
>=20
> If no directory entry corresponding to the user-selected device is found
> at the standard location for non VLAN interfaces
> (/sys/class/net/${device}/mesh/), 'batctl' now looks into directory:
>      /sys/devices/virtual/net/${base_device}/mesh/vlan${vid}
> Information on VLAN devices (base device, vid) necessary to construct the
> directory path is acquired by parsing /proc/net/vlan/${device}.
> Where:
>     -${base_device}: the batman device on top of which the VLAN is sitting
>     -${device}: the device interface for the VLAN,
>     -${vid}: the identifier assigned to the VLAN.
>=20
> If the user-selected command is not supported by the VLAN, an appropriate
> error is shown.
>=20
> Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>

I did a quick test and I realise that if the specified interface does not e=
xist
the result is:

# batctl -m bat1 ap
Error - could not open file '/proc/net/vlan/bat1': No such file or directory

Did we agree on printing another message here? (At least I think this was t=
he
intention?)

The rest seems to be working fine! good job!

Cheers,


> ---
> Notable changes in V7
> -fixed missing variable initialization
> -changed free & malloc to realloc
> -fixed various styling issues
> -removed unrelated changes
>=20
> Notable changes in V6
> -fixed error in string length computation
> -moved some more variable declarations at the beginning of functions=20
>=20
> Notable changes in V5
> -fixed use of sizeof instead of strlen to compute length of string
> -use of getline instead of fgets
> -avoid using fixed-size buffer in 'get_basedev_vid'
> -moved constant string declarations, local to functions 'get_basedev_vid'
>  and 'handle_sys_setting', from sys.c to sys.h. Now uses #define like
>  other path declarations.
> -fixed scanf error condition check
> -fixed malloc error condition check
> -moved variable declarations at the beginning of functions
>=20
>  functions.c  |  3 +++
>  main.c       |  2 +-
>  man/batctl.8 |  4 ++--
>  sys.c        | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  sys.h        |  3 +++
>  5 files changed, 84 insertions(+), 3 deletions(-)
>=20
> diff --git a/functions.c b/functions.c
> index cc05a48..ed010ea 100644
> --- a/functions.c
> +++ b/functions.c
> @@ -135,6 +135,9 @@ static void file_open_problem_dbg(char *dir, char *fn=
ame, char *full_path)
>  			fprintf(stderr, "Error - the folder '/sys/' was not found on the syst=
em\n");
>  			fprintf(stderr, "Please make sure that the sys filesystem is properly=
 mounted\n");
>  			return;
> +		} else if (strstr(dir, "/sys/devices/virtual/")) {
> +			fprintf(stderr, "The selected feature '%s' is not supported for vlans=
\n", fname);
> +			return;
>  		}
>  	}
> =20
> diff --git a/main.c b/main.c
> index 24d42fb..bac37ca 100644
> --- a/main.c
> +++ b/main.c
> @@ -49,7 +49,7 @@ void print_usage(void)
> =20
>  	fprintf(stderr, "Usage: batctl [options] command|debug table [parameter=
s]\n");
>  	fprintf(stderr, "options:\n");
> -	fprintf(stderr, " \t-m mesh interface (default 'bat0')\n");
> +	fprintf(stderr, " \t-m mesh interface or mesh-based VLAN interface (def=
ault 'bat0')\n");
>  	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table=
> -h' for the parameter help)\n");
>  	fprintf(stderr, " \t-v print version\n");
>  	fprintf(stderr, "\n");
> diff --git a/man/batctl.8 b/man/batctl.8
> index d04385b..b45cccf 100644
> --- a/man/batctl.8
> +++ b/man/batctl.8
> @@ -42,7 +42,7 @@ behaviour or using the B.A.T.M.A.N. advanced protocol.
>  .SH OPTIONS
>  .TP
>  .I \fBoptions:
> -\-m     specify mesh interface (default 'bat0')
> +\-m     specify mesh interface or a mesh-based VLAN interface (default '=
bat0')
>  .br
>  \-h     print general batctl help
>  .br
> @@ -61,7 +61,7 @@ originator interval. The interval is in units of millis=
econds.
>  .br
>  .IP "\fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
>  If no parameter is given the current ap isolation setting is displayed. =
Otherwise the parameter is used to enable or
> -disable ap isolation.
> +disable ap isolation. This command can be used in conjunction with "-m" =
option to target per VLAN configurations.
>  .br
>  .IP "\fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
>  If no parameter is given the current bridge loop avoidance setting is di=
splayed. Otherwise the parameter is used to enable
> diff --git a/sys.c b/sys.c
> index b1d7ea8..517be03 100644
> --- a/sys.c
> +++ b/sys.c
> @@ -371,11 +371,63 @@ static void settings_usage(int setting)
>  	fprintf(stderr, " \t -h print this help\n");
>  }
> =20
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
> +	char *line_ptr =3D NULL;
> +	size_t len;
> +	FILE *fp;
> +	int size =3D strlen(PROC_VLAN_PATH) + strlen(mesh_iface) + 1;
> +	char *fpath =3D malloc(size);
> +
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
> +	if (fscanf(fp, "%ms VID: %hu", &vdev, vid) !=3D 2)
> +		return EXIT_FAILURE;
> +
> +	*base_dev =3D NULL;
> +	while (getline(&line_ptr, &len, fp) !=3D -1) {
> +		if (sscanf(line_ptr, "Device: %ms", base_dev) =3D=3D 1)
> +			break;
> +	}
> +	fclose(fp);
> +	free(line_ptr);
> +	/* handle base device not found case */
> +	if (!*base_dev)
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
> @@ -392,6 +444,29 @@ int handle_sys_setting(char *mesh_iface, int setting=
, int argc, char **argv)
>  	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
>  	path_buff[PATH_BUFF_LEN - 1] =3D '\0';
> =20
> +	if (access(path_buff, F_OK) !=3D 0) {
> +		if (errno =3D=3D ENOENT) {
> +			/* path does not exist, no lan interface: check vlan */
> +			if (get_basedev_vid(mesh_iface, &base_dev, &vid) =3D=3D EXIT_FAILURE)
> +				return EXIT_FAILURE;
> +
> +			path_length =3D strlen(SYS_VLAN_PATH) +
> +				      strlen(base_dev) +
> +				      VLAN_ID_MAX_LEN + 1;
> +			path_buff =3D realloc(path_buff, path_length);
> +			if (!path_buff) {
> +				fprintf(stderr, "Error - could not allocate path buffer: out of memo=
ry ?\n");
> +				return EXIT_FAILURE;
> +			}
> +			snprintf(path_buff, path_length, SYS_VLAN_PATH,
> +				base_dev, vid);
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
> diff --git a/sys.h b/sys.h
> index a588e0b..f5df845 100644
> --- a/sys.h
> +++ b/sys.h
> @@ -30,6 +30,9 @@
>  #define SYS_IFACE_DIR SYS_IFACE_PATH"/%s/"
>  #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
>  #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
> +#define PROC_VLAN_PATH "/proc/net/vlan/"
> +#define SYS_VLAN_PATH "/sys/devices/virtual/net/%s/mesh/vlan%d/"
> +#define VLAN_ID_MAX_LEN 4
> =20
>  enum batctl_settings_list {
>  	BATCTL_SETTINGS_ORIG_INTERVAL,
> --=20
> 1.8.3.2

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSMvybAAoJEADl0hg6qKeOCSQQAI0SVb8qM6U5wKWg1KhBpHea
czjuzSaDDI1oy+2vQOq25GLQR91PaJtD86Gb1eg9pDZipAgW/RYMuNCTkrA1G8Kd
7rxYj/9GqncdGLfNasnLsv6XCaZ5WH23HApom4USfHlCnQkSU+x1jRylRtCFR7LS
2r8fMuKqYLv7850O8UW53xE/srxccs7mrBHFyuX08OsjpxlXfJv2uECj0759fzJg
VU1NMijbHVo/V8eRIH97ncnhfQrAgwT42tTWKBc3LorTCPGwdyPfkOSbqeq9j4pl
bArT7CCflhUHUecA7AdS0Ub5Xv9QZt/xfWeJLHtsvZyyEWA/we3s9LKlA+aMerEf
2MVsQwI8i5FDSVH6xeRisod3oi2yFib239AOikHgFxXaA992llddAEMZ1KQThBBA
5Hc8WxVWS2zQOVRLGAOD1uyxfY2AZb1Oc3TeZOG7BY0hZxkZzztBYdG8KQk0cmIJ
V7yYU/TYCpiZjg51DEFBPZ4auerNfteAhHFjl16ahnWAVNwVnnqqV4Txo/aSxdMK
sorLXlJozCn6qg9w0h3zVcjKn3CzfrRRgi9FigxBBIQYYhjNsBy6EI6YoFHjTXPp
tgCaKslMxjb5Ymya/igBSPRvUTsebRbXAvpU7hN58jB+EdkTLGqUdY7s5nYNv0M6
9deDECrwXlfcJaR7d5WY
=9Y4F
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
