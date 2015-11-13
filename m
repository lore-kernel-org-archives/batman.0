Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 Nov 2015 09:48:07 +0100
Message-ID: <2974435.qdNic3fArI@bentobox>
In-Reply-To: <5644E372.6060308@freifunk-malente.de>
References: <5644E372.6060308@freifunk-malente.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart53609925.Xq6ufn4WAB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] compiling error of alfred (master) on deb7 host
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

--nextPart53609925.Xq6ufn4WAB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 12 November 2015 20:07:30 Christian Breutkreutz wrote:
> This problem is reproducible on any fresh installed deb7 systems. Has
> anyone an idea?

libcap 1:2.22-1.2 from Debian oldstable is missing the pkg-config file. This 
was only fixed in the current Debian stable release (1:2.24-8). So you have 
different options

 * build without capability support using a make override

    make CONFIG_ALFRED_CAPABILITIES=n

 * provide the info about the libs and flags for libcap as make override

    make LIBCAP_CFLAGS='' LIBCAP_LDLIBS='-lcap'

 * install a newer version of libcap which includes libcap.pc

Kind regards,
	Sven
--nextPart53609925.Xq6ufn4WAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWRaPHAAoJEF2HCgfBJntGMosQAJrGhVF1ffW/DqPY2Rb5mZ5V
Ui0s1FTSsHwH/1zHTiEnwbGm795iyvRF4JbfKdVmPLPFVj320EYLAj7LVQvXmIt+
v6C4Ep3bPkUZal1CawaDaHCMvSPQjG9ulSGG6umQ5T/yf6k+mGF9w2JYYRn1a+EG
/nqLVDmC2H2vhWlZZhqIKWrwib/tDmvjtjQFijRRmZOyQrPxqUV7e4Oa6SsJpSVH
4CPVNgTCGjX/TwuoiPhxXz+yaF+SJ1dNuLeAGy6wpCUe0OtxvPDXMboq5ORDnVBy
wiZi5n41/Fa6ygCMc2UuwDo/Fr6PGx2//9nocCpYS/Y2tHuDU6jAhp081oZl+2Jq
2xZ07C11HQuEKYgdJinidQjreQCj5s9qzVFztFQ6iiinlsdrOZ9OEaRtD0l+Z50O
0/OO2CUGpyr0tHhQaS7Gq0lwJsZoLAChFl0nsGrEhDoPTA5dh1sXMGpwIQbud5s7
NyBDW7NeRVxIrRsmzbDAf/inQ2A+f1TGrnz7X/wvsSwvMc85W/OscA3XoSplPS/y
jCEkFRwD5Z+KdIytgS8ZPEZ2eOR8qdBcCzlD8Q8TQPdTso9yBY6hR55rNYRyNAHw
BMiu+CYkNpb7Ou8fn1zL4++ndzwGXXDAyf3CqiakOUbsn45B6ryzKae9y5raA5xK
Y7M9pdyS+GM1HULuZS8h
=GhCS
-----END PGP SIGNATURE-----

--nextPart53609925.Xq6ufn4WAB--

