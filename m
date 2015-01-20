Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Jan 2015 08:31:18 +0100
Message-ID: <3346859.V9Mt6glXr0@sven-edge>
In-Reply-To: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
References: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1423330.8B46UmWyCy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Tighten size check on received
	packet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Jan-Philipp Litza <janphilipp@litza.de>


--nextPart1423330.8B46UmWyCy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 19 January 2015 21:59:32 Jan-Philipp Litza wrote:
> When first checking if a received packet is truncated, the size of th=
e
> alfred_tlv structure is ignored, thus allowing packets that are
> truncated by 4 bytes or less to pass the check unnoticed.
>=20
> Even the check itself might access memory after the packet if its siz=
e
> was only 2 bytes or less.
[...]
>  =09/* drop truncated packets */
> -=09if (length < ((int)ntohs(packet->length)))
> +=09if (length < (int)sizeof(*packet) ||
> +=09    length < (int)(ntohs(packet->length) + sizeof(*packet)))
>  =09=09return -1;
>=20
>  =09/* drop incompatible packet */

Thanks for the patch. It is basically correct but maybe you can modify =
it
slightly to make it also catch very small packets.

diff --git a/recv.c b/recv.c
index 90db0b3..288f577 100644
=2D-- a/recv.c
+++ b/recv.c
@@ -391,7 +391,12 @@ int recv_alfred_packet(struct globals *globals, st=
ruct interface *interface)
 =09=09return -1;
 =09}
=20
+=09/* drop packets smaller than tlv */
+=09if (length < (int)sizeof(*packet))
+=09=09return -1;
+
 =09packet =3D (struct alfred_tlv *)buf;
+=09length -=3D sizeof(*packet);
=20
 =09/* drop packets not sent over link-local ipv6 */
 =09if (!is_ipv6_eui64(&source.sin6_addr))

Kind regards,
=09Sven
--nextPart1423330.8B46UmWyCy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUvgRJAAoJEF2HCgfBJntGLKYQALpYRUQXBKfnXEe5Q+ururb8
iHrn5D/O2NdBDcVFEq8e4LG3Lu4MgeSce5Wik2sYZu7KaFLfSMLy2BA5Asysuk+U
5Rqm4B6rv6+t+31sEc3mxZnit28OOxeY2YBCHspkHRya5bUKeM4GCxJqv0UCTXat
9hXWb0yMn5N7ygvWesc9iVs5ZKpqDwrmwtLSykmLybQ8UqypAfx7TqbJFst0GPhG
wYb7r/DX6o2CxnQiCaFm79NQN2gIAg4iOCwmahqP+knWpl6cCAI7dlskfBQbI7SJ
MVkVOk7cnTX2NbpaoGxO1Xc4KBrOuYUglM5LHT5dcLIyArNHT+5g/wlYFKvnKQ9W
oLOYKxNvG5ZOpfpjjkxHACDOa1SbROapc6EEoEc9ex6lKi+tqwoi2jOK2TafBCIn
wWa6fCRy7pQt4DwUHXI/7gsnFMNeI9PUgaClXadGKMUVb1zYhYIUn6Qtu7SgIr4N
b5rtDXEUIyqC+Z3G5Cafky3WMHU9oMHsKKJxVZ4BXpBWYVn8IZOD6j3kOJqDcPdl
22LXHIj3NAHHIbrIG9hnM5Ua34ax27740CmWo8aj5MNSGYdJWoUIQvSiQAlEdSlh
Hg/puFeKWpCKlwfTpGM879KLV6gHlDVMbQlYB4q8jdUzsdaYXV6slqg+O8xD5LDk
baC98bnOopK2eWUbwatS
=DDAe
-----END PGP SIGNATURE-----

--nextPart1423330.8B46UmWyCy--

