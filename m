Return-Path: <linus.luessing@web.de>
Date: Sun, 24 Jan 2010 00:30:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100123233044.GA12025@Sellars>
References: <20100123174616.GA4795@Sellars>
 <20100123181048.GO24649@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20100123181048.GO24649@lunn.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
 maint)
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


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, this is with symbols enabled and I changed the mac
addresses, so they are defintely different now. Here is the new
backtrace for the second issue. It occured after about 1-2 hours.

Cheers, Linus

On Sat, Jan 23, 2010 at 07:10:48PM +0100, Andrew Lunn wrote:
> On Sat, Jan 23, 2010 at 06:46:16PM +0100, Linus L??ssing wrote:
> > Hey guys,
> >=20
> > I've been installing a 9 node setup here in our cellar. They are
> > all running B.A.T.M.A.N. adv 0.2.1-beta r1545 (so the current
> > batman-adv maintance version in OpenWRT).
> >=20
> > The result over night:
> > - 1x: bat_events: page allocation failure
>=20
> This looks like a memory leak somewhere. It could be anywhere, batman
> or some other part of the kernel.
>=20
> Can you build your kernel with the kernel memory leak detector
> enabled? It is under the Kernel Hacking options. You probably also
> need to build the kernel with symbols, which will help with ksymopps
> anyway. Documentation for kmemleak is in Documentation/kmemleak.txt.
> I've never used it myself, so i've no idea how good it actually is...
>=20
> Interestingly, did you notice the warnings:
>=20
> batman-adv:The newly added mac address (00:24:01:b7:6a:d2) already exists=
 on: eth0.2
> batman-adv:It is strongly recommended to keep mac addresses unique to avo=
id
> +problems!
>=20
> I guess this is because you are using VLANs. Have you seen these
> problems without using VLANs?=20
>=20
> 	 Andrew
>=20

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="call-trace-0027-24-01-10.log"

root@OpenWrt:/# ------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:226 dev_watchdog+0x19c/0x338()
NETDEV WATCHDOG: wifi0 (): transmit timed out
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<80062a84>] warn_slowpath_common+0x70/0xb0
[<80062b04>] warn_slowpath_fmt+0x24/0x30
[<801c9c98>] dev_watchdog+0x19c/0x338
[<8006e1b8>] run_timer_softirq+0x17c/0x234
[<80068f20>] __do_softirq+0xa4/0x154
[<8006902c>] do_softirq+0x5c/0x98
[<80041444>] ret_from_irq+0x0/0x4
[<80041680>] r4k_wait+0x20/0x40
[<8004e910>] cpu_idle+0x24/0x4c
[<802a9a4c>] start_kernel+0x36c/0x384

---[ end trace 57451ac66d72b45d ]--

--hQiwHBbRI9kgIhsi--
