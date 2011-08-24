Return-Path: <javier@cozybit.com>
MIME-Version: 1.0
In-Reply-To: <20110824071841.GA7895@lunn.ch>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
	<30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
	<CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
	<20110824071841.GA7895@lunn.ch>
From: Javier Cardona <javier@cozybit.com>
Date: Wed, 24 Aug 2011 11:30:01 -0700
Message-ID: <CAPjQAd9nSQhRtfbfDsN-raqK2mo5NhuDWPxmt_FCvAS8ZYkf9w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] A case for batman-11s
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: devel@lists.open80211s.org, Clara Gnos <clara.gnos@googlemail.com>

Hi Andrew,

On Wed, Aug 24, 2011 at 12:18 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> unique way. =A0And now that a standard is in place, everyone interested
>> in mesh could benefit if there was a seventh (and final) version bump
>> to bring it in line with IEEE 802.11s.
>
> Hi Javier
>
> I don't know that much about 802.11s, so i would be very happy to be
> wrong....

I'm on equal footing regarding batman: thanks for taking the time to
help me understand the differences between the two.

> I actually think IEEE 802.11s needs to first evolve and become part of
> IEEE802.1. The problem is, mesh !=3D wireless, so having it part of
> 802.11 limits its application way too much.

802.11s is designed to fit within the IEEE 802 family of protocols (it
was approved by the IEEE 802 Executive Committee in July).  You are
correct in that 11s does restrict the mesh to be a wireless mesh.  But
it is designed to connect to external networks via 802.1D bridges.
802.1D bridges have been around for ages and are good at
interconnecting diverse MAC types without routing loops.  I read here
(http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance) that
batman implements its own loop-avoidance protocol which, from my
limited perspective, seems redundant.

> I've been to a few of the wireless battlemesh events and gained some
> experience with real mesh network. One thing which is very clear to me
> is, they are multi-technology. They mix 802.11, 802.3, cable modems,
> VPN, and in theory, there is no reason why avian carriers could not be
> used.
>
> If you look at the mesh routing protocols represented in battlemesh,
> static routes, babel, olsr, BMX, and batman{-adv} all are multi
> technology and have no problem building one mesh over a heterogeneous
> network.

I can appreciate the benefits of supporting a diversity of link
technologies.  I'd have to understand better how a single metric
definition can be used to quantify the quality of all link types, from
802.11 to homing pigeon.  But I guess it's being done successfully.

> (...)
>
> You also said 802.11s contains device authentication, encryption,
> etc. This also seems to me to be the wrong layering. These should be
> generic services which any 802.11 "mode" above can use.
> Can these services be used in adhoc mode or managed mode?

In 802.11 infrastructure mode you have only one authenticator (the AP)
and many supplicants.  You cannot use the same security model in a
mesh, when there are no such role divisions.  Does batman-adv provide
a security layer above the link layer security (and below IP)?  If so,
where can I read more about that?

> If yes, great, anybody setting up a static routes, babel, olsr, BMX, and =
batman{-adv} mesh
> can just use there services.

Based on my current understanding it looks like you could establish a
batman-adv network over 1-hop 11s links.  Interesting.

> My personal opinion is that taking the multi-technology batman-adv
> protocol and shoehorning it into the single technology 802.11s is the
> wrong way to go. What might however be interesting is taking a closer
> look at 802.11s and see what can be generalized and moved up into
> babel, olsr, BMX, and batman{-adv}, or merged into plain old managed
> mode and adhoc mode 802.11 and offered as services to layers above.

When I wrote my first e-mail to your list I was under the impression
was that batman-adv's routing algorithm was more advanced than HWMP,
mainly because it had incorporated improvements gathered from many
deployments (... and mesh battles :).  But it seems like batman's main
strength is its ability to establish routes over heterogeneous links,
not necessarily minimizing the spectrum utilization.

Thanks a lot for sharing your thoughts on this.

Cheers,

Javier
