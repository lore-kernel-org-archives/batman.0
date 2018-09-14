Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 14 Sep 2018 19:48:35 +0200
Message-ID: <2079093.ygK4H1pEnq@sven-edge>
In-Reply-To: <20180911155942.15494-1-sven@narfation.org>
References: <20180911155942.15494-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9096500.e7ONl0PPP1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Enable LockLess TX for softif
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

--nextPart9096500.e7ONl0PPP1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 11. September 2018 17:59:42 CEST Sven Eckelmann wrote:
> The batadv interfaces are virtual interfaces which just tunnel the traffic
> over other ethernet compatible interfaces. It doesn't need serialization
> during the tx phase and is using RCU for most of its internal
> datastructures. Since it doesn't have actual queues which could be locked
> independently, the throughput gets significantly reduced by the extra lock
> in the core net code.
> 
> 8 parallel TCP connections forwarded by an IPQ4019 based hardware over
> 5GHz could reach:
> 
> * without LLX: 349 Mibit/s
> * with LLX:    563 Mibit/s
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/soft-interface.c | 1 +
>  1 file changed, 1 insertion(+)

Applied as e3ed8ad1a7b3 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/e3ed8ad1a7b36bc63b31df6fc9771dc63f8cac3e
--nextPart9096500.e7ONl0PPP1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlub9HMACgkQXYcKB8Em
e0ad5A/9HCzhHB+EH8myauqp3QF5OfWuig2g+MNY7kBPw4WMGr8ttRu6RgATOhAW
9JiV2eQXP2nDN0X6SbnYCw5TEuXN6Iv07lZV3NQQ7XFqpkab1SPm3mLHN2C8re0S
svqnZhz+qEbHOgo2ilapjeOHVGxRnV/3wWV1QwxFLLKiH/5x+bycU5uhlYqwrjXa
q/VUDVcci6t6+YhYQevII4A1gx6JTyl+KJlK3NptH60xIpDzBWRISA2RVpQzRJJi
CWS8Qk9+p6jAyPLvGRrBDWWxo5XFNfM48erpsojo2wUaFwVYLk3VK+1uhOY9bU6P
PsogJ+hqF0zS+2kWcxLNlJupreYPLhJsG2py7ziSOWJChtBiMhLVrJoO+TrqsXxh
Ty8SrJAVATD0ARh9tRVgMbDc/bwZ8aCPGjEjXx/wyL9EJ0XQjVRFiZ/wUm4GSPNG
/BhBbcNC9O61COEfAQGb0a7uoO/oHXVEOY4zySr48uf2EIGxU0MXrcbQV1MMxVkN
eE0sTrZqLlrPw5hR43YNRYSXsXefp7OdX2uuFb3hjv02U+tUxLRHYXeYXLBf/8fg
IabICg+KmOX9HhpmrxDAyQGK5JMA+pW0saCgu/JJmjbNZJX3cQ+lp7senHudHlBE
lhZ67TtUeyccGpNQe4to/q9Zs41Q3dX7TX32I7nklW3p4YmAX7w=
=nqL1
-----END PGP SIGNATURE-----

--nextPart9096500.e7ONl0PPP1--



