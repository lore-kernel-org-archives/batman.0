Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693B0CD3439
	for <batman-adv@archiver.kernel.org>; Thu,  7 May 2026 15:58:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9920185C01
	for <batman-adv@archiver.kernel.org>; Thu, 07 May 2026 17:58:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778169514;
 b=EwQE+pSDolT25ADcGJ42SMNejj5LVympi/qQvAmj1kBsM9qPv/8vtUtPH4kNbnWMtBBK9
 nLi++mR6iTP9qTpXp5v5fwo+ID1nhzYnrK21RaqTWEUgB3Vr7LwNdaHLkA4C8QLRNkneK5B
 5ebBt77nlC6xTzc2MNudFe/wBnEU+bU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778169514; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tZQbGEsosRMwg0kKaSwS10fn4wCh/U9Lw5X741iOjx4=;
 b=10x37GJAWg8C4eZk7K2UbgtqkYIbtg1r1Ys5Dy9eVYmsE61BycD1DvG3q74ecfn4HGiwi
 Z38pnozwsCoGPL9BElPbnBvcwrGBalnieQexgYDU7pJteFgFByZtejn0LSqadfKRc+oKRz0
 koGUMwOV9IZi33mKK+CvuXfSH9IW9gQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 658A384511
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 07 May 2026 17:49:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778169010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZQbGEsosRMwg0kKaSwS10fn4wCh/U9Lw5X741iOjx4=;
	b=iZJhPBLGi1ARgDdoJj3nBvO5KXBJNc7qLiPVRQHv+LWJP/K6UOZWGmRfzwfvcKdhtlSn4F
	qMJ7D7mI2+U5S8BZ6KERtZP8Z/hO7f8EKX9tYFnp/B6CCXLnqbf09xIgRUE+CJijb1QP+R
	Wdgz3ac0Lq3E/rWVCebfq7KRxjqqLZQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of n05ec@lzu.edu.cn designates
 162.243.164.118 as permitted sender) smtp.mailfrom=n05ec@lzu.edu.cn
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778169010;
	b=BkomEtFAMD0CJrFKK8gCD9NjY3xpZROZoQcdsbHESLPLKTewqjnkdHga0RjsMshX/8q8d3
	AXMjo6WUe1V6Go5wpkBX2EXQyzMUtEVYZ+50vlQYfDQuWILhcveBXTWe+0NPzc5oSItci8
	IlKWGi7Fk667zexj3TNR9qPzWnTl+ms=
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown
 [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACXCvuetPxpV6T8AA--.700S3;
	Thu, 07 May 2026 23:49:54 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	rakukuip@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH batadv 1/1] batman-adv: fix tp_meter counter underflow during
 shutdown
Date: Thu,  7 May 2026 23:49:46 +0800
Message-ID: 
 <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778118303.git.rakukuip@gmail.com>
References: <cover.1778118303.git.rakukuip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: ygmowACXCvuetPxpV6T8AA--.700S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw18GFyruw4kCw1fKryfJFb_yoW8Wrykpr
	WfWr17Kr97Xw4DAa4qyrySvryUAw4xXFW7GanrKr13ZFs8KrWSqryrKFyIvF1FvayqkFsx
	Zw4j9a47AayDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAACWn8UeQJBAAAsl
X-MailFrom: n05ec@lzu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 2XLFCBORHUQIZOS44OIXUANRQHU42JKL
X-Message-ID-Hash: 2XLFCBORHUQIZOS44OIXUANRQHU42JKL
X-Mailman-Approved-At: Thu, 07 May 2026 17:58:27 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2XLFCBORHUQIZOS44OIXUANRQHU42JKL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Luxiao Xu <rakukuip@gmail.com>

batadv_tp_sender_shutdown() unconditionally decrements the "sending"
atomic counter. If multiple paths (e.g. timeout, user cancel, and
normal finish) call this function, the counter can underflow to -1.

Since the sender logic treats any non-zero value as "still sending",
a negative value causes the sender kthread to loop indefinitely.
This leads to a use-after-free when the interface is removed while
the zombie thread is still active.

Fix this by using atomic_xchg() to ensure the counter only transitions
from 1 to 0 once.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 2e42f6b348c8..4c582443f67c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -435,7 +435,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
-	if (!atomic_dec_and_test(&tp_vars->sending))
+	if (atomic_xchg(&tp_vars->sending, 0) != 1)
 		return;
 
 	tp_vars->reason = reason;
-- 
2.43.0

