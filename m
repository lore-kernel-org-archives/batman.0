Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 16 Oct 2018 12:00:37 +0200
Message-ID: <3063679.xsfac3rA88@prime>
In-Reply-To: <02cd01d46535$b6f468d0$24dd3a70$@sina.com>
References: <CAEmTpZG2E2+4taAqrRpr0Yq_2HNte16wB2_gD87ZuN8aRnAOag@mail.gmail.com>
 <4303236.klkYGd5fVA@prime> <02cd01d46535$b6f468d0$24dd3a70$@sina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7662796.ZuOoLiKVQS";
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
To: gary <guohuizou2000@sina.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?utf-8?B?J9Cc0LDRgNC6INCa0L7RgNC10L3QsdC10YDQsyc=?= <socketpair@gmail.com>

--nextPart7662796.ZuOoLiKVQS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Gary,

On Tuesday, October 16, 2018 5:50:42 PM CEST gary wrote:
> Hi Sinon,
>=20
> Thanks for your tips. The loss happens only on one mesh point, other mesh
> points work well. By default bla is enabled on all of the mesh point.
> Can disabling bla on non-backbone mesh point help to improve the mesh
> network's overall performance?

I don't think this will help. If they are not on a shared backbone, BLA wil=
l=20
not do much more than sending an "announce" frame every 10 seconds. This=20
shouldn't have performance implications.

Cheers,
      Simon

>=20
> Regards,
> Gary
>=20
> -----Original Message-----
> From: Simon Wunderlich <sw@simonwunderlich.de>
> Sent: 2018=E5=B9=B410=E6=9C=8815=E6=97=A5 18:12
> To: b.a.t.m.a.n@lists.open-mesh.org
> Cc: gary <guohuizou2000@sina.com>; '=D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=
=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3' <socketpair@gmail.com>
> Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode
>=20
> Hi Gary,
>=20
> when the loss happens, for how long does it happen? Do you see where/why =
the
> ping packets get dropped? That should be the first step to find out, IMHO.
>=20
> Changing the gateway should be working in general [1]. It's also possible
> that the loss is mesh related and the gateway change happens due to a node
> failing in your mesh - that would be a problem independent of BLA.
>=20
> I hope those suggestions help you to find out the problem. :)
>=20
> Cheers,
>       Simon
> [1]
> https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-=
Te
> stcases#A-client-switches-its-gateway-due-to-loss-of-linkbetter-TQ
> On Monday, October 15, 2018 2:34:53 PM CEST gary wrote:
> > Hi, guys,
> >=20
> > I meet an issue related to bla.
> > There are two backbone nodes on backbone LAN, and many mesh nodes
> > connected with the two backbone nodes. When I run ping test on one
> > client, there is about 20% packet loss. And I find out the packet is
> > always loss when the client is switch from one backbone node to
> > another one(observing "batctl cl" on backbone node).
> >=20
> > Do you have any suggestion for the issue?
> >=20
> > Thanks very much.
> > -----Original Message-----
> > From: B.A.T.M.A.N <b.a.t.m.a.n-bounces@lists.open-mesh.org> On Behalf
> > Of Sven Eckelmann Sent: 2018=E5=B9=B410=E6=9C=8812=E6=97=A5 14:06
> > To: b.a.t.m.a.n@lists.open-mesh.org
> > Cc: =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=
=D1=80=D0=B3 <socketpair@gmail.com>
> > Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode
> >=20
> > On Freitag, 12. Oktober 2018 10:55:02 CEST =D0=9C=D0=B0=D1=80=D0=BA =D0=
=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> > > Hello, guys.
> > >=20
> > > Does anybody know if BLA is somehow connected with gateway mode ?
> >=20
> > No it isn't connected.
> >=20
> > > In
> > > short, I'm unsure if gateway mode algorythms influence only DHCP
> > > traffic. It is not strictly said. Documentation about BLA II use
> > > term "gateway". As afr as I understand, there maybe case when BLA
> > > gateway is one node, and DHCP gateway is another one.
> >=20
> > Correct
> >=20
> > > So, the question: does
> > > GW functionality influence BLA algorythms ?
> >=20
> > No
> >=20
> > Kind regards,
> >=20
> > 	Sven


--nextPart7662796.ZuOoLiKVQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvFtsUACgkQoSvjmEKS
nqEVPRAAo3jI/1jtDqF6b6YZIJgLS5IvdmqW+asdSqJStcS308vW8Aur4NsHkhrr
V8Iqg7CLuxTxQHytNqgP94mghGk9s7iiWPLIUxQAXHKXgcSidhBXEJC4SMMbO5Sf
Xncro1SNdzL/x92xY5S9MGMwzCfQTIIThG36B8q+28f+HC0QIY6EDnIY8m8kzP+Z
GoPeht5jsNQ/qj1I+8aJkVwjkAifWpdDjwOMF1xj2sSKYqEI9Fq85R1JbRqOLy8e
FS3Z9ZKIuS7M33VnPhLYxQ4QNg8ctC0aUh6yE9IzfyZEsGIbxE0Wz0725PTWTSP8
qEMTB9odc5j2HI50MzEOiQRtUYfg5JzT9RG3WEfS8RMo5/nTOPhFtG+qnmi7UIca
GgAC+OcGK6Py1ULTnMAaLoZO4nwE78xjDHt5RVenVznkpoAfOmy/0XBLhQVUXJ1A
N/1AaYawm8WhbjFRd2e0fahlTvIYDCnxerH+52ekxhbCka70VHoZ8U9JTZRLWvTJ
XdXIdu0QXrVvewmpO5cfmt/SZXQt/wYfGVlXkQZ+3zBrJlbBF43I0k1+vmr7kdXs
MwJhPWR11xtLvO9WJenoY8mGDb7Eqs/jNVTavvnbHOthDIClHyGBrxUq5jpl4lqz
vTbDYu7Dmm2bOXaReypmOjP0/hWdMcLN4XR1FSMbI64Nfred44A=
=aeE6
-----END PGP SIGNATURE-----

--nextPart7662796.ZuOoLiKVQS--

