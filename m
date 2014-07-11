Return-Path: <antonio@meshcoding.com>
Message-ID: <53BFE10A.3060506@meshcoding.com>
Date: Fri, 11 Jul 2014 15:05:14 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
 <1405081595-23371-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-3-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rbCkswwk0afGWF0b4bIEkkoKdCBLj2PFg"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/13] batman-adv: kernel doc fix for
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
--rbCkswwk0afGWF0b4bIEkkoKdCBLj2PFg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/07/14 14:26, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
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

How can this be detected as kernel doc if you removed the starting  /** ?=



Cheers,


--=20
Antonio Quartulli


--rbCkswwk0afGWF0b4bIEkkoKdCBLj2PFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTv+EOAAoJEJgn97Bh2u9etjAP/Au9jdbWyBUpEDHBHwV6AFhi
DfOprjhd10AaJSF80+VHnG07ZWflCDqtskHj+BUL4mskTV1gXItC6yyae8ZvRz8S
SYjrPlFMVt7EuasCPmszOX5KA9Ihj1X//fnUBl7JT664ol3INig1CKd90VY4KGl5
iWwnHM/8A3qPuDLlhs1JY84rKUJTfg4UlXlsISatFESIn3CEZx+0U09pvBK/OeDb
NjD0c2hM3rF6y7brDRqlnew9NUIVDFgXI+R19ia3aUyD7jU+cB5sF7lLCVN6aJsN
jVhuKiHGNv/2u2tozMspDJQ+WabN0MmYUw8hMuXelpQHu1aPscT0dQzzGfhH6zhX
v2UmPDpPynk73y6jBnkUmddUNIUCZrRTd3qH0r21zo6B/OZ2PZryuQdMZPeObxnA
F2m82bYrMrDr2ovUOYdj+ZNN6Lh3BeeZhL++21CpbQqOraAE9dYOhRWGRvyh6Ag4
WnjR6SBOF0Ahz14pMqYjSffJegVI1+HKuKOSzVYgS+IL3jIqS+spY1ggB1Mt33U7
BZ49DH71SQbwqgGeMNCduWbhYG2nC+Pd8+Qu3xqumgeWraAuvu3qjyZwWeSPS3f0
IadNJWXKyaqripy2f5cv9cpk/b+ZcPUGsuq61YGD/pxWJBSy9bSM+VfIQyP6ENca
Gwpncvd7g1kcIVtNresE
=MzYJ
-----END PGP SIGNATURE-----

--rbCkswwk0afGWF0b4bIEkkoKdCBLj2PFg--
