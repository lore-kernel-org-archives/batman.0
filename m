Return-Path: <javier@cozybit.com>
MIME-Version: 1.0
In-Reply-To: <30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
	<30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
From: Javier Cardona <javier@cozybit.com>
Date: Tue, 23 Aug 2011 15:23:38 -0700
Message-ID: <CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, Clara Gnos <clara.gnos@googlemail.com>

Hi Sven,

On Tue, Aug 23, 2011 at 3:32 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Monday 22 August 2011 16:30:56 Javier Cardona wrote:
>> Which brings me to the main point of my e-mail: =A0is anyone out there
>> interested in porting batman's path selection algorithm into
>> open80211s?
>
> Which one? There are ~5 revisions of the algorithm (not implementations).=
 The
> newest iteration is B.A.T.M.A.N. V and is currently in the research and
> prototyping phase. The algorithm described in the RFC draft was B.A.T.M.A=
.N.
> III

Thanks for pointing that out.  I did not know there were that many versions=
.

> ...but I am not interested in implementing it for 802.11s. Maybe there is
> somebody else. Most people are currently focused on batman-adv. So I will
> write this response with batman-adv in mind.

Noted.

>> The benefits:
>
> I only see benefits mentioned by you, but were are the disadvantages? I d=
on't
> think that a marketing mail is a good start for a serious discussion.

??

>> 1. By being based on a standard, you'll know you won't be colliding
>> with other layer 2 technologies (for instance, no need to define your
>> own ethertype)
>
> At least batman-adv is quite happy about the fact that it is based on a w=
idely
> used standard technology. And defining another identificator instead of a=
n
> ethertype doesn't make a big difference to me.
>
> But why are we colliding with any other layer 2 technologies? It sounds l=
ike
> "uh, you are so bad. you kill cute bunnies", but I don't see the "collidi=
ng"
> problem here. Maybe you mean the missing ethertype registration (anyone g=
ot
> $2500 for us?).

By colliding I mean "come into conflict or opposition", not killing
bunnies.  And it happens to be the same verb that Simon Wunderlich
used to explain why batman-adv had to change its ethertype
(https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2009-August/001682.html)=
.
 Of course it's not a big deal, but definitely something you need not
worry about if your implementation is based on a spec that has been
standardized.

>> 2. You can leverage most of open80211s, from test tools to wireshark
>> patches.
>
> batman-adv also has wireshark integration (already upstream) and test too=
ls.

Nice.

>> 3. By being integrated in the kernel's 802.11 stack, you can take
>> advantage of the development that's taking place there, from encrypted
>> management frames to HT support.
>
> Aren't all those things part of the layer _below_ batman-adv? Why should =
we
> care about it when the stuff we use has to deal with it.

I see.  If I understand correctly batman-adv works as a bridge,
encapsulating mesh management info into data frames.  In that case
batman-adv routing must be based on hopcount and/or transmission
failures as radio layer info is lost in the conversion to 802.3.  By
being in the 802.11 stack, 11s has more information about the quality
of the links and can use that information to compute a finer-grained
metric.  The standard defines airtime as the default link metric but
11s can be extended to include other info like RSSI or SNR.

A similar argument can be made about security.  I assume batman-adv
does not implement security but instead relies on whatever the lower
layer provides.  In 11s security is built from the ground up.  Peers
authenticate each other and exchange encryption keys at the same time
they establish a peer link.  Security becomes easier to manage and
more robust than when using, for instance, WPA to secure peer links.

>> 4. You can reach out to a larger development community and raise
>> awareness about batman.
>
> What larger development community? At least the open80211s community seem=
s to
> be a lot more silent.

No matter how silent or small the open80211s community is, batman-adv
+ open80211s will always be larger than batman-adv alone.  That's what
I meant by "larger".

>> 5. A big problem in mesh adoption on Linux is not the mesh protocol
>> itself but the absence of simple to use configuration tools (e.g. no
>> mesh support in ConnMan, NetworkManager, etc.). =A0By providing a
>> unified wireless mesh framework we increase the likelihood of having
>> some support at the distro level.
>
> Hm, maybe we have a different target audience. batman-adv is made for
> routers/APs and not for desktop systems.

Why limit yourself there?  There are definitely use cases for
non-routers to join a mesh network.

> Thats why it has client mac propagation, bridge loop avoidence and roamin=
g announcements (and many more
> things with funny names).

IEEE 802 also has its share of funny names...

client mac propagation, roaming announcements =3D (802.11s, Sec.
7.3.2.116) Proxy Updates
bridge loop avoidance =3D (802.1D, Sec. 17) Rapid Spanning Tree Protocol
or my favorite:  (802.11s, Sec 8.2a.1) Simultaneous Authentication of Equal=
s

> And we already have a relative good distro integration for our target gro=
up...

Agree to that.  openwrt rocks.

>> and last, but not least...
>> 6. You'll be able to say authoritatively that batman is X times more
>> efficient than HWMP (pick any X greater than 1 :)
>
> And this is important because... And can be measured by... And uses the n=
ormed
> scale...
>
> Maybe you should visit a Wireless Battle of the Mesh and tell them how su=
ch a
> benchmark is correctly done.

You mean the same Wireless Battle of Mesh that year after year fails
to decide on a winner? :)
(My sixth point as well as the response above should be taken
humorously, that's what the colon thingy at the end of the sentence
meant)

I could not help noticing a certain level of skepticism in your
response.  I'm not trying to sell anything nor asking anyone to dump
batman in favor of anything else.  I admire and respect what the
batman project has achieved so far.  Even people in open80211s'
mailing list criticize that batman performs much better than
open80211s ( http://open80211s.com/pipermail/devel/2011-August/000859.html)=
.
But my impression is that, maybe because they were ahead of their
time, the batman community had to invent/reinvent things in their own
unique way.  And now that a standard is in place, everyone interested
in mesh could benefit if there was a seventh (and final) version bump
to bring it in line with IEEE 802.11s.

Greetings and congratulations for your good work.

Cheers,

Javier


--=20
Javier Cardona
cozybit Inc.
http://www.cozybit.com
