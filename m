Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 Jan 2017 13:41:26 +0100
Message-ID: <4792653.oeXsgRQRRR@prime>
In-Reply-To: <2527763.cX7mnL5d4j@sven-edge>
References: <2527763.cX7mnL5d4j@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1540618.WDi4tl9tFu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/4] batctl: Minor cleanups related to
	tcpdump
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

--nextPart1540618.WDi4tl9tFu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 22, 2017 1:07:10 PM CET Sven Eckelmann wrote:
> Hi,
> 
> here are just some random cleanups/fixes for things I've noticed while
> having a look at https://www.open-mesh.org/issues/298.
> 
>       batctl: tcpdump: Reset socket state on initialization error
>       batctl: tcpdump: Free resources on SIG(TERM|INT)
>       batctl: ping: Use sig_atomic_t variable to stop ping
>       batctl: Simplify standard error messages with perror
> 

Merged this series into dfe9da9..fae430b.

Thanks,
     Simon


--nextPart1540618.WDi4tl9tFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliHS3YACgkQoSvjmEKS
nqGeJg//UKuwYGWFEznZhXZ1+zawYvNgmvtCJl5kGXILQ9yomTvPHyLkvqet7/I2
kKJXfUxl2TCZXj78Xx7donp39teX//mtNI+6RZv0adIQuOK2qQNGpN5DCVLgxkhv
Z1fnG+OEP+JnkjHlZwnGIZG0/KRriI79YEUwOhPgQubRiYtfhUWJC2T3N34/Hrz1
7n/oIOLkc3/qcfli5cknnXwg5mzPhsrr+ltsLQLEICD8fPRxtbaWbUExhDNv70uN
gDvGLYW3kzRH2SGDvVUg2nzqMjlDvVoFhmC4Hmd8VZlhtNufUjjbwP64e51pO6MV
VRZahmQjA9Va7iNr/4BRBVqmUrluBnft9BMxelG/33c7GvFCliFeBfjHzB7EMvDg
kvqQZYtbC2rfLW05Sh0dsGfCr+kPVmnkIm0mX4RPE/61gm8B+T4XIt3LcMIL3cCv
vfcH3Z1NO0KyYRF4GYmHxOFirqS+idcRluXX3fOHFv6SutvDOgWhvgLt5X0y28Wl
Inz1rHyhKNrJvEnoY7swuGdcsxHNgQpiusNwpvxDegIH7Y88XBzR0QQAQrCT6eZL
0aEqhmTFPa5YxEF9xS3msZDXALaOSe2XJcw6OYNlx988AIzYm6e9dFmDZRF+Cvi+
Tew8SqqMjGthHFWkw1oPl4JRazCKeBSsSlC+Y7psdsaOxRih5kk=
=a62R
-----END PGP SIGNATURE-----

--nextPart1540618.WDi4tl9tFu--

