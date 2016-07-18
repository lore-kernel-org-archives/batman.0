Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 12:12:07 +0200
Message-Id: <1468836728-21890-10-git-send-email-sven@narfation.org>
In-Reply-To: <6098496.c9QsHxvAun@sven-edge>
References: <6098496.c9QsHxvAun@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v11 10/11] batctl: Document a network
	namespaces example.
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

From: Andrew Lunn <andrew@lunn.ch>

Add example of has BATMAN can be used with network name spaces in the
README.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/README b/README
index 6df669a..ce049d4 100644
--- a/README
+++ b/README
@@ -555,3 +555,60 @@ where:
 - IPv4 is the IP address of a client in the mesh network
 - MAC is the MAC address associated to that IP
 - last-seen is the amount of time since last refresh of this entry
+
+batctl and network name spaces
+==============================
+
+The batman-adv kernel module is netns aware. Mesh instances can be
+created in name spaces, and interfaces in that name space added to the
+mesh. The mesh interface cannot be moved between name spaces, as is
+typical for virtual interfaces.
+
+The following example creates two network namespaces, and uses veth
+pairs to connect them together into a mesh of three nodes.
+
+EMU1="ip netns exec emu1"
+EMU2="ip netns exec emu2"
+
+ip netns add emu1
+ip netns add emu2
+
+ip link add emu1-veth1 type veth peer name emu2-veth1
+ip link set emu1-veth1 netns emu1
+ip link set emu2-veth1 netns emu2
+
+$EMU1 ip link set emu1-veth1 name veth1
+$EMU2 ip link set emu2-veth1 name veth1
+
+$EMU1 ip link set veth1 up
+$EMU2 ip link set veth1 up
+
+ip link add emu1-veth2 type veth peer name veth2
+ip link set emu1-veth2 netns emu1
+$EMU1 ip link set emu1-veth2 name veth2
+
+$EMU1 ip link set veth2 up
+ip link set veth2 up
+
+$EMU1 batctl if add veth1
+$EMU1 batctl if add veth2
+$EMU1 ip link set bat0 up
+
+$EMU2 batctl if add veth1
+$EMU2 ip link set bat0 up
+
+batctl if add veth2
+ip link set bat0 up
+
+alfred and batadv-vis can also be used with name spaces. In this
+example, only netns has been used, so there are no filesystem name
+spaces. Hence the unix domain socket used by alfred needs to be given
+a unique name per instance.
+
+($EMU1 alfred -m -i bat0 -u /var/run/emu1-alfred.soc) &
+($EMU2 alfred -m -i bat0 -u /var/run/emu2-alfred.soc) &
+alfred -m -i bat0 &
+
+($EMU1 batadv-vis -s -u /var/run/emu1-alfred.soc) &
+($EMU2 batadv-vis -s -u /var/run/emu2-alfred.soc) &
+batadv-vis -s &
-- 
2.8.1

