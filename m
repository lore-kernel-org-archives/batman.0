Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 04 Apr 2016 17:48:06 +0200
Message-ID: <7157804.0g29hBlr0l@prime>
In-Reply-To: <1459531356-8361-2-git-send-email-sven@narfation.org>
References: <1459531356-8361-1-git-send-email-sven@narfation.org>
 <1459531356-8361-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9419963.XH1PdhRNXZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Only accept valid mac
	addresses via unix socket
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

--nextPart9419963.XH1PdhRNXZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 01 April 2016 19:22:36 Sven Eckelmann wrote:
> Not only 00:00:00:00:00:00 but also multicast addresses are invalid as data
> source for alfred. These have to be checked too before accepting the mac
> address received from the client over the unix socket.
> 
> Fixes: 58e109973bbe ("alfred: Allow setting the source mac via unix sock")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 25b4ae6.

Thanks!
     Simon
--nextPart9419963.XH1PdhRNXZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXAoy2AAoJEKEr45hCkp6hugkQAJ689LNAHwZRmRzQuTdc7e/T
j5VuZROgTVeaGPfnXpKLfgH2DvePvywCCNWy87alyNuO8h1hkAbTct/G8GP+Wv+E
S5rz7Q+iIHW444AyIu6bk8bFx+7Fa8/xjDsJ+oPZNf660uQyiTCwG4WVM7NQEPpi
CcXO4l8PE/y9Gq2eX/qWGL9jY980xevHQ4Np6xbBBpU6Y/wXGfNoCIE4lHTp/5Fn
28UsDgr4kYW85Ebb8WTSZLlP6uTxb3lrvKbnrcheZ3G0Vw9qKD3b2CqbZrJT3f/Q
KRH2kKzt8bD4KfQ3X1N2PcD9A0neEKuNeeHN0mDKJOCPgY7lNq2GWGX4peOtfAvZ
9EDfj3/4niSryEhiqkOjjoQhNb7G15+sMTptrjLYtIY/4IaLMQLxBkiwl6dLHdA4
WJmUOqzMZnaAQPt25kLBJrausZHzLBLxHbrUdWwmZ3Eqjx8PqFIjLqNiorbFhIFg
RuKa85nkEwG7swhYTb+dWrb8M87vXAyxe3bTWyJ3ZfBiy4+waq+GQKAPKYoGUMxv
yHpCeIdZ65aGbXmqcGlnTpu5DvzdTop8xd/Jz4YnQNvRsQivRMJUGz5VjxPZWZeO
0C99Flr5EfgUxtEeRXWFNw9wjxjv4zXaOYYQyG562Sh+gi7C9UDMN3OKjJkLbbBz
8yhvadlCeKu0XV4yyQXg
=EUMa
-----END PGP SIGNATURE-----

--nextPart9419963.XH1PdhRNXZ--

