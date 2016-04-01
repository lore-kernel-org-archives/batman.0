Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 01 Apr 2016 19:05:28 +0800
Message-ID: <2059986.bEeyFFViME@voltaire>
In-Reply-To: <1459503434-19906-1-git-send-email-sven@open-mesh.com>
References: <1459503434-19906-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5888725.KCL5lFAoPA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix checkpatch warning about
	'unsigned' type
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart5888725.KCL5lFAoPA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 01, 2016 11:37:14 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> checkpatch.pl warns about the use of 'unsigned' as a short form for
> 'unsigned int'.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
>  net/batman-adv/fragmentation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision e2c48f2.

Thanks,
Marek

--nextPart5888725.KCL5lFAoPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW/lX4AAoJEFNVTo/uthzAQEIH/2v0tlmwZeREWIw1WZTIVAYU
vw1jbph86oTAL6wU+/2Uo1uyA0mCLNjIBWu31QhOIiIAGz+gBStIx4y43ur/DefA
2P3Ir6/f9h9xCpEVbYS/vwgpmG+TPUk2w4J3GosDS3BAIxn2T+75apMdiPPtWaus
4RC3YN7JRj7vJAAUsSJgM7gnQQPpf51VyFpbosrTK0wZiPimqya8+PZF7NLCzRrO
tQ52gF8OqBJZRrjWFep9p5LBw8wA//qilsZIIGsqzA1DaW2IGaYPPmZ7eY3oBXt9
ZsljxzXgVja8ac7IcYEy0xwLvYMl3ca388rFqmSIcjN5fBesAqv7j1bLYVuGOzc=
=pgLS
-----END PGP SIGNATURE-----

--nextPart5888725.KCL5lFAoPA--

