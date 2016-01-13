Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unused
 BATADV_BONDING_TQ_THRESHOLD constant
Date: Wed, 13 Jan 2016 09:40:33 +0100
Message-ID: <5342457.c8rZ44sIM3@sven-edge>
In-Reply-To: <1452561325-12947-1-git-send-email-a@unstable.cc>
References: <1452561325-12947-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1868933.T1kRjTMnkn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart1868933.T1kRjTMnkn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 12 January 2016 09:15:25 Antonio Quartulli wrote:
> BATADV_BONDING_TQ_THRESHOLD is not used anymore since the implementation
> of the bat_neigh_is_similar_or_better() API function.
> Such function uses the more generic BATADV_TQ_SIMILARITY_THRESHOLD
> constant.
> 
> Therefore, remove definition of the unused BATADV_BONDING_TQ_THRESHOLD
> constant.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>

Just in case somebody else is interested since when it is not used anymore:

a64108267584 ("batman-adv: adapt bonding to use the new API functions")

This is in v2014.0.0/v3.13. So it should be fine to remove it :)

Kind regards,
	Sven
--nextPart1868933.T1kRjTMnkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWlg2BAAoJEF2HCgfBJntG06AQANCmTokftZTdnIKD8U6BwweE
L+prjUIKBJusiMuG3jR1YU+AdQQITAyq5ZS1GlX5ZVu4TocYJi1BBL2lC49Yn96+
OwU7zI+iUd5ZZYS7FKIHExC3z1icnuhYS7XFd3VNiKIb1CNmTvuORJMehCYr1N1T
Uc7bHggix0IZmHalVNZ7nTQlfDSIhgcJ9sDBBOQFxsbpsS5eRbEkCPEO7XiNXTlF
KEwGdMoRkh3z4Csh8yDvW3eCVgXXlsQbyjDW76D8pBFbKBj6YZGyZMnC2xpHCfJr
/gqFJFJZZxCq4bRVKvJsFnF9zdsD4XWtitkRQbR3uO5as/OaCMZvtrwIkFJNGQ0T
6/qLGqILN3IKa5/o8oUDgmffPlwUnP8pWZxEtskTHyvJYzv9lqtzcfqjR9s/ukan
O6M1mC0/agRZdGzSjbVQm3+rKkISEc25O4tor5Qk7yaqUqKN2Uar6+9SGEHFGuZL
2D2yvZaqIbtTqmNqyNcGjoHuWZ/YJSTq7Zi5eqAhr21L2ht2FkCFh3i57q729S4C
lvB4XbeSHjjqX6xUsFM1kbRmnxH/pIsRCxKRNDUlrouSLTTDLQaatrLiDOxHeWAn
aRXbHed7SjFahtk/xcwCbc6D8UDXSUuMRbavricTzSCvvtEkY+xVS982QiRpkcvQ
f4p5wYwxs4qEUdPr8QZE
=JgsE
-----END PGP SIGNATURE-----

--nextPart1868933.T1kRjTMnkn--

