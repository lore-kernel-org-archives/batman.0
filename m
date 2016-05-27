Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 27 May 2016 16:01:13 +0200
Message-ID: <5051653.7LK392eFxL@bentobox>
In-Reply-To: <20160527135729.GS13048@prodigo>
References: <20160525152736.9031-1-a@unstable.cc>
 <1623801.mhGnxyytJi@bentobox> <20160527135729.GS13048@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1777122.WKCm2vHHIH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 5/6] batman-adv: B.A.T.M.A.N. V -
	implement GW selection logic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1777122.WKCm2vHHIH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 27 May 2016 21:57:29 Antonio Quartulli wrote:
[...]
> Do you think it makes more sense to keep the declaration and whitelist the
> function in your test ?

Yes, this is the right thing(tm) to do. I've already whitelisted it for
the unused-symbol check :)

Otherwise sparse and smatch will scream that the non-static function
has no declaration.

    net/batman-adv/gateway_client.c:363:23: warning: symbol 'batadv_gw_node_get' was not declared. Should it be static?

Kind regards,
	Sven
--nextPart1777122.WKCm2vHHIH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXSFMpAAoJEF2HCgfBJntGKQUQAMyVp1RnIA9SevvYgaim5R5u
lJfe8zL+OrN/zNWYbYcEZjSYtu+gcwwnf4vKl47GEwSaR/48AdwcPvK4FfnKL+d5
fobaNreYNXUTav57CJSUe0xn/i8gk6Q6SQ+nmaSgPMg+KmRly4Y1cBBvnw4s/E8Y
Q/CFheDsMaUgneU+ktrSm63XS42qEaXGvkobhV54EO/Xpi2QkVZKNJRrDzNzOmwp
bydaJsGGiTFoA8Ingmzi0D7PynqNAJJOGeCwbP82c3vHxwuSjIeMCt0D3IB5Fz55
3HVkCTnwBw0nDe0TosLGfSv/LVk1K6CwQ9jHvs1a4y1Yl9PuWlqRH7D3ZwgsMleg
i7uJr0s32ViPrIRhuhWoMDzFEKRBV6QQFmjWAZ/j9Wf0dQ8vCZjhOSJvO24kARrX
Yz7CivGaE5ZtN6XTgohN4k6dPLDyoW+fW/QDCxJzFXpiy/+tYaID+a6Ib54nA+bR
NFsaP6t4O92IUP3ba+i2uyJE6LTtyNGiDdATJf6AcEem7oe8fQ45e7X8fNsHk0Th
732fPUP2crRMb2DZMt3LIWpuO83wvog1yxz8bQvtuLSnWDE1ojuYU5kt31477GRY
0wnelBki3j+eYzJqFefxWOjKxzB1nWC3nP9HmGqCdKQDvHdQQRMbcL25d0DMxLor
YvyLYpkQuMcNSc9RkIbF
=7fAq
-----END PGP SIGNATURE-----

--nextPart1777122.WKCm2vHHIH--

