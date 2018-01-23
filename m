Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Jan 2018 13:21:08 +0100
Message-ID: <3054592.V1b4d6Bjbj@bentobox>
In-Reply-To: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
References: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2354350.EuDcRRZAWy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2 1/2] batman-adv: fix packet
 checksum in receive path
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

--nextPart2354350.EuDcRRZAWy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Januar 2018 10:59:49 CET Matthias Schiffer wrote:
> eth_type_trans() internally calls skb_pull(), which does not adjust the
> skb checksum; skb_postpull_rcsum() is necessary to avoid log spam of the
> form "bat0: hw csum failure" when packets with CHECKSUM_COMPLETE are
> received.
>=20
> Note that in usual setups, packets don't reach batman-adv with
> CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
> batadv's ethtype?), which is why the log messages do nor occur on every
> system using batman-adv. I could reproduce this issue by stacking
> batman-adv on top of a VXLAN interface.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Applied both as 798174b15153 [1] and 2c1bce065baa [2].  They are also queue=
d=20
up in linux-merge [3] but will most likely only forwarded when Simon is bac=
k=20
from=20his vacation. Tested-by's are still welcome :)

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/798174b15153afd88268f2f=
87811602f68b3f2c6
[2] https://git.open-mesh.org/batman-adv.git/commit/2c1bce065baa688bc1eca41=
16f83ca3b790432a5
[3] https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/batadv/ne=
t
--nextPart2354350.EuDcRRZAWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpnKLQACgkQXYcKB8Em
e0bDHQ//a6CO/cQWr5tNYmOcbMyXEhhij6IpMXsQRTQ9AjH/x/SoqCHYjFM96gyJ
TpqEJEt8d7o+ZrjSiYBCYi8xwl8FFJ5PERnnxvIGAwSp/Axud5KHx7WcODydCzfg
AyIWWghInpbEDEeogBpKTNqdV1UOb42OtNOT7ZwPSyEd5S6V/qf7fe7WQyiD9pvm
UqjT9hVW40WR/JJbrFKSwJvFwnHVfxTC/8gDCEm8Y3NxJgSRuYO+IxVk60J0kpe/
TNEeNGSIhcBAkjh08IlWIUH+fD9T8A168yYTX0I0VFZsbJyz5x38CmsgHJ5isdHt
7s1EBz3QB8uPLFzmFGrjp2QEO2hYzSgigeFOyVhrgjmOIwbE8Fn/jWhm9TsxQW7T
RI4VCE1TCSsmPuXEjQqLDCoXHuoMiz0kiNPJZOohUzL5lAFT76hp2sczwgHwq9/G
XykxIzorutb4cQU7gvXHVCjXBUnCl18e65gg/gd1YftXOrQO1qB0DfMT49kmkYAJ
kgiEh7Gs6fm3IuDCxYNkK+tuwaSbhAwnHDAD29brZ138U1hNR9HdfCWg+J9d6ryZ
oUnJheU/eMZpXM9Cn7jzImwojyvoJWqVimqYIf+QIGUT7Js6eskjjjcPgkeQy+TF
oe3dM3NPZ6+P0TS5khbzcSS9Qb/s3sMlpNfLaaHYe+Pvw+gjNrQ=
=mSv5
-----END PGP SIGNATURE-----

--nextPart2354350.EuDcRRZAWy--

