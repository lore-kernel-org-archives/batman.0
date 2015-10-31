Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2015 12:29:30 +0100
Message-Id: <1446290970-24053-2-git-send-email-sven@narfation.org>
In-Reply-To: <1446290970-24053-1-git-send-email-sven@narfation.org>
References: <1787438.NkeQ2a2MeO@sven-edge>
 <1446290970-24053-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix kerneldoc of
	network-coding functions
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/network-coding.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 4a95fbe..ae3b055 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -64,6 +64,8 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 
 /**
  * batadv_nc_init - one-time initialization for network coding
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int __init batadv_nc_init(void)
 {
@@ -142,6 +144,8 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_mesh_init - initialise coding hash table and start house keeping
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 {
@@ -994,6 +998,8 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
  * batadv_nc_random_weight_tq - scale the receivers TQ-value to avoid unfair
  *  selection of a receiver with slightly lower TQ than the other
  * @tq: to be weighted tq value
+ *
+ * Return: scaled tq value
  */
 static u8 batadv_nc_random_weight_tq(u8 tq)
 {
@@ -1786,6 +1792,9 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
  *  resulting unicast packet
  * @skb: incoming coded packet
  * @recv_if: pointer to interface this packet was received on
+ *
+ * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
+ * otherwise.
  */
 static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
@@ -1870,6 +1879,8 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
  * batadv_nc_nodes_seq_print_text - print the nc node information
  * @seq: seq file to print on
  * @offset: not used
+ *
+ * Return: always 0
  */
 int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 {
@@ -1932,6 +1943,8 @@ out:
 /**
  * batadv_nc_init_debugfs - create nc folder and related files in debugfs
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 {
-- 
2.6.2

