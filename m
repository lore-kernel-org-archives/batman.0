Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2016 16:30:53 +0200
Message-ID: <1734620.RxNen75AvH@sven-edge>
In-Reply-To: <20160521133555.13403-1-a@unstable.cc>
References: <20160521133555.13403-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2311161.aPcuG74xV5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: B.A.T.M.A.N. V -
	implement hard-iface init function
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2311161.aPcuG74xV5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 May 2016 21:35:55 Antonio Quartulli wrote:
> Some fields in the hard-interface data structure are specific to the
> B.A.T.M.A.N. V protocol and have to be initialized only when such
> protocol is compiled in.
> Instead of having a #ifdef block in the middle of the hard-interface.c
> code it is better to have an algorithm private function that hides the
> precompiler logic in its own header file (like other functions).
> 
> Fixes: ffd2f27908e5 ("batman-adv: Only init ELP tweaking options when
> BATMAN_V is enabled") Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart2311161.aPcuG74xV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXQHEdAAoJEF2HCgfBJntGQJMQAI7/wOREkB2PLH3WVTYHybH4
cCYyuKH56L9AQG30okzJdbwS1LAXHRdpD6z9p10RulirNKFk89rbzJYN+vWHCwYR
4p3QIexKSiZFPGRd0RYJQqUcwkn8yW4bEMU+BDKSxQQtv8CQijXWTE4ATh8o8GaZ
8bT4AQ7H6jcKRuPZVv6PJWo6RFYHOmwuSXqZSwtxrB27dAG0ZZOsXvMzdqH/CGKk
jHG6IUY7TUiNqLOQS0K5ekbYUYLJ/glC93dQbLBeG653UhXINxz/1MJj5N6tNTE3
uWdhdh5VV8zbL2ZNSrhlTigGwhvrtmVgsXCSy4WfFx+452ZPOQZe20bg1TXkzuSJ
S0kfzI9nDJjpYa30Mfh+bedWL2kCYHWApOt6Xh6dnEEqwPGj2jmRLY/EJQcALVj5
9tiGtpDEtL2WPpROcI/Tw36SKka7b8QDxlqqzCI4RE4FACjjJFRsTdaIzNMV/h6P
BSX0B7DAgD1Ll8XV+6ARTbeemZYjbNlmZ4kp/oRrpfoFkhqxwTevZTzzojaFp7JO
UIhIZErtRkVoG4cSlzAyEJ9Mo8kKjXXyoNR4moLlPLObpNQCVXNNhW+mCueT4HOK
z7jD9+C99AZb1NA8u/3kI3QkSul/M4eudlH9bU6TwvIYst0KuVUEY61YWu9RDFL/
Mc37bUQ+4kdSVEbQHbyH
=rX7e
-----END PGP SIGNATURE-----

--nextPart2311161.aPcuG74xV5--

