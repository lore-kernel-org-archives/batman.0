Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Jul 2017 11:35:16 +0200
Message-ID: <5381040.oULHX02DyE@sven-edge>
In-Reply-To: <20170721091709.7978-1-sven@narfation.org>
References: <20170721091709.7978-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2060915.FXPscDntj4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Only enable priv_destructor
 compat for < 4.11.9
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

--nextPart2060915.FXPscDntj4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 21. Juli 2017 11:17:09 CEST Sven Eckelmann wrote:
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 11, 9)

The other option would have been

#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0) && \
    (LINUX_VERSION_CODE < KERNEL_VERSION(4, 11, 9) || \
     LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0))

But it should be enough to use the shorter version for this stable kernel. But 
we may need the other version for older kernels (not sure whether it will be 
backported to 4.9.x, 4.4.x, 4.1.x, 3.16.x, 3.10.x, 3.4.x or 3.2.x).

See https://www.open-mesh.org/issues/342 for more information.

Kind regards,
	Sven
--nextPart2060915.FXPscDntj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAllxytQACgkQXYcKB8Em
e0ZtOg/9HbERp+4IWYdTXoEcKpbOW5BaJw+CtYrBw+NdFtFcmcJITIAXQhDbAtxd
//XUK8IliYnCwsEii8MWjx1b0WPgl8J2WQ/FViQkupSVDUYgmd7vvHAg/Mr2yZaK
33zqaNN0DJE005AY2qPd8gyxIScdbCQyYTYsPeuOiHX8MkaxGkXrgBswaxUtwRnA
Ck8UTPFwMxfzoBxqwzjXWg2qm+xkiiPgcsfbZXKpx8mTj4iVl8m1Ep7E9KW0XRUX
1hWp9BN0dNvdoKKQsqWd7+nvM+444+X4VE1YI42kyA2n4oo/QNENAeAd5m/hLvyq
J2J73Vfpc0Xjc2bxpn74IbTGszAX7o24Dt+Y9QyPn1kJ8qm/zdX7wG0rhvtBKcRi
u8x7giDDtJcAsk+s+5BEJs+YT1Dp0bzxa1XCL6lOHth8HlT4htCG+Nyl4aYqOrxM
HJH8ZdXKFOqxK2e0hOJsqiWFwpeBhtDcfPNZIrEnJTMLPwfDEWHry/v//ZmXgKaK
s73c+Yw7ZZ9dAlE9VHMZ2lik+E2BgKNrWR81US8XUkE5CGElNR0Fsh6r0yWGaj8H
d3yrbaDxH8uIM1pXLLe6JHPI36VyxlOmcdECTKiD/DvkakSwkYcpHBenLYuyF0z6
zdYquUiyBljlVx3uTwatKBQXtuF9jm3XuGWhH/ca0cmESY+7+xA=
=SDhl
-----END PGP SIGNATURE-----

--nextPart2060915.FXPscDntj4--

