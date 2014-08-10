Return-Path: <booray@gmail.com>
MIME-Version: 1.0
Date: Sun, 10 Aug 2014 15:00:51 -0700
Message-ID: <CAA51LVr2ogEGnJNCepYRm2eAZvE_TpPFTeLf6BXkVpjyFfHSFg@mail.gmail.com>
From: Ray Gibson <booray@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Testing example of interface bonding
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

Hello,

Are there any documented cases (aside from the aging graph on the
wiki) on batman-adv bonding setups?

I'm testing batman-adv 2014.3.0 in an effort to experiment and test
with multi-link optimizations.  There is no wifi in the picture at the
moment, this is being done with tap interfaces right now.

My two nodes have this network config:
lan0: bridge of eth0 and bat0, 192.168.100.1 on node1, 192.168.100.2 on node2
bat0: includes tap0 and tap1 active, no IP.
eth1: "wan" link, 10.10.10.1 on node1, 10.10.10.2 on node2
tap0/1: openvpn bridge links over eth1, no IPs assigned to these interfaces.

This is a VMware environment for testing.  With the above setup, I can
ping/iperf/whatever back and forth on the 192.168.100.x network.  It
works great just extending a lan transparently on a wan link.  This
was the original idea, with redundant connections (hence the multi tap
interfaces).

Now, I'm trying to isolate the test down to bonding.  However,
enabling bonding in batctl on both nodes has no apparent effect
whatsoever.  Watching an iperf session in ifstat, I will see constant
traffic on bat0, and then either tap0 or tap1 depending on how it's
feeling at the time.  Sometimes it will shift all the traffic to the
other tap interface.  Sometimes the incoming traffic will be on one
interface and the outgoing traffic will be on the other.

Note: I'm running iperf/etc on the nodes themselves, not on separate
devices on the lan bridge.

Ultimately I am looking to try bonding several 3G or 4G devices
together with batman-adv to achieve higher throughput to a single
destination.

Thank you for any comments or suggestions.  I find batman-adv very
useful in other projects and look to extend its use into this one.

Ray
