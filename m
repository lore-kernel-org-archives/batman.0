Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Sep 2016 13:02:33 +0200
Message-ID: <3438157.vQCbVqHM4o@prime>
In-Reply-To: <1473772759-4987-1-git-send-email-jhaws@sdl.usu.edu>
References: <1473772759-4987-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1601143.lmIVBa1Ykj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: Externalized synchronization
	interval
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart1601143.lmIVBa1Ykj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, September 13, 2016 7:19:19 AM CEST Jonathan Haws wrote:
> ALFRED_INTERVAL is now externalized via the -p option (synchronization
> period).  If specified as option, user supplied interval is used,
> otherwise the default interval of ALFRED_INTERVAL is used.
> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>

Applied in commit 99a3945.

Thanks!
     Simon
> ---
>  alfred.h     |  1 +
>  main.c       | 14 +++++++++++++-
>  man/alfred.8 |  5 +++++
>  server.c     | 12 ++++++++++--
>  4 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/alfred.h b/alfred.h
> index a9906c8..5b7e965 100644
> --- a/alfred.h
> +++ b/alfred.h
> @@ -131,6 +131,7 @@ struct globals {
>  	uint16_t changed_data_type_count; /* maximum is 256 */
> 
>  	struct timespec if_check;
> +	struct timespec sync_period;
> 
>  	struct hashtable_t *data_hash;
>  	struct hashtable_t *transaction_hash;
> diff --git a/main.c b/main.c
> index 9cab705..f1bc9a5 100644
> --- a/main.c
> +++ b/main.c
> @@ -59,6 +59,8 @@ static void alfred_usage(void)
>  	printf("  -m, --master                        start up the daemon in
> master mode, which\n"); printf("                                     
> accepts data from slaves and syncs it with\n"); printf("                   
>                   other masters\n"); +	printf("  -p, --sync-period 
[period]
>          set synchronization period, in seconds\n"); +	printf("            
>                          fractional seconds are supported (i.e. 0.2 = 5
> Hz)\n"); printf("\n");
>  	printf("  -u, --unix-path [path]              path to unix socket used 
for
> client-server\n"); printf("                                     
> communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n"); @@ -156,6
> +158,7 @@ out:
>  static struct globals *alfred_init(int argc, char *argv[])
>  {
>  	int opt, opt_ind, i, ret;
> +	double sync_period = 0.0;
>  	struct globals *globals;
>  	struct option long_options[] = {
>  		{"set-data",		required_argument,	NULL,	's'},
> @@ -170,6 +173,7 @@ static struct globals *alfred_init(int argc, char
> *argv[]) {"update-command",	required_argument,	NULL,	'c'},
>  		{"version",		no_argument,		NULL,	'v'},
>  		{"verbose",		no_argument,		NULL,	'd'},
> +		{"sync-period",		required_argument,	NULL,	'p'},
>  		{NULL,			0,			NULL,	0},
>  	};
> 
> @@ -193,12 +197,14 @@ static struct globals *alfred_init(int argc, char
> *argv[]) globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
>  	globals->verbose = 0;
>  	globals->update_command = NULL;
> +	globals->sync_period.tv_sec = ALFRED_INTERVAL;
> +	globals->sync_period.tv_nsec = 0;
>  	INIT_LIST_HEAD(&globals->changed_data_types);
>  	globals->changed_data_type_count = 0;
> 
>  	time_random_seed();
> 
> -	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:",
> long_options, +	while ((opt = getopt_long(argc, argv,
> "ms:r:hi:b:vV:M:I:u:dc:p:", long_options, &opt_ind)) != -1) {
>  		switch (opt) {
>  		case 'r':
> @@ -265,6 +271,12 @@ static struct globals *alfred_init(int argc, char
> *argv[]) printf("%s %s\n", argv[0], SOURCE_VERSION);
>  			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange
> Daemon\n"); return NULL;
> +		case 'p':
> +			sync_period = strtod(optarg, NULL);
> +			globals->sync_period.tv_sec = (int) sync_period;
> +			globals->sync_period.tv_nsec = (double) (sync_period - (int)
> sync_period) * 1e9; +			printf(" ** Setting sync interval to: %.9f 
seconds
> (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec,
> globals->sync_period.tv_nsec); +			break;
>  		case 'h':
>  		default:
>  			alfred_usage();
> diff --git a/man/alfred.8 b/man/alfred.8
> index 49d42bc..5936e64 100644
> --- a/man/alfred.8
> +++ b/man/alfred.8
> @@ -118,6 +118,11 @@ overhead).
>  \fB\-c\fP, \fB\-\-update-command\fP \fIcommand\fP
>  Specify command to execute on data change. It will be called with data-type
> list as arguments.
> +.TP
> +\fB\-p\fP, \fB\-\-sync-period\fP \fIperiod\fP
> +Specify alfred synchronization period, in seconds. If not specified, the
> default +ALFRED_INTERVAL setting of 10 seconds will be used. Fractional
> seconds are +supported.
>  .
>  .SH EXAMPLES
>  Start an alfred server listening on bridge br0 (assuming that this bridge
> diff --git a/server.c b/server.c
> index 47aee4f..3a0ad8d 100644
> --- a/server.c
> +++ b/server.c
> @@ -372,7 +372,15 @@ int alfred_server(struct globals *globals)
> 
>  	while (1) {
>  		clock_gettime(CLOCK_MONOTONIC, &now);
> -		now.tv_sec -= ALFRED_INTERVAL;
> +
> +		/* subtract the synchronization period from the current time
> +		 * NOTE: this is an atypical usage of time_diff as it ignores the 
return
> +		 * value and store the result back into now, essentially performing 
the
> +		 * operation:
> +		 * now -= globals->sync_period;
> +		 */
> +		time_diff(&now, &globals->sync_period, &now);
> +
>  		if (!time_diff(&last_check, &now, &tv)) {
>  			tv.tv_sec = 0;
>  			tv.tv_nsec = 0;
> @@ -409,7 +417,7 @@ int alfred_server(struct globals *globals)
> 
>  		if (globals->opmode == OPMODE_MASTER) {
>  			/* we are a master */
> -			printf("announce master ...\n");
> +			printf("[%ld.%09ld] announce master ...\n", last_check.tv_sec,
> last_check.tv_nsec); announce_master(globals);
>  			sync_data(globals);
>  		} else {


--nextPart1601143.lmIVBa1Ykj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX2S5JAAoJEKEr45hCkp6hShUP/AwHZGhkL6CAVAs693smbRX/
5XDBluGFnnJcCOnpcBpfrhKMh18GxI17eWMyGoewtVV2ySF6mXuNgcVjKGD+ImxV
iWJReHDaKC/6/r+RLjjQw9bRL8EbBzyWHUKrl7PTaBd5yr2ZgM/Xcf+JZuipsFdv
nG6w9H/ZO8K0L2EUKK0oTEDUpBm6qgdTud6sfSFMGsOjiWBADfISbC9C/KRYbB2N
luLgCH0YYvFOiZSWXO8/LoXYSK5+lSDn6Ia1+Hg/N5Dc4i4MK9nBCbYRS9Hcn1Cb
UB0blDX9aykVIfcciKayOiIg5/QfSrqi6fdpWHAGqMenl0AqbsH6Ros7rPCuIwM8
qw5WUTcH1z/Vm/h+CjE7U3Na6d4Qyz5I72yQ3GVDQ5MWIjJ4kdy6AV3OULrWfE2n
FyvgSg2g3pEh8h7XWhtZ0CgTYtH7lsHdlrhVVja6eN6p9dajO4jccDFzgFvRsJB3
1D/1ivEam4+8oFZgQUqvpf3QJG3RW3V2nlREUxGwPn9qwQWCiLomU5mYLRYuzMht
HvxInslc/FZf58yW57pVUt1qhw91/MyRX3q0uLiXtocPFtzvL31eEz9X7yLNAV1s
6U5hoxMN8uAeNSeGuNvIzo1Lu7pKrP1UspgkzWAU7X1DkzIzCeC60jPy2T+O9WDP
VV5J1LTA/5h9xUg3x3Dy
=SrLO
-----END PGP SIGNATURE-----

--nextPart1601143.lmIVBa1Ykj--

