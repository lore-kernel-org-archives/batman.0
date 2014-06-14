Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Jun 2014 09:56:26 +0800
Message-ID: <3702785.FfcFgHl5Vr@diderot>
In-Reply-To: <1402651269-19233-1-git-send-email-antonio@meshcoding.com>
References: <1402651269-19233-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16901833.HIN889Qxmr";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add compat code for
	kmalloc_array()
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


--nextPart16901833.HIN889Qxmr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 13 June 2014 11:21:09 Antonio Quartulli wrote:
> kmalloc_array() was introduced with linux-3.4 therefore
> we need some compat code in order to be able to compile
> batman-adv against older kernels.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Changes from v2:
> - fix linux version in commit message
> 
> 
> 
>  compat.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision c38939d.

Thanks,
Marek

--nextPart16901833.HIN889Qxmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTm6vKAAoJEFNVTo/uthzAL+EIALxDVxxpbArfxUg1yyTFFR1H
mBhZXmnJpT3ZXKQh0m/inuZnIcusZkZGGLcHAYbHYX3QKEAx7aq7NHcTB4G6d5ks
SF+tNvVIj44+AQn+szJNkoWVyNSGWBDtv6Q/lWiyqZ6t11e0wx+Ol+XgI609wSey
z9PdAeTN4Ge+VKtjsXyuAFDEnSWA7nvYUCZikHUC44elprDrM59f3ZYnB0kuAqHD
Kz1+K15sKeBwJsSPwpbgxwCSc6WuFemEm3U8G5YBqETZDc0wJW2oawMoDaEyPkai
LMH+RYoaI7FKJ4WiEjerIph802tNbBdTzzDD3XBmlr4RuEm0J+sG0kaTwBFUYXc=
=aY48
-----END PGP SIGNATURE-----

--nextPart16901833.HIN889Qxmr--

