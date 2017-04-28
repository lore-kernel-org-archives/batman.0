Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 28 Apr 2017 14:23:16 +0200
Message-ID: <3080757.qWi1On8dnJ@prime>
In-Reply-To: <1493376248.28193.6.camel@openmailbox.org>
References: <1493216459.18414.3.camel@openmailbox.org>
 <1504855.vmUtePouqW@prime> <1493376248.28193.6.camel@openmailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1866016.NKEMmzXYkG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] how well does batman-adv scale
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

--nextPart1866016.NKEMmzXYkG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Friday, April 28, 2017 12:44:08 PM CEST fuumind wrote:
> Ok, so clouds of a few hundred nodes would work reasonably well and at
> the same time keep customization to a minimum.

Yes

> 
> What makes OSPF a better candidate for interfacing between the clouds?
> Does it keep a more limited routing table and thus minimize overhead
> traffic? I haven't been able to figure it out good enough yet.

The idea would be that you do a layer 3 protocol only on a few selected 
"gateway" nodes of the clouds. Those gateways would forward traffic from one 
cloud to the other, without having the details (and thus not having the 
overhead) of the state of the mesh.

Which technology is the best is beyond my knowledge.

Cheers,
      Simon


--nextPart1866016.NKEMmzXYkG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkDNDQACgkQoSvjmEKS
nqElEQ//c5q4sRdhOi1WPJM8uKYqNkildYitcul6+93ZRuryfgIJ9+IrpDIz2lGP
v2JKRoE8rYeUHGmS7rJ5gJZXvNeW3qiF14dJhlFZUIJWkyFYdChbO1B3mRsWXvG6
jXd/3A6NZXVBmV3AgYdgOA2EQVMqWlfW0iWhB/ANSAvQ4lwW139RX5eAOWLcgfqd
3beqctiJvhE1X7NaMrE5Hc4+3EmEjmE0y1O01E7ngTcM+WD/+kQ/Vd+z50cSur9o
xBOh6Op/Rw9U3tBPnLjVbfY1uk0AF7N3fL6HkUblqoewz0Kk7ye2KGN8we4YN1Ab
AGXx/haWopxrark1hZlrNYmIron6wLuhnU5aK54yvjQxkA/0HR0duP5sc6i3/rWa
Rhp2bsIn8Sxam8Q8ki4Mzlgv0UR8rgAiV+GUUAagJcr1o+lMG+rhBEsRNc3TNHlx
wvj/vW8zo+PXMHgmdjnwKMf2MKDFxqLMNWgzMzUZnVYlyrRyP4P5YOVbR48dPt+H
Whx9IIhnZO2nTBhjMkAz/VpvOySEWYSG/4KUDvZX+jMDa8nVfu2QijI+651CQEW8
ZS57z9DMPwnpdSemB2dPicoc12oZjYlVsTsg0i5eVmpYgPMOJcucU+mCkhsuvGeW
AkeyAuk5F2eQ0sGOxuxYEhhXEGmiDwKR6o2QF7CmQrByNmXtdk8=
=5CIG
-----END PGP SIGNATURE-----

--nextPart1866016.NKEMmzXYkG--

