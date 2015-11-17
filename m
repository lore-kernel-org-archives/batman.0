Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 17 Nov 2015 16:40:51 +0800
Message-Id: <1447749653-26430-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix kerneldoc for DAT
	functions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Cc: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/distributed-arp-table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9daccdc..193ea33 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -738,6 +738,8 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 /**
  * batadv_dat_init - initialise the DAT internals
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 in case of success, a negative error code otherwise
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
@@ -776,6 +778,8 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
  * batadv_dat_cache_seq_print_text - print the local DAT hash table
  * @seq: seq file to print on
  * @offset: not used
+ *
+ * Return: always 0
  */
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
-- 
2.6.3

