Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 13 May 2016 18:24:33 +0200
Message-Id: <1463156673-6658-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix mcast_flags debugfs output
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

We recently switched to the atomic variants set_bit() / clear_bit()
/ test_bit() for originator capabilities.

Unfortunately, this was missed for the new multicast debugfs
entry, resulting in an empty multicast flags table.

Fixing this by using test_bit().

Fixes: f1f0fbb2c956 ("batman-adv: Add debugfs table for mcast flags")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index abb12f1..2dd5aec 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1205,12 +1205,12 @@ int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			if (!(orig_node->capa_initialized &
-			      BATADV_ORIG_CAPA_HAS_MCAST))
+			if (!test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
+				      &orig_node->capa_initialized))
 				continue;
 
-			if (!(orig_node->capabilities &
-			      BATADV_ORIG_CAPA_HAS_MCAST)) {
+			if (!test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
+				      &orig_node->capabilities)) {
 				seq_printf(seq, "%pM -\n", orig_node->orig);
 				continue;
 			}
-- 
1.7.10.4

