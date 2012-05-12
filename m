Return-Path: <ordex@autistici.org>
Date: Sat, 12 May 2012 13:56:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120512115652.GB14279@ritirata.org>
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <1336823339-4095-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Move hash_ipv4 to
 distributed-arp-table.c
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


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 12, 2012 at 01:48:52 +0200, Sven Eckelmann wrote:
> hash_ipv4 is only used in distributed-arp-table.c and therefore can be pl=
aced
> inside this file instead of the header.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  distributed-arp-table.c |   24 +++++++++++++++++++++++-
>  distributed-arp-table.h |   22 ----------------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index e678ec4..4894a85 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -32,6 +32,28 @@
>  #include "translation-table.h"
>  #include "unicast.h"
> =20
> +/* hash function to choose an entry in a hash table of given size.
> + * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
> + */
> +static uint32_t batadv_hash_ipv4(const void *data, uint32_t size)

since the function is static, why do we want to use the batadv prefix? would
this create confusion?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPrlAEAAoJEFMQTLzJFOZFVeYH/j8dgXT5MkJ1CjWkSOTOChYX
zo495Hw126CM7RYeVIoSdER2A8lGBeaebk2kv94zKqElTyCMJ2gDs3qeX9qbZY3u
apeSwgBpKzWfVFUFOOQIjBh8XzyxHsR6cqC1DmiErtDIQxM+BdnvaCfpdpmC84OD
EGAZ62XBE88i/WnRmjB7MLvTL0YPWPQSrxQziRY2imArucSZy3Y6Ez7cYIaZWktH
kWjWJR25j++wNqyrw8/ZiT9Fi2cA2rbsTIF/go2t38SvBX7N5GQfO6OxXgjUfPLs
l8LqfcnVJMTjYJKj/a1ySabmXE2qAth1V5YFrUrh480bDV3zpJ9O1IM6ZKtUqVM=
=TMZj
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
