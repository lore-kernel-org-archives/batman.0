Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
References: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de>
 <88928628.8v8VXxemU5@ripper>
From: MK <mailing.m1@kkk-web.de>
Subject: Re: Does batman choose DHCP server by random?
Message-ID: <998e8a9b-e0c6-babb-0b45-5fb3fb657a32@kkk-web.de>
Date: Tue, 29 Sep 2020 22:04:58 +0200
MIME-Version: 1.0
In-Reply-To: <88928628.8v8VXxemU5@ripper>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jNUqtfHPkjOFwyECooQmK3yi9cfgWKvV4"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

 This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNUqtfHPkjOFwyECooQmK3yi9cfgWKvV4
Content-Type: multipart/mixed; boundary="W7T39sBAMlaQrfwfaD9HS6b9g6I87MPzD";
 protected-headers="v1"
From: MK <mailing.m1@kkk-web.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <998e8a9b-e0c6-babb-0b45-5fb3fb657a32@kkk-web.de>
Subject: Re: Does batman choose DHCP server by random?
References: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de>
 <88928628.8v8VXxemU5@ripper>
In-Reply-To: <88928628.8v8VXxemU5@ripper>

--W7T39sBAMlaQrfwfaD9HS6b9g6I87MPzD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sven.

> See https://www.open-mesh.org/projects/batman-adv/wiki/Gateways

We did set up all batctl values according to the manual, but still get
IPs/Leases from other gateway's ranges and therefore cross-traffic...

Any hint on what we did wrong?

Server:
$ batctl gwl
[B.A.T.M.A.N. adv 2020.2, MainIF/MAC: fastd_mesh/ (bat0/ BATMAN_V)]
  Router            ( throughput) Next Hop          [outgoingIf]  Bandwid=
th
   (        7.7)  [fastd_mesh]: 10.0/10.0 MBit
   (        7.7)  [fastd_mesh]: 10.0/10.0 MBit
   (       10.0)  [fastd_mesh]: 10.0/10.0 MBit
   (        8.8)  [fastd_mesh]: 10.0/10.0 MBit
   (        7.7)  [fastd_mesh]: 10.0/10.0 MBit
   (        8.8)  [fastd_mesh]: 10.0/10.0 MBit

$ batctl gw_mode
server (announced bw: 10.0/10.0 MBit)

$ batctl -v
batctl 2020.2 [batman-adv: 2020.2]

Client:
https://github.com/ffulm/firmware/blob/ec1d061e20557662dd8c7fc75dc603fee9=
bf77e0/files/etc/uci-defaults/50_freifunk-setup#L207

Regards,
 Martin



--W7T39sBAMlaQrfwfaD9HS6b9g6I87MPzD--

--jNUqtfHPkjOFwyECooQmK3yi9cfgWKvV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE9IPOuVyPsFfx2iJ9cNiJ0EN5ao8FAl9zk3UACgkQcNiJ0EN5
ao+WxBAAwbco8iuF2Bc9+kr4U9vWTeMqIB8azS9TiYkh1/yjS0Vf9FpeAPB5AorI
Fby13ofJLcPIcZJKs6ZhdouwCY/F2xhQQZW43XhqOeO710rzJrvSzKvXG8737krY
gJ7GoY2ZFBBsccJpIkH5eS2fuqermZgMQyT1zSejs+hWmAiKKZd7l0CktwCjivqq
Af4nha3XgamYKPIpSCBy5kkmp6W3bp9p0ZST5ILfd9g6mBmvS4UXYQEohIl5K5qi
SLfk0SFOVJoEXxuuMXwChjin6/En+r8+iS4pWRRNQY5wv2ylvC/8Anoiz3nBia9T
YEN/yoh31dU3Abnjb4zoSoYBIwre/X7XGVc9GTpFc9zPf/Cw9t5+ncH3eSRperCI
+o9q7h3GFUV1WKvDGrIKgspThWGyHba8Ore4fptnCE7Cbh+LB86woZJneO9OKXkv
oIKCifk/BKSbvcHKcmcYDqtCWFo/ni8wVQXmTrIlmuv5sYSUy+frg22tdUwQ1qMZ
j3FEiqTxZU/f0JnzaEhEKU6NKo2wqudk0LT2KBks2S3Jm6DPg/tIG3KDcRh++5XM
YUjlAjCDMALlw5JlU6iDewx5LTlPIiBKM6RRxfTaV7e7zNA3LGnE+X5lcjwiza78
cqekfJXV5ye05uy1pElWsUQQ6/R4awhT3w/gND21IWXC5ovu9Rg=
=OUfT
-----END PGP SIGNATURE-----

--jNUqtfHPkjOFwyECooQmK3yi9cfgWKvV4--
