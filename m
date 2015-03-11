Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 11 Mar 2015 13:07:32 +0100
Message-ID: <16026573.b6BZCNubOt@prime>
In-Reply-To: <1424719130-2661-1-git-send-email-sven@narfation.org>
References: <1424719130-2661-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2224553.F0oZVTvcnO";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Drop capabilities when not needed
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart2224553.F0oZVTvcnO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 23 February 2015 20:18:50 Sven Eckelmann wrote:
> The alfred process only requires the capability to bind to a raw socket
> (CAP_NET_RAW). It is enough to mark this capability as permitted on program
> startup and mark it again as effective whenever a new netsock is
> initialized. All other capabilities can be dropped completely.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision b0877b3 (just replaced that "B.A.T.M.A.N. debugging 
comment).

Thanks!
     Simon
--nextPart2224553.F0oZVTvcnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlUAMAcACgkQrzg/fFk7axYlHQCdHGEQQeQGgoZ9hzElr0WZdkxI
MZMAoL2A2AL6BNhma/yg3DtoB4VZic45
=ibjf
-----END PGP SIGNATURE-----

--nextPart2224553.F0oZVTvcnO--

