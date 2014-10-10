Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 10 Oct 2014 21:03:14 +0200
Message-ID: <5383000.xXB04C6BSt@prime>
In-Reply-To: <CAKKX4kEYFJoSQLndrvP7E1pYP7PehPitWkTjv38bEG9iT-tjng@mail.gmail.com>
References: <CAKKX4kEYFJoSQLndrvP7E1pYP7PehPitWkTjv38bEG9iT-tjng@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] batman-adv bonding feature - unable to get data
	packets fragmented into multiple wireless interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: syed moulana <syedmoulana47@gmail.com>

Hey Syed,

which version of batman-adv are you using?

Please note there is a fix for a bonding problem which hasn't been merged yet, 
please merge it manually for your tests (assuming you are using a recent 
version)

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-August/012382.html

Also bonding has nothing to do with fragmentation - the idea of bonding is 
that the packets should not be split, but get sent interleaved over the 
interfaces, e.g. 

 * wlan 1 - packet 1
 * wlan 2 - packet 2
 * wlan 1 - packet 3
 * wlan 2 - packet 4
 * etc ...

To have a real gain from that, the two links must be equally good quality. 
Also deep queues in the driver may cause reordering of packets which will 
upset TCP. The best results I've seen in the past were 50% performance gain 
over a single link, but I didn't try it out in real world scenarios lately.

Thanks,
    Simon
On Tuesday 07 October 2014 17:27:50 syed moulana wrote:
> hi
> 
> I tested the throughput between point to point mesh nodes using single
> and 2 radios.
> 
> 1.  Using single radio (ch 5180)  the resulting throughput for HT40+
>            TCP max 250mbit/s
>            UDP - max 320mbit/s
> 
> 2. Using 2 radios with and without batctl bonding enabled (ch 5180 for
> wlan0, ch 5785 for wlan1), the resulting throughput for HT40+ is same.
>            with batctl bonding and fragmentation enabled I believed I
> should be getting 50% gain in througput.
>     When I monitor the wlan0 and wlan1 interfaces using batctl tcpdump
> -p 4 wlanx I can see that iperf data are interleaved.
>     There is no splitting of data frames into 2 wireless interfaces.
> 
> Please advice
> 
> Tq
> 
> Syed

