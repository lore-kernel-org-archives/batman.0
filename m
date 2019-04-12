Return-Path: <lucas.pickstone@minlog.com.au>
MIME-Version: 1.0
From: Lucas Pickstone <lucas.pickstone@minlog.com.au>
Date: Fri, 12 Apr 2019 16:00:11 +1000
Message-ID: <CANDy-jbnAvmYFaPjK2tfTRANFeijK-b7nTKrbMcSUHgkAPH34g@mail.gmail.com>
Subject: Removing a node causing mesh to stop
Content-Type: text/plain; charset="UTF-8"
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
Cc: James Matheson <james.matheson@minlog.com.au>, Andrew Corke <andrew.corke@minlog.com.au>

Hi,

We have problem where our mesh is failing after a node is removed from
it. We have a test set up of 3 computers (A, B and C) that can all
directly see each other in an ad hoc wireless network.

When we remove a node, the mesh between the remaining two nodes
continues to work for a time (batman pings get through), but "batctl
o" shows nothing recently last-seen. Once it times out after 200
seconds, the mesh dies (no further pings via batman get through).

If we bring the disconnected node back up, everything goes back to normal.

Has anyone else seen this problem or had any experience with something similar?

We're a little bit stuck on how to diagnose/debug what is happening.
We thought that maybe the underlying ad hoc network was causing
issues, but it seems okay - we can assign IP addresses on the wlan
interfaces and ping without interruption through the entire test.

Here is a link to a video showing the behaviour from node C, some time
after node A was removed. Both node B and C should still be connected.
https://www.youtube.com/watch?v=Hj_0OFvgTt0

- The terminal at the top shows the batman ping to node B (from node C).
- The middle terminal shows the standard ping via the adhoc network
wlan interface to node B (from node C).
- The lower window shows the B.A.T.M.A.N. originators table (as seen by node C).

Environment (identical on all computers):
- WiFi Card : SparkLAN WPEQ-160ACN(BT)
- WiFi driver: nl80211
- batman-adv: 2019.1
- batctl: 2019.1
- Linux Kernel: 4.4.0-130 Ubuntu 16.04 LTS

Any thoughts would be greatly appreciated.

Thanks,

Lucas Pickstone
