Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Sep 2016 15:01:04 +0200
Message-ID: <2405543.TZHNHoipHL@bentobox>
In-Reply-To: <20160920121245.593-2-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1728695.iXqq5isNtQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Store and transmit own
	neighborhood hash
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1728695.iXqq5isNtQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[...]
> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
> index f20742c..35e220e 100644
> --- a/net/batman-adv/Kconfig
> +++ b/net/batman-adv/Kconfig
> @@ -18,6 +18,7 @@ config BATMAN_ADV
>  config BATMAN_ADV_BATMAN_V
>  	bool "B.A.T.M.A.N. V protocol (experimental)"
>  	depends on BATMAN_ADV && CFG80211=y || (CFG80211=m && BATMAN_ADV=m)
> +	depends on CRYPTO_SHA512
>  	default n
>  	help
>  	  This option enables the B.A.T.M.A.N. V protocol, the successor


Nearly everyone else seems to select the crypto sha512 module (maybe we should
do the same?):

    crypto/Kconfig: select CRYPTO_SHA512
    crypto/Kconfig:        select CRYPTO_SHA512
    crypto/Kconfig: select CRYPTO_SHA512
    crypto/Kconfig: select CRYPTO_SHA512
    drivers/crypto/Kconfig: select CRYPTO_SHA512
    drivers/crypto/chelsio/Kconfig: select CRYPTO_SHA512
    drivers/crypto/qat/Kconfig:     select CRYPTO_SHA512
    drivers/staging/lustre/lustre/Kconfig:  select CRYPTO_SHA512
    init/Kconfig:   select CRYPTO_SHA512
    init/Kconfig:   select CRYPTO_SHA512
    security/integrity/ima/Kconfig:         depends on CRYPTO_SHA512 && !IMA_TEMPLATE

Kind regards,
	Sven
--nextPart1728695.iXqq5isNtQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX4TMQAAoJEF2HCgfBJntG3Z8P/2RFl7EqKiY8PO+fgGTiBAAV
QY26DeHkn72NZTLs6J5nM2zrFjA2B9XQh8YG4fKvQRtE4SOVYJl/BhBv3j2CVfvh
QLUv1RWj6bcONoUwhaxVlFXM5Wutm30T22o5sHjXZrAgNCz70Xkg3p4uApRYcFe9
1vc2BIx3KNSToeZLVrkeoXjCg7g3UJVl3sATRAvz9IgBgxuuDdpobEn3g3ctRAIT
nyIpuKxIqEQzgAiHPh13632UL84j1+SNM1gshE8WPYqebLm2+86F3ZE99S5Lqm6X
vtKSFlaULMGDZPFGih/1xga5y3BhuSHtStNJw3hs1tvP04pX9F5QKvLYi1Kmuyck
A9TbUdTlwh47aKtAzch/DuOdI2XlSKloN116RG1NP0q3MRerMT8PVtxKQgZd3bEP
fP4Xi/m+l6l5WBzVL3Pbj5lG3DqkKzOTLf9+9esxX8Zz0tFd4rCW0Rb2B+z2sTp9
LiplFJiPuC56S9j17hxd84O3YVJyoQbV+jigyiMIQwPVS1U0OBYeDsx8Y7ywhdpo
3oFXAugtyKBnrbyR9NeXAnIocDHxtgGhrvUGKhV6RBURG/9aD+/UzpV52DzVc0iv
hrk2AQ7hpOXdx5YhQC3ncRAZ+tA1R0N3B7Z04cVVeati+JcQF8sVswycYsQBaTgq
acr9j1ShGlo1cJyvHmXR
=NV8m
-----END PGP SIGNATURE-----

--nextPart1728695.iXqq5isNtQ--

