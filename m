Return-Path: <dreamtrick@gmail.com>
Message-ID: <1470928381.10121.0.camel@gmail.com>
From: Ignacio Quezada <dreamtrick@gmail.com>
Date: Thu, 11 Aug 2016 17:13:01 +0200
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] is the multicast performance throttled?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

Hello,
I am trying to build an application using UDP multicast sockets based
on a network mesh built with devices connected in IBSS mode. 

The kernel documentation says that this was the place to ask questions
or anything :).

Testing the application in the mentioned environment, it suffers some
kind of throttling or buffering limiting the throughput. Testing with
my application, without the batman interface, just 2 IBSS connected
devices, the multicast rate goes around 100kb/s (not saying that the
wifi link actually tops at that speed), but then just to add the
batman-adv interface and use that instead, the multicast rate becomes
unstable between 0-20kb/s.

Disabling multicast optimization, it changes a bit the behaviour but
still the same speed.

If I change the multicast packet to a unicast packet, both setups
achieve the same speed (~100kb/s), so the batman interface is working
but the multicast packets are being handled in a different way. Is it
supposed to be like that?

The packets are sent right away according to the iptables counter of
packets as well as tcpdump, but the receiver only gets them in a very
slow way (counting but not calculating, I think it is around 8 packets
per second).
The MTU is set as advised, 1532 and the payload for the UDP packets is
as big as it can be so the packet does not get fragmented.

Any way to increase the rate or disabling the throttling?
-- 

MVH
Ignacio Quezada
