Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:55 +0100
Message-Id: <1426333379-17777-11-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/14] alfred: Fix alignment of multi-line
	statements
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hash.h      | 2 +-
 send.c      | 2 +-
 server.c    | 2 +-
 unix_sock.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hash.h b/hash.h
index ee01c0f..6e027bb 100644
--- a/hash.h
+++ b/hash.h
@@ -57,7 +57,7 @@ void hash_init(struct hashtable_t *hash);
 
 /* allocates and clears the hash */
 struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
-				 hashdata_choose_cb choose);
+			     hashdata_choose_cb choose);
 
 /* remove bucket (this might be used in hash_iterate() if you already found
  * the bucket you want to delete and don't need the overhead to find it again
diff --git a/send.c b/send.c
index 3228d5c..cc55489 100644
--- a/send.c
+++ b/send.c
@@ -120,7 +120,7 @@ int push_data(struct globals *globals, struct interface *interface,
 		status_end.tx.seqno = htons(seqno);
 
 		send_alfred_packet(interface, destination, &status_end,
-				sizeof(status_end));
+				   sizeof(status_end));
 	}
 
 	return 0;
diff --git a/server.c b/server.c
index ab6f4ec..83dfc9b 100644
--- a/server.c
+++ b/server.c
@@ -72,7 +72,7 @@ static int tx_compare(void *d1, void *d2)
 
 	if (memcmp(&txh1->server_addr, &txh2->server_addr,
 		   sizeof(txh1->server_addr)) == 0 &&
-	   txh1->id == txh2->id)
+	    txh1->id == txh2->id)
 		return 1;
 	else
 		return 0;
diff --git a/unix_sock.c b/unix_sock.c
index a3affdc..2c862d5 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -389,7 +389,7 @@ int unix_sock_read(struct globals *globals)
 	case ALFRED_MODESWITCH:
 		ret = unix_sock_modesw(globals,
 				       (struct alfred_modeswitch_v0 *)packet,
-					client_sock);
+				       client_sock);
 		break;
 	case ALFRED_CHANGE_INTERFACE:
 		ret = unix_sock_change_iface(globals,
-- 
2.1.4

