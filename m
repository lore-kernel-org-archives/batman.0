Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 17:40:45 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201164044.GO24115@ritirata.org>
References: <1353931112-17392-1-git-send-email-sven@narfation.org>
 <1353931112-17392-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Content-Disposition: inline
In-Reply-To: <1353931112-17392-5-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 5/5] batman-adv: Allow to use different
 sized hash locks array
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


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 12:58:32PM +0100, Sven Eckelmann wrote:
> The amount of locks of a hash directly affects the parallelity when all a=
ccess
> independent parts of the hash. But this also affects the amount of memory=
 used
> for each hash. Allowing to decouple the hash size and the lock size allow=
s to
> reduce this memory consumption for hashes which don't allow this parallel=
ism.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bridge_loop_avoidance.c |   28 ++++++++++++++--------------
>  distributed-arp-table.c |   16 ++++++++--------
>  distributed-arp-table.h |    6 +++---
>  hash.h                  |   19 +++++++++----------
>  originator.c            |    6 ++++--
>  originator.h            |   13 +++++--------
>  translation-table.c     |   22 ++++++++++++++--------
>  vis.c                   |    8 ++++----
>  8 files changed, 61 insertions(+), 57 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index 1a78bac..781119f 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -38,7 +38,7 @@ static void batadv_bla_send_announce(struct batadv_priv=
 *bat_priv,
>  				     struct batadv_backbone_gw *backbone_gw);
> =20
>  /* return the index of the claim */
> -static inline uint32_t batadv_choose_claim(const void *data, uint32_t si=
ze)
> +static inline uint32_t batadv_choose_claim(const void *data)
>  {
>  	struct batadv_claim *claim =3D (struct batadv_claim *)data;
>  	uint32_t hash;
> @@ -46,12 +46,11 @@ static inline uint32_t batadv_choose_claim(const void=
 *data, uint32_t size)
>  	hash =3D jhash(&claim->addr, sizeof(claim->addr), 0);
>  	hash =3D jhash(&claim->vid, sizeof(claim->vid), hash);
> =20
> -	return hash % size;
> +	return hash;

I do not fully understand how having the mod operation inside the function =
would
prevent the decoupling. Why you need to move it out?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQujMMAAoJEADl0hg6qKeOGIwQAMPQoVkPkrW/Ky/mRzT/emen
hnkffgaTNwwyG2x9WrFX+TNzB4D9Wo1SmFj23H/vZ/vwX/QaidpiwwDkUN63FA8B
/oGo12ihEDnT7jkEMVFZTkchtWdzeYUQv67G7sgwW85hpcjEeEKqDigO6lajJC1y
vICtM+9Ykmbk1+oc8PrWTzcaZ6KBbCNb1PkVv0/e5+NjXQniF9pqBO9OEGA6Ntc+
WEJqlKI7nJkTpTA+A+morvCHdoPMIgJvUWrlDEpQ/SDTEXAnIJD6wB7chRZpOzCM
cHuc5S1GqJc8IuTJFzQ84yqvryVNJXTDBZsiKooHg1zVjLltDJ2qAlXRVd0JuEGY
sPRq7BEXBQmQhuwM6c2CSRsE22i2u3xbUz7FCec+82+UUKdK5ZufzSt4J9VhPvyU
MdjT9JrnSGMOQbl8kmdyLh0xTqGEXWqW4uE90Kwx5jCOh8ErzjvzyohlRK27z1Si
O1Oyqz9tMn0yx8myGLbNQHjhaV0iy9kdeyOjZbyPDttvN+9OJnldod7JzeO3O87+
/FoLv96tuEHCLFTfdeY/MxCUmx4J41S1fKL7tV4Ua9wN2sRdPT2FCSM4f+Ive5Uv
eaGYaP6IH7Sqzz3E4ikJpPPfEHIbZv0EVYVmtrgO4ZLee1noZZwN6eOBMDpAlGwl
ARhw3wg3Ugeggf3VN1Ih
=O4B8
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
