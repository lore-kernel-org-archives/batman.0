Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <CAEmTpZG2E2+4taAqrRpr0Yq_2HNte16wB2_gD87ZuN8aRnAOag@mail.gmail.com>
 <6363727.6cOmail6FH@bentobox> <029001d46451$32dd4ec0$9897ec40$@sina.com>
 <4303236.klkYGd5fVA@prime>
In-Reply-To: <4303236.klkYGd5fVA@prime>
Date: Tue, 16 Oct 2018 17:50:42 +0800
Message-ID: <02cd01d46535$b6f468d0$24dd3a70$@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
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
To: 'Simon Wunderlich' <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?B?J9Cc0LDRgNC6INCa0L7RgNC10L3QsdC10YDQsyc=?= <socketpair@gmail.com>


Hi Sinon,

Thanks for your tips. The loss happens only on one mesh point, other =
mesh points work well.
By default bla is enabled on all of the mesh point.=20
Can disabling bla on non-backbone mesh point help to improve the mesh =
network's overall performance?

Regards,
Gary

-----Original Message-----
From: Simon Wunderlich <sw@simonwunderlich.de>=20
Sent: 2018=E5=B9=B410=E6=9C=8815=E6=97=A5 18:12
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: gary <guohuizou2000@sina.com>; '=D0=9C=D0=B0=D1=80=D0=BA =
=D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3' =
<socketpair@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode

Hi Gary,

when the loss happens, for how long does it happen? Do you see where/why =
the ping packets get dropped? That should be the first step to find out, =
IMHO.

Changing the gateway should be working in general [1]. It's also =
possible that the loss is mesh related and the gateway change happens =
due to a node failing in your mesh - that would be a problem independent =
of BLA.

I hope those suggestions help you to find out the problem. :)

Cheers,
      Simon
[1] =
https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-=
Testcases#A-client-switches-its-gateway-due-to-loss-of-linkbetter-TQ


On Monday, October 15, 2018 2:34:53 PM CEST gary wrote:
> Hi, guys,
>=20
> I meet an issue related to bla.
> There are two backbone nodes on backbone LAN, and many mesh nodes=20
> connected with the two backbone nodes. When I run ping test on one=20
> client, there is about 20% packet loss. And I find out the packet is=20
> always loss when the client is switch from one backbone node to=20
> another one(observing "batctl cl" on backbone node).
>=20
> Do you have any suggestion for the issue?
>=20
> Thanks very much.
> -----Original Message-----
> From: B.A.T.M.A.N <b.a.t.m.a.n-bounces@lists.open-mesh.org> On Behalf=20
> Of Sven Eckelmann Sent: 2018=E5=B9=B410=E6=9C=8812=E6=97=A5 14:06
> To: b.a.t.m.a.n@lists.open-mesh.org
> Cc: =D0=9C=D0=B0=D1=80=D0=BA =
=D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 =
<socketpair@gmail.com>
> Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode
>=20
> On Freitag, 12. Oktober 2018 10:55:02 CEST =D0=9C=D0=B0=D1=80=D0=BA =
=D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> > Hello, guys.
> >=20
> > Does anybody know if BLA is somehow connected with gateway mode ?
>=20
> No it isn't connected.
>=20
> > In
> > short, I'm unsure if gateway mode algorythms influence only DHCP=20
> > traffic. It is not strictly said. Documentation about BLA II use=20
> > term "gateway". As afr as I understand, there maybe case when BLA=20
> > gateway is one node, and DHCP gateway is another one.
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



