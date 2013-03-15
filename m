Return-Path: <ordex@autistici.org>
Date: Fri, 15 Mar 2013 12:57:22 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130315115722.GI8563@ritirata.org>
References: <CAP5XTDM0KWS4c=0Z_KO=AdFh9rBDo_AOz553bstFk0FQRuWA0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <CAP5XTDM0KWS4c=0Z_KO=AdFh9rBDo_AOz553bstFk0FQRuWA0Q@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
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


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2013 at 07:40:48PM +0200, Mihail Costea wrote:
> Subject: [RFC] batman-adv: Modified DAT structures and functions in order
>  to support both IPv4 and IPv6
>=20
> In order to support DHT for IPv6 there was needed a general implementatio=
n for
> the IP field in distributed-arp-table.c (now the IP is __be32 and this pa=
tch
> will transform it to unsigned char *). Distinction between types is done
> using a new enum.
>=20
> Also all functions were changed to support this.
>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>

Hi Mihail,

thanks for this patch. Sorry for the late reply, but I required some time to
review it all :)

As first concern I would say that we need some more #ifdef (not thrown in t=
he
code, but placed in the right spots) to let the whole code work if somebody=
 has
disabled the IPv6 support in his kernel.

More comments inline

>=20
> ---
>  distributed-arp-table.c |  234 ++++++++++++++++++++++++++++++++++++-----=
------
>  types.h                 |   21 ++++-
>  2 files changed, 197 insertions(+), 58 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index 9215caa..ed6e817 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -20,6 +20,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/if_arp.h>
>  #include <net/arp.h>
> +#include <net/ipv6.h>
>=20
>  #include "main.h"
>  #include "hash.h"
> @@ -31,6 +32,36 @@
>  #include "translation-table.h"
>  #include "unicast.h"
>=20
> +/* Prints similar debug message for IPv4 and IPv6.
> + * At list one variable parameter should be the IP itself, and it should
> + * be placed correctly based on format prefix and format suffix argument=
s.
> + */
> +#ifdef CONFIG_BATMAN_ADV_DEBUG
> +
> +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
> +			       format_suffix, ...) \
> +		{ \
> +		switch (ip_type) { \
> +		case BATADV_DAT_IPv4: \
> +			batadv_dbg(BATADV_DBG_DAT, bat_priv, \
> +				   format_prefix "%pI4" format_suffix, \
> +					__VA_ARGS__); \
> +			break; \
> +		case BATADV_DAT_IPv6: \
> +			batadv_dbg(BATADV_DBG_DAT, bat_priv, \
> +				   format_prefix "%pI6c" format_suffix, \
> +					__VA_ARGS__); \
> +			break; \
> +		} \
> +		}
> +
> +#else
> +
> +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
> +			       format_suffix, ...) /* do nothing */

in this case we prefer to write a stub function rather than an empty define=
=2E In
this way the type check can still work and report issues. See
distributed-arp-table.h for an example.

> +
> +#endif /* CONFIG_BATMAN_ADV_DEBUG */
> +
>  static void batadv_dat_purge(struct work_struct *work);
>=20
>  /**
> @@ -47,12 +78,14 @@ static void batadv_dat_start_timer(struct
> batadv_priv *bat_priv)
>  /**
>   * batadv_dat_entry_free_ref - decrements the dat_entry refcounter and p=
ossibly
>   * free it
> - * @dat_entry: the oentry to free
> + * @dat_entry: the entry to free
>   */

this is an example of change that should go in a separate patch as it is fi=
xing
a typo previously introduced.

>  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
>  {
> -	if (atomic_dec_and_test(&dat_entry->refcount))
> +	if (atomic_dec_and_test(&dat_entry->refcount)) {
> +		kfree(dat_entry->ip);
>  		kfree_rcu(dat_entry, rcu);
> +	}

mh, here we are mixing rcu freeing and not. it may be better to create a fr=
eeing
function which take cares of freeing everything which will be set in this p=
oint
by means of call_rcu() (you can grep for call_rcu in translation-table.c to=
 see
how we use it).

>  }
>=20
>  /**
> @@ -130,18 +163,50 @@ static void batadv_dat_purge(struct work_struct *wo=
rk)
>  }
>=20
>  /**
> + * batadv_sizeof_ip - gets sizeof IP based on its type (IPv4 / IPv6)
> + * @ip_type: type of IP address
> + *
> + * Returns sizeof IP, or sizeof IPv4 if @ip_type is invalid

no need to write the '@' here.

[...]
=20
>  /**
> + * batadv_dat_types - types used in batadv_dat_entry for IP
> + * @BATADV_DAT_IPv4: IPv4 address type
> + * @BATADV_DAT_IPv6: IPv6 address type
> + */
> +enum batadv_dat_types {
> +	BATADV_DAT_IPv4,
> +	BATADV_DAT_IPv6,
> +};

Constants should be all capital letters (look at the 'v')

> +
> +/**
>   * struct batadv_dat_candidate - candidate destination for DAT operations
>   * @type: the type of the selected candidate. It can one of the followin=
g:
>   *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
> --=20

What is not entirely clear to me (I may have overlooked it) is how do the t=
wo
types of data interacts. If I am not wrong, you want to use the same table =
for
both data, but this will create problems when comparing a 16bytes long ipv6
address with a 4bytes long ipv4 one. So you should assume that mixed compar=
e can
happen and you should check the type of the two objects before going to the=
 real
data compare.

I think you are on the right track, but you should think a bit more how to
generalise your approach in order to account the case I described above.

It would also be nice to generalise it such that you do not have to talk ab=
out
IPs, but about "DHT data" and its len, which can then be whatever we would =
like.
However this point might be something we want to discuss later...now you can
focus on your patch assuming we want to store IPv4/6 only.

Cheers,

p.s. feel free to join our IRC channel (#batman at irc.freenode.org) for li=
ve
discussions)

Cheers=C2=B2,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRQwyiAAoJEADl0hg6qKeOzOsP/A0KJeMZHQUEcpmeg4VoamDX
XDMIjUWnttqOuwM2j7zg0Xp973/pZA6JX2yygjd4kRYt9s0GBZQIInGM18YCtPTr
TrBN+W7+fe1CMkJwxWqUfo+E+ieqAoCPHFvhVFoLWrF3vGeNm6iuNuqup7pEbStt
GbENp73KSJGdAzIrDOZ6n6GexTExylasD77GZ0jLUwUMolPAszfVUbuk8hinfWQW
/RbvQbCIQr+n4jpnI2AhV7fpZ9JGI09C8YlxDwj2Y44MLFH3UIvryicifkGA36NL
NLZxvDXC7hRY2ohwRTm31+mpb73mi6QXt7C4PJ+hI6Hp/D2DqfAmtfG5hdlX8V7y
EVQFBZ4aSj5WkRbDiY0SfGQT+mj70/JDkSjloc2EBceWyYNPI3Vkxh8FPNF+bOOA
F+3IL8hsFa5Aek2mcjMrA4IhVejPFY7hkDKfNmXfJqYkwz5aOcC8iH6o13fEHsNR
XkjnSZd13ltQX8VGOrzBNigEVvsx4QAqfnJ0usiPqJ6rdi5Jp77oLwD1RoiDlqo4
JFFDPE6ZpvxI8S/jhBxV0us1WiNmkLaQU/frIapAkPPtByHlmMLmpVcYht5r3BRp
2r/IcjQySHEJHE2k5wznEmwOqiwYsxLfvvTjMllnT8jc9aL5xziYXwPAu4Ss1e3N
ayTL8e9Z10P6CMtbydsQ
=26DT
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
