Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Sep 2016 11:25:11 +0200
Message-ID: <2527721.G80JbDCa0P@bentobox>
In-Reply-To: <1473928860-30519-1-git-send-email-apape@phoenixcontact.com>
References: <1473928860-30519-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1614720.HIOS6IANL1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: optchar variable uses wrong type
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

--nextPart1614720.HIOS6IANL1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 15. September 2016 10:41:00 CEST Andreas Pape wrote:
> The variable "optchar" used char instead of int leading to a non
> working batctl tp command as the while loop parsing the tp
> arguments with the getopt command is only left via the "default"
> case leaving the tp subcommand unusable. Using type char also
> lead to a compiler warning.

I find the commit message extreme confusing. It think you wanted to describe 
following problem:

* some platform C ABIs define char as unsigned
* getopt can return negative values
* the loop "around" getopt waits for a negative value to stop (which never
  happens with an unsigned char)

But the code change itself looks good.

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

> ---
>  tp_meter.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tp_meter.c b/tp_meter.c
> index 7fe0d56..10dc2b9 100644
> --- a/tp_meter.c
> +++ b/tp_meter.c
> @@ -395,7 +395,7 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
>  	int ret = EXIT_FAILURE;
>  	int found_args = 1, read_opt = USE_BAT_HOSTS;
>  	uint32_t time = 0;
> -	char optchar;
> +	int optchar;
>  	struct nl_sock *listen_sock = NULL;
>  	struct tp_result result = {
>  		.error = 0,


--nextPart1614720.HIOS6IANL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX2mj3AAoJEF2HCgfBJntGtY4QANiwz4eu03uRYFYB6C6+J5Xg
luCB2iYajff+F0DidkGUpUBDYzigth2PB0vF7U97DCocgXaVkl4mfk4vfzQMHlEC
X6wZKh9UhltiNiaR00B7LKzYJFSVPvrqgsavU9wrtSfT30rGitL8sKh/tbGxp/St
dUD4Yzsm5IWaIpSDrBoJWl9uOCTN3LX/OdHlpe/yXvCuAN4xgZT+layr97bzYnbR
o8lb6SMLdydqMFWwW+gay+Rv765PphmRN7jPGykLX6PCTRSnGm763d+/dE6HU/ja
U+zqS2fADLhc8Sc+TRy0+EQ/gh5uVoFuzdMcoXj5hPY5SaVHDL01bAOBc8decaDn
l07cyUuy2PSVf4hSoHk6GApK4VMsUTQafhsFTUz7cWuTrjmEvVDnka8hqT1vgVTC
qsL7g+K9B7np0JAkf+HCRdt8Vd2pm8JpuOJcaBQEvZnXAC1hxDH9i7I/FK44xq6/
a457AluWExB3JL2CQ6nT6xrENV18clw+f+wfBF9bf/ufmVvEOoBXeHTnIjCYT0xR
CKiffOS/ibfp3ywhDZlvz37a6YxSWXJzBF1WLEIqp7JV35+H0A4dJznqiXMV37YF
rmUQdAN0ddyH4Q1AT7imrRl8sYfvBx1fJaJaUBSBaHtBu172a/kOwQN2wYThdXUq
/jBsXIn1HBlxxUlLuO+3
=0iTJ
-----END PGP SIGNATURE-----

--nextPart1614720.HIOS6IANL1--

