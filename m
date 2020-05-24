Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
 <4485194.d5W8GeZ6RB@sven-edge> <CAOVt3fE8-U73oJV2XjnxFzWc35LAMeXeaNsTUUgPaLqvchv-Cw@mail.gmail.com>
 <2164745.TYCVdmGlQZ@sven-edge>
In-Reply-To: <2164745.TYCVdmGlQZ@sven-edge>
From: Alexey Ermakov <axel101@gmail.com>
Date: Mon, 25 May 2020 00:53:05 +0300
Message-ID: <CAOVt3fG9AbAEMP+uKLy8Hsnub6=hAJG2Ekg3vrC__AqVJAdZHw@mail.gmail.com>
Subject: Re: Batman-adv packet retranslation
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> As Marek pointed  out, you told batman-adv that the  eth0 interfaces have for
> some reason a link speed of 0.1 [Mbit/s] (or 1 [100Kbit/s] - what the actual
> unit is for B.A.T.M.A.N. V). And unfortunately, 88% (for the hop penalty) of 1
> [100 Kbit/s] is in integer arithmetic 0 [100 Kbit/s]. And 0 whatever/s is just
> discarded by B.A.T.M.A.N. V [1] and not considered for routing traffic - hey,
> this path ends up as being 0 and therefore useless.
> The reason why you want to set the link to 1 [100 Kbit/s] has to be figured
> out by yourself. But for a (during forwarding) strictly monotonic decreasing,
> integer value, it is a bad starting point to set it to 1 [whatever-unit] for a
> multi-hop setup.

I have three interfaces on each node:
eth0 - radio modem, speed 145 kbit/s (see desiription below)
eth1 - ethernet, speed 100mbit/s
eth2 - radio modem 10kbit/s (hasn't been tested yet)

I have to say few words about radio modems. Radio modem is not builtin
device with special driver, it is separate machine with linux which
set up as bridge and connected to node by ethernet. This means node
can send data to modem with 100mbit/s, and think that all is ok but
data will dropped on modem side, it will not call netif_stop_queue, or
something on node side.

All tests I have been making were with eth0 and eth1 because eth2
doesn't ready yet.

---
FIRST test conditions:
 - All 3 nodes see each other
 - Both interfaces added to batman network
 - no throuthput override

FIRST test steps:
 - Turn on all nodes and setup batman - All nodes see each other.
Route goes via eth1
 - Switch off eth1 (plug off ethernet cable) - Route switches to eth0,
all nodes see each other
 - Switch eth1 on - Unstable behavior: sometimes route switch back to
eth1, but sometimes - not
---
SECOND test conditions:
 - All 3 nodes see each other
 - Both interfaces added to batman network
 - eth0 throuthput override set to 100, eth1 throuthput override set to 100000

SECOND test steps:
 - Turn on all nodes and setup batman - All nodes see each other.
Route goes via eth1
 - Switch off eth1 (plug off ethernet cable) - Route switches to eth0,
all nodes see each other
 - Switch eth1 on - Route switch back to eth1, works as expected
---
THIRD test conditions:
 - Node 1 And Node3 see only node 2, but not each other on eth0. All 3
nodes see each other on eth1
 - Both interfaces added to batman network
 -  no throuthput override

THIRD test steps:
 - Turn on all nodes and setup batman - All nodes see each other.
Route goes via eth1
 - Switch off eth1 (plug off ethernet cable) - Route switches to eth0,
ALL NODES SEE EACH OTHER (this means speed 145 kbit/s enough to route
through Node 2)
 - Switch eth1 on - Unstable behavior sometimes route switch back to
eth1, but sometimes - not
---
FOURTH test conditions:
 - Node 1 And Node3 see only node 2, but not each other on eth0. All 3
nodes see each other on eth1
 - Both interfaces added to batman network
 - eth0 throuthput override set to 100, eth1 throuthput override set to 100000

FOURTH test steps:
 - Turn on all nodes and setup batman - All nodes see each other.
Route goes via eth1
 - Switch off eth1 (plug off ethernet cable) - Route switches to eth0,
But Node 1 and Node 2 see only Node 3 for the reasons you described
above.
 - Switch eth1 on - Route switch back to eth1, works as expected
---
Summary: If I don't set override throughput, batman doesn't switch
back to ster eth0, but if I set it, retranslation doesn't work
properly.
I believe, I should tweak batman and I whould be happy if you say how.
