Return-Path: <a@unstable.cc>
Subject: Re: [PATCH maint] batman-adv: Fix DAT candidate selection on little
 endian systems
References: <20191128114349.7794-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <33c8e3ca-8377-a9be-1c11-a56785d61af4@unstable.cc>
Date: Thu, 28 Nov 2019 14:19:37 +0100
MIME-Version: 1.0
In-Reply-To: <20191128114349.7794-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LAknDfYw5VduG9SmTIr57xxxT0rYHximk"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LAknDfYw5VduG9SmTIr57xxxT0rYHximk
Content-Type: multipart/mixed; boundary="hQOjp5mCQR5M4HmCWOLx8qYv1PlGLLm4Y"

--hQOjp5mCQR5M4HmCWOLx8qYv1PlGLLm4Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/11/2019 12:43, Sven Eckelmann wrote:
> The distributed arp table is using a DHT to store and retrieve MAC addr=
ess
> information for an IP address. This is done using unicast messages to
> selected peers. The potential peers are looked up using the IP address =
and
> the VID.
>=20
> While the IP address is always stored in big endian byte order, it is n=
ot
> the case of the VID. It can (depending on the host system) either be bi=
g
> endian or little endian. The host must therefore always convert it to b=
ig
> endian to ensure that all devices calculate the same peers for the same=

> lookup data.
>=20
> Fixes: 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan a=
ware")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Thanks a lot for fixing this subtle bug.

Acked-by: Antonio Quartulli <a@unstable.cc>




--=20
Antonio Quartulli


--hQOjp5mCQR5M4HmCWOLx8qYv1PlGLLm4Y--

--LAknDfYw5VduG9SmTIr57xxxT0rYHximk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl3fyWkACgkQpNfqZUlH
tXIhgQ/+MEUm/Bo8O/fP457vZz29iP+aXQGLGnJFrHxFnXg6hEl18EVXBzv/aB45
1oVKUeS9/wqa1GL39T61kFKhvHVzGemnqhOi26ToYqy7Fby37zVYneCxiOFPjxNu
9B3TpkGrwKAlI36CbZNUeIBgo+LIeb4qU7oW2is4tR146ezedACDurJ+rg3BTZM2
O5461Z26/17puSkR4w9skoC7Cbo35hJKbG947umCMcfi37Uldy+AzQjo6T+E7Opu
41Lh2Hgw9nYk+XD3UYAvTUIqd08+u2e9BHNRBeCc6s+vphUml9udlDPdr0R71/yA
0tCwG/JLQlKOIrWIQpFfjkBud6z4d/qae2PaLWpCxPOt48Xq9i90ihXkhKtZHnDy
lTzSebWU3yBYcIaCX9cxN79Cz4h9BnlVm5EpOIyJwdmzNjrg0WLrzqVbzNg/idaU
Iv3CR8alaTGr9p/NbKVHRslsVkMeVVmqSTCercmfJc32nAdj7rhkRTuXmEwiWfF8
QcLygjAmcgxd3L47kt6dQgQWzGJoYfmJkgbngRkiVXY0OapIZ+xsuYHvyyo2AHRy
o1yVon7mpnvPaq1XowZUzQdNBPPQqwjv0LxMTPpGSXEgs9JD9Rexrg1ewWVlIDkV
XMNqQ5WSZ2BXuuSwGXrWBGMmXBGGOZEWn9Qp1xhMMl6s7P5An+A=
=q+7c
-----END PGP SIGNATURE-----

--LAknDfYw5VduG9SmTIr57xxxT0rYHximk--
