Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Dec 2013 22:17:38 +0800
Message-ID: <17158888.3spVh1yqTs@diderot>
In-Reply-To: <1387303932-18445-1-git-send-email-sw@simonwunderlich.de>
References: <1387303932-18445-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1641013.uqeRPlj1RY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add build checks for packet
	sizes
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


--nextPart1641013.uqeRPlj1RY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 17 December 2013 19:12:12 Simon Wunderlich wrote:
> With unrolling the batadv_header into the respective structures, the
> offsetof checks are now useless. Instead, add build checks for all
> packet types which go over the wire to avoid problems with wrong sizes
> or compatibility issues on some architectures which don't use every day.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  main.c |   24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Applied in revision 30e6045.

Thanks,
Marek

--nextPart1641013.uqeRPlj1RY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSuukCAAoJEFNVTo/uthzA13gH/R9pfz+qu+IQrfhEkQFFzIn1
oXX6dHIcdV9XV/hXbpAgMY6cIYBfJ3AmMQV/AZ2vcb90eR3LJTwYvQVXqxjwlI94
Fv/zk6MJAg3ufA7coHdH4vpb4iBmfYgOelGVP0qoYKT9RPzomI2hFDdnAndnzvCA
CAktTZFXWWl4/841bdM4J8NT760b54u39li+ljgfFeQ++FEB/obouYYuLE8z+Xpy
23EXYFanCl1TDatmBYUDOtyz+42mWT8aU/zof1X0WAzOgZJBSi7SfXp/zgLdfmAr
UijbFh9facVRx+RD2DGdeJZOM774qvr646QiyGxjidGWV0J4Nxa+5/sv9DdcXl0=
=vjrJ
-----END PGP SIGNATURE-----

--nextPart1641013.uqeRPlj1RY--

