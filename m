Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 14 Oct 2016 15:33:35 +0200
Message-ID: <11536441.PBqhyhFjMe@prime>
In-Reply-To: <20160923143557.30828-1-sven@narfation.org>
References: <20160923143557.30828-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4408979.DMUsDzYJsh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Enable _GNU_SOURCE by default
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

--nextPart4408979.DMUsDzYJsh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, September 23, 2016 4:35:57 PM CEST Sven Eckelmann wrote:
> alfred uses any netlink library which is (more or less) compatible with
> libnl-3. This is for example libnl-tiny on OpenWrt.
> 
> Programs and libraries which are build against libnl-tiny must be build
> with _GNU_SOURCE enabled to have some types in its headers defined. Thus
> _GNU_SOURCE is enabled in the OpenWrt alfred package since 2016.3. But
> sometimes using _GNU_SOURCE and sometimes not using it can have severe side
> effects which are non-trivial to debug when the developer is not also using
> the same _GNU_SOURCE preprocessor define. Thus enable _GNU_SOURCE by
> default to have similar behavior (defines, type definitions, structure
> members, ...) from headers like on OpenWrt.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
Applied in revision 415ebc7

Thanks!
     Simon
--nextPart4408979.DMUsDzYJsh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYAN6vAAoJEKEr45hCkp6h9Y4P/0fSRDk0lYDUTyPnK4kcrLSn
akw+bGM6F97xWmXxXU6qNJrjJ2APw/Sjnn3+nfw0/Om92qOrwWpxFkyn2t7y7Cdf
KcnXwKt39T5xTqETMhUlZUom/87kuod+R1A6HuotSHyLaX2c2jBLYTFqOQXAe9VL
F+dj6wrfbVPfhVMygzueNpQh3zO0gh3AvPb9y9CYRWNkj4QMqg9//bjYBHgwrCSq
8mjMkr03hq2K7LCcFubMqHrKZjY/Jny3U4ZoYFwpI1tZwhPuFYx2mzs8PFWGDXVz
cquyHoCn+F4h+Ppgzurkz284uyzE5sgbpibLtj5JM3IDYT8AqZ738bDbJhbsMHsR
XMFa8rHNgFV5nbmE8fquQz+g171BMBzMwWLds0CspZ/33kWQsXtL/zw5Xozq0ily
GTlhz93LLa3lrvCWiLA2/IOLQdNPnkJkX3ILoSNa+zoPhzH/SHKqkYAy23AEqBiy
hRV5Tf/tkWgMgFJDJ6TsvGd05NvIpVWru2itd7A0qB7Eg1FLV3/hN+HAZtsLw3cX
/3q0NkY1ZgDe8HuMavbtDjpa3nIiQAeE0WjIo54IeX8rCodzesHk6Zxn1Ug0KVjo
Wj5xUsmBtFfYlvi3cmQ8gl2oPL64JVV1PgPG8uA0PX9l/9JyMVYKll9Tebo6PAgR
YJoPDJiwQhm3fA/SfjZC
=XrXL
-----END PGP SIGNATURE-----

--nextPart4408979.DMUsDzYJsh--

