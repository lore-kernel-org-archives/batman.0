Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 22:39:22 +0200
Message-Id: <1340051963-14836-19-git-send-email-ordex@autistici.org>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 18/19] batman-adv: fix locking in hash_add()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Matthias Schiffer <mschiffer@universe-factory.net>

To ensure an entry isn't added twice all comparisons have to be protected by the
hash line write spinlock. This doesn't really hurt as the case that it is tried
to add an element already present to the hash shouldn't occur very often, so in
most cases the lock would have have to be taken anyways.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hash.h |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 93b3c71..3d67ce4 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -110,26 +110,23 @@ static inline int hash_add(struct hashtable_t *hash,
 	head = &hash->table[index];
 	list_lock = &hash->list_locks[index];
 
-	rcu_read_lock();
-	__hlist_for_each_rcu(node, head) {
+	spin_lock_bh(list_lock);
+
+	hlist_for_each(node, head) {
 		if (!compare(node, data))
 			continue;
 
 		ret = 1;
-		goto err_unlock;
+		goto unlock;
 	}
-	rcu_read_unlock();
 
 	/* no duplicate found in list, add new element */
-	spin_lock_bh(list_lock);
 	hlist_add_head_rcu(data_node, head);
-	spin_unlock_bh(list_lock);
 
 	ret = 0;
-	goto out;
 
-err_unlock:
-	rcu_read_unlock();
+unlock:
+	spin_unlock_bh(list_lock);
 out:
 	return ret;
 }
-- 
1.7.9.4

