Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 May 2013 09:24:50 +0200
Message-ID: <5327945.UAE3F7hzx2@bentobox>
In-Reply-To: <201305081311.57379.lindner_marek@yahoo.de>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-8-git-send-email-sven@narfation.org>
 <201305081311.57379.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1410955.DnPHNsdsXJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv-devel: Add missing
	TARGET_* flags to batctl compile
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1410955.DnPHNsdsXJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 08 May 2013 13:11:57 Marek Lindner wrote:
> On Tuesday, May 07, 2013 20:51:07 Sven Eckelmann wrote:
> > The compilation step of batctl completely dropped the TARGET_CFLAGS,
> > TARGET_CPPFLAGS and TARGET_LDFLAGS and therefore weren't compiled and
> > linked with the flags given by the OpenWRT build environment.
> 
> It seems you missed the meaning of MAKE_BATCTL_ARGS ? This variable contains
> TARGET_CFLAGS already. We apparently are missing TARGET_CPPFLAGS and
> TARGET_LDFLAGS. Do you want to resend and make the necessary changes to
> MAKE_BATCTL_ARGS ?

I didn't felt like fixing your other problems too, but sent two other patches 
resolving the MAKE_BATCTL_ARGS problem. See 
[Bonus-PATCH 10/9] batman-adv-devel: Don't overwrite batctl's CFLAGS
[Bonus-PATCH 11/9] batman-adv-devel: Remove unused parameters from 
MAKE_BATCTL_ARGS

Kind regards,
	Sven
--nextPart1410955.DnPHNsdsXJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJRif3CAAoJEF2HCgfBJntGV1IP/0kUr0LAaXTis8hlQs1o8yQR
byUTrY3lS2jCqEy4mfNvAzPhkdA3G9Tpdn4dGAdoajb/ibhF+BxUy/uERHRwT3aM
nK4Va+oLJw+wbBjL7til3QBFP3+EN6XTFMacObBmQqTWSJR2yxnwC0xSgYaGZ/Lz
Bzf2dozH6fSD1JPmR5prDIoLEm7iXDSdXRRRBNK+VOk/9cEja9upwUG5dYYq930C
pA/+BtLnO8O2U87PhW+O2OCX6EjGvQ6p3S5mhNIbeUehLK4h7aB3yItRL1NYkNYL
ZhtoVOEv+gs1PO6VyHbqGRo4QSl1CFCaiIGPt3wzoKxXsVGQ2Vi/RixQJRqnQKpf
dOGbCgwP2tVHpmll/90CCYBV7AQsLm66x06UgSV8UO6iUHOmGLNKF174pKCBQojE
BuT2i+8zR2zR6uqZ+xkVhuuewtsD6jkZNaBr9zKIytcS50Sckq4u6Ikgf9esMjTi
pByp7i0iQiMTXjmGRq0PKi7i4oC/t+nY6ZKvpLqdrtKZpRh2MMvFf37E+io/pKYF
KSzFhpNH7B6A9VtMdVe8vosonoALLtUR6aE+4Dvl/10w//NzDDqI5h1vJtTdLbp7
5eQ2WPP2m8++itiG+2CWlQb4EhElau1M2Y3ygxRYPW0kaJRlZr9KaOGxdHA39D18
QiHSYDJfm+9r5LvEmUL2
=jQpi
-----END PGP SIGNATURE-----

--nextPart1410955.DnPHNsdsXJ--

