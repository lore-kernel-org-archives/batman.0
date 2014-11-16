Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:27:14 +0800
Message-ID: <54466937.WmcY3Eb2fn@diderot>
In-Reply-To: <1415815109-17111-4-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
 <1415815109-17111-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1959618.y5is59yJ7h";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batctl: Parse non-variable TVLV only
	with correct length
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


--nextPart1959618.y5is59yJ7h
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 November 2014 18:58:28 Sven Eckelmann wrote:
> The TVLV length has to be verified before the tvlv parser can start.
> Otherwise the tvlv parser might access invalid data.
> 
> Doing the same for zero length TVLVs is just good practice and might help
> finding problems easier.
> 
> This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
> ("batctl: tcpdump - parse TVLV containers").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tcpdump.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)

Applied in revision 0505524.

Thanks,
Marek

--nextPart1959618.y5is59yJ7h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDWyAAoJEFNVTo/uthzAiDIIAKlf/uUZ2IUJmc6En9EPMvlF
Ik+1jz/fEclwLST0TirOxjIuoOkwVi7a9QIiGIN0pwHEJed7AG+UYfolNjIzph96
V1+eiZniLGrkWeaopUZyx7RiHBP4f7cFJNzLUW6SaOp0G2uql9cPKkLhzNBygXcT
Usz31gMG4IH72oAPAJFUKecKCa+3QsoYi3U510PbWsRNl5gjhywzYu27a+nGXXut
rD/adOx0ILwzmJ2dju015Tporfh2cI8/nQ41AnQLLdHOyUvas+aWCm/XiFAh0sdC
JjbmvcWR0UtgYHd+vaG6zN+sVr0tRiQsB+pElo7U4qteuiwTn5tj8+3MmHSu880=
=K8QQ
-----END PGP SIGNATURE-----

--nextPart1959618.y5is59yJ7h--

