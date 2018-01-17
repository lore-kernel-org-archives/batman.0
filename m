Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <EAA43A4A33E954458F0C43C14387663A631A4567@ottsvw192.gdcan.com>
References: <EAA43A4A33E954458F0C43C14387663A631A4567@ottsvw192.gdcan.com>
From: dan <dandenson@gmail.com>
Date: Wed, 17 Jan 2018 16:56:35 -0700
Message-ID: <CAA_JP8XHGyA4yYxw1WuH12K+YYe4SvZUPe3GkC4EZSz1YNY+gA@mail.gmail.com>
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

I dont see you setting MTU on enp0s3.

On Wed, Jan 17, 2018 at 4:41 PM, Linchieh, Alex <Alex.Linchieh@gd-ms.ca> wr=
ote:
> Hello,
>
> I am having some issues getting simple multicast to work under batman-adv=
 (2017.4).
>
> I have isolated the system as much as I can to reduce any uncertainties a=
ssociated with wlan. My test environment consists of 4 virtual machines (ub=
untu server 17.10) that are connected to each other via an internal etherne=
t network. I have been able to get the bat0 interface working over the ethe=
rnet interface (enp0s3). I am able to get the devices to ping eachother ove=
r the batman mesh as well as send iperf test data via TCP and UDP unicast m=
odes. However I have not been able to get multicast running properly over t=
he bat0 interface.
>
> The commands I am using to initialize batman-adv on each of the virtual m=
achines are as follows:
>
> Sudo modprobe batman-adv
> Sudo ifconfig enp0s3 up
> Sudo batctl if add enp0s3
> Sudo ifconfig bat0 192.168.14.x/24      where "x" is replaced with a numb=
er depending on the VM
> Sudo route add -host 239.255.10.10 bat0
>
> I am using iperf in order to generate multicast traffic from the iperf cl=
ient (192.168.14.1), and the iperf servers (192.168.2, 3, 4). The client wh=
ich generates multicast data is able to "connect" to the multicast address =
and send data. Iperf also shows that the servers are able to subscribe to t=
he multicast address however this is as far as I can get because the multic=
ast data does not appear to ever reach the subscribers. When I use tcp dump=
 to monitor the bat0 interfaces on these devices, I can see outgoing multic=
ast traffic from the multicast sender, however the bat0 interface on the mu=
lticast receivers does not show anything, so it looks like none of the mult=
icast traffic seems to be reaching any of the subscribers (or perhaps the m=
ulticast subscribers aren't able to communicate that they are subscribed to=
 the multicast address).
>
> I have tested this with "batctl mm" set to both enabled and disabled. In =
addition, when I try to run "batctl mf" it says that I am not connected to =
a mesh (even though I am).
>
> I have also duplicated this test using just the internal Ethernet network=
 (static IP addresses, batman disabled) and muilticast seems to work fine. =
This leads me to believe that there is something with batman-adv that I am =
overlooking.
>
> If anyone could shed some light on enabling multicast on batman that woul=
d be greatly appreciated.
>
> Thanks,
> Alex
>
>
