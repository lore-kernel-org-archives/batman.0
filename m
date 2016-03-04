Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Mar 2016 16:53:22 +0100
Message-ID: <1558669.ODGCKOSvmE@sven-edge>
In-Reply-To: <2378940.op5bKN67gL@sven-edge>
References: <20160304152132.GV15541@lunn.ch> <2378940.op5bKN67gL@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9715976.hVJTW1uW8y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Use of ref_get_unless_zero() ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart9715976.hVJTW1uW8y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 04 March 2016 16:50:43 Sven Eckelmann wrote: 
> batadv_send_outstanding_bat_ogm_packet (and later send to the mentioned
> function via batadv_schedule_bat_ogm). Also batadv_add_bcast_packet_to_list
> doesn't increase the reference counter for if_incoming before adding to the
> forward packet. So I would just say that the reference counting for
> batadv_hard_iface is broken.

Ah, just saw that batadv_primary_if_get_selected already increased the 
reference counter. So it is not as easy as I said.

Kind regards,
	Sven
--nextPart9715976.hVJTW1uW8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW2a9yAAoJEF2HCgfBJntGHP4P/1KuPCy48MxZOhOgUOQYTBUF
jNmprztWE4p1/f/KkDtUoV5d280Z6MmmkK3z6ROuikeB4LU0qJZgoHCQkgkOHln+
mwqcSLN3YgHfrmmvloArJJR5MuOgYRCWp6ISLUBSGF/RXseV9U5SUsIkMkSlUPkI
3ab4GV0SiWn3iVVfgkC8NLepATBal7p1dWgkqY47Aahsfb2Z0+11V/j4Pe/Ip49N
iNYgTe9Ag8K3iGT+upzGmn8KdvjIwFAY1QH740/Malyi0RIgp3LYw+RAGrxZIwCg
TBFHuzQi8NZ0CnSlQBkP62upQglu/td8jYx/xG5pNj8BxC0hKFEQyK7mJUVjawXL
fu1h/Fh4A8h69OWPlvbMUi3vFNGQ0fGqgfuGxVj5fOD4BCy5fYChbzoAU3w/HMBK
5XCGzGdgbCqzkyqVjK9FT97UfPpGVjfMbwCI4Jy2km74/rt2MyiCBL/mNMSlRhiL
xo3gpSRrJ8Smy2hq7s8No2R3+GtuwHYA5blwLReDhROMn9J3xIfhR94vaqZfYCQg
o1tGLQABRYDS0jAMCA30QK/DyDqe+oGfvEnffyyc+6wdvxFRw5qUomugkQdhWkDP
qNaRCIFXrBQH3QWu/AIq558soHaZWnwNIbSynxBeLrVHRep+kfXH+VsfC2vmqFSy
m+yAemunSajvOuoxOqdz
=k3tf
-----END PGP SIGNATURE-----

--nextPart9715976.hVJTW1uW8y--

