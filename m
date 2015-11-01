Return-Path: <mpa@pengutronix.de>
Date: Sun, 1 Nov 2015 16:13:02 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20151101151302.GA32213@pengutronix.de>
References: <1787438.NkeQ2a2MeO@sven-edge>
 <1446290970-24053-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <1446290970-24053-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix kerneldoc of main
 functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On Sat, Oct 31, 2015 at 12:29:29PM +0100, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bitarray.c       | 12 +++++++++---
>  net/batman-adv/bitarray.h       | 11 +++++------
>  net/batman-adv/debugfs.c        |  6 ++++++
>  net/batman-adv/main.c           |  2 ++
>  net/batman-adv/main.h           |  4 ++++
>  net/batman-adv/originator.c     |  4 +++-
>  net/batman-adv/packet.h         |  6 ++++++
>  net/batman-adv/routing.c        |  7 ++++++-
>  net/batman-adv/send.c           |  5 ++++-
>  net/batman-adv/soft-interface.c |  2 ++
>  net/batman-adv/sysfs.c          |  1 +
>  11 files changed, 48 insertions(+), 12 deletions(-)
>=20
> diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
> index 06bab51..3404195 100644
> --- a/net/batman-adv/bitarray.c
> +++ b/net/batman-adv/bitarray.c
> @@ -29,10 +29,16 @@ static void batadv_bitmap_shift_left(unsigned long *s=
eq_bits, s32 n)
>  	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZE);
>  }
> =20
> -/* receive and process one packet within the sequence number window.
> +/**
> + * batadv_bit_get_packet - receive and process one packet within the seq=
uence
> + *  number window

Are you sure this works? IIRC some time ago multi line function
descriptions were not supported.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNiv9AAoJEEpcgKtcEGQQ0ckP/jZw6i9pQdo41hcRvyFpMGlI
LVu2DtQGicR/GyNYyF+uRBBC51TLDqMTQ4NMzo/J8/wadZNGbdI8sGtWBtDLthGc
LaDZm7ERLydyugN1ILDhhb5UwbfpEj6Mizp1WcX8DCA4Af66giTIdAKdqQryPkg4
yzSb98JpKswtDZbYi8aSp2aSpmdFZzDs+8h2VTwv2nik2bmqaKpy0mtn8mAJzgRO
2MTLQitadjfHY7s1RBPyj4xiPWpYGAy8lw8m6j/4/FMi0AKyVQAlU2Jn2rVbh+GO
L6rjIdEdqaSu1w3OJULhHThweKzeEJIb0I79dhShW/kHcb9w65bIseR0gyoEMRw1
utZ1If4a0AX5JDWze3Gi3W/9fV4zD3WzUZWDj5OjKoM+giGF/SHY1+MJye3o1zJk
s9qYz0w2t2xImzT8lxW1wGEzimcZGyNKnnpFffOUAF0od6MtY0eIFzK/6kCnozHm
TX6T85dxuYU2kXjdO6oGBH/dV7O3T77LpUgntQ5c2aAOy/zzHeht/4PLBk/UWDuh
6lBtJo9SdFLB0vVcsxzC663mxEySNyWKVL3CpT+PDUPL4S3qJ73epYPIkWU4OuzL
ojr3Ofo9FJDz/keRCdAnubN7HBnZCLqhtwny8Gq0Sja8SfuOtawrhOvGsLOdbOfT
aQdZEQkmnlXuze+HF0Jn
=ZcyI
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
