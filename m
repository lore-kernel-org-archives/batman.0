Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:23:14 +0800
Message-ID: <153914316.OY1o62cYj5@diderot>
In-Reply-To: <1384366492-27310-2-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1979213.ldXgGU88Nz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/8] batman-adv: remove bonding and
	interface alternating
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


--nextPart1979213.ldXgGU88Nz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:45 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Remove bonding and interface alternating code - it will be replaced
> by a new, network-wide multi interface optimization which enables
> both bonding and interface alternating in a better way.
> 
> Keep the sysfs and find router function though, this will be needed
> later.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>

Applied in revision dc5b9ca.

Thanks,
Marek

--nextPart1979213.ldXgGU88Nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWCCAAoJEFNVTo/uthzAEvgIALXgE6d7bi0TGmyI9lMboqPv
39Ing759za4ifODdNANwFtx43T1dixdbtBHv2einZUzf8EUfEaAtzS2qjXnspAgX
zyTgNSZZNBgVymeCTcfJPu1gUmJzg79HNU7inp1QBRLBRL7NOIkwRhxVMPOVQM8J
5S1JDJAGzcA2JdC7SQ4QTkoCZveo52AWJjLgwoOfOIl6pNBLVOQt1KsjaplHdrFG
ALwF8xzID2o8V4bP07VNCF63E88FyjzD6qM3N0q5eOJvqeMe+oQOk7JhSVseYR/s
yntva5XS1U6T2laDKVDzn+2dNnvpmNTa28CCjSTyESopHMt55z3oA2sQEioUULE=
=GXty
-----END PGP SIGNATURE-----

--nextPart1979213.ldXgGU88Nz--

