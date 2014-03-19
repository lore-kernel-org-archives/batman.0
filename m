Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:50 +0100
Message-Id: <1395216532-31099-9-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 09/11] batman-adv: fix code style
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

- don't split lines if shorter than 80 chars
- don't use goto if there is no cleanup to perform

Introduced by 90ad6a40c80323805be1e86504385de2bd861f0a
("batman-adv: Modified forwarding behaviour for multicast packets")

Cc: Linux Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c         | 3 +--
 multicast.h         | 8 ++++----
 translation-table.c | 5 ++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/multicast.c b/multicast.c
index 94ba522..7927865 100644
--- a/multicast.c
+++ b/multicast.c
@@ -318,8 +318,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
 	 * then allow scope > link local, too
 	 */
-	if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=
-	    IPV6_ADDR_SCOPE_LINKLOCAL)
+	if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) != IPV6_ADDR_SCOPE_LINKLOCAL)
 		return -EINVAL;
 
 	/* link-local-all-nodes multicast listeners behind a bridge are
diff --git a/multicast.h b/multicast.h
index 2861899..73b5d45 100644
--- a/multicast.h
+++ b/multicast.h
@@ -20,10 +20,10 @@
 
 /**
  * batadv_forw_mode - the way a packet should be forwarded as
- * @BATADV_FORW_ALL: forward the packet to all nodes
- *  (currently via classic flooding)
- * @BATADV_FORW_SINGLE: forward the packet to a single node
- *  (currently via the BATMAN unicast routing protocol)
+ * @BATADV_FORW_ALL: forward the packet to all nodes (currently via classic
+ *  flooding)
+ * @BATADV_FORW_SINGLE: forward the packet to a single node (currently via the
+ *  BATMAN unicast routing protocol)
  * @BATADV_FORW_NONE: don't forward, drop it
  */
 enum batadv_forw_mode {
diff --git a/translation-table.c b/translation-table.c
index dab5c39..d636bde 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -206,16 +206,15 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 				const uint8_t *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
-	int count = 0;
+	int count;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
-		goto out;
+		return 0;
 
 	count = atomic_read(&tt_global_entry->orig_list_count);
 	batadv_tt_global_entry_free_ref(tt_global_entry);
 
-out:
 	return count;
 }
 
-- 
1.8.3.2

