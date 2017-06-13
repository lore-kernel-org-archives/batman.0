Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 10:49:21 +0200
Message-ID: <1864526.SW9Iu2NTCn@prime>
In-Reply-To: <20170613082600.24910-2-philipp.psurek@gmail.com>
References: <1496077749.5980.2.camel@gmail.com>
 <20170613082600.24910-1-philipp.psurek@gmail.com>
 <20170613082600.24910-2-philipp.psurek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2334470.vSGuNNJzL5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batctl: change PATH_BUFF_LEN to
 maximal possible value
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Philipp Psurek <philipp.psurek@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2334470.vSGuNNJzL5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, June 13, 2017 10:25:59 AM CEST Philipp Psurek wrote:
> The output of
> 
> snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name)
> 
> in sys.c can be between 34 and 289 bytes and should not write into a
> destination of size 200.
> 
> Signed-off-by: Philipp Psurek <philipp.psurek@gmail.com>

I've picked this one, but increased the size to 400 to be a bit more future 
proof. :)

Thanks,
      Simon
--nextPart2334470.vSGuNNJzL5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlk/pxEACgkQoSvjmEKS
nqE3Qg/+P4E5QcN6fFcBBk0R5JSV9YuO0he77BJ8D56noshSihlKUFPIV1DxweFU
B1sJsreGysJBs38A3WvrUzC18oLpIm0ciADNI8vnQyYsEXBIfM91gB1vgVuj4meB
CCgEWnxEyEZ4JH29BW0gTxjMprL7DPtz7vkO1MFlNlz/NKCUUk2LtfVOwIlKjXYh
QmTbMz7xwjQvKS3YIOzwyO6caZ3UVz7cnwqz6SqYiArCptwsdKaXMdsKAZ2xYSND
LOrum+PJBE2rt2jeoFh4r7OcJf39XahY+4n+tWcgbPgp4DbdRDgvUTDSlW8fSzHt
8i8qWnhIDanQSnErydgC8kUL938NpMuqNsWJqjEcjAOGTS6wTf9nFDQ63s6mhyol
6EYOKF0mjXIyRSVyS+gKtehJfq19zaSRhPA8hrp5NtvTxXCGcAIrfN20q6SDwnL3
LZOXRhOq5Mxp1//+wLjcc7DbLiL7DH0Zto22K1iEP0B2BSeN5mBt85krHylJTbgw
sdn983RLSmfOJDnKHUNZ+mLs4ZF/9DUch21DuJKoSyL/tD8vnK1bOk1uPpoUEsbI
jf0O8mW73kRJIf6eus2k17yMqR2hKVjldMEEx2GcqNhn0T4lbiGi3EonGyejoCQJ
fdLflG3QuaL36Hvs+wyT6MOGc1luiC+Eq37Sb+K6iXLsJAdZ52Y=
=kHiv
-----END PGP SIGNATURE-----

--nextPart2334470.vSGuNNJzL5--

