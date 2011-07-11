Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJA-1LgVGHSZh_o-MtVkAuaTDh8PkHMZdxTG82apf=JgzqHxMQ@mail.gmail.com>
References: <CAJA-1Li8gevyO20o02WuSehdvzVPs-4S5EgmO5oTkiWs3VSLBw@mail.gmail.com>
	<CAG7VhQS+pLTw+avYZ3ux_FskLeAp0LREeN8sHJ=o+v3C1ciSsA@mail.gmail.com>
	<CAJA-1LgVGHSZh_o-MtVkAuaTDh8PkHMZdxTG82apf=JgzqHxMQ@mail.gmail.com>
Date: Mon, 11 Jul 2011 15:31:24 +0200
Message-ID: <CAG7VhQReDCUNw54PhS28qB5FOgsNCQaA8yBmY-AnEN77W5BksA@mail.gmail.com>
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
> In the two nodes, without using batman-advanced, I got the following :
> *************************************************************************=
********
> netperf -t UDP_STREAM -H 192.168.1.3 -c -C -- -m 32768
> UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
> 192.168.1.3 (192.168.1.3) port 0 AF_INET : demo
>
> Socket =A0Message =A0Elapsed =A0 =A0 =A0Messages =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 CPU =A0 =A0 =A0Service
> Size =A0 =A0Size =A0 =A0 Time =A0 =A0 =A0 =A0 Okay Errors =A0 Throughput =
=A0 Util =A0 =A0 Demand
> bytes =A0 bytes =A0 =A0secs =A0 =A0 =A0 =A0 =A0 =A0# =A0 =A0 =A0# =A0 10^=
6bits/sec % SS =A0 =A0 us/KB
>
> 114688 =A0 32768 =A0 10.00 =A0 =A0 =A0 =A0 605 =A0 =A0 =A00 =A0 =A0 =A0 1=
5.9 =A0 =A0 3.35 =A0 =A0 34.693
> 114688 =A0 =A0 =A0 =A0 =A0 10.00 =A0 =A0 =A0 =A0 604 =A0 =A0 =A0 =A0 =A0 =
=A0 =A015.8 =A0 =A0 0.70 =A0 =A0 7.291
> *************************************************************************=
********
> So, the received (real throughput as daniele said) is 15.8 between
> nodes 192.168.1.2 and 1.3. =A0Also, the cpu usage is as expected.
>
>
> Then, after installing batman-adv 2011.1.0, and naming the new nodes
> for bat0 interface 10.42.43.1 and 10.42.43.2, I got
>
> *************************************************************************=
*********
> netperf -t UDP_STREAM -H 10.42.43.2 -c -C -- -m 32768
> UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
> 10.42.43.2 (10.42.43.2) port 0 AF_INET : demo
>
> Socket =A0Message =A0Elapsed =A0 =A0 =A0Messages =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 CPU =A0 =A0 =A0Service
> Size =A0 =A0Size =A0 =A0 Time =A0 =A0 =A0 =A0 Okay Errors =A0 Throughput =
=A0 Util =A0 =A0 Demand
> bytes =A0 bytes =A0 =A0secs =A0 =A0 =A0 =A0 =A0 =A0# =A0 =A0 =A0# =A0 10^=
6bits/sec % SS =A0 =A0 us/KB
>
> 114688 =A0 32768 =A0 10.00 =A0 =A0 =A0120574 =A0 =A0 =A00 =A0 =A0 3160.7 =
=A0 =A0 51.45 =A0 =A011910.058
> 114688 =A0 =A0 =A0 =A0 =A0 10.00 =A0 =A0 =A0 =A0 =A027 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0.7 =A0 =A0 0.95 =A0 =A0 220.982
>
>
> *************************************************************************=
*********
>
> Thus the received throughput is 0.7 Mbps. Out of 120574 data only 27
> are received. How can using batman-adv decrease the throughput by such
> a big amount? Is it because of using the accesspoint (managed mode
> instead of ad-hoc mode)?
>
I've not clear what happens using batman in this way, with an access point
and in managed mode.
You can try to examine what is happening using wireshark with another PC
or creating a virtual interface in monitor mode, see:
http://linuxwireless.org/en/users/Documentation/iw#Adding_interfaces_with_i=
w
You can see if packets pass throught the access point (if it has AP isolati=
on
enabled) or go directly and at what rate packet are sent.

Anyhow i really advise you to pace netperf because this can influence the
results.

> Cheers
>
> MAx
>
>
>
>
> On Mon, Jul 11, 2011 at 1:14 PM, Daniele Furlan
> <daniele.furlan@gmail.com> wrote:
>> 2011/7/11 Max Ip <ipmax2011@googlemail.com>:
>>> Hi all,
>>>
>>> I have network connection of two laptops connected through wifi in
>>> Access Point mode with bandwidth 54Mbps (802.11g).
>>>
>>> Laptop A =A0 =A0 =A0---- =A0 =A0 =A0 Access point =A0 =A0 =A0 ------ =
=A0 =A0 Laptop B
>>> 192.168.1.2 =A0---- =A0 =A0 =A0 192.168.1.220 =A0 =A0 ------ =A0 =A0 19=
2.168.1.3
>>>
>>> I used netperf to measure the bandwidth and CPU utilization
>>>
>>> Without installing batman-adv on Laptop A and Laptop B , the results
>>> of netperf are:
>>>
>>> netperf -H 192.168.1.3 -t TCP_STREAM -l 10 -c
>>>
>>> TCP throughput : 11.89 Mbps
>>> TCP CPU usage: 1.73 %
>>>
>>> netperf -H 192.168.1.3 -t UDP_STREAM -l 10 -c
>>>
>>> UDP throughput: 22.5 Mbps
>>> UDP CPU usage: 1.8 %
>>>
>>> Now, after I installed batman-adv 2011.1.0 on Laptop A and Laptop B.
>>> To the nodes Laptop A and Laptop B I assigned IP address:
>>>
>>> sudo ifconfig bat0 10.42.43.1 (laptop A)
>>> sudo ifconfig bat0 10.42.43.2 (laptop B)
>>>
>>> The protocol runs fine and the originators are seen on both sides.
>>> Also, the avahi-discover shows both laptops.
>>> When I now tried to measure the throughput,
>>>
>>> netperf -H 192.168.1.3 -t TCP_STREAM -l 10 -c
>>>
>>> TCP throughput : =A09.23 Mbps
>>> TCP CPU usage: 3.91 %
>>>
>>> netperf -H 192.168.1.3 -t UDP_STREAM -l 10 -c
>>>
>>> UDP throughput: 3200 Mbps
>>> UDP CPU usage: 51%
>>
>> The real throughput is what you read in the second line of the results
>> of netperf. The value you have reported refer on the packet sent (first
>> row of resutls) and not to the packets correctly received.
>>
>> Furtermore it is better to "pace" the load offered by netperf using
>> options -b and -w as you can read in:
>> http://www.netperf.org/svn/netperf2/tags/netperf-2.4.5/doc/netperf.html
>>
>>>
>>> Why would the UDP throughput be so high? There is no possibility to
>>> have it so high. Is it because of the bad configuration in access
>>> point as it is non batman interface or sth else?
>>>
>>> What do you think?
>>>
>>> Thanks.
>>>
>>> Max
>>>
>>> Max
>>>
>>
>> Regards
>>
>> --
>> Daniele Furlan
>>
>



--=20
Daniele Furlan
