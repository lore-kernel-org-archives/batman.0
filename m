Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 22:08:01 +0800
Message-ID: <2604944.zfeymXHJyP@voltaire>
In-Reply-To: <1434646404-19291-3-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
 <1434646404-19291-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1477144.YDWid1VCGk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Add missing include for
	clear_/set_bit in MCAST
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


--nextPart1477144.YDWid1VCGk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 18:53:21 Sven Eckelmann wrote:
> 201a54ba710a ("batman-adv: Make MCAST capability changes atomic") started
> to use clear_bit and set_bit but did not add the include for these
> functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/multicast.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 0128bee.

Thanks,
Marek

--nextPart1477144.YDWid1VCGk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVhCJBAAoJEFNVTo/uthzAsVcH/0/98zLSKimlpV1RHhfDAOc2
vVcwppe5syv42zYSOOeKyNL1nOJ6EGfzJbzG76zKmcxDa868iF5CRekXCU1u7TpI
LWHW96r1o79UBni10vJXc03y9UtcOb0Gml+iTDgxGGpND6mJ2Wjy/cq7ETaLWQMo
ZvGCUHhe0JJEpzRy/rmHQ0R05ilUAzhQF5+/hEYz3jrm3SzWd4uQ/eZWclJbRPhm
ThbiHx3ungoiqwWSGz7SkgUs11G+WGqO6qM8ItlkU1cstRCOtMyOgJoR+0G4UYf/
xHNbZZ6Kgrgw2a0hshNBHh5430pCbeTdWf1wr4/z3ELiIoFoeVVJoaRy/3TN87M=
=9JBX
-----END PGP SIGNATURE-----

--nextPart1477144.YDWid1VCGk--

