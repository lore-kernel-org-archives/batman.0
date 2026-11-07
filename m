Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0E606A32D
	for <batman@archiver.kernel.org>; Sat,  7 Nov 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osxdx8mR
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 58309844C5
	for <batman@archiver.kernel.org>; Sat, 07 Nov 2026 16:52:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794066758;
 b=oI2DMCM+5dhtIkUSUoy8lOBfrWUSASyDZgR9oRg3RI4tbz6/6erWzUSyah1WLJBXvhh+q
 ViXfL52XxDoQpwWt90gx1kUnOMiwuND49WmXMvDCMS5cgsBv+myg88bSlklgQ+gYjjMIKVH
 KdePOR9nRYao0CYxi3HV6Gh1NN8c7KI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794066758; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=e7WCE0joRdahraK3eZfXCjWTLgBJmE8aKVh2y7KO0oA=;
 b=A+JkT9/N5GDFi6VBxm8hET1NiRDBDSEL7WTjNuVwbMtwsk/jSWQzqE/Sj+dVth0Ey/N4/
 7+QtxiygfN5D2X03smPvotjsBQbqVsiJvMFgaO27aFc6R6EFDC1gkOAdtnm3cplVTjmJvhm
 sBQX+EeMCP13HcCKg5AUt+fm/0laD3c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E6F0482219
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 07 Nov 2026 16:39:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794065982;
	b=llhzBfDKSO98yWst7KKOEy2S/xFCAidCEJNdq8o7st4r9wqDZ2DJoMnJuvYsnGK4bjH5MC
	Y8x6/suUj1V8jdImIlJ928rQ1b4aVB5ABoWr+2xwIMDl8rxvXdb1Lxt7mOETkVAbchw3j0
	FMUn2OzKWCEQdrT0OH93yb7ofYuGH9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794065982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=e7WCE0joRdahraK3eZfXCjWTLgBJmE8aKVh2y7KO0oA=;
	b=CFiYXV4caQjvmGt0/ftRkcABUwuakMWO5qANqKOS80X4s9jm/Vq8KvUK+9D3QiBWB8kbD9
	ROT1syZ6yZWcrqS95IlFroJD9c67qy7QJLkhnhsK42eLMLkKBjjSxNJHh6Z/i18c7Qtzug
	BbQ2ESxTtW2IrlKTQ600FcIi5mmkHd4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20260707 header.b=osxdx8mR;
	spf=pass (diktynna.open-mesh.org: domain of omermetekaya0@gmail.com
 designates 2a00:1450:4864:20::436 as permitted sender)
 smtp.mailfrom=omermetekaya0@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso1326366f8f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 07 Nov 2026 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794065980; x=1794670780;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7WCE0joRdahraK3eZfXCjWTLgBJmE8aKVh2y7KO0oA=;
        b=osxdx8mR5niIhrnc5pazCg1A9W6c9p03By3ZMOQ/3hYg6Uyv+1VeBLEGkdL/RvU8Dh
         wtyZwdFfSelJSWkIXk0Ag6Vi4ZmWwn5+4SfUExBUOJn2AKDhEogWs3o7U4LrO2pSBhwi
         lC4oL9u/JSE4NqDM6HEJdXK4Y7wONUfnMfikvrdSl+1TH2KGrQdjJqBPmzu14tAyI0oB
         vudRe6m6xxPyg/SBT/TKWHeF+i+x2vwjZZvrX4KwVvZE0Fk0ZaETzhoT4FppksBUFzrZ
         NcksRTlumjFC7Toj58vWqhldjN1e+Ck0918rhSYUIUwRFAZWCjH9u3O2i5/VtEXlYAau
         69EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065980; x=1794670780;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e7WCE0joRdahraK3eZfXCjWTLgBJmE8aKVh2y7KO0oA=;
        b=IQKREhWmou9zdyUVLyb45vXPyxuDcX57mitaRsimObj2Fs5eZsGysb3/kU81Wwjd3/
         Ucjqq9cWQlLCK/izIrlwID5vI/8Y0AG+fGajQ1PG/Jkro04noTyjCX2uGtrnh/QGNju+
         PkmF7l+w6m2PcSi47nrp8iTEtSJpC5pqr8OHds5zRZTnnBZz8JgNKFZ+s67tOKugNPh4
         JFIzAdYw+rsVLSdR0s0Ge50FLwQ/TVSIBCYagM+2CIRtXMQeN7Is2NLG3NN7POLEwzRO
         v/qjybInFXWG5PS6inIEkKttvx0+/D3xkBjhuBDNzce5M1XHSA72MLZ8Qb4QngJUVXM5
         YXqA==
X-Gm-Message-State: APuU4Z/iDi5sY7a/ABDeASxfC3i1+EhuLrmvczt4bE18tbAvDJ0AdlHp
	cuz9yHIJqD/goPPan2EEwt6PDbPFoX6Ob8zARglQ63BTgs22jHbeDD5h
X-Gm-Gg: AYBFou0bUVeYtANYwwVW693Clh9FR5r4d6PjUw0T7k75FMCNBIW5ESO1V4OFx8DabYf
	O5twt1wfU7NxuQyuCk2ADOb+SOvbbeOWSJt7BHS8sURE2zFAkGhCFA9JWrq6ni1taiBuGJXR72O
	e8AOZGapxF4o7/5TyA/F0GL4SlzvDEgg06cOzr45WEbBdeI3WOQVsZ2Sqi0iZ9VerBS4/mJm6Tg
	fTDt8m6GNKnaCljNQu40jhwuE375yDpdE7iupY2aKxyiLW+Rc/7P1YvpI4oLMbk1NQXMB379jsG
	iTnd32L0czFKKlwFWf1OQQNVsQxeNQagmTI72nIfcGXj/uKhMW47B6uRCdGKC+lkWMk5d705iB0
	x+B/jJbSQVZh6zomdX42+J2JooLBEpLgTkHmD87wZJz7oof3e2ZNA/0sg/Ue5kttG4AVlVEi/tw
	RAjglSWM6rtHZGwDSvgQ0NlKMTq0IenhKa8qSXKJ29U+u31h4D0x2Q16QFPLBrI9vUZqoYiHUr8
	N4GMmWVPoWTSbhJT3GJPvbGO984AoqLpsG0PoN8qPJeCt9opUooiY90HLjqFkU7YcND5pdKogat
	Ym3A1bQVoiQuvJ8/gKyK7h8gSQ==
X-Received: by 2002:a05:6000:3112:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-4926fd37ab1mr10100341f8f.0.1794065979360;
        Sat, 07 Nov 2026 07:39:39 -0800 (PST)
Received: from metepc ([46.197.185.3])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7702477sm10391912f8f.41.2026.11.07.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:39:38 -0800 (PST)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Subject: [PATCH batadv-next v2] batman-adv: tt: batch BH re-enable during TT
 hash walks
Date: Sat,  7 Nov 2026 18:37:25 +0300
Message-ID: <20261107153923.797338-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: omermetekaya0@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: WDNRUIVTYNATZDCRGIRACVJENGKSOUDC
X-Message-ID-Hash: WDNRUIVTYNATZDCRGIRACVJENGKSOUDC
X-Mailman-Approved-At: Sat, 07 Nov 2026 16:52:14 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WDNRUIVTYNATZDCRGIRACVJENGKSOUDC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each spin_unlock_bh() re-enables bottom halves and, when softirqs are
pending, processes them inline before returning. During a 1024-bucket
TT hash walk under network load, the purge worker can be repeatedly
interrupted by inline softirq processing at every bucket boundary.

Replace per-bucket spin_lock_bh()/spin_unlock_bh() with an outer
local_bh_disable(), inner spin_lock()/spin_unlock(), and periodic
re-enable points via batadv_hash_bh_resched(). The helper re-enables
BH and calls cond_resched() every BATADV_HASH_BH_BUDGET (64) buckets.
The total softirq work is unchanged, but BH state transitions drop
from 1024 to ~16 per walk, reducing how often the purge loop is
interrupted.

The cond_resched() provides a voluntary preemption point on
non-PREEMPT kernels. Functions called under tt.commit_lock cannot
yield because the caller holds a spinlock; these paths run only
during TT commit and the hash walk is the only significant work
under that lock.

The five converted functions:

  batadv_tt_local_purge():
    Accepts a new @may_sleep parameter. From workqueue context
    (batadv_tt_purge), may_sleep=true allows periodic yielding.
    From batadv_tt_local_resize_to_mtu(), may_sleep=false because
    the caller holds tt.commit_lock.

  batadv_tt_global_del_orig():
    Called from workqueue context; yields every 64 buckets. The
    local_bh_enable() is placed before clear_bit() so that pending
    softirqs run while no per-bucket lock is held.

  batadv_tt_global_purge():
    Called from workqueue context; yields every 64 buckets.

  batadv_tt_local_transition_new():
  batadv_tt_local_purge_pending_clients():
    Called under tt.commit_lock. Convert to outer local_bh_disable()/
    local_bh_enable() with inner spin_lock()/spin_unlock() but do
    not use batadv_hash_bh_resched().

On PREEMPT_RT, local_bh_disable() maps to migrate_disable() and
softirqs run in dedicated kthreads, so the batching has no effect
on softirq latency but the reduced BH transition overhead still
applies.

Reported-by: syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug\?extid\=61b202fdc410840f0198
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Changes in v2:
  - Rewrite commit message to explain the patch better
  - Extract common helper batadv_hash_bh_resched() with
    BATADV_HASH_BH_BUDGET constant
  - Convert all five hash-walking functions:
    batadv_tt_global_del_orig(), batadv_tt_local_transition_new(),
    batadv_tt_local_purge_pending_clients()
  - Add @may_sleep kernel-doc for batadv_tt_local_purge()
  - Add #include <linux/sched.h>
  - Drop Fixes: tag; target batadv-next
  - Rebase onto current batadv-next

 net/batman-adv/hash.h              | 30 +++++++++++++++++
 net/batman-adv/translation-table.c | 52 ++++++++++++++++++++++--------
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 5d9a5ab..cf3ef70 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -10,10 +10,12 @@
 #include "main.h"

 #include <linux/atomic.h>
+#include <linux/bottom_half.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/rculist.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -167,4 +169,32 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 	return data_save;
 }

+/* work which can be done in a hash walk before BH gets re-enabled */
+#define BATADV_HASH_BH_BUDGET 64
+
+/**
+ * batadv_hash_bh_resched() - re-enable BH after the work budget is used up
+ * @buckets_done: buckets processed since BH was disabled, reset when BH is
+ *  re-enabled
+ *
+ * A walk over all buckets of a hash disables BH only once instead of
+ * re-enabling it after each bucket. Otherwise, pending softirqs would be
+ * processed inline after each bucket. When @buckets_done reached
+ * BATADV_HASH_BH_BUDGET, BH is re-enabled to run the pending softirqs and to
+ * give other tasks a chance to run.
+ *
+ * Must be called with BH disabled, without any spinlock held and from a
+ * context which is allowed to sleep.
+ */
+static inline void batadv_hash_bh_resched(u32 *buckets_done)
+{
+	if (*buckets_done < BATADV_HASH_BH_BUDGET)
+		return;
+
+	local_bh_enable();
+	cond_resched();
+	local_bh_disable();
+	*buckets_done = 0;
+}
+
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b9407ad..db93750 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -36,6 +36,7 @@
 #include <linux/overflow.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/sched.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -1892,23 +1893,32 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @timeout: parameter deciding whether a given tt local entry is considered
  *  inactive or not
+ * @may_sleep: if true, periodically re-enable softirqs and yield the CPU.
+ *  Must be false when called with spinlocks held.
  */
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
-				  int timeout)
+				  int timeout, bool may_sleep)
 {
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
+	u32 buckets_done = 0;
 	u32 i;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		batadv_tt_local_purge_list(bat_priv, head, timeout);
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
+		buckets_done++;
+
+		if (may_sleep)
+			batadv_hash_bh_resched(&buckets_done);
 	}
+	local_bh_enable();
 }

 /**
@@ -2882,16 +2892,18 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct hlist_node *safe;
 	struct hlist_head *head;
 	unsigned short vid;
+	u32 buckets_done = 0;
 	u32 i;

 	if (!hash)
 		return;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, safe,
 					  head, hash_entry) {
 			/* remove only matching entries */
@@ -2916,8 +2928,12 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 				batadv_tt_global_entry_put(tt_global);
 			}
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
+		buckets_done++;
+
+		batadv_hash_bh_resched(&buckets_done);
 	}
+	local_bh_enable();
 	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }

@@ -2970,13 +2986,15 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	char *msg = NULL;
+	u32 buckets_done = 0;
 	u32 i;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
 			tt_global = container_of(tt_common,
@@ -2996,8 +3014,12 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)

 			batadv_tt_global_entry_put(tt_global);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
+		buckets_done++;
+
+		batadv_hash_bh_resched(&buckets_done);
 	}
+	local_bh_enable();
 }

 /**
@@ -4402,7 +4424,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	priv_tt = container_of(delayed_work, struct batadv_priv_tt, work);
 	bat_priv = container_of(priv_tt, struct batadv_priv, tt);

-	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT);
+	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT, true);
 	batadv_tt_global_purge(bat_priv);
 	batadv_tt_req_purge(bat_priv);
 	batadv_tt_roam_purge(bat_priv);
@@ -4449,11 +4471,12 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry(tt_common_entry, head, hash_entry) {
 			bool cont = false;

@@ -4472,8 +4495,9 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->key.vid);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 }

 /**
@@ -4497,11 +4521,12 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
 			bool cont = false;
@@ -4536,8 +4561,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)

 			batadv_tt_local_entry_put(tt_local);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 }

 /**
@@ -4839,7 +4865,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		if (size_max >= table_size)
 			break;

-		batadv_tt_local_purge(bat_priv, timeout);
+		batadv_tt_local_purge(bat_priv, timeout, false);
 		batadv_tt_local_purge_pending_clients(bat_priv);

 		timeout /= 2;
--
2.56.0

