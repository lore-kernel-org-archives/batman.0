Return-Path: <linus.luessing@web.de>
Date: Thu, 17 Jun 2010 14:07:09 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100617120708.GA23608@Sellars>
References: <201006171018.47209.clemens-john@gmx.de>
	<201006171045.00578.sven.eckelmann@gmx.de>
	<201006171220.03431.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201006171220.03431.clemens-john@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] MTU/connection problem
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

Hi Clemens,

> Sry this should have been gone to the Batman list, so here it is again:
> 
> I did this and everything works fine till I try to connect over the vpn. So the 
> vpn is the problem I think.
> 
> Here is some output of what I tried connecting over vpn:
> 
> [floh1111@flohdesktop ~]$ ping -M do -s 1467 10.18.1.1
> PING 10.18.1.1 (10.18.1.1) 1467(1495) bytes of data.
> 1475 bytes from 10.18.1.1: icmp_seq=1 ttl=64 time=85.6 ms
> --> Works fine till package size 1467 or lower
> ----------
> [floh1111@flohdesktop ~]$ ping -M do -s 1468 10.18.1.1
> PING 10.18.1.1 (10.18.1.1) 1468(1496) bytes of data.
> --> Does not work with package size from 1468 to 1472, no error message
> ----------
> [floh1111@flohdesktop ~]$ ping -M do -s 1473 10.18.1.1
> PING 10.18.1.1 (10.18.1.1) 1473(1501) bytes of data.
> From 10.18.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1500)
> -->  Does not work too, but I get an error message trying package size 1473 or 
> higher.
> 
> We are using OpenVPN in tap mode. Below is our server config:
> ----
> mode server
> tls-server
> 
> port 1195
> proto udp
> dev tap
> ca /etc/openvpn/ff/ca.crt
> cert /etc/openvpn/ff/ffsrv.crt
> key /etc/openvpn/ff/ffsrv.key  # This file should be kept secret
> dh /etc/openvpn/dh1024.pem
> client-config-dir ccd
> client-to-client
> keepalive 10 120
> comp-lzo
> max-clients 100
> persist-key
> persist-tun
> status openvpn-status.log
> verb 3
> -----
> 
> I don´t know if openvpn is adding some extra headers but maybe you know?
Yep, tap mode in openvpn is adding an extra header, it
encapsulates not only the ip-packet but also the ethernet frame
into udp or tcp. (By the way, tun-mode also adds an
extra header, but the packets are smaller - only IP packets
encapsulated in UDP or TCP.)

May I ask whether you are bridging tap0 or if you are routing the
packets (so having an ip address on tap0 and having according
entries in your routing table)? If it's the latter, then you could
just decrease the MTU on the tap0 interfaces to a fitting size and
let the VPN routers do the PMTU discovery stuff automatically. But
of course, then you probably wouldn't need tap-mode in this
scenario, as it just adds additional overhead with the unnecessary
ethernet frame in between.

I know that tinc has two little, a bit hacky features in case of
bridging tap0 with tap-mode (they call it switch-mode) to inform
the other machines of the lower MTU in between. But I haven't
heard of OpenVPN having similar features.

So I guess the easiest step would be the first suggestion, to do
routing in between and lowering the MTU on the tap interfaces for
a start before starting to experiment with (experimental) features
and/or more complicated setups :).

Cheers, Linus
> 
> Thanks
> Clemens


