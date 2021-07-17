Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7/9] batctl: man: Add example section
Date: Sat, 17 Jul 2021 13:01:27 +0200
Message-Id: <20210717110129.25539-8-sven@narfation.org>
In-Reply-To: <20210717110129.25539-1-sven@narfation.org>
References: <20210717110129.25539-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

A very simple example can help users to figure out how to get a very simple
mesh running. This allows to figure out the correct order of commands
directly from the manpage without needing additional (maybe currently
unreachable) resources from the internet.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/man/batctl.8 b/man/batctl.8
index 009494f..4cc55f9 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -437,6 +437,65 @@ together with the experiment duration in millisecond and the amount of bytes
 transferred. If too many packets are lost or the specified MAC address is not
 reachable, a message notifying the error is returned instead of the result.
 
+.SH EXAMPLES
+The setup of a batadv interface usually consists of creation of the the main
+interface, attaching of the (lower) hard-interface, adjusting of settings
+and bringup of the interface:
+.PP
+.in +4n
+.EX
+# create batadv (mesh) interface bat0 with routing algorithm B.A.T.M.A.N. IV
+.RB "$" " batctl meshif bat0 interface create routing_algo BATMAN_IV"
+# add the (already up and running) mesh0 interface as lower (hard) interface to bat0
+.RB "$" " batctl meshif bat0 interface -M add mesh0"
+# change some settings to better match the requirements of the user
+.RB "$" " batctl meshif bat0 orig_interval 5000"
+.RB "$" " batctl meshif bat0 distributed_arp_table disable"
+.RB "..."
+# set the batadv (mesh) interface up before it is possible to use it
+.RB "$" " ip link set up dev bat0"
+.EE
+.in
+
+This only makes sure that the layer 2 functionality of bat0 is started up. It
+is the responsibility of the user to make sure that the bat0 device itself
+gets attached to a bridge, configured with an IP address (manually/DHCP client/...)
+or integrated in other parts of the system before it gets used.
+.PP
+Also the attached (lower) hard-interfaces attached to the batadv interface must
+be configured by the user to support transportation of ethernet unicast and
+broadcast packets between its linked peers. The most common reason for a not
+working batman-adv mesh are incorrect configurations of the hard-interfaces,
+hardware, firmware or driver bugs which prevent that some of the packet types
+are correctly exchanged.
+.PP
+The current status of interface can be checked using the debug tables. It is
+often relevant to check from which direct neighbors discovery packets were
+received.
+The next step is to check the (preferred) routes to originators. These will
+only be established when the metric has detected bidirectional connections
+between neighbors and might have forwarded discovery packets from not directly
+reachable nodes/originators.
+.PP
+.in +4n
+.EX
+# get list of neighbors from which the current node was able to receive discovery packets
+.RB "$" " batctl meshif bat0 neighbors"
+# get (preferred) routes the routing algorithm found
+.RB "$" " batctl meshif bat0 originators"
+.EE
+.in
+.PP
+If the bat0 interface should no longer used by the system, it can be destroyed
+again:
+.PP
+.in +4n
+.EX
+# destroy the interface and let the system remove its state
+.RB "$" " batctl meshif bat0 interface destroy"
+.EE
+.in
+
 .SH FILES
 .TP
 \fBbat-hosts\fP
@@ -444,6 +503,7 @@ This file is similar to the /etc/hosts file. You can write one MAC address and o
 for bat-hosts in /etc, your home directory and the current directory. The found data is used to match MAC address to your
 provided host name or replace MAC addresses in debug output and logs. Host names are much easier to remember than MAC
 addresses.
+
 .SH SEE ALSO
 .BR ping (1),
 .BR traceroute (1),
-- 
2.30.2

