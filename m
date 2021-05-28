Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Remove the repeated declaration
Date: Fri, 28 May 2021 12:00:44 +0200
Message-ID: <56516093.ber78CngbM@ripper>
In-Reply-To: <1622195785-55920-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1622195785-55920-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13351496.OZpsN2k5gf"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

 
--nextPart13351496.OZpsN2k5gf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH] batman-adv: Remove the repeated declaration
Date: Fri, 28 May 2021 12:00:44 +0200
Message-ID: <56516093.ber78CngbM@ripper>
In-Reply-To: <1622195785-55920-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1622195785-55920-1-git-send-email-zhangshaokun@hisilicon.com>

On Friday, 28 May 2021 11:56:25 CEST Shaokun Zhang wrote:
> Function 'batadv_bla_claim_dump' is declared twice, so remove the
> repeated declaration.
> 
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.h | 1 -
>  1 file changed, 1 deletion(-)

Applied

Thanks,
	Sven
--nextPart13351496.OZpsN2k5gf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCwv00ACgkQXYcKB8Em
e0bgmQ/7Bfub8mMSSR8Q3Rp9lJk0s7uHkLHB+M5TxDZTCKTpxCPvWANddLrD4cPy
FmrjUMXKIyIE9KSGiX+C/XLB7cMNpH5gyuiZ1xuVOtw5zqyNqliTqOvx8ODOUQ27
NvsFKDvBl3TwhqCfDHwp7xWssLDCx5Yisc0SSlGC/Ev+0g55PMHL7IiMaALFrjnZ
2WWatv2D7GoSeDSNgRi9rHQUeUXpo6nKDSy99DDQHPt2iHsAErZvN65lSt0wzkGC
M1TcsZmE9+QTwnHKdbwwsoEZ1IFU59ovxfoQ8KCBw+0t/UAoTvMN7hSB8Ph7Ar8a
UrsMBL4T/NpOmNFYiaLjHfIjd6AKHUhv4kFTWtY7e9MkhF2LMyi9oNqjiX1LwlIO
RxI7jyyiUW5z4Jz+ioxOG60UD5Q9GEgJ1/5Ecb4U43HYBBUy3DaCLHXIxXhjoQgG
z9uARVB0xfGuvegJElr59eNRGoAN9EbL6AlJQRb4kuF78fHRP8gYD1u3OswTkSHt
om6WIlsFqXTRuz5W1dT72TQ4LLTpHziCV0B9ZWiYrL7mrjwi03RcnwbAIe7bS/us
wGqIbdpny63hiOD+wpjqr7lt653p9KOlDn/10JIip2W4tkRjBzRriKU+qLxFjMf5
7M6+0uKaRa6vfRZ4N9jW0dAO+EEzFBsOOs5OMbssO/Ij6d1+UEI=
=36As
-----END PGP SIGNATURE-----

--nextPart13351496.OZpsN2k5gf--


