Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: openwrt batman-adv
Date: Tue, 24 Dec 2019 10:03:10 +0100
Message-ID: <2363117.f9ZONqFbmS@sven-edge>
In-Reply-To: <tencent_01E5105A2CC20B1B047FF188EFCF47E55D08@qq.com>
References: <tencent_01E5105A2CC20B1B047FF188EFCF47E55D08@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1619690.nZUtLWqyvc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: =?utf-8?B?5byg6bmP?= <1805692831@qq.com>

--nextPart1619690.nZUtLWqyvc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, 24 December 2019 09:37:12 CET =E5=BC=A0=E9=B9=8F wrote:
> Hi,
>     The platform I work on is openwrt mips, the kernel I use is version 3=
=2E3; the version using batman is relatively low, and I want to use the new=
er version batman on version 3.3, but I encounter many problems during comp=
ilation, and I don't know it Whether it works ?

We dropped the support for kernels lower than 3.16.80 a long time ago [1]. =
It=20
is irresponsible to still ship such an old kernel (and batman-adv) version=
=20
with known security problems. And the last OpenWrt version which used 3.3 w=
as=20
something like 12.09 (Attitude Adjustment) from 2013. It is isn't supported=
 by=20
OpenWrt upstream since many year.

Please tell your hardware (+software) supplier to provide an up-to-date=20
software package for your system. But since it is OpenWrt, you should just=
=20
grab 19.07 [2] and use it - and if it is just a OpenWrt fork and the hardwa=
re=20
supplier never submitted the support to the official OpenWrt then please te=
ll=20
your hw supplier to get the support correctly integrated in OpenWrt.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/7ab78d556b343b592aa80f4=
d84b2dfd14019f2d8
[2] https://downloads.openwrt.org/releases/
--nextPart1619690.nZUtLWqyvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl4B1E4ACgkQXYcKB8Em
e0bipQ/7B0uL5ox9tXATZq7NIGY97BhMIdO+8hAEuhNOKIVAYvonMkePTJdJmpG+
l+fWnUsZcHQNNmORQUqEhr2rUTQvqzZyFatbGWS5bIcxz85gtKdzXE2ej5vSHUtH
MjOHuE/Dp8McPnrBpTaKdE0tp7doIoRn/WLeS76Ch/lPrsikcLLXUwbz3b+okfNQ
nE1Xtw4PMsnulqb+wXSMaRmTj+1P3yQ/on9quruwC5jEdM/Ob8m+GdHKf4Tf8x1R
Z5ZB6lc6VrpFb1IAG794xT2UByCjwkw2/LYm0WhGEORQU6jNch9C3h1oBKhnv496
BVzxSDOL3UuNX4zYkzX7Rr287ezryGmevfg2S7SxrEH8heAQzoZ1uV4yhwtJwVEy
OxZ8HqWvYeEJjvgWUReIpB0mz/qA+uFZ0oOFTEcMi8vYqj2THiNcwmrDTEPzWcA8
pC60MhHyP4hpgId9Vfw1G0ycFIJSd5pklDPANTYoDdH56eRdgYyclDTpMWEoH/+M
iT7mhMVQ/5wi/WucJRZtk1OGi0wY28HQq7Uj/hTBVPc+AtitQvREZGPvla+6n669
FHf8R8qfEHBHxgQHlWm9NLY1o8ek5C6l9liQKgUQnZV3wyVCHuAQ9j/iB0SrWlyV
7JWxSuW5A6fO6BksoQUzeheEFMnm68dXZB4mZJN9HBwDpcEmao4=
=KiKk
-----END PGP SIGNATURE-----

--nextPart1619690.nZUtLWqyvc--



