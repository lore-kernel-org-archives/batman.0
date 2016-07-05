Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 17:26:24 +0800
Message-ID: <3137606.2gRyssZLBh@voltaire>
In-Reply-To: <77232143.NV1dyT7Nfk@prime>
References: <1467310294-5892-1-git-send-email-sven@narfation.org>
 <1467380983-14959-1-git-send-email-sven@narfation.org>
 <77232143.NV1dyT7Nfk@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1535130.gZJzKIMhUe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/4] batman-adv: Fix non-atomic
	bla_claim::backbone_gw access
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

--nextPart1535130.gZJzKIMhUe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 01, 2016 15:54:41 Simon Wunderlich wrote:
> On Friday 01 July 2016 15:49:43 Sven Eckelmann wrote:
> > The pointer batadv_bla_claim::backbone_gw can be changed at any time.
> > Therefore, access to it must be protected to ensure that two function
> > accessing the same backbone_gw are actually accessing the same. This is
> > especially important when the crc_lock is used or when the backbone_gw of
> > a
> > claim is exchanged.
> >
> > Not doing so leads to invalid memory access and/or reference leaks.
> >
> > Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> > Fixes: b307e72d119f ("batman-adv: lock crc access in bridge loop
> > avoidance") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Applied in revision e401297.

Thanks,
Marek

--nextPart1535130.gZJzKIMhUe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe31BAAoJEFNVTo/uthzA+2IH/A+0AJiON0DOuUNdnB9OF3ID
fO9/WCgcVtO3rqlk4yWzo9XcUnJJ8yESKVGyHIVEtXVgh1T5pJrrnX2UI3UjvR11
qAcRxuQL9l5yGSFlbC1ROH1+XYeuE/ZhvlnNkyb0DCfe5O4HIjmnpaes7XkyyoSV
sFXXVgJzrNwgu0cqce6c09X0ReY41o5LxnqQoYGls/cy4aIiPkHf4C60gEtWzNfj
rM5K+E2H+3pAvFb8Erqt13uOF1Q4ken2DimF8SLfd9xgiMS1/jCti8hLGSfla68k
b7bDHZYRr3BFCQ206xLKEmq9Pjq6mgU4fgfjR7oJqDMtbLfX9QJtag35nFUmhBM=
=iEgX
-----END PGP SIGNATURE-----

--nextPart1535130.gZJzKIMhUe--

