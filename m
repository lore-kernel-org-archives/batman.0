Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
Date: Fri, 30 Mar 2012 07:35:30 -0600
Message-ID: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] link alternation when radios are not on batman-adv
	router?
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

I have an interesting hardware setup I'd like to explore.

Basically, I would like to take commodity ubiquiti and/or openmesh
hardware and build a mesh with two different node types, some having
just 1 radio and others having multiple radios, a standard node and a
super node.

the standard node is:
a picostation flashed to openwrt running batman-adv and running the
radio in Ad-Hoc mode.  Alternately an OM2P flashed to openwrt.  This
is the basic client radio

the super node is:
a group of picostations or nanostations, flashed openwrt in adhoc
mode, but acting only as the L2 transport with a router at the center
running batman-adv.

The idea is that the super nodes have multiple radios in multiple
channels and can take advantage of link alternation allowing super
nodes to keep much higher bandwidth between them while the standard
nodes are cheap.  The 'router' MIGHT also have a radio for client
access (unifi station flashed to openwrt maybe, or an ALIX board)

The supernode will have more CPU and also be the target of
backhaul/shorthaul links to cut down on hop count.  The main router
would also be a batman-adv device, probably an x86 server, and would
be the border router for the mesh.

some questions,
I know that the supernodes will have higher throughput capabilities
due to dual mesh radios, but how will batman-adv know this or how
would I tell it?  Is the internal mechanism for determining the best
path going to take this into account?  Is there a way to identify a
supernode as being a better path above and beyond the automatic
batman-adv mechanisms?

Is having separate radios connected to a batman-adv router going to
behave how I presume?  That multiple node2node connections will be
identified and the links be alternated when appropriate?

If the supernodes have 2 mesh radios, 1 in 5Ghz and 1 in 2.4Ghz, then
the standard nodes will only be able to connect to the 2.4Ghz channel
which might make it inappropriate to do link alternating on these two
links because of the shared traffic.  Should batman-adv automatically
stop alternating the tx/rx on these links when one of the channels
starts to get saturated?

some other info:
the supernodes may have a link directly to the main distribution
point, but may also be linked just to another supernode and not to the
main distribution point, or possibly both.

the supernodes are likely to have more than 2 mesh radios as some of
these could be direction antennas.  A supernode might have 3x 2.4Ghz
radios for mesh, 2x 5Ghz radios for mesh, and a 2.4Ghz radio for
non-mesh clients.  These would most likely all be connected to a
switch port and only be on a single ethernet interface as far as
batman-adv is concerned.
