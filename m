Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Feb 2016 09:39:21 +0100
Message-ID: <11933942.EqGnTx1S2H@bentobox>
In-Reply-To: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
References: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1675205.9vhufxVAFv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Allow setting the source mac via
	unix sock
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

--nextPart1675205.9vhufxVAFv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 17 February 2016 00:51:10 Dominik Heidler wrote:
> The alfred client sets the mac to zero by default
> so this shouldn't break existing behaviour.

This also may not to be true. Some users of alfred may not set the source in 
alfred_data and thus they may end up with random bytes when reusing a buffer, 
allocating a buffer without memset or using an uninitialized buffer on stack.

It is bad practice to send uninitialized bytes around but I just wanted to 
point out that potential problem.

Your patch also doesn't explain why this feature may be required.

Btw. you can grep for "data_source" to find the code related to the 
sync/forwarded rules of alfred.

Kind regards,
	Sven
--nextPart1675205.9vhufxVAFv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWxDG5AAoJEF2HCgfBJntG04sP/jA1xzGcufaVB/oO3+suMT1l
VsoB1uVroaNBQ2aeJ77+TcHkTA7y6BnN5sgCFEEoFHANr2NIHhnQ9IyxB5OIovoR
vqBuZFz+1KEkIzL3sHMIjiJHKb/mbz+KaEUK2v8spaxXWkWpvdzDQLHFU5T3E8O/
Z0Zuhnyel+KofgoL6ffAunGvd44q67GFLZIH0vqTKqtn/P1q1XC1w0mtJEA70CK4
wxYOCcEKHN40MndS8TqtBejYOlH1yW1WX67rIjgV7OLnJ0BWH6cTneW+wwCTZi5I
mwuvjppNnIlAMi0asB2GcXViWwj9Tj96B901eU3cIfolmfaE0/JmjE/7/jJo1r3y
3D/hRpXM05Z4Lvg/Md4PI9oYflE6USbMEVNMQgqqjTpndjQkSgc4w9EmNXCL03ct
DDW8CtYSwFAdbUNIMwvfOXLtUHUi69UgNzsYijG9fAW8/MYUViqG6zl/s62C4XBQ
+Qi3huh88SJdrNk38SJ8mSksz5kUU4Oe8TT0DtQiUaYP6z9L6knOKqW+ERl0neaM
55PkrxJs1vf217q2tEvZr8IpOg2NjBt/nzMoG84Fy3WVDcwJwiBDJ7UUa7rWhAOH
ceCsqqDTjXd4rNKu9QFJdWKHiXCYD62rkFTCGp/Pk+u2MtJrinhCxYkm6K5pR6ht
NzpTWpsEUxI+oY2Upmge
=389e
-----END PGP SIGNATURE-----

--nextPart1675205.9vhufxVAFv--

