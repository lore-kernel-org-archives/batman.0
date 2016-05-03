Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 May 2016 11:47:37 +0200
Message-ID: <2159279.DU25yn4Ghe@bentobox>
In-Reply-To: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2604442.D4xvA6bhMl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
	debugfs
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

--nextPart2604442.D4xvA6bhMl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 02 May 2016 22:56:57 Andrew Lunn wrote:
> The kernel has gained support for exporting some information via
> netlink.  Use this when available, rather than debugfs.
> 
> If netlink is not available, or the information is not yet available
> via netlink, batctl will fall back to debugfs.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> v2: Verify mandatory attributes are returned by the kernel, and that
>     they have the expected size.
> ---

git-am also reports some whitespace errors:

Applying: batctl: Use netlink to replace some of debugfs
.git/rebase-apply/patch:1042: space before tab in indent.
                printf("%02x:%02x:%02x:%02x:%02x:%02x ",
.git/rebase-apply/patch:1117: space before tab in indent.
                printf("%02x:%02x:%02x:%02x:%02x:%02x ",
.git/rebase-apply/patch:1264: new blank line at EOF.
+

And could you please use b.a.t.m.a.n@lists.open-mesh.org to submit patches.

Kind regards,
	Sven
--nextPart2604442.D4xvA6bhMl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKHO5AAoJEF2HCgfBJntG0vYQAKkSa5fP7YEBg2d7bFhKq3Ry
MGd5B0r9t7ZHWeB4KTgRZ5/Ov5tmIfw/jYF8V8tFF88NKVGOBmSLiROhTKKnzrrv
9F67Q0PeGb0/kY9g8uLOVsE0PisXdFqEhs2G/qGGh6qLkS9iLgR49OyVLYIuzyC/
leYU8SkXx8ac2qDaWbklBTIRrJ26Zpg5HRJgZhDuBEZQpfdXd9bgQieHMe2FqPJ2
fsx4a3xhsZmCcYvMUpB0LeoamI/4HyjiH2q28MbKFyUBhm+He2yZZPIZ3wruWOE/
XXZHw/gW8cExFLz/LcyETr5tPx07Ay3KMUk4VUEZEUeYc9c1kBr7aOyZO3gd0bf2
a73YSWouq7Vh8ETJayTebtAt8k2tjSQZ0vS1HxOhFuIJ0cpVX38UMwK/6+AqmmEL
eD6yPbZRKcilmoPX1OH556CQtzbZTX/kk7hnsMCBeIWz63S+jRdyproRWpYnbH7N
cmhU7NUGckAyR5Q86+aHM1fMTRiHFq3EmofqsmMfV+onYwum4cBBNEabBC+bqWgj
P4ELYp2u9dOwcYUUAOvWg10C9hYNX1dacABxc499KFIhjMTQAN35XNxKk/WrQWxl
EfO7cEq1UTKs1j77euIAtMISI9ceznRwZ2butAhFYANCipAfAu4s45o6iczRRO6X
ZjqpYdmwFHde/M+VygWm
=MUSr
-----END PGP SIGNATURE-----

--nextPart2604442.D4xvA6bhMl--

