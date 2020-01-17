Return-Path: <jeremy.j.martin33.civ@mail.mil>
From: "Martin, Jeremy J CIV USARMY CCDC C5ISR (USA)"
 <jeremy.j.martin33.civ@mail.mil>
Subject: RE: [Non-DoD Source] Re:
Date: Fri, 17 Jan 2020 14:07:33 +0000
Message-ID: <766B88D91EC93C4C8C7E844717CBB21F0DF4B39A@UCOLHPUH.easf.csd.disa.mil>
References: <mailman.6.1579205674.8101.b.a.t.m.a.n@lists.open-mesh.org>
 <2587871.AsJD0l72uE@prime>
In-Reply-To: <2587871.AsJD0l72uE@prime>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: "Martin, Jeremy J CIV USARMY CCDC C5ISR (USA) via B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Simon,

    Thank you very much for taking the time and answering my questions. Gre=
at work on Batman, the little I've seen of it, it seems to be a very well m=
ade routing protocol.=20

Best,

Jeremy Martin=20
Office: (443)-395-7475
Jeremy.j.martin33.civ@mail.mil
Radio Frequency Communications Division, RF Modeling and Simulation Branch
C5ISR Center, Space and Terrestrial Communications Directorate   =20



-----Original Message-----
From: Simon Wunderlich [mailto:sw@simonwunderlich.de]=20
Sent: Friday, January 17, 2020 2:45 AM
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin, Jeremy J CIV USARMY CCDC C5ISR (USA) via B.A.T.M.A.N <b.a.t.m.a=
.n@lists.open-mesh.org>; Martin, Jeremy J CIV USARMY CCDC C5ISR (USA) <jere=
my.j.martin33.civ@mail.mil>
Subject: [Non-DoD Source] Re:

Hi Jeremy,

On Thursday, January 16, 2020 9:06:50 PM CET Martin, Jeremy J CIV USARMY CC=
DC C5ISR (USA) via B.A.T.M.A.N wrote:
> My/My Teams intent is to have 4 radios in total, 2 on one pc and two=20
> on another. Our plan is to have Batman take care of the switching=20
> between which radio to use in order to transmit data between these two=20
> PC's. One radio is high frequency radio (60 Ghz) and the other would=20
> be a lower frequency radio and the idea is to have batman switch=20
> between these radios once the higher frequency radio is dropping between =
a certain TQ.

BATMAN will switch by default when one link has a better TQ (towards the fi=
nal
destination) than the other link, so I believe this should happen by defaul=
t.

> My
> primary questions regarding this scenario would be, 1) Are there=20
> specific standards the radio chipsets would need to support in order=20
> for them to work in this scenario?.

Normally you would want IBSS mode or 802.11s mode work. BATMAN can also wor=
k in AP/Sta mode, although the packet loss counting may be biased since bro=
adcast handling works a bit different than in IBSS/11s. But for point-to- p=
oint links it might just work.

> 2) Would Batman-adv be adequate enough to be able to handle a 1Gb/s=20
> data transmission and be able to swap accordingly to the lower=20
> frequency radio?

If your radio and CPU are powerful enough, batman-adv is able to handle it,=
 yes.

Cheers,
      Simon
