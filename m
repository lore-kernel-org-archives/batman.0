Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:28:13 +0800
Message-ID: <6408238.g0UpgU5QYU@diderot>
In-Reply-To: <1384366492-27310-5-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-5-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3830699.nCIBui4aJ4";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 4/8] batman-adv: add WiFi penalty
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart3830699.nCIBui4aJ4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:48 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> If the same interface is used for sending and receiving, there might be
> throughput degradation on half-duplex interfaces such as WiFi. Add a
> penalty if the same interface is used to reflect this problem in the
> metric. At the same time, change the hop penalty from 30 to 15 so there
> will be no change for single wifi mesh network. the effective hop
> penalty will stay at 30 due to the new wifi penalty for these networks.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv2:
>  * remove an obsolote check when printing if_incoming to make smatch
>    happy
> 
> Changes to RFCv2:
>  * various style changes
> 
> Changes to RFCv1:
>  * use hop penalty for wifi penalty, and use half of the original hop
>    penalty.
> ---
>  bat_iv_ogm.c     |   27 ++++++++++++++++++++++-----
>  hard-interface.h |    1 +
>  soft-interface.c |    2 +-
>  3 files changed, 24 insertions(+), 6 deletions(-)

Applied in revision 46e44fd.

Thanks,
Marek

--nextPart3830699.nCIBui4aJ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWGtAAoJEFNVTo/uthzARf8H/inUjWZkLiN1J8mUch+AwejY
8TP0KhmbRHoHc4IU2Oq7lYmOniBtiCGl68g47Pt42VOMH7xbABNcfTzu6NigAiqF
hkIYQKzBy7VIV35Am/qC5hqgegUtFIwTdz/w/gT4BpIcsA7Jwc6Y3daou8qBWFJU
mrOSD9oQeeSJEUPBShUgdcPaTP4DyIOQHJHgO3MljcRm8G6vxYlWz0Mo9FVpVidW
ZiU0JBNgSDSjbCn4ReSBMTL/+br9GA4F0az0rbZBNyy05SYUBtctQsprEdk630+O
jSHHoIz4B2rFLMjXW5thokiTIIhWaUrco9bFmwSta5gT1afWJ/nr/SjmO8NWYDc=
=RWDR
-----END PGP SIGNATURE-----

--nextPart3830699.nCIBui4aJ4--

