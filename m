Return-Path: <linus.luessing@web.de>
Date: Mon, 1 Mar 2010 02:51:03 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100301015103.GA6602@Linus-Debian>
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
	<1267302649-22040-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <1267302649-22040-2-git-send-email-lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: follow /proc to sysfs
 conversion & introduce input validation
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


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek!

I like :). This already looks well structured for introducing more
than one bat-interface later. On the first test, I found two
smaller issues:

Just noticed, that I don't have this /sys/devices/virtual folder
on my Debian stable VM. But I think we should be on the safe side
to use
#define SYS_BATIF_PATH "/sys/class/net/bat0/mesh/"
instead, they look equivalent and I'm having them both avaiable on
Debian stable (2.6.26 kernel) and Debian unstable (2.6.32 kernel).

The second thing is, I'm getting two harmless compile time
warnings on the Debian stable VM here:
- bat-hosts.c:79/functions.c:174: warning: implicit declaration of function
  getline

Cheers, Linus

On Sun, Feb 28, 2010 at 04:30:49AM +0800, Marek Lindner wrote:
> batman-adv is in the process of migrating to sysfs, hence batctl needs
> to adapt the file paths. In addition batctl makes use of the input
> validation support of the new files in sysfs.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  batctl/functions.c |    9 +++-
>  batctl/functions.h |    3 +
>  batctl/main.c      |    8 ++--
>  batctl/proc.c      |   34 ---------------
>  batctl/proc.h      |    4 --
>  batctl/sys.c       |  121 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  batctl/sys.h       |   10 +++-
>  7 files changed, 141 insertions(+), 48 deletions(-)
>=20
> diff --git a/batctl/functions.c b/batctl/functions.c
> index 2ead2fc..cf4d264 100644
> --- a/batctl/functions.c
> +++ b/batctl/functions.c
> @@ -35,8 +35,6 @@
>  #include "functions.h"
>  #include "bat-hosts.h"
> =20
> -#define BATMAN_ADV_TAG "batman-adv:"
> -
>  static struct timeval start_time;
>  static char *host_name;
>  char *line_ptr =3D NULL;
> @@ -174,6 +172,13 @@ open:
> =20
>  read:
>  	while ((read =3D getline(&line_ptr, &len, fp)) !=3D -1) {
> +		if (read_opt & SEARCH_ARGS) {
> +			/* omit log lines which don't start with the correct tag */
> +			if (strncmp(line_ptr, SEARCH_ARGS_TAG, strlen(SEARCH_ARGS_TAG)) =3D=
=3D 0)
> +				break;
> +
> +			continue;
> +		}
> =20
>  		/* the buffer will be handled elsewhere */
>  		if (read_opt & USE_READ_BUFF)
> diff --git a/batctl/functions.h b/batctl/functions.h
> index 88fa53b..c21e9a3 100644
> --- a/batctl/functions.h
> +++ b/batctl/functions.h
> @@ -25,6 +25,8 @@
> =20
> =20
>  #define ETH_STR_LEN 17
> +#define BATMAN_ADV_TAG "batman-adv:"
> +#define SEARCH_ARGS_TAG "commands:"
> =20
>  /* return time delta from start to end in milliseconds */
>  void start_timer(void);
> @@ -45,4 +47,5 @@ enum {
>  	USE_BAT_HOSTS =3D 0x04,
>  	LOG_MODE =3D 0x08,
>  	USE_READ_BUFF =3D 0x10,
> +	SEARCH_ARGS =3D 0x20,
>  };
> diff --git a/batctl/main.c b/batctl/main.c
> index 6e4493d..99bfb5b 100644
> --- a/batctl/main.c
> +++ b/batctl/main.c
> @@ -102,15 +102,15 @@ int main(int argc, char **argv)
> =20
>  	} else if ((strcmp(argv[1], "originators") =3D=3D 0) || (strcmp(argv[1]=
, "o") =3D=3D 0)) {
> =20
> -		ret =3D handle_table(argc - 1, argv + 1, PROC_ORIGINATORS, originators=
_usage);
> +		ret =3D handle_sys_table(argc - 1, argv + 1, SYS_ORIGINATORS, originat=
ors_usage);
> =20
>  	} else if ((strcmp(argv[1], "translocal") =3D=3D 0) || (strcmp(argv[1],=
 "tl") =3D=3D 0)) {
> =20
> -		ret =3D handle_table(argc - 1, argv + 1, PROC_TRANSTABLE_LOCAL, trans_=
local_usage);
> +		ret =3D handle_sys_table(argc - 1, argv + 1, SYS_TRANSTABLE_LOCAL, tra=
ns_local_usage);
> =20
>  	} else if ((strcmp(argv[1], "transglobal") =3D=3D 0) || (strcmp(argv[1]=
, "tg") =3D=3D 0)) {
> =20
> -		ret =3D handle_table(argc - 1, argv + 1, PROC_TRANSTABLE_GLOBAL, trans=
_global_usage);
> +		ret =3D handle_sys_table(argc - 1, argv + 1, SYS_TRANSTABLE_GLOBAL, tr=
ans_global_usage);
> =20
>  	} else if ((strcmp(argv[1], "loglevel") =3D=3D 0) || (strcmp(argv[1], "=
ll") =3D=3D 0)) {
> =20
> @@ -142,7 +142,7 @@ int main(int argc, char **argv)
> =20
>  	} else if ((strcmp(argv[1], "aggregation") =3D=3D 0) || (strcmp(argv[1]=
, "ag") =3D=3D 0)) {
> =20
> -		ret =3D handle_proc_setting(argc - 1, argv + 1, PROC_AGGR, aggregation=
_usage);
> +		ret =3D handle_sys_setting(argc - 1, argv + 1, SYS_AGGR, aggregation_u=
sage);
> =20
>  	} else if ((strcmp(argv[1], "bisect") =3D=3D 0)) {
> =20
> diff --git a/batctl/proc.c b/batctl/proc.c
> index 3294662..e323a52 100644
> --- a/batctl/proc.c
> +++ b/batctl/proc.c
> @@ -68,33 +68,6 @@ int interface(int argc, char **argv)
>  	return EXIT_SUCCESS;
>  }
> =20
> -void originators_usage(void)
> -{
> -	printf("Usage: batctl [options] originators \n");
> -	printf("options:\n");
> -	printf(" \t -h print this help\n");
> -	printf(" \t -n don't replace mac addresses with bat-host names\n");
> -	printf(" \t -w watch mode - refresh the originator table continuously\n=
");
> -}
> -
> -void trans_local_usage(void)
> -{
> -	printf("Usage: batctl [options] translocal \n");
> -	printf("options:\n");
> -	printf(" \t -h print this help\n");
> -	printf(" \t -n don't replace mac addresses with bat-host names\n");
> -	printf(" \t -w watch mode - refresh the local translation table continu=
ously\n");
> -}
> -
> -void trans_global_usage(void)
> -{
> -	printf("Usage: batctl [options] transglobal \n");
> -	printf("options:\n");
> -	printf(" \t -h print this help\n");
> -	printf(" \t -n don't replace mac addresses with bat-host names\n");
> -	printf(" \t -w watch mode - refresh the global translation table contin=
uously\n");
> -}
> -
>  void gw_srv_list_usage(void)
>  {
>  	printf("Usage: batctl [options] gw_srv_list \n");
> @@ -118,13 +91,6 @@ void vis_server_usage(void)
>  	printf(" \t -h print this help\n");
>  }
> =20
> -void aggregation_usage(void)
> -{
> -	printf("Usage: batctl [options] aggregation \n");
> -	printf("options:\n");
> -	printf(" \t -h print this help\n");
> -}
> -
>  void gw_mode_usage(void)
>  {
>  	printf("Usage: batctl [options] gw_mode [mode]\n");
> diff --git a/batctl/proc.h b/batctl/proc.h
> index d867b78..74ac398 100644
> --- a/batctl/proc.h
> +++ b/batctl/proc.h
> @@ -21,13 +21,9 @@
> =20
>  #define PROC_ROOT_PATH "/proc/net/batman-adv/"
>  #define PROC_INTERFACES "interfaces"
> -#define PROC_ORIGINATORS "originators"
>  #define PROC_ORIG_INTERVAL "orig_interval"
> -#define PROC_TRANSTABLE_LOCAL "transtable_local"
> -#define PROC_TRANSTABLE_GLOBAL "transtable_global"
>  #define PROC_VIS_SERVER "vis_server"
>  #define PROC_VIS_DATA "vis_data"
> -#define PROC_AGGR "aggregate_ogm"
>  #define PROC_GW_MODE "gateway_mode"
>  #define PROC_GW_SRV_LIST "gateway_srv_list"
> =20
> diff --git a/batctl/sys.c b/batctl/sys.c
> index d67a915..65f1ebd 100644
> --- a/batctl/sys.c
> +++ b/batctl/sys.c
> @@ -94,11 +94,11 @@ int handle_loglevel(int argc, char **argv)
>  	}
> =20
>  	if (argc !=3D 1) {
> -		res =3D write_file(SYS_ROOT_PATH, SYS_LOG_LEVEL, argv[1]);
> +		res =3D write_file(SYS_MODULE_PATH, SYS_LOG_LEVEL, argv[1]);
>  		goto out;
>  	}
> =20
> -	res =3D read_file(SYS_ROOT_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_=
BUFF);
> +	res =3D read_file(SYS_MODULE_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_REA=
D_BUFF);
> =20
>  	if (res !=3D EXIT_SUCCESS)
>  		goto out;
> @@ -118,3 +118,120 @@ out:
> =20
>  	return res;
>  }
> +
> +void originators_usage(void)
> +{
> +	printf("Usage: batctl [options] originators \n");
> +	printf("options:\n");
> +	printf(" \t -h print this help\n");
> +	printf(" \t -n don't replace mac addresses with bat-host names\n");
> +	printf(" \t -w watch mode - refresh the originator table continuously\n=
");
> +}
> +
> +void trans_local_usage(void)
> +{
> +	printf("Usage: batctl [options] translocal \n");
> +	printf("options:\n");
> +	printf(" \t -h print this help\n");
> +	printf(" \t -n don't replace mac addresses with bat-host names\n");
> +	printf(" \t -w watch mode - refresh the local translation table continu=
ously\n");
> +}
> +
> +void trans_global_usage(void)
> +{
> +	printf("Usage: batctl [options] transglobal \n");
> +	printf("options:\n");
> +	printf(" \t -h print this help\n");
> +	printf(" \t -n don't replace mac addresses with bat-host names\n");
> +	printf(" \t -w watch mode - refresh the global translation table contin=
uously\n");
> +}
> +
> +int handle_sys_table(int argc, char **argv, char *file_path, void table_=
usage(void))
> +{
> +	int optchar, read_opt =3D USE_BAT_HOSTS;
> +
> +	while ((optchar =3D getopt(argc, argv, "hnw")) !=3D -1) {
> +		switch (optchar) {
> +		case 'h':
> +			table_usage();
> +			return EXIT_SUCCESS;
> +		case 'n':
> +			read_opt &=3D ~USE_BAT_HOSTS;
> +			break;
> +		case 'w':
> +			read_opt |=3D CLR_CONT_READ;
> +			break;
> +		default:
> +			table_usage();
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	return read_file(SYS_BATIF_PATH, file_path, read_opt);
> +}
> +
> +void aggregation_usage(void)
> +{
> +	printf("Usage: batctl [options] aggregation \n");
> +	printf("options:\n");
> +	printf(" \t -h print this help\n");
> +}
> +
> +int handle_sys_setting(int argc, char **argv, char *file_path, void sett=
ing_usage(void))
> +{
> +	int optchar, res;
> +	char *space_ptr, *comma_char, *cmds =3D NULL;
> +
> +	while ((optchar =3D getopt(argc, argv, "h")) !=3D -1) {
> +		switch (optchar) {
> +		case 'h':
> +			setting_usage();
> +			return EXIT_SUCCESS;
> +		default:
> +			setting_usage();
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	if (argc =3D=3D 1)
> +		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ);
> +
> +	res =3D read_file(SYS_BATIF_PATH, file_path, SEARCH_ARGS);
> +	if (res !=3D EXIT_SUCCESS)
> +		return res;
> +
> +	while ((space_ptr =3D strchr(line_ptr, ' ')) !=3D NULL) {
> +		*space_ptr =3D '\0';
> +
> +		if (strncmp(line_ptr, SEARCH_ARGS_TAG, strlen(SEARCH_ARGS_TAG)) =3D=3D=
 0) {
> +			cmds =3D space_ptr + 1;
> +			goto next;
> +		}
> +
> +		comma_char =3D NULL;
> +		if (line_ptr[strlen(line_ptr) - 1] =3D=3D ',') {
> +			comma_char =3D line_ptr + strlen(line_ptr) - 1;
> +			*comma_char =3D '\0';
> +		}
> +
> +		if (strcmp(line_ptr, argv[1]) =3D=3D 0)
> +			goto write_file;
> +
> +		*space_ptr =3D ' ';
> +		if (comma_char)
> +			*comma_char =3D ',';
> +
> +next:
> +		line_ptr =3D space_ptr + 1;
> +	}
> +
> +	if (!cmds)
> +		goto write_file;
> +
> +	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
> +	printf("The following values are allowed: %s", cmds);
> +	return EXIT_FAILURE;
> +
> +write_file:
> +	return write_file(SYS_BATIF_PATH, file_path, argv[1]);
> +}
> diff --git a/batctl/sys.h b/batctl/sys.h
> index 812da63..0d6f334 100644
> --- a/batctl/sys.h
> +++ b/batctl/sys.h
> @@ -20,10 +20,16 @@
>   */
> =20
> =20
> -#define SYS_ROOT_PATH "/sys/module/batman_adv/"
> +#define SYS_MODULE_PATH "/sys/module/batman_adv/"
> +#define SYS_BATIF_PATH "/sys/devices/virtual/net/bat0/mesh/"
>  #define SYS_LOG_LEVEL "parameters/debug"
>  #define SYS_LOG "log"
> -
> +#define SYS_ORIGINATORS "originators"
> +#define SYS_TRANSTABLE_LOCAL "transtable_local"
> +#define SYS_TRANSTABLE_GLOBAL "transtable_global"
> +#define SYS_AGGR "aggregate_ogm"
> =20
>  int log_print(int argc, char **argv);
>  int handle_loglevel(int argc, char **argv);
> +int handle_sys_table(int argc, char **argv, char *file_path, void table_=
usage(void));
> +int handle_sys_setting(int argc, char **argv, char *file_path, void sett=
ing_usage(void));
> --=20
> 1.6.6.2
>=20

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLix2HAAoJEBKw7u43QNpfZnAP/3WZJ5WoXVIm8ks9eaiELsGX
zMYYK2rI8AAB2+jEr4zb1uYQ/NJTVIZALe85qS5o8+LR3QTkXPXFqtVoXhFwXAYu
PhIdqQaHC9sLFRG3wEztBhXOcPJG1H26MupbPIpTL2zBRpvaMCdHnTeU1SCHcxO/
7t6FcIXZouSjLHNlYf3UxNOahqE2YLwavWxGuwhy+556IbbnEiLHIatBsIbm/bhl
I7Aq8Q10hAYHGV66D4fw9sgWaKvyLR5t1e+l8/RWeZA1uHhSP5VoN00I0HilNwto
FHBuCiibIUENoCcwMKGQ/GNw97HlfiYpjJzHcW4ajnLPHUNCM4GcsCGvEba4roAO
p/Xgk6gqFXhiSddI7pCA/++BU4auKGOWEapOZWmFSPkx3ztdHIEC03EwVumiUENb
3eiBRuTJG2kUKpiRqgV4lLmINcWrYIHDvsl5aOdHAc3J08piaoHdn8nqyMT13+iJ
bOTDILk/3R1slZYYjl7JcJMjlRtJimaiNyR315uTqxLbE66mVqjh9w1aUvCxqrB4
av1d2PTB13DOxFScfAeH2CeW2U0Bo+sX60aF7UJoiocaNwF+INysoS2ExRfIBZT6
K9dNGW0ZP8KjgFiA7Rk8O5KGsv79ap15I4T8CoovuZ7YcRr8OOUkemPV112GfMig
X/1095u34a4cQew/+oBC
=PEwt
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
