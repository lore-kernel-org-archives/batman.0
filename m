Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D6606A31A
	for <batman@archiver.kernel.org>; Sun,  8 Nov 2026 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vspvb8D6
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0542684668
	for <batman@archiver.kernel.org>; Sun, 08 Nov 2026 07:52:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794120746;
 b=cq6Yu64AZF6XD3S+fwLnb9Rx04yk4Qwg9r3eqwvw3SWgX59lym1fdJr+bUOZgMqO5vwV8
 Lp6CuXp9Rk2z1ciIJAMIUNGAvtuCBJdQ97DyKeE/4tsSXh6BrVA8+G7dY9rlRgvvaIU4liT
 +/NLbJOlf96RmKc98oGs18kmb8EGegQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794120746; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
 b=s/G1NVaktsl6UOEMaxWuC/T6Gj29EX7LBT6aLwv0DsvKMo7EeL/Y2VCQPgoZ80wW/Y7qk
 nQWuCYC9u74pTW+PXG8UBtPCDr8XwLRn3Nn0t+bF+RPcZH0IN0IMwG1/p1GGYm9pDbSQzlf
 zowHa41AueL8BO6YyqziT7+GSCTYARc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2CEF3814C0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 08 Nov 2026 01:01:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794096126;
	b=d6Os0ke8bvSeFcsKG/pr1RWj0BKK7eghAcgbPA9mS4Ac7UI2sPTFCBFDuBLNQb1zUysyHZ
	RcFferLoT7fXWHbcWaXvZsTbF3MeSTZwdsb0ipkGjabiUE5xVwpjfbenbYYZTR8NlWv8vx
	98fdetJKSvS1Fiy5G/2X5Y5+sYBlJ8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794096126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
	b=EYqllyz6oBAZWfupjdPRlg75QgGj1kwAB/xcwb4FNtCHwidpuc4G20IfP6yBf1ePj/pkIM
	cjW8KCYhNXbMVYI6no89NsxoCTI1xk5keJg/ZqmS9kHqWlaiR0UEqUhEF7ujT8mSwiUX/f
	RircPnAp2EBht8WAPHy9ZG+UBnD9tPA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20260707 header.b=Vspvb8D6;
	spf=pass (diktynna.open-mesh.org: domain of omermetekaya0@gmail.com
 designates 2a00:1450:4864:20::332 as permitted sender)
 smtp.mailfrom=omermetekaya0@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so974055e9.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 07 Nov 2026 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794096115; x=1794700915;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
        b=Vspvb8D6rNoeG80OiUkKp04sGIjrvxRBelZnY8Bm7P+lqMPFVx7cztJdzcxsdwqo4o
         9+JQgfNnnGqnQFGuAI4+LnDD9O814EliZzWtbopSTVLa5+8KA1U94J4MW8cPOFksxk5e
         GrEr5Jssc8RmEzXkBZXC07IplK85251NeXSEH+D3FH6PMmoKxRHPOux5RUAo+6aAv2UP
         QLLs2sVCgH1zjiOUHj75y4AVEhSf99aYnTcfeVzmirqJ7FkzWvXV8q6/UGQYOEr7SeRi
         6Gddhym9DUmwz4Xs3S0Esh8q3cIEEUC1mLN+TKhfBbPUGMJ6ygsvEbgY93wqc8dH+BFf
         plEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794096115; x=1794700915;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
        b=cZ6qM4SJY1gSq21D0AiwPpzdK61ShG68gQinuhm3LOaUqWxWMcFxniI34BFnt3a5hL
         Q2XkCXiaNUhFMBaoVdsWsDhxqaWf0m5r5I71RxZx2lMcUiGpEPZ/OaRxwlBVIiIZQui0
         lP/l7E4neqAJx1ost0Dfqb5xFzrGx97aqvw7ujWVMUEIxr4rbRm/gkjjVTPHmVKVIgH2
         1yXvvNvZl4o4mXj3oSvfLXXt31NtaV7DUHgn5/lbjpqi6K08nVUJFKdZRRj6OSv0lXJG
         Nrn8Kr3EpiFz+pLhtoZXrRs4cPIgjppyaDNOZo8MPDrCgDb4kDU8AalfJPeT3qMxtGrh
         lmwQ==
X-Gm-Message-State: APuU4Z+s6gt0UZdGvqKMWhIN8Le13v/baFJuJjz9ehSycsdptOU8ePGJ
	04KidMhrVtVm6TuBygzyBwgiVDvxG5cLGB7qcGuyy+p/1i7rr2z5/xkx
X-Gm-Gg: AYBFou3pN5un9Vkbt28/KnA7TYqT2HmtYeHrTwk2O9t2ERwQH9ZxZhjys6NoJurURao
	BJZ9cJl3C2cnV8MFXgUzLfriKYOQrGqPLtTeqmSgoZrYYN/jEKUH5rBMAgBoGLjIa8yh7bnmfz5
	OMKstQwVVpcBX5/qYur0/78Cln/0TDB8JoYyJ4OrI6wi9Nq3zaLvXtU2E5HV8K/lK2SD5/YYAhL
	14MbrvUKh0k+1d4Laagb3U4jZd9riBPxK6JqDgdd9mgtMwQo8c5xSrbuy/eGsHRzM5+XMNJaWCv
	ulIl55vlSJthwoIulCEA7QLNZ4DyIwCY6+QzpxkvUDFZe7imtz865dY8zi3tbdrQqGfX8fobZMx
	6jQIz+O/GsLhoYZQYYXRyvvawuCsfuVSW1t8Y6R2xyCxDBl8S4D4zxsGRF/+NGBXVK06Ayls+0P
	kHwekCCfpF8rOSM6crv5EKGYkxxQhY+M0YrLWKQArGwFwLNyQyL9ntqd/1CZbJk7r/lhofh3Gas
	ZwMh221dWqnSYiZD0SnCyoNtO2adomUb6c+vtMSj6CssWo0WVX7jTb1TUvUI7XMZP+60JXfhTST
	Mzz0kY1M9BV4PpjAS0KsiFqUxA==
X-Received: by 2002:a05:600c:4e05:b0:4b2:4b5e:8141 with SMTP id
 5b1f17b1804b1-4b963c662f4mr4462525e9.9.1794096114831;
        Sat, 07 Nov 2026 16:01:54 -0800 (PST)
Received: from metepc ([46.197.185.3])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee247e9sm17430835e9.6.2026.11.07.16.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:01:54 -0800 (PST)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: sven@narfation.org,
	marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH batadv-next v3] batman-adv: tt: batch BH re-enable during TT
 hash walks
Date: Sun,  8 Nov 2026 03:01:11 +0300
Message-ID: <20261108000137.822325-1-omermetekaya0@gmail.com>
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
Message-ID-Hash: EKIBKNY7CNMM4QQ2YZIJFVTRKHJ6EB7I
X-Message-ID-Hash: EKIBKNY7CNMM4QQ2YZIJFVTRKHJ6EB7I
X-Mailman-Approved-At: Sun, 08 Nov 2026 07:52:01 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EKIBKNY7CNMM4QQ2YZIJFVTRKHJ6EB7I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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
non-PREEMPT kernels. Functions called under a spinlock or from
non-sleepable contexts cannot yield; these use the outer
local_bh_disable()/local_bh_enable() conversion without
batadv_hash_bh_resched().

The five converted hash-walking functions are:

  batadv_tt_local_purge():
    Accepts a new @may_sleep parameter. From workqueue context
    (batadv_tt_purge), may_sleep=true allows periodic yielding.
    From batadv_tt_local_resize_to_mtu(), may_sleep=false because
    the caller holds tt.commit_lock.

  batadv_tt_global_del_orig():
    Called from multiple contexts including under spinlocks
    (batadv_purge_orig_ref). Cannot yield. Converts to outer
    local_bh_disable()/local_bh_enable() with inner spin_lock()/
    spin_unlock() but does not use batadv_hash_bh_resched().

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
Closes: https://syzkaller.appspot.com/bug?extid=61b202fdc410840f0198
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Changes in v3:
  - Remove batadv_hash_bh_resched() from batadv_tt_global_del_orig():
    called under spinlocks (e.g. batadv_purge_orig_ref).
    Convert to outer local_bh_disable()/local_bh_enable() with
    inner spin_lock()/spin_unlock() only, like the commit_lock paths.
  - Fix reverse christmas tree ordering in batadv_tt_global_purge()
  - Fix Closes: URL (remove backslash escaping)

 net/batman-adv/hash.h              | 30 +++++++++++++++++++
 net/batman-adv/translation-table.c | 48 ++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 13 deletions(-)

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
index b9407ad..ebeb486 100644
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
@@ -2887,11 +2897,12 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
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
@@ -2916,8 +2927,9 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 				batadv_tt_global_entry_put(tt_global);
 			}
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }

@@ -2969,14 +2981,16 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
+	u32 buckets_done = 0;
 	char *msg = NULL;
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
@@ -2996,8 +3010,12 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)

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
@@ -4402,7 +4420,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	priv_tt = container_of(delayed_work, struct batadv_priv_tt, work);
 	bat_priv = container_of(priv_tt, struct batadv_priv, tt);

-	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT);
+	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT, true);
 	batadv_tt_global_purge(bat_priv);
 	batadv_tt_req_purge(bat_priv);
 	batadv_tt_roam_purge(bat_priv);
@@ -4449,11 +4467,12 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
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

@@ -4472,8 +4491,9 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->key.vid);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 }

 /**
@@ -4497,11 +4517,12 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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
@@ -4536,8 +4557,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)

 			batadv_tt_local_entry_put(tt_local);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 }

 /**
@@ -4839,7 +4861,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		if (size_max >= table_size)
 			break;

-		batadv_tt_local_purge(bat_priv, timeout);
+		batadv_tt_local_purge(bat_priv, timeout, false);
 		batadv_tt_local_purge_pending_clients(bat_priv);

 		timeout /= 2;
--
2.56.0

