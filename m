Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 01:41:17 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126004117.GI14547@ritirata.org>
References: <cover.1353331252.git.martin@hundeboll.net>
 <e0944b8b9fcc9f288f11789a5f7f499b266caa2a.1353331252.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <e0944b8b9fcc9f288f11789a5f7f499b266caa2a.1353331252.git.martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/6] batman-adv: Detect coding nodes and
 remove these after timeout
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 02:22:00PM +0100, Martin Hundeb=C3=B8ll wrote:
[...]

> diff --git a/network-coding.c b/network-coding.c
> index 8d930e7..29f7744 100644
> --- a/network-coding.c
> +++ b/network-coding.c
> @@ -17,8 +17,12 @@
>   * 02110-1301, USA
>   */
> =20
> +#include <linux/debugfs.h>
> +

Ok, I don't want to make you feel a cavy :) but it is better to correct this
stuff when we can: kernel-includes (<..h>) should follow project-includes
("..h")

>  #include "main.h"
>  #include "network-coding.h"
> +#include "originator.h"
> +#include "hard-interface.h"
> =20
>  /**
> @@ -68,11 +218,197 @@ static void batadv_nc_worker(struct work_struct *wo=
rk)
>  	priv_nc =3D container_of(delayed_work, struct batadv_priv_nc, work);
>  	bat_priv =3D container_of(priv_nc, struct batadv_priv, nc);
> =20
> +	batadv_nc_purge_orig_hash(bat_priv);
> +

ah, now this function makes sense (with respect to what I said in reply to =
1/6).
Would it be better to add the worker here instead of adding it in 1/6?

>  	/* Schedule a new check */
>  	batadv_nc_start_timer(bat_priv);
>  }

[...]
> @@ -268,9 +274,12 @@ struct batadv_priv_dat {
>  /**
>   * struct batadv_priv_nc - per mesh interface network coding private data
>   * @work: work queue callback item for cleanup
> + * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
>   */
>  struct batadv_priv_nc {
>  	struct delayed_work work;
> +	struct dentry *debug_dir;
> +	u8 min_tq;

If I am not mistaken min_tq is never modified. Why do we need to store it i=
n a
bat_priv field? And being a constant is it worth a define? In this way it a=
n be
easily found and tuned like the other constant params.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCyuq0ACgkQpGgxIkP9cwfmlACfYcvWBIwq1iDCBrCyHhtqbUkO
klUAn0AkyYkbeN2WJjqFc5ps5SU8PKyS
=AJJc
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
