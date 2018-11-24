Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2018 18:52:48 +0100
Message-ID: <1694017.nOdmXTrEoU@sven-edge>
In-Reply-To: <20181123161359.13342-17-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
 <20181123161359.13342-17-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1712775.IgncgPvfao";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 16/19] batman-adv: Add orig_interval
 mesh genl configuration
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

--nextPart1712775.IgncgPvfao
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 23. November 2018 17:13:56 CET Sven Eckelmann wrote:
> +       if (info->attrs[BATADV_ATTR_ORIG_INTERVAL]) {
> +               u32 orig_interval;
> +
> +               attr = info->attrs[BATADV_ATTR_ISOLATION_MASK];

This should have been BATADV_ATTR_ORIG_INTERVAL

Kind regards,
	Sven
--nextPart1712775.IgncgPvfao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlv5j/AACgkQXYcKB8Em
e0bU4A//V6qtcjwdlBhALa8CYBQ9kTQex3OEXOtYz+VRhQ8T4gzjDhw3q1gJwTcE
Y58p/XM/zp13aLGF2+wp9CRhqOV596pUdv0Ih4l5USQGqwXWVZTqOc7mQe8KcPeJ
C2jogbKazKVsuupODYICxictWU8i253HHFnDiUA32iYzKHF0k+/TWixVZT9T0QRE
q1pSGPYoYlmH38n6gC5EfF2JupntpWLWlXn3FeGfeSlrKU4Gzaaqk9bxYukjLbFt
WsF6vJPRJO9f3ol/cy0jpoiv8Z1+QK07O3jzVGh8McJET9US/CWM3eetgy9DVXN6
HoEicT4jtsYAsQGvhUd5x1ODBxqFt2+CN8AVY1ApvP80Ee937seoqkWGrJQ9EDzx
BqGtcEe2sQMcBvGBItk6bTj4bSctHSP7Xt8RqeZ7hT86zXQ79Bqrtmj9ZDvCESsh
2WVrkeHwCZijpD8rEfVLl8erNbH6W9Uby/q1bKjF1zKHNNFb/M2thbTvPppQZAhM
3QchQZLKzE7f5lce3fZ8Q9HOpQPIGgt+xuVc6kaaEOwGNY5SduWGtDltYiGE3tTB
tP/wmua1O8YLyThzuu91d1PMD5C46p6qTTGXFZU9QMlI+zSHOy/Wfyq9mGtiCrUk
yTmGsiTIzL7O9FhrM3r7yTHdrUUhz67BOuobG/5OJ9wviZN7l0M=
=rSRM
-----END PGP SIGNATURE-----

--nextPart1712775.IgncgPvfao--



