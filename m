Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2011 10:35:06 +0200
Message-ID: <1526434.FaG4SdHL5r@sven-laptop.home.narfation.org>
In-Reply-To: <20110717191407.GA7377@pandem0nium>
References: <1310899392-1941-1-git-send-email-sven@narfation.org>
	<2528846.xa574SJbNA@sven-desktop.home.narfation.org>
	<20110717191407.GA7377@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1356357.cYkapPOCVI";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Start to fiddle with compat
	stuff
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


--nextPart1356357.cYkapPOCVI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 17 July 2011 21:14:07 Simon Wunderlich wrote:
> Hey Sven,
> 
> actually I wanted an ugly macro which keeps the kernel version check in
> the compat.h only - I tried my luck based on your patch, but i failed
> miserably... I just can't tame the preprocessor. Sorry. :D

I never expected that you are able to fix it without doing more ugly things 
inside the source code.

[...]
> As a compromise, we might upload compat patches on open-mesh.org for
> release versions of batman-adv. No maintaining, just "best effort service".
> We keep some more unmaintained patches there too [1]. What do you think?

That is exactly what we started to discuss. Personally I don't have anything 
against it, but Marek said that nobody will test it and it will be harder and 
harder to backport. My answer was that it is already even harder to backport 
it to 2.6.21 without modifying the actual sources. But at least it is a way to 
share some work for people which have to work together with.... against a 
marketing department that doesn't understands that "supports latest linux" 
doesn't mean some old and rotting linux 2.6.x.

The current steps for the compat patch is to revert David's patch (but modify 
it to use >= 2.6.29 instead of HAVE_....) and revert my "remove that old 
compat stuff" patch.

Kind regards,
	Sven
--nextPart1356357.cYkapPOCVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOI/A6AAoJEF2HCgfBJntG97kQAKgz+Qh/IC1W2EVphXtqE8eZ
jCRH6Zq7QGg7jmclqEjLN08Osiy2jBjp4i7n1IKQs6SXkIJnXpmdUIbqGEl+6loX
GMv1Z1XKXab6y7wxy1G7oN4dy8oqHm9bWWsCuJ0/gAYBTH6Fil38hgkTL+aqwaGg
B2PooG0E3+wrJh1OnfKw+CqpiDpvibzbt2mE+mlb745P75Rf2bkMolVE9luwO2oC
xGnnI4sVcPl/4ck6IEcpcNJlukBG3wOLBj6xsU81Bdg68tdiEPltF6HSIRWhn5Ps
wYe3ZIhvjpHOHNX200Wasb1cdTggHKuXpK/sWtkubm1K4i9PEnvLU9QMclKeKWUD
xvigveAK5o1iuWYkrKRSco+wmMGwYpnO5Pu6mCrZXRSu0M6k+7aBh5aU+9YWwUe8
rgfgefg/r9c6KMiUwCvc4cnXsMRENgwNtEbyLPwCqq7AOe8xrsUyn0wGvSsITbbl
0V4x2OOI2PX3ikc3qKwSCQZQrU4d+pxXU5xbwmLKVeFyy/620MOPXqQadVeVhIrt
2lyMCR0OfioMclGjeOJ3Dk4GYpXZ3tW+cxMT7+l77WiXqFClNAvBSQHtA5+ouGKB
WfbvnuTOSZ3KDU5zZ7axNSJDHmvy+XcZfd6lTb8f6Z1Q7lij8+S+6TzSFcAS5zdO
gv9XfcAncY2TurB4zDAW
=RLLT
-----END PGP SIGNATURE-----

--nextPart1356357.cYkapPOCVI--

