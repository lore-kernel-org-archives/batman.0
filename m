Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Dec 2017 11:43:06 +0100
Message-ID: <3221021.b1BNhtzxAk@bentobox>
In-Reply-To: <20171119165913.23313-1-sven@narfation.org>
References: <20171119165913.23313-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1872477.cNLA0X4QYl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deinline
 batadv_orig_hash_find, save 7339 bytes
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>

--nextPart1872477.cNLA0X4QYl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 19. November 2017 17:59:13 CET Sven Eckelmann wrote:
> From: Denys Vlasenko <dvlasenk@redhat.com>
> 
> This function compiles to 288 bytes of machine code for Linux 4.14 on
> Debian Stretch amd64 and (6.3.0-18) with the default configuration. 27
> callsites (25 used in default config).
> 
>    text    data     bss     dec     hex filename
>  179291   10317    4416  194024   2f5e8 batman-adv.ko.pre
>  171952   10317    4416  186685   2d93d batman-adv.ko.post
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> [sven@narfation.org: Fix includes, correct sizes+counts in commit message]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - updated the statistics against Linux 4.14

Applied in f795e77ba40d [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/f795e77ba40d104a6a20f5706b88fae1671dd1a5
--nextPart1872477.cNLA0X4QYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlonyboACgkQXYcKB8Em
e0aTAg/9FO5HVPEVGflftGGRWXNHfBYolIc+6O/DxhHhaiB43ZrXb4KIyuoMIK8C
ZVIJWErVvGcXOzk7FPWeZBpOzmJPX093QYN63r1Wh0BlsHCp9Iq1A47BLYHgkrBx
YXAqtIZL5YbZvIL/oQppK2OwX8DLvZDlg10mxYdrfaiz5SnW7bC6cls1rnaXgRTz
AJnQ+bCasbmD+VNpDMxHxtRBauq2xVA1mJ1J2WKIfkeSO/q+mRHKnvLW3s4XMUWT
iRue7ozqiZkb7FvsUmCtoTW/4Z87xbk+jKsUI9Ol4s+sEwVlU+ltYQ6BJuUbirvv
V2Ds55hoid2YJgYCVQtutkozHZWT7sj14kGpxd9bXIIGTBJUT9FximjYKqLKRTWc
mxZJRXHx9ae577HHgzkygFZa3ZQhMmQ96NHNgWu0izDRKUTFKYhct65S4IG6giUO
WHMy55voqF0iWsgGx864yjsWnJg9YvsiDIJl3gk41QriUPb/Syfj1AwINdxFeRsq
IEFVop7SQbsbZxC/L7wyccA2iPGqrarR75We/3+pVHB3nJHjirW9BI916XJTsmD/
k/3YFzU2DMhZgA+grkjXlc46TRhjQt8ubsGDKMtZMtIHPnuvQeNX3qxv7IPtA0UX
FDOkIGTuh4mWvUk89gA1ryTfOzxzBbOupO5EIT5Ovz0XjsyOVhY=
=iivC
-----END PGP SIGNATURE-----

--nextPart1872477.cNLA0X4QYl--

