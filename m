Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 23 Jun 2010 17:17:27 +0200
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2920245.m6OTqMgFIP";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006231717.35877.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
	accessible via debugfs
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart2920245.m6OTqMgFIP
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
>  /*
>   *  Vis
> @@ -160,3 +148,20 @@ int choose_orig(void *data, int32_t size);
>  int is_my_mac(uint8_t *addr);
>  int is_bcast(uint8_t *addr);
>  int is_mcast(uint8_t *addr);
> +
> +#ifdef CONFIG_BATMAN_ADV_DEBUG
> +extern int debug;
> +
> +extern int bat_debug_type(int type);
> +extern int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
> +
> +#define bat_dbg(type, bat_priv, fmt, arg...) do {		\
> +		if (bat_debug_type(type))			\
> +			debug_log(bat_priv, fmt, ## arg);	\
> +	}							\
> +	while (0)
> +#else /* !CONFIG_BATMAN_ADV_DEBUG */
> +#define bat_dbg(type, bat_priv, fmt, arg...) do {	\
> +	}						\
> +	while (0)
> +#endif

Can you please change that (at least the 'null' function) from a define to =
an=20
static inline function? Otherwise there are a lot of "unused" warning when=
=20
compiling without debug support.

static inline void bat_dbg(char type __attribute__((unused)),
			   struct bat_priv *bat_priv __attribute__((unused)),
			   char *fmt __attribute__((unused)), ...)
{ }

I will send a include guard patch later which is needed to get this working.

To you suggestion to add more information from kernel log to the debug log =
=2D=20
it seems to be interesting, but we must ensure that those information are=20
specific to a mesh device. I will sent a patch which modifies all printks=20
later. Maybe we could discuss where it would be a benefit and where it is n=
ot=20
needed (~54 printks are for discussion).

Best regards,
	Sven

--nextPart2920245.m6OTqMgFIP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMIiWIAAoJEF2HCgfBJntGsqEQAKd1GgI7xNKjVZbNOO4VdhrS
qyDQo8aRjwqjmBBSLK3yv23NGCSFFUpKTv9aDkIkrEgjK/cx/DiCkV/NUaD4ei74
RKNTEe3k0SLu81MWB2q5520efEALKTzFC8MZpA9ZjBL59QVG25PoXnmqWYgDp9es
QER+4GmcA6byIo7HvOFXs+CdL/MCieJhsyOFrifIWmaEX/IJctxInT/ClByM2ijh
wbZn6W5yENyNR2YNhN/FtJJkJ2PISwtJZn8sMG1tp7NKX57w0+5A562OV0QyFN0x
QAgbajRtHeq0XoSTo02hOA9fWKSCmsaStKnVCwRZZgYFBizKnFAi8j25H+LOlhHI
vvm0n+IWL2t+q2eQHa3AVFSMvjAKFG6bPA92iAKRzvblnP93gsTNwzwVa3qSfcTP
lJ1OHpyuOQT6MrFYVEMyjxUdVZojgZUh6gdNauW99fo4JjIOMEx5EKZT8uTURL45
lwmaSt/iZBsrN+H93gg9B3a/3J3+hDE4OtFg57MJCkSBrhXDNrVllQ/txoL0qYrT
3T8kw9+TJnyEpLzkIxaD/s3WleIvKLdVq13BTlCze7fW/7bYxlqwgNZXjOk3ApFQ
Ima8tjGjDWHrSt+wNarsJDdLU+/hnCo96cZmYriOei5ZSuGFG5ZUHbxaB9+T5VnA
AhxJe1zy368mzZZ5YazO
=Dy2N
-----END PGP SIGNATURE-----

--nextPart2920245.m6OTqMgFIP--
