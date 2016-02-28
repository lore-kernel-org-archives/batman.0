Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 11:37:17 +0100
Message-ID: <3805562.RtX9XxSZnx@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1857896.bWv0fb970x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/3] batadv_interface_rx pskb_may_pull cleanup
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

--nextPart1857896.bWv0fb970x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

this patchset is about cleaning up the pskb_may_pull(skb, hdr_size) in 
batadv_interface_rx. This was pointed out by Marek while he checked the 
"pskb_may_pull(skb, ETH_HLEN)"/"pskb_may_pull(skb, VLAN_ETH_HLEN)" fix [1]. 
This patchset *does not* replace the other fix.

The patchset contains three patches because:

 * first one is there to make clear that batadv_interface_rx is not
   responsible for checking hdr_size
 * second one is a bonus. Just noticed this useless parameter while writing
   the kernel-doc
 * the last patch then really removes this extra check.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/15853/

--nextPart1857896.bWv0fb970x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0s3dAAoJEF2HCgfBJntG/aEQAIIGKTwYrQqD/enET2ubO326
uA3nR7mw2UkS+CjZOGeai9OIV0yI+4FA6mj3CAMMmF2+ZokWsS5bC9//QT0wQRIe
ulyyAAs6Tkwq/l5C610boSOoFYq1vcT61WF+ZW2Pl070u5GAJ1usjXoagYGcVIcq
qGYf8d2nF+Q7FljhtO+HdrfTgUcuDH12E2uNSy0svZJXl3GIr5Igp5Qwi9RZrAid
4wiaY7A+OoirRDg/VJmJqeHo3heer8ZAVd4H76ZJCwQ4e9qbAowwH7sBkXi8yRAq
rSPDfyFCDFP5OcJCV4mNn9n3v1r02hc9EUJcWJlOp89HEJG0UmPtvWAF62/PrZtH
G8NZA4GGkUV4qb5Kc5tbxg4c6yww7LgrhjEjrxMf+dNBH9sSmXA0MUPls7fK9OhR
ru9TUg4m+XSbO6eIlC26bCTN4MQAPZy0Fhvhgc6+8vcIjcgk+qO5Vw7c9MyOOqea
xDot2ydwbs7Sxx1055npI/JV0AqslcmIlJs/cyXtQ1oGcCVAf+GvBS2s0533bo+A
1il3teRFoShLDnugBwIABO9HmaHm3CR/a+UBwKAXdUpvuJtRViy+dznIddkE/r5A
Q/KPBto48guIb+eKNTEueeb6xyE2ivQb8TmAPa8bpoBEhB2BKoYNLJN0K78OdStr
nucP0qENjhqAZEoGu3Ig
=m+Bv
-----END PGP SIGNATURE-----

--nextPart1857896.bWv0fb970x--

