Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Sun, 20 Oct 2019 08:35:03 -0600
Message-ID: <CAA_JP8VXv-oRtvh4XLi_208_q7bqcRqbJw-CLi1GFLBAF=sLRg@mail.gmail.com>
Subject: Batman-adv behind bridge to wireless?
Content-Type: text/plain; charset="UTF-8"
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

I'm considering a certain deployment model here and wanted to get some
expert input.

The design would be
-batman-adv router (could be raspberry pi, or pcengines, etc)
-1,2,3 etc complete radio devices doing 802.11s or dynamic WDS etc
with that radio interface bridged to an ethernet port connected to the
batman-adv router.

This might be called 'radio on a stick'.

an example might be

2 mikrotik omnitik ac devices on different channels, each with their
5Ghz radio configured as ap-bridge with dynamic WDS, those WDS
interfaces would be bridged with horizon (to eliminate loops) and 1
ethernet interface w/o horizon.  Those interfaces would connect to the
batman-adv router.

mikrotik has an hwmp based mesh, but it's primitive and I don't want
nodes responding to other nodes in that mesh, I want batman-adv magic
in the mix.  I might utilize this interface but with a 1 hop limit so
it works a lot like a horizon bridge without using horizon.

this design appears as ptp links plugged into a switch and has no
opportunity for loops.  Each batman-adv router can broadcast and each
other batman-adv will receive that through the bridge because it
doesn't have horizon set, but the A and C devices that are 'bridged'
by B can't because those interfaces share horizon on B, or the hop
limit depending on the interface used.  I'm thinking that solves any
issues batman-adv might have with putting the 'switch/hub' of sorts in
the middle.

One thing I'm trying to solve here is the classic single radio mesh
issue of halves bandwidth, as well as having link health in the mix
without taking an interface offline.  I'd rather have 2% packet loss
on an interface that have 100% packet loss.

additionally, this is for a hybrid mesh design where there is a ~50
node mesh with 2-3 backhauls to a mesh entry point on a tower, and
then likely a 'midspan' link or two with high capacity radios to
reduce hop count.

finally, this allows me to use off-the-shelf devices with pole mounts
etc for this while running the batman-adv router on the ground in an
appropriate container.  A raspberry pi4 would be a great router for
this and I could use VLANs up the feed ethernet link.

Thoughts?
