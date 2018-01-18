Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <EAA43A4A33E954458F0C43C14387663A631A4588@ottsvw192.gdcan.com>
References: <EAA43A4A33E954458F0C43C14387663A631A4567@ottsvw192.gdcan.com>
 <CAA_JP8XHGyA4yYxw1WuH12K+YYe4SvZUPe3GkC4EZSz1YNY+gA@mail.gmail.com>
 <EAA43A4A33E954458F0C43C14387663A631A4588@ottsvw192.gdcan.com>
From: dan <dandenson@gmail.com>
Date: Wed, 17 Jan 2018 17:24:42 -0700
Message-ID: <CAA_JP8WAwdvaGQv6eOnJMCcfznEt9M66g+5Ys8KQG+ZHErRP_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Simple Multicast on Batman-Adv
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

awesome.

On Wed, Jan 17, 2018 at 5:20 PM, Linchieh, Alex <Alex.Linchieh@gd-ms.ca> wr=
ote:
> That resolved it. Thank you Dan!
>
> -----Original Message-----
> From: B.A.T.M.A.N [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On Beh=
alf Of dan
> Sent: Wednesday, January 17, 2018 4:57 PM
> To: The list for a Better Approach To Mobile Ad-hoc Networking
> Subject: Re: [B.A.T.M.A.N.] Simple Multicast on Batman-Adv
>
> I dont see you setting MTU on enp0s3.
>
> On Wed, Jan 17, 2018 at 4:41 PM, Linchieh, Alex <Alex.Linchieh@gd-ms.ca> =
wrote:
>> Hello,
>>
>> I am having some issues getting simple multicast to work under batman-ad=
v (2017.4).
>>
>> I have isolated the system as much as I can to reduce any uncertainties =
associated with wlan. My test environment consists of 4 virtual machines (u=
buntu server 17.10) that are connected to each other via an internal ethern=
et network. I have been able to get the bat0 interface working over the eth=
ernet interface (enp0s3). I am able to get the devices to ping eachother ov=
er the batman mesh as well as send iperf test data via TCP and UDP unicast =
modes. However I have not been able to get multicast running properly over =
the bat0 interface.
>>
>> The commands I am using to initialize batman-adv on each of the virtual =
machines are as follows:
>>
>> Sudo modprobe batman-adv
>> Sudo ifconfig enp0s3 up
>> Sudo batctl if add enp0s3
>> Sudo ifconfig bat0 192.168.14.x/24      where "x" is replaced with a num=
ber depending on the VM
>> Sudo route add -host 239.255.10.10 bat0
>>
>> I am using iperf in order to generate multicast traffic from the iperf c=
lient (192.168.14.1), and the iperf servers (192.168.2, 3, 4). The client w=
hich generates multicast data is able to "connect" to the multicast address=
 and send data. Iperf also shows that the servers are able to subscribe to =
the multicast address however this is as far as I can get because the multi=
cast data does not appear to ever reach the subscribers. When I use tcp dum=
p to monitor the bat0 interfaces on these devices, I can see outgoing multi=
cast traffic from the multicast sender, however the bat0 interface on the m=
ulticast receivers does not show anything, so it looks like none of the mul=
ticast traffic seems to be reaching any of the subscribers (or perhaps the =
multicast subscribers aren't able to communicate that they are subscribed t=
o the multicast address).
>>
>> I have tested this with "batctl mm" set to both enabled and disabled. In=
 addition, when I try to run "batctl mf" it says that I am not connected to=
 a mesh (even though I am).
>>
>> I have also duplicated this test using just the internal Ethernet networ=
k (static IP addresses, batman disabled) and muilticast seems to work fine.=
 This leads me to believe that there is something with batman-adv that I am=
 overlooking.
>>
>> If anyone could shed some light on enabling multicast on batman that wou=
ld be greatly appreciated.
>>
>> Thanks,
>> Alex
>>
>>
