Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jun 2016 16:00:10 +0200
Message-ID: <3504520.4WTWZUr9vM@bentobox>
In-Reply-To: <1467274165-2866-1-git-send-email-linus.luessing@c0d3.blue>
References: <1467274165-2866-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4735833.MlyeRxG8xu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix Kconfig dependencies
	regarding multicast optimizations
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

--nextPart4735833.MlyeRxG8xu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 30 June 2016 10:09:25 Linus L=FCssing wrote:
> Since recently the multicast optimizations are using functions from t=
he
> bridge module. If batman-adv is a kernel built-in, then these bridge
> functions need to be accessible immediately. Thus adding a Kconfig
> dependency for the multicast optimizations to depend on batman-adv be=
ing
> built as a module if the bridge is built as a module, too.
[...]
>  config BATMAN_ADV_MCAST
>  =09bool "Multicast optimisation"
> -=09depends on BATMAN_ADV && INET
> +=09depends on BATMAN_ADV && INET && !(BRIDGE=3Dm && BATMAN_ADV=3Dy)
>  =09default n
>  =09help
>  =09  This option enables the multicast optimisation which aims to

The used functions are provided via stubs in include/linux/if_bridge.h =
when
bridge is disabled. So the symbols are only missing when the batman-adv=
 code
is compiled as part of the kernel but the bridge code is compiled as mo=
dules.
So this change seems to make sense.

Reviewed-by: Sven Eckelmann <sven@narfation.org>

It is now part of the linux-merge.git.

Kind regards,
=09Sven
--nextPart4735833.MlyeRxG8xu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdSXqAAoJEF2HCgfBJntGo/kP/1h2MPNtgHgSA6fpp2rFXg1S
tSzSSugWKtjDg7Wo+UC926GK0VvZVs1JCs26eAnOUMbEz4xwAo80wuq2TiU8YLZb
bEI2iFe+G/ZtgCcJE8ggqSp11Wl29WzCVm5qzGsbyR+lOqs+IYT5w5vI89v4VqYZ
VcDFIz0Sn8EaimODPVWIirOsQFbC6GCh8myQ3UlkqjRmvWEWxgKhLHAxvCbo+IEt
ECWX9wU1P0TFOt5Symrgw4VJukkXHSir5UIkHKhW/RJkLI8X4JBy+ER5PngdKPRC
nmogfO9mV1Nlm4isnl0Z27n1Lykz1ODU8bW8qVmEWjm4VQH+FKDy0TtEFTOVsnad
jh9qa8zoAixfNkau/iCguoJgrS70TM1D4t8FKocaQmGKoHfTkcWak0BhrWion3lM
pZOCaXDHMlWK5+Wov05Xul+h+bGpPpv25Ek1n9XqaJOsXmsxRNBq0exzDeiHrVWx
VzZ/PANbXeRtiR9fxukXwDQGqQU7Rr/Zir7UnoRdOkUSgRgogOJJwzomVgVsOAPB
cVFfIsSUfz4O27p08+vZ9RYRH1tQgc/uxQMV2Zl6Z/0+T0PqeUqYgZnt325Msnn5
ywr6glv5Q0fn9Y/OB/qJYHayAvs8kqiJhVpUiqszwVJ/japljI8837kcwqOlQwGO
3QcjyqnjEYLsIY6pmwn+
=MB7L
-----END PGP SIGNATURE-----

--nextPart4735833.MlyeRxG8xu--

