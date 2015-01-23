Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 23 Jan 2015 17:32:02 +0100
Message-ID: <3471179.FAUhTczCdE@prime>
In-Reply-To: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
References: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3920252.pzyt6fdFV0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Tighten size check on received
	packet
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
Cc: Jan-Philipp Litza <janphilipp@litza.de>


--nextPart3920252.pzyt6fdFV0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 19 January 2015 21:59:32 Jan-Philipp Litza wrote:
> When first checking if a received packet is truncated, the size of the
> alfred_tlv structure is ignored, thus allowing packets that are
> truncated by 4 bytes or less to pass the check unnoticed.
> 
> Even the check itself might access memory after the packet if its size
> was only 2 bytes or less.
> 
> Signed-off-by: Jan-Philipp Litza <janphilipp@litza.de>

applied in commit 0e2728c.

Thanks!
    Simon
--nextPart3920252.pzyt6fdFV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTCd4YACgkQrzg/fFk7axbljACeK0xT3FrEyFOuB37Y1wE/XYeQ
swEAoIQoJu+LR9nlovrqhzoctJIlVdgg
=P0/0
-----END PGP SIGNATURE-----

--nextPart3920252.pzyt6fdFV0--

