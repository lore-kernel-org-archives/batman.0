Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 May 2011 21:41:11 +0200
References: <1305703250-23111-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1305703250-23111-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1560173.YAHVtaO3KR";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105192141.18647.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move smallest_signed_int(),
	seq_before() and  seq_after() into main.h
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

--nextPart1560173.YAHVtaO3KR
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> smallest_signed_int(), seq_before() and seq_after() are very useful
> functions that help to handle comparisons between sequence numbers.
> However they were only defined in vis.c. With this patch every
> batman-adv function will be able to use them.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>


Acked-by: Sven Eckelmann <sven@narfation.org>

David S. Miller doesn't want to have the seq_before/seq_after in a global=20
header: http://lkml.org/lkml/2011/5/19/88

I would still like to propose the type check on top of that patch

Kind regards,
	Sven

> ---
>  main.h |   16 ++++++++++++++++
>  vis.c  |   16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/main.h b/main.h
> index 3ca3941..90db244 100644
> --- a/main.h
> +++ b/main.h
> @@ -181,4 +181,20 @@ static inline int compare_eth(void *data1, void
> *data2)
>=20
>  #define atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
>=20
> +/* Returns the smallest signed integer in two's complement with the size=
of
> x */ +#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
> +
> +/* Checks if a sequence number x is a predecessor/successor of y.
> + * they handle overflows/underflows and can correctly check for a
> + * predecessor/successor unless the variable sequence number has grown by
> + * more then 2**(bitwidth(x)-1)-1.
> + * This means that for a uint8_t with the maximum value 255, it would
> think: + *  - when adding nothing - it is neither a predecessor nor a
> successor + *  - before adding more than 127 to the starting value - it is
> a predecessor, + *  - when adding 128 - it is neither a predecessor nor a
> successor, + *  - after adding more than 127 to the starting value - it is
> a successor */ +#define seq_before(x, y) ({typeof(x) _dummy =3D (x - y); \
> +			_dummy > smallest_signed_int(_dummy); })
> +#define seq_after(x, y) seq_before(y, x)
> +
>  #endif /* _NET_BATMAN_ADV_MAIN_H_ */
> diff --git a/vis.c b/vis.c
> index c39f20c..e1ed552 100644
> --- a/vis.c
> +++ b/vis.c
> @@ -30,22 +30,6 @@
>=20
>  #define MAX_VIS_PACKET_SIZE 1000
>=20
> -/* Returns the smallest signed integer in two's complement with the size=
of
> x */ -#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
> -
> -/* Checks if a sequence number x is a predecessor/successor of y.
> - * they handle overflows/underflows and can correctly check for a
> - * predecessor/successor unless the variable sequence number has grown by
> - * more then 2**(bitwidth(x)-1)-1.
> - * This means that for a uint8_t with the maximum value 255, it would
> think: - *  - when adding nothing - it is neither a predecessor nor a
> successor - *  - before adding more than 127 to the starting value - it is
> a predecessor, - *  - when adding 128 - it is neither a predecessor nor a
> successor, - *  - after adding more than 127 to the starting value - it is
> a successor */ -#define seq_before(x, y) ({typeof(x) _dummy =3D (x - y); \
> -			_dummy > smallest_signed_int(_dummy); })
> -#define seq_after(x, y) seq_before(y, x)
> -
>  static void start_vis_timer(struct bat_priv *bat_priv);
>=20
>  /* free the info */

--nextPart1560173.YAHVtaO3KR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1XJYAAoJEF2HCgfBJntGun4QAK2ZWhtFWMPUwa2Gg/nuA8Z/
WqSJRp3RkjL+Mj/k64hnM8ejQC95EOGyOp6ImH2Yp6ApzgIl3nz4WRti+RWRI2a/
JJ4sDsdQdlD6I2ZiThGHgi0Pk7n7HSXlFg94zDHf7kkqjPnkmX6YfSXPFOmBQXhZ
4laUkFe7BLqsof9iCph0wwsiPfZElzbWsibPgEx8VQBZZskRvIi0m/A7/JMBpbiI
prhtoPrO1fWy8Fw6RcCZK6hQIh/QRBevVixUw+Nw5ifJ7VjT42YV+1IVg6ul4McQ
9hL0hDvzg4i116Trb3nrpD6t07Zrxwmj19rF4pYK6XMfMgQspbqNpyPnzFdnujAG
jy8gVT7bHn1nsX1tZgnPgWqYMFbINfn7i78sRlbvNkYvZknJKxPdlyneH3Vt4Y1d
06GvCfhooeLb5T0x3HnmJcbjk6oKgEnopr3Z784pkPAa4rR0OaCT3Nr/dTl8fWGE
WMHhW9c68zf9WW9RB0pPtBfOJ3caUxf30UO5sxuGOufiA/EIaPCCAnJXI06h3vfM
K565yELkQUz0M4zsGYE0VvtlMEO2Y+5AUWxxGNyT1EWNWcRzqIYuheJ0JkWxuzmN
F7Xf0ZChIeWt0JzxMuEi2FQLmUnrwD0v9T9D6o9UkNRjfL7X2tndXjOc/1Hb2YI2
oHCZYh2ykbDXSqnHZq22
=gAFq
-----END PGP SIGNATURE-----

--nextPart1560173.YAHVtaO3KR--
