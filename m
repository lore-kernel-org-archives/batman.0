Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFD606A31E
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zg8LwmJr
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1CAB4843D6
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 08:06:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793343995;
 b=QC6vDJnEF+0hT/OlC2axii4qe6s81D6u+8I5ZdVeWRnv5rtQDDYlv4gMoBc+MbVDe1I0a
 DWITEDQcSJElbWKVuTtt5NKIRJE9mAd5sJtZLEafYqyJIkNOX1oqrQsbeRPBiOuOLl5U3HP
 M1tVLIW3wFAYFf1q/1efEbRfR06nq0Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793343995; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BPyNGElEliISk57S6blDx0U3B+pcSFCYiKtsa38E+sg=;
 b=LYGPaQMI3BwyidEsGMfdgyXXuvYI1ppxmV9kHWB8jEk49kM2OKrmm1CfyQqOwBH3hYw20
 HDMVcUosWRnkn1rmv/RPsQ6W0HIX9CBwHWLjfz+vZKdShPIVCIBmBpjjtjeduA/SNBMJHPa
 abMDRnDXVC3k7haBkEQF9iby/kwMty4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BB49B801EB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 01:02:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793318571;
	b=ppqDFA2ISuOrbc72IKZT/sC+kvjeXWgpgeeHd0PsMThQvCDVYmaR9TitvBaLmVoIVtIVPJ
	vDYpJXyKISFn3a4psLjjN+03wrouGwfuf9g2admarIXlC8mFptBB7uOmt4YAKG6Axx4iix
	JAvEN4iFNc6dUAMdzYHVZ+speL8QSEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793318571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=BPyNGElEliISk57S6blDx0U3B+pcSFCYiKtsa38E+sg=;
	b=My6TiSDpG4Aoj7bZl2dM4ou/r5lXhi8++USb4axIzoWk4Mbb9QYa4s5scbNTunaZzcI4pn
	5KI+ESDzDvFQ/40SRswxniTKNsyB2TKNxTVK/WbnFFYZNGtu12t/BB7IFh4jNspkWdHSLN
	yRucwKjqGaYJl6VXPbCniV17xorBLwc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20260707 header.b=zg8LwmJr;
	spf=pass (diktynna.open-mesh.org: domain of omermetekaya0@gmail.com
 designates 2a00:1450:4864:20::433 as permitted sender)
 smtp.mailfrom=omermetekaya0@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso68147f8f.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 29 Oct 2026 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793318560; x=1793923360;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPyNGElEliISk57S6blDx0U3B+pcSFCYiKtsa38E+sg=;
        b=zg8LwmJrJ6WckaHS7itNChOnJWlzFpnDAN6PMFdrcA1JmDOsBSCw3QBGhUDSlXKZfz
         l/dMDm4j6SYiEYO49fdYkelMUO02EX8IdlGh9zHflmeMsY/SGWrGSf5Vn45+Y27Tp4HD
         G9Ebm7nSJMg3klZwSeR1bE1dyTRTz9z6RHFbICsAOhNtarnW5GxUT+2JWP2DFEXxK2ec
         WC+oZPMXlt8zTX6DFdckSfHGhA4Fyg7PcDF10i9J68X0FBxtX6Wlb0rBL8w24g+UTbX8
         /VTQ5MxN1oz2mZ1iLcP/G5m/isoTvpziTzIqWI2UAHvxwcgljZvldfTYdt4PZ1ma4XVo
         txsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793318560; x=1793923360;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BPyNGElEliISk57S6blDx0U3B+pcSFCYiKtsa38E+sg=;
        b=tdlJaV1Fzzmbw0g4ZKHg6uJ5KJiLDNuNlnXq4N8R95doFTZFmccnZ0NYZLTCXa0GBv
         oZr6z3fGVUwaGOw1Dtdf7KrglYYw5QvxBFTEQZ7pdTpQE0tLKxANjMhrycNCpgaIcLnu
         B8G2/m8vu6yS6L6gHkjDrd1SpBi+xWFOlQrr7MbfktKZ42YAnQmYrWCd+zV1SnrjOrio
         x1Zy5yBDHj0m1a2+Ga52KAQ/Uz68I7rthBHvlHDIX1TVu8Uk1slMUaqj8M8idqcG89iC
         L5oqe2ctOKswEMlo8mB0LxbE69skD1CimPDgZgiiUWsgL7Vf/8XcIEqfMfUCHzxzWIKA
         RqtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy03r6MFnVBvgJuz64nSaFWgcs3c48DvvE9he/WK0BdpnfG7Mjysgq6faxWUIAyRxTIpTcc4tldupLALg==@lists.open-mesh.org
X-Gm-Message-State: AFq9FYKWl8B9bfnRyEtF9Ct54BU4NQn0Q6NTlKb3s/vxAlVtsuBXre6b
	EuVBZz8okiU0YNNIYW4yCU/eIguE0UA6p8iE5TjiBLr11wVeWe6CNbMa
X-Gm-Gg: AYBFou1Pmc9hfhefbqktdCl0Z7gJq1N31ngQoBAYoczaDerXGMGOFCDjYv3DAyvmui1
	tmgD3F/XeZZzk4pENGexINUg1hUYkyBtPL8FZ6fqciLWJ0ShJZqUGauf6Bslr+6ru3AvVIGsy+b
	vf0DBlwvaX3+RaYUww1hA15lxWY0eCL1QvFOq6YRbJmVjOa3cLTR4Q6r5RxY49mh3X0ukYTp0OV
	cz8Wlfb8Tt2gtmcmU35bKMLrroizLyBOh3XIQcfcBGPEyQBq/wHEMmzSWiQQ4MkIVPqB3E0JnTg
	RSEG6zo2AE5djWgdd4+0nNC5xJmoj/JoMPb/CAd7HMBJjE1jlHb+GWSO8ofTBvRoqrA/OQpoGa2
	URn4Sn4+ZlwyYNcKgPEzkZGwTV1uRu8tUFVeupkKBVx2NmLuZRBNxNro3REEBs142enJJQ4RcxN
	+ppPHbECs2xs2uEcM3gFis87RYrPv3jGvb/D0NuhYqlXeNv5V73MpH7gRwXtw6dkEqfCCCzWy7Q
	GIUIkkV5Jt9iLVhFwtBIDoSPhDiAoE1rljcGN1PdcXAx4wFMh2G6lSy3kNWT8sryECSV/uHkp3k
	G6gjckPngOyHxbSPEHb9zpA/1dkB
X-Received: by 2002:a05:6000:40cc:b0:48e:5ea7:b1b9 with SMTP id
 ffacd0b85a97d-48e6e30543fmr2140228f8f.31.1793318559503;
        Thu, 29 Oct 2026 17:02:39 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e712cc231sm419592f8f.35.2026.10.29.17.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:02:39 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: davem@davemloft.net,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net] batman-adv: reduce softirq drain in tt_purge loops
Date: Fri, 30 Oct 2026 02:59:51 +0300
Message-ID: <20261030000222.286935-1-omermetekaya0@gmail.com>
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
Message-ID-Hash: 6C54CRVECH5KBL36HY7W2KF7YZYRCUM7
X-Message-ID-Hash: 6C54CRVECH5KBL36HY7W2KF7YZYRCUM7
X-Mailman-Approved-At: Fri, 30 Oct 2026 08:06:19 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6C54CRVECH5KBL36HY7W2KF7YZYRCUM7/>
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

Replace per-bucket spin_lock_bh()/spin_unlock_bh() with outer
local_bh_disable()/enable() and periodic drain every 64 buckets
to avoid excessive softirq processing during TT purge.

Add may_sleep parameter to batadv_tt_local_purge() since it is
called both from workqueue context (where cond_resched is safe)
and under commit_lock spinlock in batadv_tt_local_resize_to_mtu()
(where sleeping is not allowed).

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Reported-by: syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61b202fdc410840f0198
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 net/batman-adv/translation-table.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 68f79853032e..915f5589e056 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1386,21 +1386,29 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
  *  inactive or not
  */
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
-				  int timeout)
+				  int timeout, bool may_sleep)
 {
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
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
+
+		if (may_sleep && (i & 63) == 63) {
+			local_bh_enable();
+			cond_resched();
+			local_bh_disable();
+		}
 	}
+	local_bh_enable();
 }

 /**
@@ -2363,11 +2371,12 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
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
@@ -2387,8 +2396,15 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)

 			batadv_tt_global_entry_put(tt_global);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
+
+		if ((i & 63) == 63) {
+			local_bh_enable();
+			cond_resched();
+			local_bh_disable();
+		}
 	}
+	local_bh_enable();
 }

 /**
@@ -3750,7 +3766,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	priv_tt = container_of(delayed_work, struct batadv_priv_tt, work);
 	bat_priv = container_of(priv_tt, struct batadv_priv, tt);

-	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT);
+	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT, true);
 	batadv_tt_global_purge(bat_priv);
 	batadv_tt_req_purge(bat_priv);
 	batadv_tt_roam_purge(bat_priv);
@@ -4156,7 +4172,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		if (packet_size_max >= table_size)
 			break;

-		batadv_tt_local_purge(bat_priv, timeout);
+		batadv_tt_local_purge(bat_priv, timeout, false);
 		batadv_tt_local_purge_pending_clients(bat_priv);

 		timeout /= 2;
--
2.56.0

