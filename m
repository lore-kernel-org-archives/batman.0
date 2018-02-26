Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 26 Feb 2018 17:34:22 +0100
Message-ID: <1556526.EynG4TUbRq@prime>
In-Reply-To: <20180219130853.31325-1-sven.eckelmann@openmesh.com>
References: <20180219130853.31325-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3072704.2SsbaMkAQ4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Ignore invalid
 batadv_iv_gw during netlink send
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

--nextPart3072704.2SsbaMkAQ4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 19, 2018 2:08:52 PM CET Sven Eckelmann wrote:
> The function batadv_iv_gw_dump stops the processing loop when
> batadv_iv_gw_dump_entry returns a non-0 return code. This should only
> happen when the buffer is full. Otherwise, an empty message may be
> returned by batadv_gw_dump. This empty message will then stop the netlink
> dumping of gateway entries. At worst, not a single entry is returned to
> userspace even when plenty of possible gateways exist.
> 
> Fixes: fa3228924152 ("batman-adv: add B.A.T.M.A.N. IV bat_gw_dump
> implementations") Signed-off-by: Sven Eckelmann
> <sven.eckelmann@openmesh.com>

I've applied both patches in this series in c58f37c2 and 12f1d3a6.

Thank you!
      Simon
--nextPart3072704.2SsbaMkAQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlqUNw4ACgkQoSvjmEKS
nqEuShAAyimM6sBsZgdT/xpdKtl4sGauuc0MZmlOW+vDzrk25beJuQLO485Fs/2j
r7v77waP4Dxkq5lGRBbl3yY+tM03L2YWcLow4JoPrgCkehQ0AkZm3MfzFr0Q2/8x
GhmJX9IiTBdCR3biboKXTIhFLno3pezoXSVw/7IEwWnuKzcKdIhC1MNY1kUbQC9f
dodCGzMY0zQgyCoPk+Rz+AAJp4JeMibdqE1kGdhU5Gg2p+WtuhJ1bhszoeiNVHVV
oW/2hPYtRNxbfoaBPjhbezmkkBtcNc9KrsJZmkxEo9M8YR5nU8THo60HCprhkx/R
4HNkJV2xhydImjkF1IwdbbL9EHej888dBbUvp4IZFvKPG+5Ck3bdqcVzInkE46fh
5zSem/4IPKWujSf4iNZI0irXW0wb7zuYjGnqxdwaTsrrzJbPvCgwEauPD/sO01Fu
q+GFAeKCGSLV9vasq5edE224KceSsZedLkLn1YO4mpKXrLWwObWKfl/y8REWdgjm
xJXSWXrAvVwd6qlEdvo4c8KILeC+12HubUUHDv8gf+BgllpypKJ5G2q9pmlN0VNK
bk1P+yusLMd6TLZdOjT87juaKXhaCQRvj+f821IuJV2uk9LmhbZsTX1BIRJZiLqB
qpbSbQgBv0ajDvV8DxVCO1bUi4SEEbhgb/Q34hfLYyqTKvKrKM0=
=d0eO
-----END PGP SIGNATURE-----

--nextPart3072704.2SsbaMkAQ4--

