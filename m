Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:29:11 +0200
Message-ID: <1676583.l3HbVhRN6S@bentobox>
In-Reply-To: <20160901160134.15593-2-sven@narfation.org>
References: <20160901160134.15593-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1843602.ZKiiyJMh9Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [2/2] batctl: Fix unknown macro .Pp in manpage
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

--nextPart1843602.ZKiiyJMh9Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 1. September 2016 18:01:34 CEST Sven Eckelmann wrote:
> The macro .PP was accidentally modified into .Pp when the throughput meter
> support was introduced. Revert this part of the change to stop complaints
> by man.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  man/batctl.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in 6fdeebafca44e2eb960b2fd4f47e1f72f95a62c6 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/6fdeebafca44e2eb960b2fd4f47e1f72f95a62c6
--nextPart1843602.ZKiiyJMh9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhWXAAoJEF2HCgfBJntGEJIP/jXqrGA4yagKF7JIPOFdv8qg
Lwg2tbW4PAw7S90kpTDSWwFSP7UcdzH0Byussbm3d54v+UUj/arq/xUxHxba73W1
oWKaSEDiJU1ziFdUi4LhdVs/MeI7RRjhCQD1mQh3l1PJOlvJNie3a1ev5WsVd/FE
9jtoeMngh9iCT3VEG6bLU/AJYhTW2ltV1Slt/wdGkwiiX95zlXGS9Fg6K7Sasv76
x23TfqksiTw66Jjk5Dh/9U7hnPwghKgrnTnGbDwUTSFoYH5tXRTIeP6A+tWXp9qQ
0+fDaA6Oe29ROmbzXyrRpWnmn9sR3ATBEPcWocWZo65NykPsDvcL2fZD/TKRAQOe
58EH7g3w+d3sZeJkeBCbx86yBlcJ/1owXU8dHbVWJ+B+ATSypx6+IKLJSmG+Gs2+
pNLxGbIr/fMfZEuajMRh18h4Qz01ReIeG4wT727BOw3B27rgOordpsTDGpi7TPan
ZlQcy0RcoP6/D+hn0kSafIyisAsmGC06aselijamOdZR4ksPl0P17nV1A1T0f9bg
oZjgWifjOeuCk7d/oO7HFJFvA2iU6fFZ0eoGoahMNS8MqMgsXwJbjOKRC4NQQjBR
jQd6/x4Vg+sctSunnuLL5qzIPyOoLReeMI+grMg125Ud/vaAWCUBNECHMOKy78vo
zXkA90FmLVUXpNQW8p3d
=8WVw
-----END PGP SIGNATURE-----

--nextPart1843602.ZKiiyJMh9Z--

