Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 25 Aug 2015 13:02:26 +0200
Message-Id: <1440500559-28368-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
References: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 02/15] batman-adv: Fix kerneldoc over 80
	column lines
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

Kerneldoc required single line documentation in the past (before 2009).
Therefore, the 80 columns limit per line check of checkpatch was disabled
for kerneldoc. But kerneldoc is not excluded anymore from it and checkpatch
now enabled the check again.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/icmp_socket.c    | 4 ++--
 net/batman-adv/network-coding.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 5a70b7e..bcabb5e 100644
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
index 60dc7a6..5cab144 100644
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
2.5.0

