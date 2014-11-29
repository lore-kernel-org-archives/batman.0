Return-Path: <antonio@meshcoding.com>
Message-ID: <547A217A.9070209@meshcoding.com>
Date: Sat, 29 Nov 2014 20:41:46 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c9eu5AtGHUlmaoTTPc2Kp7kgduuDw5XRw"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Kconfig,
	Add missing DEBUG_FS dependency
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
To: Markus Pargmann <mpa@pengutronix.de>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c9eu5AtGHUlmaoTTPc2Kp7kgduuDw5XRw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/11/14 19:07, Markus Pargmann wrote:
> BATMAN_ADV_DEBUG is using debugfs files for the debugging log. So it
> depends on DEBUG_FS which is missing as dependency in the Kconfig file.=

>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  net/batman-adv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
> index 11660a3aab5a..c6fc8f756c9a 100644
> --- a/net/batman-adv/Kconfig
> +++ b/net/batman-adv/Kconfig
> @@ -62,6 +62,7 @@ config BATMAN_ADV_MCAST
>  config BATMAN_ADV_DEBUG
>  	bool "B.A.T.M.A.N. debugging"
>  	depends on BATMAN_ADV
> +	depends on DEBUG_FS

What if somebody does not want to bloat the kernel with debug_fs but
still wants to run batman-adv? (i.e. on a very constrained embedded unit)=


With this patch this would not be possible anymore..

Cheers,

--=20
Antonio Quartulli


--c9eu5AtGHUlmaoTTPc2Kp7kgduuDw5XRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUeiGCAAoJEJgn97Bh2u9eMoAP+wbeeCAySOCcbCU/C9QT7JC1
loxm7hlyi3xWN0a1ctuzRZ7M5RdpzyULqfZxny8+Etg/2jhQvLpLuyQeYl24d9QG
Hl+C9scKiIrYyU398dTwFNzY/kjaE3xFxrR26UoYPt9ghlCU0EjAypslaeLxiOqP
dVbKpRn92jnBDJIygi7ETOgCFdhlZm/gqXqkj3KLzxCy7Od9IfObYBS0CevBvd/D
uqhb+ZV2kBV7N0Xp/9jujLBWW/Rf6azAZ03NrjRH9+aTkPrUg9HjWeMTtLY/j8mp
P9FDtBJhRETwwwAcOc49H98BXxySOBVS4NSJlu70S0UxWIrIZuuQaJ0jyhYBZ7cT
7bpv5SaSNdyiR00xvcn5ZpoMGyHAjdUIPh7WLwTjNiQIrBzuS5dH5gNFeO/Btvkl
KaWBhL2Ahqv9Mp8HC0E1jEj1aUEjRPJmzYeHGmVsfCM2CbAbTaCQEw2rfV0vqesi
Crm0uJQVX8AyoRS36Gb18UIfPmYtGQv7Y4kkY3lHUxxB7NuEBhdnAHbfJud0M5/T
/enOegzTe0vwUISRMuld9lhnEIcTbQRvrCDhPjUrGIo9gBWZ4F86/3Y9SC1VEuSK
qkgcJYF1J/BRGh+j7PcxSHLnd83mrd3uKW5RJgSS/am44xX2vajzzWzjdDogCqI6
3H9WHuvn7VhtCRV1Uml+
=t/0r
-----END PGP SIGNATURE-----

--c9eu5AtGHUlmaoTTPc2Kp7kgduuDw5XRw--
