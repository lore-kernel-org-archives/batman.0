Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Nov 2010 17:45:58 +0100
Message-Id: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] batman-adv: promisc destination reception
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi everyone!

I've recently been wondering, if promiscuous packet reception could be used to
enhance the probability of receiving data packets. The idea behind it is, to
not feel bothered by the broadcast characteristic of WiFi but instead utilising
this fact (it's a little bit inspired by COPE which also "exploits the broadcast
property of radios instead of hiding it under an artificial abstraction"[1]).

The good thing about batman-adv is, that it is running in kernelspace and we have
batman packet headers around the data already, so we are technically able to have
a glance at all the packets we are receiving on the WiFi interface (which would
not be doable in userspace on embedded devices).

The following rather simple patches are adding sequence numbers and duplicate
checks for unicast data packets as well as the possiblity to receive unicast
packets promiscuously on the final destination node. Especially in circular
topologies like [2], this boosts the probability of reception from 53.1441%
to ~99.7937% for instance with no additional packet overhead needed despite the
unicast sequence numbers + originator address.

With the planned neighbor discovery protocol and the 2-hop-neighbourhood
information it provides, the probability could be boosted even further, even in
non-circular topologies.


However, I'm still having quite some difficulties with getting the desired
effect in a VM setup. I'm not quite sure yet if this is an issue of these few
patches, the setup configuration(, the hash-implementation in the trunk) or a routing
issue. See the setup details below.

Cheers, Linus

[1]: XORs in the air: practical wireless network coding
by: Sachin Katti, Hariharan Rahul, Wenjun Hu, Dina Katabi, Muriel Médard, Jon
Crowcroft
[2]: http://x-realis.dyndns.org/freifunk/circle-promisc-13-nodes.png

-----
I've tried to test and validate the assumptions in the following three node
topology (with a "hub/broadcast" nature on C's links at least)

A  -- 90% -- B
  \         /
  90%    60%
     \   /
      C

Where I'd expect to have (0.9 * 0.9)^2 = 0.6561 sucessful icmp replies with
ping without the patches, and ((0.9 * 0.9) + (1 - 0.9 * 0.9) * 0.6)^2 = 0.853776
sucessful icmp replies with ping and with the patches.

For the actual setup, I've started three VMs, with A and B having two
interfaces, vmtap1 and vmtap2, vmtap4 and vmtap5 and C having just one, vmtap7.
They're bridged like this:
---
mesh0           8000.7a538525c787       no              vmtap1
                                                        vmtap4
mesh1           8000.1a48b2e5ec2d       no              vmtap2
                                                        vmtap5
                                                        vmtap7
---
and "brctl setageing mesh0/1 0" to simulate a hub.

I simulated the link qualities stated above with tc inside of the VMs:
ssh vm1 "sudo tc qdisc add dev eth1 root netem loss 10%"
ssh vm1 "sudo tc qdisc add dev eth2 root netem loss 10%"
ssh vm2 "sudo tc qdisc add dev eth2 root netem loss 40%"

What I further did, is setting the hop penalty to 0, to force C to only send to
B via A and to force B to only send to C via A too and to avoid tc's flakiness,
which resulted to one-hop-connections between C and B quite often. I verified,

However, when I'm now trying to ping from B to C now, C receives B's icmp
sucessfully but B does not receive the reply.

My first guess was, the first thing that seemed odd to me was, that the
hash_find() in check_duplicate() returned NULL quite often on B according to
some printk()s, resulting in dropped packets - but that turned out to be the own
packet from B which was just sent and now also received promiscuously right away
again.

Well, probably I'm just having something in the patches or setup wrong, I'm
going to do some more tests with some more printk()s. However, if someone can
spot something weird or would like to test the patches already, I'd be happy
about any feedback :).
