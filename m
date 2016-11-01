Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 14:39:16 +0100
Message-ID: <1657394.aEyv3RqyCa@bentobox>
In-Reply-To: <5818988B.5050600@yahoo.com>
References: <5818988B.5050600@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4878347.eNgjY2Ej4V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] how to config gateway ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart4878347.eNgjY2Ej4V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 1. November 2016 21:28:43 CET johnzeng wrote:
[..]
> i run avahi-autoipd bat0 at two host only ( not run dhcpcd ) and run
> batctl gw_mode server and batctl gw_mode server 5mbit/1mbit at hostA,

batman-adv gateway (mode) is only about filtering DHCP packets from the
client. They will (with enabled gw client mode + reachable gw server)
packets only at the "best" DHCP server. So it will not do anything with
your avahi packets.

The configuration of an DHCP server is not really something for this
mailing list. There is more than one tutorial how to use dnsmasq or
isc-dhcp-server

> and run batctl gw_mode client and batctl gw_mode client 20 at hostB

This will not work. One of the devices has to be the one answering the
DHCP requests (aka the "gw_mode server").

Kind regards,
	Sven
--nextPart4878347.eNgjY2Ej4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGJsEAAoJEF2HCgfBJntGy18P/j+oVTpfdvhjrJQCA88xbgZ0
TVJuNYP9zFD1TTpe2XAD0NthjnEou/AplOPpHgbRasHuMz+KNdh2bKssni34yiWU
d21oVBsnZOoLD+Dc0r7NX92rmz6iApnL2DkklNKB6UQKR2wtaFAgoWIUhe7DuuhQ
xE72lM2xgaXbtwhMnsl4W/iRu0gq7ZRgvfbXdZos502YHTCp58iZaF04qpTf/RjP
a0qW8CC+lzxWeHGk5+hPunCNl7jg2cDw1UfILHrfrVd19Agp+d86+DLceZVTwknD
iRfoLLs7PDMBiE6j6CztE9htFUa/R0AEZwVJukrAjOLhOX6HeJCpsHvdbjF21lEa
hCbTMNVS3GEfxGZ2W8SED713XLlV5qh51dfS8Vm/3R9d3OFXucU1DesS7C60oRAm
SbFnImmpU/5N9cY0iGd8wz4UB8AI3k1Lkpld96K6lgvQY9cAEfI/l8q9ZAV1HD7L
7H3dEhti8O+IQMxUBQyOD3Ds+oESGr2gxCJkr6ahOQhz8WHhyPhCUYHuKwgh6YmE
CaJ7XXD9N4rQDSYH+0uIufezmMgMb6lX1+FJloPpdQznuSkkPttqOU+Q3jULESWm
tTh42JMubc40w5rs9r2NTnLUl3CFYF4HIRj0+ZY7PqmiQTVMlIR9tVR4NFj4XQU6
+kwrbP0w3NBDrCn37ZAE
=maiL
-----END PGP SIGNATURE-----

--nextPart4878347.eNgjY2Ej4V--

