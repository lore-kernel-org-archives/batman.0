Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:26:29 +0800
Message-ID: <4554378.gaC6ESIVH8@diderot>
In-Reply-To: <1415815109-17111-3-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
 <1415815109-17111-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23602878.nbDpV0b1Gq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batctl: Only parse TVLV data when
	length is valid
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


--nextPart23602878.nbDpV0b1Gq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 November 2014 18:58:27 Sven Eckelmann wrote:
> The length in a TVLV field must be smaller or equal to the length of the
> remaining read data. Otherwise the parser can read outside of the
> valid data region.
> 
> This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
> ("batctl: tcpdump - parse TVLV containers").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tcpdump.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied in revision 79f3061.

Thanks,
Marek

--nextPart23602878.nbDpV0b1Gq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDWFAAoJEFNVTo/uthzAMpMIAKraznJ43KU/5NvbrvOOS8rl
CjvcR41yl5YA1ssK8Gken/XsYhmAtmCZwIALOSrLyd3VHFPilnENPpdRZZC1TTtO
vjSq0PpZUU+TPwixEuozAL1HwNR+C1zwhTHjLVEecXCrOQ8n82NIJs18/mdlsU/s
OvMOHwxeWFqu/fTRUdaRdegb9+agjH5IrXkFRyJsi+wbO3b+J8Xq8nlwOTAZ4STU
E5+fozZp+4ASBPb8j0QFlU3/ghO9fn+0QukVSp6g63QAax9nDQSfaWtmN12XO2+Q
DAOwX0yaPsZS82ibrWxrpp59zprW++wT08wTJmZesQtsFhReHDaroz694Ez2Jsc=
=9WMv
-----END PGP SIGNATURE-----

--nextPart23602878.nbDpV0b1Gq--

