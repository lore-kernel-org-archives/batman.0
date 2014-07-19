Return-Path: <antonio@meshcoding.com>
Message-ID: <53CA3F08.10302@meshcoding.com>
Date: Sat, 19 Jul 2014 11:48:56 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
 <1405410077-28764-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405410077-28764-3-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dtssMl23AK4j6pil6hWpKkDtwEnHd4oEg"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 03/13] batman-adv: kernel doc fix for
 distributed-arp-table.h
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
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtssMl23AK4j6pil6hWpKkDtwEnHd4oEg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 15/07/14 09:41, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>


Acked-by: Antonio Quartulli <antonio@meshcoding.com>


> ---
>  distributed-arp-table.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/distributed-arp-table.h b/distributed-arp-table.h
> index d76e1d0..2fe0764 100644
> --- a/distributed-arp-table.h
> +++ b/distributed-arp-table.h
> @@ -25,9 +25,7 @@
> =20
>  #include <linux/if_arp.h>
> =20
> -/**
> - * BATADV_DAT_ADDR_MAX - maximum address value in the DHT space
> - */
> +/* BATADV_DAT_ADDR_MAX - maximum address value in the DHT space */
>  #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)=

> =20
>  void batadv_dat_status_update(struct net_device *net_dev);
>=20

--=20
Antonio Quartulli


--dtssMl23AK4j6pil6hWpKkDtwEnHd4oEg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTyj8LAAoJEJgn97Bh2u9ecy8P/1i3wXQGNzeDIF9OZnbvMPV2
vRqLWcAhwMpuzoGaG1PRxQvwHZScxg0pUp6g0WK79Frxrz6daBbt/Xk8TeUCubQD
9wOzPaKdRt4O+ZqOnVlEiWuuX55jjj8Gs3IirFls9oQrK3JYyBK3yMvR9JlJJz1C
tWwS2DAJnNHKfqupTWJ9R7zg9wBXqXJlA9yG7sWIXLcvusS9LqIrzTZfO+1bZufu
QElIN3UKLsPAcWQIlx8SBEzw0bQAOjYswUbbMjcrheLxx6GOKVYFFf2y6hz5qDQ3
LXaqN4/rBtsMqVL05cmYFQ2yjH/P9TV54a54igGwlB7fV9d3I6XJaO8811JbbqYz
kBUrzd+a6pxs1Yd+5UHs6tOyY2wFhiVDfO1vSwOprIRclVkeU+7g/KmQRQqUKZsI
G4p1N3wjvTI0Fncx1BynsQOS8P2xuJLjmLuidCmkCEmrOY9MOFXAn5dKg1nVvSYs
f7Zp3uAmtxS/W+Q08qEDYfHd+yayn+5VaKKzYoAIektJto2bi6xJwL2CbpivO8BW
pGRho6pO3xwuiMf4nTzz39/k25mHwK8X8kEMTpNoGyY00I24ZfPFg9Imv4Sf7q3Y
G8hMc7Y31db7nZParESC4HuveIb2ufXjZg/3yiZw39JLl9Al4SHsB4eZgDPzYzRH
i33uIYtK4kX09qiKysJG
=qdYY
-----END PGP SIGNATURE-----

--dtssMl23AK4j6pil6hWpKkDtwEnHd4oEg--
