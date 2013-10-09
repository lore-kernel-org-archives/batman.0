Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 09 Oct 2013 16:14:46 +0800
Message-ID: <12447770.xO0R1XlQHM@diderot>
In-Reply-To: <1380834133-10808-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1380834133-10808-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6061929.pJm4VTbTtB";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat of
	net_ratelimited_function for >3.2.46
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


--nextPart6061929.pJm4VTbTtB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 03 October 2013 23:02:13 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Appearently net_ratelimited_function was added to the stable series of
> from 3.2.47, which results in a lot of warnings when compiling against
> this kernel. This patch avoids this redefinition.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  compat.h |    2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 227df84.

Thanks,
Marek

--nextPart6061929.pJm4VTbTtB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSVRCDAAoJEFNVTo/uthzApesIAKPZyT/94Dw3+bGbNKuAi7zm
nSBSSZAq+yiNMKI2b+XJDXJfTHeVGRHI2hnjm+uUbKx0R+OuEIEfmrkM1C5myUnk
rrYG8v4z4Nh55oHFNSil7MR1IHLFKF6aOibPEGHYGzRyx6QoOJapu/wHXqao7tgk
caZjf36R+IxtXhpAKpWmws1zSl8num4rh+cX8MSSVbgtKxhCcfq4Bjefok939/qq
WK/pD1FvjwdcJEb0jw1zbVagLlOJ61ll2xBVa5cMx9Vlcld6AzbuW/TJ+vD/VtgS
Xu2bKeIOHT//DILEjA1rwByEQ5Gxyji2Ql5rUtMvxbMLaTDPyz2I20AqOtDfH3Q=
=a9Lh
-----END PGP SIGNATURE-----

--nextPart6061929.pJm4VTbTtB--

