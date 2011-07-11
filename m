Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJA-1Li8gevyO20o02WuSehdvzVPs-4S5EgmO5oTkiWs3VSLBw@mail.gmail.com>
References: <CAJA-1Li8gevyO20o02WuSehdvzVPs-4S5EgmO5oTkiWs3VSLBw@mail.gmail.com>
Date: Mon, 11 Jul 2011 13:14:33 +0200
Message-ID: <CAG7VhQS+pLTw+avYZ3ux_FskLeAp0LREeN8sHJ=o+v3C1ciSsA@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] UDP and TCP bandwidth test for 802.11g in
 batman-adv 2011.1.0
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

2011/7/11 Max Ip <ipmax2011@googlemail.com>:
> Hi all,
>
> I have network connection of two laptops connected through wifi in
> Access Point mode with bandwidth 54Mbps (802.11g).
>
> Laptop A =A0 =A0 =A0---- =A0 =A0 =A0 Access point =A0 =A0 =A0 ------ =A0 =
=A0 Laptop B
> 192.168.1.2 =A0---- =A0 =A0 =A0 192.168.1.220 =A0 =A0 ------ =A0 =A0 192.=
168.1.3
>
> I used netperf to measure the bandwidth and CPU utilization
>
> Without installing batman-adv on Laptop A and Laptop B , the results
> of netperf are:
>
> netperf -H 192.168.1.3 -t TCP_STREAM -l 10 -c
>
> TCP throughput : 11.89 Mbps
> TCP CPU usage: 1.73 %
>
> netperf -H 192.168.1.3 -t UDP_STREAM -l 10 -c
>
> UDP throughput: 22.5 Mbps
> UDP CPU usage: 1.8 %
>
> Now, after I installed batman-adv 2011.1.0 on Laptop A and Laptop B.
> To the nodes Laptop A and Laptop B I assigned IP address:
>
> sudo ifconfig bat0 10.42.43.1 (laptop A)
> sudo ifconfig bat0 10.42.43.2 (laptop B)
>
> The protocol runs fine and the originators are seen on both sides.
> Also, the avahi-discover shows both laptops.
> When I now tried to measure the throughput,
>
> netperf -H 192.168.1.3 -t TCP_STREAM -l 10 -c
>
> TCP throughput : =A09.23 Mbps
> TCP CPU usage: 3.91 %
>
> netperf -H 192.168.1.3 -t UDP_STREAM -l 10 -c
>
> UDP throughput: 3200 Mbps
> UDP CPU usage: 51%

The real throughput is what you read in the second line of the results
of netperf. The value you have reported refer on the packet sent (first
row of resutls) and not to the packets correctly received.

Furtermore it is better to "pace" the load offered by netperf using
options -b and -w as you can read in:
http://www.netperf.org/svn/netperf2/tags/netperf-2.4.5/doc/netperf.html

>
> Why would the UDP throughput be so high? There is no possibility to
> have it so high. Is it because of the bad configuration in access
> point as it is non batman interface or sth else?
>
> What do you think?
>
> Thanks.
>
> Max
>
> Max
>

Regards

--=20
Daniele Furlan
