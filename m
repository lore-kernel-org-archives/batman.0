Return-Path: <ordex@autistici.org>
Date: Thu, 23 May 2013 13:17:48 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130523111748.GF1679@ritirata.org>
References: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: forward late OGMs from
 best next hop
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2013 at 01:07:42PM +0200, Simon Wunderlich wrote:
> ---
> Changes to PATCHv1:
>  * use enum to distinguish different duplicate states
>  * fix typo "is_simlar -> is_similar"
>  * remove antonios sign off (the patch changed, feel free to add it if
>    he is ok with it, it was his idea originally ...)

no, it's ok as it is :)

> ---
>  bat_iv_ogm.c |   86 +++++++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 55 insertions(+), 31 deletions(-)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 8d87f87..2b94fdd 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -701,6 +701,21 @@ static void batadv_iv_ogm_schedule(struct batadv_har=
d_iface *hard_iface)
>  		batadv_hardif_free_ref(primary_if);
>  }
> =20
> +/**
> + * batadv_dup_status - duplicate status
> + * @BATADV_NO_DUP: the packet is a duplicate
> + * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for t=
he
> + *  neighbor)
> + * @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor
> + * @BATADV_PROTECTED: originator is currently protected (after reboot)
> + */
> +enum batadv_dup_status {
> +	BATADV_NO_DUP =3D 0,
> +	BATADV_ORIG_DUP,
> +	BATADV_NEIGH_DUP,
> +	BATADV_PROTECTED,
> +};
> +

Very nice! splitting the "simple boolean" into an enum is a very good idea =
imho.

> -/* processes a batman packet for all interfaces, adjusts the sequence nu=
mber and
> - * finds out whether it is a duplicate.
> +/**
> + * batadv_iv_ogm_update_seqnos -  processes a batman packet for all inte=
rfaces,
> + *  adjusts the sequence number and finds out whether it is a duplicate.
> + * @ethhdr: Ethernet header of the packet
> + * @batadv_ogm_packet: OGM packet to be considered
> + * @if_incoming: interface where the OGM packet was received

A blank line is needed here. Maybe who's going to merge this patch can add =
it?
:)

> + * Returns: duplicate status as enum batadv_dup_status
>   * returns:
> - *   1 the packet is a duplicate
> - *   0 the packet has not yet been received
> - *  -1 the packet is old and has been received while the seqno window
> - *     was protected. Caller should drop it.
> - */
> -static int
> +  */
> +enum batadv_dup_status
>  batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
>  			    const struct batadv_ogm_packet *batadv_ogm_packet,
>  			    const struct batadv_hard_iface *if_incoming)


The rest looks good! Thanks Simon.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRnfrcAAoJEADl0hg6qKeOJ2YP/imLXXQMibY+dsKOMLQ6jTX6
WuppdYAA9l68ttqK5WzchtBCRA72FWJqeUJuVf8OZ2PotDbXa1EiOD98TPD0cgGG
o6mw+G7X7sdssVsOdRWUQIQeaFVcrPhL9lAdg/cd7MMH3Tsr1aDvjr7e32DvBcqv
Fw9VO4Xnx8BFQnv3m8XtCmBhm9+FuCZepDMBWQTD8MZDoFegK+cMh2Ec85PdMJyQ
BwuDqCQyUIxw1x8+FF8C2rM6vvqn+8+4/UHfid4085IqY3JjsRpmw2KA+Gd887ES
Z6cu+KTksHyg9hGE3bkWyzYIg6MX4HksPotvJ9eDE1w5qlcPneggQwK9mXd5y5zq
hgt123zOLD5Evg7NUc8WIsjcltYdy2fCMCODLPJekWsoOwW5wU1tlTx/Rx/L9KCt
VNgtBFmmLZrWj4CL1WXfliPrvOsZ/pmxZOEliqZnO7wurSOuTv53fV4NwYsAOs1s
TYdEvq9kbJVwzi5p8KlrwAjoiP4Hk5myP+DX2HaLLuV02EdUydut+KopM7apGOaD
jx1nt21bbtYzzlmG0uhwiSfwovYhPJkBk2k9MFtsQF5KxLcyHkXyJ5Mqzfo84nUK
zCnDVWu8y6sRnkNrEVinFBblZ4Su1IypIov3mWZi5LpOf6yYNkJhWq9eTSB/hZJr
o0KzPAlG4hfklAHL1xnZ
=pL5Y
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
