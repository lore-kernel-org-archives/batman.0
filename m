Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 24 Nov 2013 00:33:44 +0800
Message-ID: <2199049.jZZboEJzjt@diderot>
In-Reply-To: <1385121727-12847-1-git-send-email-sw@simonwunderlich.de>
References: <1385121727-12847-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4265994.Rc61VdAQyi";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix neigh_node multiif
	regression in network coding
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart4265994.Rc61VdAQyi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 22 November 2013 13:02:06 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> A previous commit for the multi interface optimization did not
> change the member access for neigh_node to their respective new ifinfo
> structures for the network coding implementation.
> 
> This was introduced by change 9bb33b8d88e318c4879d37d06ad28e3e018b9036
> ("batman-adv: split tq information in neigh_node struct")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  network-coding.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Applied in revision cb7ec5f.

Thanks,
Marek

--nextPart4265994.Rc61VdAQyi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSkNjsAAoJEFNVTo/uthzAMc4IAJuAR7b+Uvw1QX1JfqTocoLF
0fZI9znZLc/qqkFKXoa8Ohu+JvSzi/tHRugqWDaIlbiWKSRKANQHt0PlBLDyhU2M
KYUW8b7TVECk5oQ6dnsw8hpVABBoPkGg0JId7Xh+DvAu7uKuCA80RCMq5hAfPVMW
1AK3vsORHqvJgCgmWTi6LzQWxZZpGyLpf//48MhDpHHzRG+M19H+D3J029SQY7iY
FKR3zIvGFjii/teKg3wg1ZRAhSZO9gCO2SltwDw4Duxrmo5BvgoonIM3f9l0+b7H
8KRc++0JNDQMsUzA7RNlebQJINzVxiXMlhRt4+Jw8DSrxej7yT9sw3iOA3V0n4s=
=Cn+5
-----END PGP SIGNATURE-----

--nextPart4265994.Rc61VdAQyi--

