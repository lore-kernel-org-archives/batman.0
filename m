Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 26 Feb 2018 17:40:49 +0100
Message-ID: <1579093.AxJxHVZVZT@prime>
In-Reply-To: <20171226141401.13046-1-sven@narfation.org>
References: <20171226141401.13046-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4538987.eB448S5pYM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix internal interface
 indices types
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

--nextPart4538987.eB448S5pYM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 26, 2017 3:14:01 PM CET Sven Eckelmann wrote:
> batman-adv uses internal indices for each enabled and active interface.
> It is currently used by the B.A.T.M.A.N. IV algorithm to identifify the
> correct position in the ogm_cnt bitmaps.
> 
> The type for the number of enabled interfaces (which defines the next
> interface index) was set to char. This type can be (depending on the
> architecture) either signed (limiting batman-adv to 127 active slave
> interfaces) or unsigned (limiting batman-adv to 255 active slave
> interfaces).
> 
> This limit was not correctly checked when an interface was enabled and thus
> an overflow happened. This was only catched on systems with the signed char
> type when the B.A.T.M.A.N. IV code tried to resize its counter arrays with
> a negative size.
> 
> The if_num interface index was only a s16 and therefore significantly
> smaller than the ifindex (int) used by the code net code.
> 
> Both &batadv_hard_iface->if_num and &batadv_priv->num_ifaces must be
> (unsigned) int to support the same number of slave interfaces as the net
> core code. And the interface activation code must check the number of
> active slave interfaces to avoid integer overflows.
> 
> Fixes: d1fbb61d0534 ("raw socket operations added: create / destroy / bind /
> send broadcast of own OGMs implemented orig interval configurable via
> /proc/net/batman-adv/orig_interval") Fixes: ea6f8d42a595 ("batman-adv: move
> /proc interface handling to /sys") Signed-off-by: Sven Eckelmann
> <sven@narfation.org>

Applied in d5db560d. As discussed, I've applied this into the master branch to 
avoid merge conflicts, since we are about to release anyway.

Thank you!
      Simon
--nextPart4538987.eB448S5pYM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlqUOJEACgkQoSvjmEKS
nqH8Vg/+LAY9QzkN9akKqlF+GEuxNb5iItmQ787JsxvAXTIxD4FrVUO5R09uglKe
zueh7lCobsTECP7a5i8Pa2/5I5UdlNr5w4jCyY0n8tMHaWm6oe80GK49kVCQFc03
OTc2GL3VT6EUFssE1SGRjKTYy9iBedzDbsdWgm5C4UiZG8awU0Hb3uUelJu075no
otYVuxc7y3CF6YGIE+gue+urUhnN0MpUF2eCViCegjQr9Lk23WEnaBtTyiXnBcTT
1QycvOIGXRGlG35L61a2Rg+EBWc/EYZ2agvASpeLIjqAiQJlcD8oFTrjZUmdPLG8
yILaUaTPpCM8+FwZLs2srf84udM+mDRAMGKr4jzObcnkYOg7HiBExjqPx5d/6vqA
sPtlmAcG6AltU8VU/fb38QilvaRL1Mxd0m+fykG8ko5mmeVe82YdAGPZm1GQdUks
dlxoM8cBKLDlnBItx57CS6YYb2wqp48CHIDFf8fXvL29Fuxnb2t0yzavLlqitBXK
eGKhErP5jOD0gUh+PnRtRZZ0z2J3+P2dNVKiF60r32NkE9L2o7iMyizFIg2jErCi
OIXx/S61Yok69pe+JW8ezGhmDPY+uO3UdQuvV55fOpK1UFzK2arj0qVerQXl3mFq
NFVtOiAlPRIbv7YtKVBiJpGhuHrpx5MiXzDVKPCbypdidDIr2UE=
=dK+N
-----END PGP SIGNATURE-----

--nextPart4538987.eB448S5pYM--

