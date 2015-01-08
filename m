Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:08 +0100
Message-Id: <1420730120-9844-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/15] batman-adv: kernel doc fixes for
	bat_iv_ogm.c
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Martin Hundebøll <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 1e80539..73209f3 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -28,7 +28,7 @@
 
 
 /**
- * batadv_dup_status - duplicate status
+ * enum batadv_dup_status - duplicate status
  * @BATADV_NO_DUP: the packet is a duplicate
  * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for the
  *  neighbor)
@@ -517,7 +517,7 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @packet_len: (total) length of the OGM
  * @send_time: timestamp (jiffies) when the packet is to be sent
- * @direktlink: true if this is a direct link packet
+ * @directlink: true if this is a direct link packet
  * @if_incoming: interface where the packet was received
  * @if_outgoing: interface for which the retransmission should be considered
  * @forw_packet: the forwarded packet which should be checked
@@ -1366,6 +1366,7 @@ out:
 /**
  * batadv_iv_ogm_process_per_outif - process a batman iv OGM for an outgoing if
  * @skb: the skb containing the OGM
+ * @ogm_offset: offset from skb->data to start of ogm header
  * @orig_node: the (cached) orig node for the originator of this OGM
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
@@ -1902,10 +1903,10 @@ out:
  * batadv_iv_ogm_neigh_is_eob - check if neigh1 is equally good or better than
  *  neigh2 from the metric prospective
  * @neigh1: the first neighbor object of the comparison
- * @if_outgoing: outgoing interface for the first neighbor
+ * @if_outgoing1: outgoing interface for the first neighbor
  * @neigh2: the second neighbor object of the comparison
  * @if_outgoing2: outgoing interface for the second neighbor
-
+ *
  * Returns true if the metric via neigh1 is equally good or better than
  * the metric via neigh2, false otherwise.
  */
-- 
2.2.1

