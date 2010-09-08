Return-Path: <jesse@nicira.com>
MIME-Version: 1.0
In-Reply-To: <201009082225.47498.sven.eckelmann@gmx.de>
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<201009082058.15533.sven.eckelmann@gmx.de>
	<AANLkTi=FVyLE6OHTd+_qDbzSLk6fY5j6wBOWkYA810Dj@mail.gmail.com>
	<201009082225.47498.sven.eckelmann@gmx.de>
Date: Wed, 8 Sep 2010 16:37:17 -0700
Message-ID: <AANLkTim-jswWzG=H0AQP5Z3byxoR1uXoV-ZhdaZ7+Sqd@mail.gmail.com>
From: Jesse Gross <jesse@nicira.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Andi Kleen <andi@firstfloor.org>, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.net

On Wed, Sep 8, 2010 at 1:25 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wrot=
e:
>> > =A0* Does it allow to append extra header information to the packet?
>> > =A0* Does it allow fragmentation of packets (not real fragmentation, b=
ut
>> > more single split)?
>>
>> I'm assuming that both of these questions are for tunneling. =A0Open
>> vSwitch currently supports a few different L2 over L3 tunneling
>> mechanisms and has a tunnel library that makes adding additional
>> protocols easy. =A0It probably can't do exactly what you need right now,
>> but it should be fairly easy to extend.
>
> Hm, low overhead tunneling is one of the main parts, but if you think tha=
t it
> is easy to extend then fine.

I understand that tunneling needs to go in the kernel.  However, as I
said, several tunneling mechanisms already exist in Open vSwitch
(maybe one of them even already meets your needs) and adding another
one would certainly be less code than the approximately 9000 lines
that this patch entails.

>
>> > =A0* Does it allow to define outgoing patterns (on which attached inte=
rface
>> > =A0 goes the thing out again) on packet number or incoming device (the=
 real
>> > =A0 hardware device it was coming in)?
>>
>> I'm not sure what you mean by "packet number". =A0It does allow you to
>> specify the output interface based on a number of factors, include the
>> input device.
>
> It would mean that for example 5 packets goes over device 1, the next 5
> packets goes over

I'm assuming that those packets are from different higher level flows,
right?  Otherwise you will have significant reordering issues.
Assuming that is the case, then yes, this is possible and is how Open
vSwitch implements bonding purely in userspace.

>
>> > * directly influence the traffic flow, i.e., ARQ for broadcasts,
>
> Could you please comment on that one (taken from Mareks mail). Think abou=
t
> that one:
> =A0* A Broadcast packet must be send over wifi (adhoc)
> =A0* This packet is probably dropped due to some interferences. So each n=
ode
> =A0 must transmit the broadcast more than one time to be (with a good cha=
nce
> =A0 successful). This is quite essential on l2 based adhoc wifi mesh netw=
orks
> =A0 (as tests showed - but please ask Marek for the actual test setups)

This isn't something that Open vSwitch currently has support for since
it expects the properties of Ethernet, which is best effort, and
assumes the upper layers will do any retransmission if desired.
However, I know that for lossy wireless networks sometimes this is not
sufficient.  Open vSwitch has a virtual port abstraction in the kernel
that works well for this type of application specific code and is
where I would expect you to put your tunneling protocol.  I suspect
that this may fit in there as well.  Again, I understand that there
are some areas where the existing Open vSwitch does not exactly fit
all of your needs.  However, I think that you will find that the parts
of the kernel that require extension are actually quite small and well
abstracted.
