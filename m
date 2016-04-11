Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:18:15 +0800
Message-ID: <3343208.0PArO0F0TK@voltaire>
In-Reply-To: <1457190564-11419-5-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2269056.2BVEBNM0YX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv: Use kref_get for
	batadv_tvlv_container_get
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

--nextPart2269056.2BVEBNM0YX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:20 Sven Eckelmann wrote:
> batadv_tvlv_container_get requires that tvlv.container_list_lock is held by
> the caller. It is therefore not possible that an item in
> tvlv.container_list has an reference counter of 0 and is still in the list
> 
> The kref_get function instead WARNs (with debug information) when the
> reference counter would still be 0. This makes a bug in batman-adv better
> visible because kref_get_unless_zero would have ignored this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied in revision 21a288f.

Thanks,
Marek

--nextPart2269056.2BVEBNM0YX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC3nnAAoJEFNVTo/uthzAcUAH/RqYQYPBdz2APSGMmzaIifk+
1oo6s/sX4okMPyt9Hf7A3FMPeUI5wnYOXxSx0e1DeTcnycWO0RMmREj2QV+TLOc6
Dn60AszbagRNaLWrChuDdToiCdJT85vXPHYOdCkpZBu5t9aXAtqp5q/RBaq/xukN
16yty/J4Z+wAO8C1c22WshMNJ7vWZziMuDFS5m+shrLeNAORJOW2/dGEa5NFmI+T
NnKdzeolrnhsVPN6YgRoJlChZ+MrO9c4JgHGdjOR7a7As9M/vP2flMwakK/ez5Yv
upPa7q/kkrhG/h5oBWLmFX4D6hJmutjC+uv/nKlmqc9xeu/r6ZPOJSVMkh5IMDk=
=4quR
-----END PGP SIGNATURE-----

--nextPart2269056.2BVEBNM0YX--

