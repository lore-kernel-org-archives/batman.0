Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Network stops passing traffic randomly
References: <20200525083512.832.13419@diktynna.open-mesh.org>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
Date: Thu, 28 May 2020 15:03:20 -0400
MIME-Version: 1.0
In-Reply-To: <20200525083512.832.13419@diktynna.open-mesh.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: smartwires@gmail.com

I have exactly the same problem with the same symptoms.=C2=A0 I'm running=
 a=20
fresh build of OpenWRT trunk.=C2=A0 The problem is not new. On some days =
it=20
happens several times.=C2=A0 On other days it doesn't happen at all.

I'm curious to know what your hardware(s) and driver(s) are,=20
Smartwires.=C2=A0 Mine is TPLink Archer [AC]7 v[245].=C2=A0 I'm running t=
he QCA=20
988x driver on the 5GHz radio.=C2=A0 My solution is the same as yours: re=
boot=20
the gateway.=C2=A0 It's a terrible solution, having only one advantage, w=
hich=20
is that it (sort of) works.

I have seen Sven's remark about unicast packets.=C2=A0 I'm not sanguine a=
bout=20
getting Qualcomm to fix a driver for an older product. The Candela=20
Technologies driver refuses to function on the DFS channels (100, 116,=20
132), which in my large, populous US residential environment work far,=20
far better than channels 36 or 149.

All ideas welcome.

On 5/25/20 4:35 AM, smartwires@gmail.com wrote:
> I have been battling a weird problem recently, I have this problem occu=
rring on two (2) separate networks, one with 2 nodes and the other with 3=
 nodes. What happens is the network is fine and all of a sudden the clien=
ts can not reach the Internet, This what I have observed. on both Openwrt=
 19.07, 18.07. A reboot of the gateway corrects the problem.
> 1. Gateway is up and running and able the reach the internet.
> 2. batctl o show the neighbor/s
> 3. batctl ping [MAC] fails
>
> root@Main-GW:~# batctl o
> [B.A.T.M.A.N. adv openwrt-2018.1-5, MainIF/MAC: mesh0/e8:5b:b7:00:10:73=
 (bat0/22:55:4d:3e:5f:8f BATMAN_IV)]
>     Originator        last-seen (#/255) Nexthop           [outgoingIF]
>   * e8:5b:b7:00:10:6b    0.880s   (255) e8:5b:b7:00:10:6b [     mesh0]
> root@Main-GW:~# batctl ping e8:5b:b7:00:10:6b
> PING e8:5b:b7:00:10:6b (e8:5b:b7:00:10:6b) 20(48) bytes of data
> Reply from host e8:5b:b7:00:10:6b timed out
> Reply from host e8:5b:b7:00:10:6b timed out
> Reply from host e8:5b:b7:00:10:6b timed out
> Reply from host e8:5b:b7:00:10:6b timed out
