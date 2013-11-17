Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:39:19 +0800
Message-ID: <1472723.q4BUIL9jbH@diderot>
In-Reply-To: <1384639371-630-1-git-send-email-antonio@meshcoding.com>
References: <1384639371-630-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13606964.LIpbxIFisI";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove returns at the end of
	void functions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart13606964.LIpbxIFisI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 23:02:51 Antonio Quartulli wrote:
> Return at the end of void functions is not needed.
> 
> Since most of the void functions in the code do not do so,
> make all the others consistent by removing the useless
> returns. Actually all the functions to be "fixed" are in
> network-coding.h only.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  network-coding.h | 7 -------
>  1 file changed, 7 deletions(-)

Applied in revision 2826f30.

Thanks,
Marek

--nextPart13606964.LIpbxIFisI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDpnAAoJEFNVTo/uthzAw04IAKzNoGCe1Jaa5IZHg2thh2wQ
AhX3h0qnJmxnJtKRSxxA0OalmM4VXk76fSLtZDwdG6SCXuj/N3AeOEsRFue6Cs2X
5obiFF+XGCXzRCLaglgwm+2F0MqYH/Ch/Q/R97G/kEC84L82Yh6FX+DvCfMZ91iW
7H+lHlIn97+58+4/35r6lx7deidxrci2n/0dxg811SmZp7sf/IZetwt6fvMv3JFx
Bqwg2spCrG91Qw5DKSHYox4biKqvOc9O6xdfkHXAwcS4IgrQA4FYYvgTnuc/pjVi
eNwyu+IPLd6JDY/GTnWFIRPmGZc/w0bKXkwmTcA3yoOlzvaDyCZbxRtkkPB9xzA=
=4xPf
-----END PGP SIGNATURE-----

--nextPart13606964.LIpbxIFisI--

