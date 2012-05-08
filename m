Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Tue,  8 May 2012 22:31:57 +0200
Message-Id: <ebf1a5f57c2b4069b177913c3a7ee3d7e0b8db3d.1336509029.git.mschiffer@universe-factory.net>
In-Reply-To: <201205081359.26707.lindner_marek@yahoo.de>
References: <201205081359.26707.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix locking in hash_add()
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
To: b.a.t.m.a.n@lists.open-mesh.org

To ensure an entry isn't added twice all comparisons have to be protected by the
hash line write spinlock. This doesn't really hurt as the case that it is tried
to add an element already present to the hash shouldn't occur very often, so in
most cases the lock would have have to be taken anyways.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 hash.h |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hash.h b/hash.h
index 7bcb98f..2e0409a 100644
--- a/hash.h
+++ b/hash.h
@@ -109,26 +109,23 @@ static inline int hash_add(struct hashtable_t *hash,
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
1.7.10.1

