Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Aug 2012 09:00:14 +0200
Message-ID: <7478673.Y7b8uEpliJ@bentobox>
In-Reply-To: <1345418559-27150-1-git-send-email-sven@narfation.org>
References: <1345361393-8759-1-git-send-email-sven@narfation.org>
 <1345418559-27150-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart149497974.BnzkSS34XK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Set special lockdep classes
	to avoid lockdep warning
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart149497974.BnzkSS34XK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 20 August 2012 01:22:39 Sven Eckelmann wrote:

> lock get a special batman-adv lock class to avoid a false positive for each

The first "lock" should have been "queues"

Kind regards,
	Sven
--nextPart149497974.BnzkSS34XK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQMeB+AAoJEF2HCgfBJntGBOgQAIhtXwloaAFm45VhNDuNUuMx
cmf00/gIsbxmj2WGqayUBSbWR64bzr5IJxibI2UIJqj3nwoYoKnovBK/yvYWgbGd
qF1Nxhz2PJJnLNCvkmybCRJX/H/PlsApOZXSwlBbwz1ol26HOCXN4GR+EJzcakpH
r4jAVKiwRCggJyTnvHjCqQELMiOJX8ACujbN1D1BiGOY3OO95CW2H50ISi3Xkbez
CIXWt1WFyaiwdkS9Fwy32KskjJfbSpVWDkTGkNcNHo5uXMoFL3EiW1lYdtN219Nx
l6gBgtsdVzOnk6RboOOZnHAbltCXKch3LRh8PJCu8nn8Z0Zwe2nIfYeLPwazpxbp
hbQbS439xvDOX9NhMfU5FPHwAhAlO/iQwWR8fqRsglcq2HKiRhIGJgStEzXL/WL3
kokyAa4ZD3TlhXYR6LIWvNl/r2+O12jdZGQG7ckFRWnKGbgU+t3Kb933DhU8Co0y
MJCS2gqclnyu7LDbQsi3sQ278+FfKupTKxv2RtLcKzKu4zndaMjvPBYYk2mAYd+t
oY+E2nE6kADwXwghwqzEkBc463lAM0DYaC4xi1mbUZZu0orm0Qk4I+3aPGNCncOm
6CVtizy0fZgKbUKBNUT0Q+dgPGwrc1SzZDu5J08/gFY57+52SEoEztdYR9fDYR3F
P/TsiUcdvKY8GEWjAPSH
=c5N4
-----END PGP SIGNATURE-----

--nextPart149497974.BnzkSS34XK--

