Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 Dec 2013 13:42:20 +0800
Message-ID: <3397594.HxVRnQW3Sg@diderot>
In-Reply-To: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2615519.Nbvscoxx1f";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 1/4] batman-adv: fix alignment for
	batadv_coded_packet
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


--nextPart2615519.Nbvscoxx1f
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 02 December 2013 20:38:30 Simon Wunderlich wrote:
> The compiler may decide to pad the structure, and then it does not
> have the expected size of 46 byte. Fix this by moving it in the
> pragma pack(2) part of the code.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  packet.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 08a9dd9.

Thanks,
Marek

--nextPart2615519.Nbvscoxx1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqUzEAAoJEFNVTo/uthzA6W8IALa3PvXh9poovVcZdShdm0eN
w/PAX3uRt+TKiKnyf1Q1wiuQRVqW86x8/0l/gGo17hpQXoiBnkkISDX5tB7trA1P
52+ydeaWLKsqEnDkmbw+lufNaIWT1TIkjFpJ9E69AddUmyIUNP63MRxFemEYoyFT
0OceX4kjKedxZW8nnYxDWUwH342Zt8s8tfYFkSGak/7qgs0fmrbnkGiVk85TQs0T
AAlaApMzrkoEwCWlthTj8FYaSZLg0Sk11/IVumlNmXhIoh64i91VjJMCDICzRym3
bYoxgYHrV/aNUZLXlVFLH86V5WMXZRsToMSh4GdfDFauk51fUShRdKgB7H5+lpY=
=0Rj4
-----END PGP SIGNATURE-----

--nextPart2615519.Nbvscoxx1f--

