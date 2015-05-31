Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 10:10:20 +0200
Message-Id: <1433059821-8521-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix kerneldoc over 80 column
	lines
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Kerneldoc required single line documentation in the past (before 2009).
Therefore, the 80 columns limit per line check of checkpatch was disabled
for kerneldoc. But kerneldoc is not excluded anymore from it and checkpatch
now enabled the check again.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/icmp_socket.c    | 4 ++--
 net/batman-adv/network-coding.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 07061bc..8d8a7d2 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -337,8 +337,8 @@ err:
 }
 
 /**
- * batadv_socket_receive_packet - schedule an icmp packet to be sent to userspace
- *  on an icmp socket.
+ * batadv_socket_receive_packet - schedule an icmp packet to be sent to
+ *  userspace on an icmp socket.
  * @socket_client: the socket this packet belongs to
  * @icmph: pointer to the header of the icmp packet
  * @icmp_len: total length of the icmp packet
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index f0a50f3..3c89119 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -872,8 +872,8 @@ free:
 }
 
 /**
- * batadv_nc_update_nc_node - updates stored incoming and outgoing nc node structs
- *  (best called on incoming OGMs)
+ * batadv_nc_update_nc_node - updates stored incoming and outgoing nc node
+ *  structs (best called on incoming OGMs)
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node originating the ogm packet
  * @orig_neigh_node: neighboring orig node from which we received the ogm packet
-- 
2.1.4

