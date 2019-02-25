Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Feb 2019 17:50:08 +0100
Message-ID: <59660839.RxU627SyFe@bentobox>
In-Reply-To: <20190225160046.GD1761@otheros>
References: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
 <CAHh66V8VNnbZCHWOi9ppnKbqfo1PbqVV3vSP1wbyROidBpTRCw@mail.gmail.com>
 <20190225160046.GD1761@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1875956.CfP0z5Gqfh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fwd: nodes start disappearing after a certain
 node count
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, umut deniz <umut.deniz@gmail.com>

--nextPart1875956.CfP0z5Gqfh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 25 February 2019 17:00:46 CET Linus L=FCssing wrote:
[...]
> Disable batman-adv and try a broadcast ping like "ping6 ff02::1%adhoc0" a=
nd
> unicast ones. If that works with 6 nodes, but not with 7 ones then you
> know it's not batman-adv's fault.

This is only true when the driver/firmware handles multicast frames as=20
broadcasts. I have already seen some of them converting the multicast/unica=
st=20
frames to unicast frames in such situations. This also broke OGM detection =
on=20
batman-adv because we only accept broadcast OGMs received as broadcast -=20
otherwise the OGM metric stuff wouldn't make any sense at all.

And you have to do this in both directions to check whether bidirectional=20
links are available. A ping6 answer (icmp echo reply) is unicast - and you=
=20
also need the check the broadcast stuff in both direction.

But yes, when even this test fails then it is definitely not batman-adv's=20
fault. Just keep in mind that a working ping6 doesn't have to mean that it =
is=20
batman-adv's fault.

Kind regard,
	Sven
--nextPart1875956.CfP0z5Gqfh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlx0HMAACgkQXYcKB8Em
e0bnHw/9GrYyWiQKcX+ziUULMlwjexCHHKzqq0dsWapzXJlCQs3Zhmu21LZLt2XB
n+bC6rFP4EniTuD72HPmw/CpoX6C5SsEDzk44dRVzWjDAfUGVCJbdm/baiSmIc3N
Gz3X+BoJDVkcp4goUpLl+5xUDmMiE+eEZuXfik/BMUXMNV6NImDMpcS0XFYRDtjo
Fv4ypaH9SgfjrSwSJT5gIIEizSUnAgW5fC+5UvMExhPYkfZ/pMMN4/qaoFO8L+xN
qE6WSYylHTQ3l9wtSJVfzxwHVJ+26YL4gkk2i0TfVlsC1tDsWuOy0pbgn8SxN+jI
scSE2+wrtNShqk39JKCoZ7T0gR5cyS9WRDGZqaMniOLMIuBh0rkcl1HWUPB6Hdur
NJ+gmEVZ1VwZcHPOeJO4pFrUPwLXOrFgY1SRciXO1YNrLLRbbBYA9sv066GGph6k
LkpUJDgoPA3PkKxDFXqf7gprmYTSp366isIBjhWESZ/2ty0XtPiLLv4IRJ/z99AK
FpCg8vnZR5f3Py2/LDgRAW4qSls5fKs2UJKRBvtaU0A9QUGJWWfs9IkpORrtY5WL
WIWH8wlT4+tKuwt7K8fbAi/oyfsERWs8DZ2AEM2s4kjD/lht+Bn+peSfSLrIx6ru
8OyO9jJPfTUx1qKv0WiHeKVLpA1Vt9ZuQ3ijbPDoRDVLCTQrGb8=
=HEkz
-----END PGP SIGNATURE-----

--nextPart1875956.CfP0z5Gqfh--



