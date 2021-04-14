Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 14 Apr 2021 13:35:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: How to mesh over ethernet VLAN?
Message-ID: <20210414113553.GA4886@otheros>
References: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
 <20210406195122.GG2742@otheros>
 <CAEX-Y1YfhoLgcwMJAg11H7f785kum6LUrYq=YrKg0C-9vXZ-ZQ@mail.gmail.com>
 <20210409112432.GJ2742@otheros>
 <CAEX-Y1ZnouWOpjrT4n8q4BVaRWSP30GLMbT_78Kn3_KoFELp9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEX-Y1ZnouWOpjrT4n8q4BVaRWSP30GLMbT_78Kn3_KoFELp9g@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Apr 09, 2021 at 03:38:15PM +0200, Andi Depressivum wrote:
> Actual OpenWRT trunk on TP-Link C7 / C2600 devices. Can decrease to
> anything lower than 1500 but cannot raise above 1500.

Hm, yes, many/most ethernet devices don't support jumbo frames.

You could test with iperf3 and its --set-mss option if smaller,
unfragmented frames have a better performance.

A few more options to solve this are then:

* using the DHCP MTU option on the DHCP server (though many
  DHCP clients do not properly support this)
* use iptables MSS clamping (only works for TCP and routed
  traffic)
* on a gateway router, set a route to the internet with a lower
  MTU, which then results in "ICMP packet too big" messages back
  to the client with containing the desired MTU and the initial
  host should retry with a smaller packet size
  (only works for routed traffic)

Or if you have full control of all hosts in the network you can
also reduce the MTU on the hosts.

Also note batman-adv v2021.0 had some performance
improvements for frames fragmented by batman-adv:

https://www.open-mesh.org/news/100 ->
* https://git.open-mesh.org/batman-adv.git/commit/92064deda9b063ca2d5a53b307c6127a9453357c
* https://git.open-mesh.org/batman-adv.git/commit/0966d5424bb87e863037301488519ccdd69e4d26
* https://git.open-mesh.org/batman-adv.git/commit/3e3ff987876d3be70d928561acbefe5a48ab1654

Regards, Linus
