Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Oct 2011 16:57:29 +0100
Message-ID: <3309808.jFsLfLl59Z@sven-laptop.home.narfation.org>
In-Reply-To: <1319989246-3670-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1850275.SO2QzbpOTm@sven-laptop.home.narfation.org>
	<1319989246-3670-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2631024.8o764XIf9i";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: explain the weird TTL for
	ICMP packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--nextPart2631024.8o764XIf9i
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 30 October 2011 16:40:46 Simon Wunderlich wrote:
> A comment may clear this up ...
> 
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

NAcked-by: Sven Eckelmann <sven@narfation.org>

No, the problem is that there is a ttl field and a version field. There is no 
reason to use the ttl field for the version or the version field for the ttl. 
When we query the information from the kernel, why don't we use the correct 
stuff in the common header structure. And the ttl position wasn't stable... so 
it would create a random number anyway when mixing particular versions of 
batman-adv/batctl.

But yes, you are right that the TTL mentioned in my first post doesn't make 
sense either.

Kind regards,
	Sven
--nextPart2631024.8o764XIf9i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOrXPpAAoJEF2HCgfBJntGBvcP/RvsARfluJLOoAq48PwaFyip
hEbmkwynUK/q3+tzzZZD7jeIg62LkAXhRV2jZdhrISWRU5DtW8trjRZyQD5OFIQZ
z1klPK062NUrnvrT58s1Xf8RW7m/LtI1pifIFjZeFiHaj9OAOP1/HUNPzW6vATvH
qe13Pm8MAYpjxbXJguKXDvQwvqbdXz/RgJ5QEDjdwHoIHSKzydS/4rTAMFFbcVBF
wEDb7Me+bpH5tVsvA9/q6kG8/rjR89cWg0f6foUo7XvIzFR/WFnOuMg67JD7De48
JtbK2PgFQk0JAC5pyhjJmYuCuYugb6luJEIQBAqLHuozbTwjOKyuJC410autCha/
JymElYhuVCalohM+SCRWzGY56pgBpga+h6cjuIPaqDWK6EtewNNeZz8irig2mSaR
6PKLckLTWsDgAsrVX1RiNr05Qryp4vh65yS6jZQyshm0+WCQRuwsHsjhRRT7MSxB
bAoXfXBAoD5zRtWzzyDfT67ugAJeYfv+IPtdDshot0BaYqxjJYgcB3hqsanXmyvQ
QiNpGw02vNAGxTEvg7/WnnBgWHpyO/u0+g+9Zc/PfteWKxiXqnwEecwPRBI4Nqy7
BlDGg1r92i5v6KACidOgeaTEOLzbiNe4DLLRwJrTzHdnFHg9MBVYauqCAQKHp6qJ
KuADlGGidKmOesqJUJng
=ApbK
-----END PGP SIGNATURE-----

--nextPart2631024.8o764XIf9i--

