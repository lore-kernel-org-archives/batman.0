Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:14:41 +0800
Message-ID: <7477816.3sWgyph77i@voltaire>
In-Reply-To: <1441385723-5565-1-git-send-email-sw@simonwunderlich.de>
References: <1441385723-5565-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2606109.hZIiYEpK2W";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: lock crc access in bridge
	loop avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2606109.hZIiYEpK2W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, September 04, 2015 18:55:23 Simon Wunderlich wrote:
> To avoid multiple functions changing a backbone gateways crc entry, lock
> it using a spinlock.

Feels like maint/stable material to me ? If so, we need a more screaming 
commit message to get the stable patch through the lines.


Cheers,
Marek

--nextPart2606109.hZIiYEpK2W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/XxAAoJEFNVTo/uthzANOoIAJ7C6CAjWZY3aINQOBrQk/M7
UaRqus23gYPu3b2RfIGd9kaQ/u+0YDLH7NrdWHXa0Ti2+phCp4GPlHKDydAU7zjo
w1aD+d094jiqGLMe84Q+Lp8dT5/2pwMQhPT7PkKlnLcprE5CMdBQaZKhyJ+VdnsP
OqpfG04yGqSNkqYJ7zpo5AM8RMnn6cIHkveiMJFaQq6At7X3pkObAAXvWXi12OGL
w23wzZAg6uEG/eOeYFQFJgf+xn/yy3vl4X1wYv9gY5dGCjxFBz6jIPPVXJcVX3rB
0vyWv/vn5YNASAnA7iGBlV6F+KkpLcyYUUkKUtKBUgZTZNavTsh4gLeNA7B0aYs=
=XD7T
-----END PGP SIGNATURE-----

--nextPart2606109.hZIiYEpK2W--

