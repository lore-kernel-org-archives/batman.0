Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <CAEmTpZG2E2+4taAqrRpr0Yq_2HNte16wB2_gD87ZuN8aRnAOag@mail.gmail.com>
 <6363727.6cOmail6FH@bentobox>
In-Reply-To: <6363727.6cOmail6FH@bentobox>
Date: Mon, 15 Oct 2018 14:34:53 +0800
Message-ID: <029001d46451$32dd4ec0$9897ec40$@sina.com>
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>
Cc: =?utf-8?B?J9Cc0LDRgNC6INCa0L7RgNC10L3QsdC10YDQsyc=?= <socketpair@gmail.com>


Hi, guys,

I meet an issue related to bla.
There are two backbone nodes on backbone LAN, and many mesh nodes =
connected with the two backbone nodes.
When I run ping test on one client, there is about 20% packet loss.
And I find out the packet is always loss when the client is switch from =
one backbone node to another one(observing "batctl cl" on backbone =
node).

Do you have any suggestion for the issue?

Thanks very much.
-----Original Message-----
From: B.A.T.M.A.N <b.a.t.m.a.n-bounces@lists.open-mesh.org> On Behalf Of =
Sven Eckelmann
Sent: 2018=E5=B9=B410=E6=9C=8812=E6=97=A5 14:06
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =D0=9C=D0=B0=D1=80=D0=BA =
=D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 =
<socketpair@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BLA and gateway mode

On Freitag, 12. Oktober 2018 10:55:02 CEST =D0=9C=D0=B0=D1=80=D0=BA =
=D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> Hello, guys.
>=20
> Does anybody know if BLA is somehow connected with gateway mode ?

No it isn't connected.

> In
> short, I'm unsure if gateway mode algorythms influence only DHCP=20
> traffic. It is not strictly said. Documentation about BLA II use term=20
> "gateway". As afr as I understand, there maybe case when BLA gateway=20
> is one node, and DHCP gateway is another one.

Correct

> So, the question: does
> GW functionality influence BLA algorythms ?

No

Kind regards,
	Sven


