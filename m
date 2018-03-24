Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Mar 2018 10:42:10 +0100
Message-ID: <5008749.PhXIyr9qhG@sven-edge>
In-Reply-To: <20180321232132.15176-1-linus.luessing@c0d3.blue>
References: <20180321232132.15176-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4439531.b3DcnRJm8E";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix packet loss for
 broadcasted DHCP packets to a server
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

--nextPart4439531.b3DcnRJm8E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 22. M=E4rz 2018 00:21:32 CET Linus L=FCssing wrote:
> DHCP connectivity issues can currently occur if the following conditions
> are met:
>=20
> 1) A DHCP packet from a client to a server
> 2) This packet has a multicast destination
> 3) This destination has a matching entry in the translation table
>    (FF:FF:FF:FF:FF:FF for IPv4, 33:33:00:01:00:02/33:33:00:01:00:03
>     for IPv6)
> 4) The orig-node determined by TT for the multicast destination
>    does not match the orig-node determined by best-gateway-selection
[...]
> ---
>  net/batman-adv/gateway_client.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied as 49b2132f0fe2 [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/49b2132f0fe2753a3b46103=
db9719898c5cd44aa
--nextPart4439531.b3DcnRJm8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlq2HXIACgkQXYcKB8Em
e0bEQQ/+JXTtxm0bUwtC+0cbwCvYkHia4RHQbXC5DPraDfa90RPH2OvyoRQsBpA2
wc4svGxt5qJmRVrgS7bDhbQiR1wOUXiT4n/3LjtBohgekw7oQJuL90Fw4EPB9rVJ
iMHvEda8j+vl9b9pOMvWCRrmNWYfh45t7fK2n6ODU26som3l8tZdJ7AaeZuy+HvZ
i+cGrZANU+wGbWnAeq8fRJhjamxD4tiqey+SfPWf7HGxmyIBDUUIuycXAM6WmFok
pmM57skj37omqe3F0SuVB8TFQz19WsfOjc2TuWtLSMkIPKv7hvsXlMGITCxLrBKl
QEmHLbGEYzHyCdCn0Iwu0+DdIho0kTC3J0tTA94cZid6yggzdDDqUJJNOYQV9rEM
0YjK6ThgK909B364XgxduLdfqtVE4mYjNkrwD/C7v4lGX2C7fC425q0axsFS43IP
Ivx/I4vxLbQeRRVpnBfn97xGQtJqfFQ3tP/LUAz9QhtMC+2tIlvXBIHeElXL/OGZ
hkXFj+S6pvm+sUCJMISUtZUWTccLIdu0tdO2mWaQn9DQrwrgPRYgmXufCom4ELUZ
WWDJggaY9G17juUOcsjdREHBi2HZLKnsP76mSmJXRqakuEMUOlXE6YGqy1WTo7Bc
XOJ5uNJcBZRANohEfU33YiLXYIrM5/U1392FPQBOmZWXclVy0xw=
=IXxL
-----END PGP SIGNATURE-----

--nextPart4439531.b3DcnRJm8E--

