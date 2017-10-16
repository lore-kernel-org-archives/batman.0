Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Oct 2017 19:07:25 +0200
Message-ID: <2908300.Ae86fhuNlt@sven-edge>
In-Reply-To: <20171007121853.6278-1-sven@narfation.org>
References: <20171007121853.6278-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5803045.Be0CearnLX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Add extack to
 ndo_add_slave
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

--nextPart5803045.Be0CearnLX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 7. Oktober 2017 14:18:52 CEST Sven Eckelmann wrote:
> From: David Ahern <dsahern@gmail.com>
> 
> Pass extack to do_set_master and down to ndo_add_slave
> 
> Signed-off-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: Add compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat.h                        | 7 +++++++
>  net/batman-adv/soft-interface.c | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)


All three patches applied in 7a1f25d9..0ce469be [1,2,3]

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/17098/
[2] https://patchwork.open-mesh.org/patch/17097/
[3] https://patchwork.open-mesh.org/patch/17099/
--nextPart5803045.Be0CearnLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlnk500ACgkQXYcKB8Em
e0YrpA/+OlSoEYCQzD2BcxJi38+o5AWUWLcUvkPzoyyQ7OLv+hc4xtesGOCy9Re3
n0g/s+sw3LMacrDUqpx2zoz5EKcdWazG8GASwynlH8URG9Vvgn6p7WkGwVo2hgCU
xEF3k6xvokTKlO41BYYrGSaZr52uIemjjAqGDIAUs1gBtb4IN1efkOU2GAXNEmAe
65kI0ABwGOtq0cJgtSYP7VGbxccry5Xdp9ofJQ344U57ucPdKpmB2/AG0soETiyT
Uuwd0y/AbkbcojQi9Jkz+/gk0g23t6N/0DTisKqB+5u/U5YPI6OL95mcWhc0oYO6
08ZsHRulXxTpApsFynxE3CkxB74LOd1dOG7pzeM+vwmdukaaDccfifSdROJveGHV
oaqFMy+guWQUeRoGY/DJVNTirbx+JGUnacPeyvPtkwVF4GxbpAWV9Ogl26JAS7Oy
oHckaqRYuvipILyxYsmVq2quChEtyaCiRaDgo38bcvze5T2OFMsSA7B45VA9z9KU
Tu5YFB6t1cmAcZRX/DP4SCVsnT9yCstpVG0va/a+cwMWC0TYv3nMukOOhZOIGkB1
sLrmspXdoI4PUBbuSR3bOB+RkvSbpvrTJVRim1Uu5c+FSwbKXdGavwtQul1umm9i
SRQJ0jRVoR6pC9sVCQrfsqpxmaxrM79FIg1bx4jDF3AYOPo4LAg=
=uWLM
-----END PGP SIGNATURE-----

--nextPart5803045.Be0CearnLX--

