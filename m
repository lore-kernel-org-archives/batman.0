Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jun 2018 15:16:13 +0200
Message-ID: <2614128.j4suOHLNvE@sven-edge>
In-Reply-To: <20180601172424.7821-1-sven@narfation.org>
References: <20180601172424.7821-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3605956.xFnA0IlnSa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix debugfs path
 for renamed hardif
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
Cc: John Soros <sorosj@gmail.com>

--nextPart3605956.xFnA0IlnSa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 1. Juni 2018 19:24:23 CEST Sven Eckelmann wrote:
> batman-adv is creating special debugfs directories in the init
> net_namespace for each valid hard-interface (net_device). But it is
> possible to rename a net_device to a completely different name then the
> original one.
> 
> It can therefore happen that a user registers a new net_device which gets
> the name "wlan0" assigned by default. batman-adv is also adding a new
> directory under $debugfs/batman-adv/ with the name "wlan0".
> 
> The user then decides to rename this device to "wl_pri" and registers a
> different device. The kernel may now decide to use the name "wlan0" again
> for this new device. batman-adv will detect it as a valid net_device and
> tries to create a directory with the name "wlan0" under
> $debugfs/batman-adv/. But there already exists one with this name under
> this path and thus this fails. batman-adv will detect a problem and
> rollback the registering of this device.
> 
> batman-adv must therefore take care of renaming the debugfs directories
> for hard-interfaces whenever it detects such a net_device rename.
> 
> Fixes: 3c926a01c8e8 ("batman-adv: add debugfs structure for information per interface")
> Reported-by: John Soros <sorosj@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: John Soros <sorosj@gmail.com>

Added as 127086f503f6 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/127086f503f6495518b95455efebee33d328f335

--nextPart3605956.xFnA0IlnSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsT6h0ACgkQXYcKB8Em
e0aerBAAyzmYaC9Dej7v3WhPU5TqP9ASAR2ezw8a/H3reZxgYKlSbqs+vdpiT/Hf
W10jejioj89F/HXQtMJSGhB57SrPdW2TLtlWLFqVZiOxiwhzQH8USwyfczdcsIW5
Ccp4D6Yv1jEqk8YJYmkZ6yc5WfSkX5ASqB3OW4NSQUpxNEsn0ZbAqN54g71S6JZx
+6LkHz2XkPOVa+3Z7dp1oKDQofetRNswXUeDg/E5nF2QL5Fw7O0G4kDOM1Vuc6NM
Bx3mwIUjdpgZUCRAI1zbk3A31Lzhb6uEg+6PNq+gJH9o6jjz4SPdxFD2IVJh09Z1
viDjRd9C9Q4W4Q9ovj++BevDSFkSSWlyGR4agCRR9hP6UkdcA5fqp+rCswKwqLg8
IybOzWwGTEK00QNQkjUKV0aytJW/zoXgBpr+oot9V7sfLPh1BjX2SJV3WpqJVLQZ
upH4LC2KuQOxlSjOdG+kBct8aGW2QE1pOlw+KvZizFgs7cmUvfnoARw1BHRyD9sK
WWqb+T5CqPJYZjCXva1+VSOVi0v//R9n/Qrz1lJylOxfSvODZ+0Q/iwhAhqnGLY3
pV1z26LCkBhWidjxnZFRRy2G/j/w6tS/sS2YPEm8fWxtuY9bpf9Q9eUPB9WVQPYJ
PHwTD/OfCjhMY6hUpo21wvYWQviAe3k/0e/mLchqqsa5OQ2xdhM=
=svqL
-----END PGP SIGNATURE-----

--nextPart3605956.xFnA0IlnSa--



