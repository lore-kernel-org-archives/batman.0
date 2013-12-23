Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 23 Dec 2013 20:28:04 +0800
Message-ID: <22774167.RUYsjOVtNJ@diderot>
In-Reply-To: <1379929964-19779-1-git-send-email-marco.dallato@gmail.com>
References: <1379929964-19779-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1667634.1lonRH4IGq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFCv4] [batctl] add IPv6 support to tcpdump
	parser
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
Cc: Marco Dalla Torre <marco.dallato@gmail.com>


--nextPart1667634.1lonRH4IGq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 23 September 2013 11:52:44 Marco Dalla Torre wrote:
> Extends 'tcpdump' functionality in 'batctl' to parse and report IPv6
> communications. 'batctl' now recognizes TCP, UDP packets and the most
> common ICMPv6 packet types:
>         -ECHO request and ECHO reply
>         -unreachable destination and subcases
>         -time exceeded
>         -neighbor discovery protocol 'solicit' and 'advert'
> 
> TCP and UDP parsing code has been moved from the IPv4 specific
> codepath to separate functions in order to allow reuse regardless
> the underlying protocol.
> 
> Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
> ---
> CHANGE FROM V3
> - fixed a string spacing issue
> To apply on fix "batctl tcpdump: Fix reported length of TCP payload"
>  tcpdump.c | 232
> ++++++++++++++++++++++++++++++++++++++++++++++++++------------ 1 file
> changed, 187 insertions(+), 45 deletions(-)

Applied in revision 35b3775.

Thanks,
Marek

--nextPart1667634.1lonRH4IGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSuCxUAAoJEFNVTo/uthzAi2gH/izZGGCLNAZLTgk3J3xr69l4
NkwEW5CJuzDnrtklcbgXUtKS5IPZvkDeKeGmLNUY9NCms6WNpbs5oR+wno17UwMv
iU+rVcWU7LvyxXaLMsskrBfd+v03NIVHixpjVHSwZkNYuCSrYf1hJVLpzhnVkIdh
YFqDsa1okSF30PlmS6lrXX8f4Vhz+RCjG+ObFXgyOfPmzFjmt2Tai3b1Wo+/3/mm
xpwyfmTGdn5DdyqTzWTPq/phQMayoxzDFvsvvlXpnx81YzaRlmp5m1kzi7fXoMf8
ls/YOKzDAcFtpN9Ttx1ghxZRdTkgKphY/rvIErsIHTpS4mH5XMkONvLa9qY/6F8=
=TfAJ
-----END PGP SIGNATURE-----

--nextPart1667634.1lonRH4IGq--

