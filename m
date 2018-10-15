Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Oct 2018 12:12:26 +0200
Message-ID: <4303236.klkYGd5fVA@prime>
In-Reply-To: <029001d46451$32dd4ec0$9897ec40$@sina.com>
References: <CAEmTpZG2E2+4taAqrRpr0Yq_2HNte16wB2_gD87ZuN8aRnAOag@mail.gmail.com>
 <6363727.6cOmail6FH@bentobox> <029001d46451$32dd4ec0$9897ec40$@sina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27495509.TRgsRWHOCc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode
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
Cc: gary <guohuizou2000@sina.com>, =?utf-8?B?J9Cc0LDRgNC6INCa0L7RgNC10L3QsdC10YDQsyc=?= <socketpair@gmail.com>

--nextPart27495509.TRgsRWHOCc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Gary,

when the loss happens, for how long does it happen? Do you see where/why th=
e=20
ping packets get dropped? That should be the first step to find out, IMHO.

Changing the gateway should be working in general [1]. It's also possible t=
hat=20
the loss is mesh related and the gateway change happens due to a node faili=
ng=20
in your mesh - that would be a problem independent of BLA.

I hope those suggestions help you to find out the problem. :)

Cheers,
      Simon
[1] https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidanc=
e-Testcases#A-client-switches-its-gateway-due-to-loss-of-linkbetter-TQ


On Monday, October 15, 2018 2:34:53 PM CEST gary wrote:
> Hi, guys,
>=20
> I meet an issue related to bla.
> There are two backbone nodes on backbone LAN, and many mesh nodes connect=
ed
> with the two backbone nodes. When I run ping test on one client, there is
> about 20% packet loss. And I find out the packet is always loss when the
> client is switch from one backbone node to another one(observing "batctl
> cl" on backbone node).
>=20
> Do you have any suggestion for the issue?
>=20
> Thanks very much.
> -----Original Message-----
> From: B.A.T.M.A.N <b.a.t.m.a.n-bounces@lists.open-mesh.org> On Behalf Of
> Sven Eckelmann Sent: 2018=E5=B9=B410=E6=9C=8812=E6=97=A5 14:06
> To: b.a.t.m.a.n@lists.open-mesh.org
> Cc: =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=
=D1=80=D0=B3 <socketpair@gmail.com>
> Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode
>=20
> On Freitag, 12. Oktober 2018 10:55:02 CEST =D0=9C=D0=B0=D1=80=D0=BA =D0=
=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> > Hello, guys.
> >=20
> > Does anybody know if BLA is somehow connected with gateway mode ?
>=20
> No it isn't connected.
>=20
> > In
> > short, I'm unsure if gateway mode algorythms influence only DHCP
> > traffic. It is not strictly said. Documentation about BLA II use term
> > "gateway". As afr as I understand, there maybe case when BLA gateway
> > is one node, and DHCP gateway is another one.
>=20
> Correct
>=20
> > So, the question: does
> > GW functionality influence BLA algorythms ?
>=20
> No
>=20
> Kind regards,
> 	Sven


--nextPart27495509.TRgsRWHOCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvEaAoACgkQoSvjmEKS
nqEJLA/8Cz/RTni8j/UZ2QNb09Yjt2Y3lAdIOq173y2cBYHJb22WJhMjqA8TOpPt
+AmNf22UHJ7U0W8mOpeyDpEnDanHal0rFqUADeO9YgV7r75kb7c1cyjq++zmEuE1
V8q7AFtYkHxDzF0rT4NYOsWbjl2BVXjtXX2x22KS9BJ731CSAtTXEmyDr+dUvd+F
xMNFk8nrZy2Xtyu5/dQBYHCWMPxdXgH+RzfIM4Np2OmI3yiFVlLORPZ7xeA4IlA+
JRGOcRY2thQdAc8Bsn8KmgA3kf+pV9vJQjscv83xsI7RTXjG3wcoWDsw9bGIpzD9
ve850ruixsv1yG9CDiTy4WDmvlwAPu0Vf96vSpkUVg0D4LKWKaj4iYQ3SdnPJAPG
ddgH9+jVedYcYbQavXHqecKmiY2wxiNnpdZTEE4ZcNjVSFQ1URokj7rZ5RnThlDE
ls8ERjERsta+ZT95y7wlWmzw9dlTDLtBB+mhlI+DaZ7n9EfFRd2bwC+Ns3UR14+S
g1ShSQAkt9tT5mieTeJTPaTAgOzDbr6QHVKyeSY42eNncMqNJg7BgT8rnoltF0bd
EomFbimJFhJXQLp1rn+0PEBTtgs/d2je8nCS+9Y6B/GWkpzLjJ8t22IRd159Q2er
/MF4nHQL0woZHaU/akEGXHnT73TmJfILo+x4mIO4u+cjBshHSc4=
=3p5D
-----END PGP SIGNATURE-----

--nextPart27495509.TRgsRWHOCc--

