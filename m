Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF0A14.3030705@meshcoding.com>
Date: Wed, 22 Jan 2014 01:00:20 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
In-Reply-To: <52DED209.5000207@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5Bo2Ti0kIURWs2aiSDHOGnWF7eknuwprx"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Bo2Ti0kIURWs2aiSDHOGnWF7eknuwprx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/14 21:01, cmsv wrote:
> Yes i understand that but it keeps on increasing.
> [   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is too
> small (1546) to handle the transport of batman-adv packets. Packets
> going over this interface will be fragmented on layer2 which could
> impact the performance. Setting the MTU to 1560 would solve the problem=
=2E

Have you tried applying this patch before testing it once again?

http://git.open-mesh.org/batman-adv.git/commit/746d6436f88899a79c1cb3b27a=
f0614510368bb7


Cheers,

--=20
Antonio Quartulli


--5Bo2Ti0kIURWs2aiSDHOGnWF7eknuwprx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3woZAAoJEEKTMo6mOh1VTK0QAJY3aJL4SvZdT7Mot3JCxBTI
EKvnQ1X/xKqPBg6jIn0pUBSCHTO+s9JRQFFJ/nsaBEdLNCqsPYA+wOJnmGl5uemz
27mva/MlxRwl2qJApEWPe+25D0XJCgenJmTXRc8UBrLiZU1uyfp30EtvdZVeJ+Ox
xl8jFo8iAtZqzP18IJLvyANgHpd9ez3H6ze/GXrR7sy9d+9pZ2/hMnajMMtV7rRL
6mddd3nFjSp1J/XVJh0C44n+RjTwW48DwDyZFp2tRO0yLrEDPgiShfxEGY7YaSze
H6AkrFnpsvYVovowiLuQ3U2Ts6Ruc54FEoWnIKlasM0zY5inTV/fZaNRJPQzjaJc
sq4St7w6kYAsAURP9PevDY7gE7It0IvYlHmByhLr9gpadY+VqZnW8Vp9B1/bAAbX
zjLxnbyIgQcq/UIDFJ+naH8pVQAAJtAP87yncS8ks5fuhyggqN5Gk8wXwbwgy37N
yuUI2SIoFYfox+Y5eoy2g7Cj6uMBp/g4/MN5ZehBXjzpkQLv7LcoKGM/WDyHxzP3
q0bCHWkHbGdspfsL0J1yFrKGE+uBlhMeiudJFuu9qT1xt1kiWOQmTDDdZb7fepJd
BeNripqKXlVYYZEdUFX7RMRV/z//HHczQHYX6tB60GseO14aeOqyKHFQT3ad9Yez
ZXzQykeqfzgCIlpzm6an
=3w/E
-----END PGP SIGNATURE-----

--5Bo2Ti0kIURWs2aiSDHOGnWF7eknuwprx--
