Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:13 +0200
Message-Id: <1400931855-7961-8-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/10] alfred: Free hash iterator when
	breaking out of loop
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

The hash iterator is automatically allocated and freed by the hash_iterate
function. But when using break during the iteration loop, the caller has to
handle the free-operation of the hash_iterator to avoid memory leaks.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 hash.c      | 8 +++++++-
 hash.h      | 3 +++
 unix_sock.c | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hash.c b/hash.c
index e1fd299..4b3106e 100644
--- a/hash.c
+++ b/hash.c
@@ -70,6 +70,12 @@ void hash_destroy(struct hashtable_t *hash)
 	debugFree(hash, 1303);
 }
 
+/* free hash_it_t pointer when stopping hash_iterate early */
+void hash_iterate_free(struct hash_it_t *iter_in)
+{
+	debugFree(iter_in, 1304);
+}
+
 /* iterate though the hash. first element is selected with iter_in NULL.
  * use the returned iterator to access the elements until hash_it_t returns
  * NULL. */
@@ -149,7 +155,7 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	}
 
 	/* nothing to iterate over anymore */
-	debugFree(iter, 1304);
+	hash_iterate_free(iter);
 	return NULL;
 }
 
diff --git a/hash.h b/hash.h
index bb77f75..c9c8fb1 100644
--- a/hash.h
+++ b/hash.h
@@ -102,4 +102,7 @@ void hash_debug(struct hashtable_t *hash);
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			       struct hash_it_t *iter_in);
 
+/* free hash_it_t pointer when stopping hash_iterate early */
+void hash_iterate_free(struct hash_it_t *iter_in);
+
 #endif
diff --git a/unix_sock.c b/unix_sock.c
index 4553db5..3915553 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -192,6 +192,7 @@ static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 
 		if (write(client_sock, buf, sizeof(push->header) + len) < 0) {
 			ret = -1;
+			hash_iterate_free(hashit);
 			break;
 		}
 	}
-- 
2.0.0.rc2

