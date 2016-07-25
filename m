Return-Path: <daniel@makrotopia.org>
Date: Mon, 25 Jul 2016 19:52:12 +0200
From: Daniel Golle <daniel@makrotopia.org>
Message-ID: <20160725175212.GC2263@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] bridge and batman-adv over ethernet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>, dev@lists.libre-mesh.org, battlemesh@ml.ninux.org

Hi!

We are currently trying to use the Libre-Mesh.org firmware with
batman-adv enabled on wired Ethernet interfaces alongside with a VLAN
which is a member of the bridge the batX interface also resides in.
------------------------------
 E |VLAN---batadv---bat0
 T +--------------+ BRIDGE
 H |VLAN------------eth0.xx
------------------------------
We do want such a setup to have the best of both worlds: the
performance of a plain bridge but yet benefit from batman-adv topology
information, alfred and all that. As many cheap Ethernet switches do
not support frames larger than 1500 bytes, increasing the MTU is not an
option and thus frames inside batman-adv end up fragmented which hurts
performance if encapsulating all traffic via batman-adv.

I remember there was a discussion during battlemesh about a race-
condition which can confuse BLA and thus batman-adv is still disabled
on wired Ethernet interfaces in Libre-Mesh by default.
So here I am asking you about the current state of affairs regarding
this issue.
We are discussing it on
https://github.com/libre-mesh/lime-packages/issues/56
and it would be great to hear a more detailed summary because I only
remember the rough details and also haven't been watching if anything
was fixed or improved since we all met in Porto.

Cheers


Daniel
