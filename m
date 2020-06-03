Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Network stops passing traffic randomly
References: <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
 <20200529001302.832.66710@diktynna.open-mesh.org>
 <174b4bab-d84e-899d-3ecf-34bfdccff4fd@coolheads.com>
 <8cb674e5-26b2-e992-61e6-5969cc50358f@candelatech.com>
 <f99daabf-2081-c6af-779d-580f8d352b59@coolheads.com>
 <92655f2e-4ec4-5e1b-4ea9-b1df87a88aac@candelatech.com>
 <c917d6e6-d3c1-61f5-1846-794f6cc06824@coolheads.com>
 <3659b31b-1f8b-1e21-43f5-b47f6e11d338@candelatech.com>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <310fffa6-ff96-cb48-355f-00e773c1a4d7@coolheads.com>
Date: Wed, 3 Jun 2020 13:56:32 -0400
MIME-Version: 1.0
In-Reply-To: <3659b31b-1f8b-1e21-43f5-b47f6e11d338@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Reply-To: srn@coolheads.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Ben Greear <greearb@candelatech.com>, b.a.t.m.a.n@lists.open-mesh.org, smartwires@gmail.com



On 6/3/20 12:42 PM, Ben Greear wrote:
> If you are trying to lift up a broad swath of the world, then you need=20
> scale and vision, and part of that is how
> to make it self sustaining.=C2=A0 Giving a few crumbs to folks is less=20
> useful in my mind than helping give them the means
> to make their own bread.=C2=A0 Think someone starting a company that wa=
nts=20
> to deploy 10k hotspots with 40k satellite
> wifi mesh nodes....
Your vision is deeply correct, but so is mine.=C2=A0 One difference betwe=
en=20
the two ideas is that yours is top-down, with the purpose of offering a=20
service, while mine is bottom-up, with the purpose of developing=20
community and neighborliness, regardless of service provider(s). =C2=A0 (=
I'm=20
an admirer of the late Fred Rogers, and I'm not ashamed to admit it.)

But you are right, too.=C2=A0 I'm also an admirer of the Indian cataract=20
surgery guy (can't remember his name) who insisted that all patients pay=20
for their surgery "because charity doesn't scale".=C2=A0 He ultimately bu=
ilt=20
a mind-boggling practice that, among other things, presumably now=20
manufactures most of the world's intraocular lenses.

>
> Open source software (and maybe hardware) with high volume,=20
> affordable, and solid hardware
> is one of the core aims of TIP.=C2=A0 Think of a price and minimum hard=
ware=20
> that meets your goals,
> if I find someone that can make such a thing at such a price, I'll let=20
> you know.
Fair enough.=C2=A0 How about a *delivered* price, i.e. an out-of-pocket c=
ost,=20
of $50.=C2=A0 Obviously a minimum of 2 radios, 128 Mb, and reasonable CPU=
=20
power.=C2=A0 Since we're forward-looking, here, with support for the new=20
channels now presumably forthcoming from the FCC.
> If you want wave-1 ath10k to mesh, my advice is to use 7 virtual=20
> station vdevs and one AP on each radio.=C2=A0 ath10k-ct
> firmware and software will support this nicely.=C2=A0 Have those 7 stat=
ions=20
> connect to peers' AP vdevs.=C2=A0 Do routing mesh
> magic through this topology.=C2=A0 Then you don't care about anything o=
ther=20
> than STA + AP working.=C2=A0 This might also scale to other platforms
> that don't support IBSS or MESH well.=20
Many thanks, Ben.=C2=A0 This is a helpful idea, and I daresay not many pe=
ople=20
could have come up with it.=C2=A0 (Certainly not I!)=C2=A0 You have just =
given me=20
some homework to do, and I'm grateful for it.=C2=A0 Bravo. If I get anywh=
ere=20
with it, you'll be the first to know.

Steve


