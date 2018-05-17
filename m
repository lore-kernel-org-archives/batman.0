Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Thu, 17 May 2018 15:25:07 -0600
Message-ID: <CAA_JP8Vi+CtXhyJSO-X7a3GydMpaPq-6UR0butY0bR_ExKWvsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] how to avoid loops, unusual config
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Ok, so I'm trying to mock up a very simple network design and I'm
having trouble getting 'out of the box'

nodes
APU2C4 with 3 ethernet ports

all ports
ethx native vlan
ethx.11 mesh vlan

bat0(eth0.11, eth1.11, eth2.11) <- so I can transport the mesh only on
configured interfaces and leave the 'native' ethernet port accessible
to non-mesh devices

br0(eth0,eth1,eth2,bat0) <- gets everything on the mesh.


And the issue is..

If I plug a point to point radio between nodes on eth0

node0.eth0 <> eth0.node1

I'm creating a layer2 link which is bridged into the mesh on both
node0 and node1, so that's the direct link AND bat0 which is a loop.

I'm reading on bridge loop avoidance, is this as simple as turning that on with:
#batctl bl 1

This is a proof of concept for wISP service

the goal being to have a node with a very basic configuration and have
all port's native VLAN be usable to non-mesh-aware devices which
includes point-to-point radios and point-to-multipoint access radios.

I just can't get out of the ptp radio causing a loop and I need to be
able to access the ptp radio interfaces on an untagged vlan.

I have considered managing the ptp radios on separate vlans and NOT
having the eth0 interface in bat0
eth0.11 mesh
eth0.12 master ptp radio
eth0.13 slave ptp radio

on node0 br0(bat0,eth1,eth2,eth0.12)
on node1 br0(bat0,eth1,eth2,eth0.13)

which I think solves the bridge loop issue *but* it means I have to
rely on the ptp radio supporting setting it's management interface to
a vlan.  The irony is that the cheapest radios support this, and the
highest end radios have dedicated management ports so I can ignore
this, but in the middle of the road radios don't.  So this is not
ideal on that front as well as it's a more complicated design and
means the mesh nodes aren't a standard config.

Thoughts?
