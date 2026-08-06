Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920B2C5AC67
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 19:37:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A33848084E
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 21:37:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786045068;
 b=yrU5pfE721Q4NgGgyiBVjgC6ElN0pOvmHKDb+DIilRsM/WYdW18dOdHN5uLWLUNvzMGqJ
 OoMhsG0M8FH2wSveluPvh77j2vzYIfkt++6KbX1rvovH7i8Tzz2pcpMA3Ix69la1smmHpOH
 eUVeQ4+XHEffeCg2TxANg4I2S98Ib/M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786045068; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8MgRhsQsJhtovHQZ0AtT8uohec29vsFDRLDH1CyPyKw=;
 b=Z8EJ3C8ZVZpaK/OW3ZPDZOlpIBJ4gMZXqgzXjfOpR+hg8tD+8i7BZLZyxV2nbKnAkF9SZ
 n9o9jAXLRnHbI/X4dzqrNZZ2ajfFDm6jtz9ABMMRjeWj+P+MYNjjSn1nmE9bm6q7k3T8blY
 HTbBVLnGMm1RC3faWIz/Bs0P3DUMEm4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C679681E08
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 20:55:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786042541;
	b=0PKwi2Au1vjXjr5fOuSxoKFomM3bkWr5I6Hts5t+t0MBvy9HZRk7ZMM3AHisKh8Xh0JxFh
	g6KP63koZBpw+TtLVPzkyKm+i3uyPWqVVRh7KqBntwplNq2U9w6KPH02QpUS76qoDp+BqU
	5Tw/5p6/eEk/GCGzyWWiTTITQdkYXEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786042541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8MgRhsQsJhtovHQZ0AtT8uohec29vsFDRLDH1CyPyKw=;
	b=f5Emnw38VGGfRay/KZ2Dm811/EA8Veqr2IO9vuhT6z13fIjFpT6H7NYUMzPlWHDQo6sSYC
	yZkWAnZDqJiLiX9ZdCU7170FPyh7l8V8+k+uwmCJf+WaccUeQqKHSzGLfmik/d5cJgVShD
	Jqe3ukELV9a+1bjTcJwEE/Tkp7++BVE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bKaFZ7sD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DBC8621B1C;
	Thu, 06 Aug 2026 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786042527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MgRhsQsJhtovHQZ0AtT8uohec29vsFDRLDH1CyPyKw=;
	b=bKaFZ7sDxV7DLlYsrNkT0F6LKVozu1FmzEa3EKSnBaQBlmdMzeWPU9R20KXo34tg0e98Y7
	FaknSrHkwApoQ6JP7FOLz+BlyWreZ9SEjX7KGiv4y0IeigUUOEQHiHcPSJWqezcN8SUJCE
	txrfz2DdS2tsrZgRWHYGZZxSxK1eR2w=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 20:54:53 +0200
Subject: [PATCH batadv 1/3] batman-adv: bat_v: fix bonding candidate
 selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-bat_v-sob-kdoc-v1-1-ba4d763de0da@narfation.org>
References: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
In-Reply-To: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=sven@narfation.org;
 h=from:subject:message-id; bh=eVw31B8xKcVDHBtxqIgYjQ0dBjibHFRREqW/iGqvL4U=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklN1pTg3dpb/2s5Xrk4ZHT4avWsPswK85gNsq6db87O
 I2Lszmro5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARucOMDHM0u6VKZ4mk6svt
 Wb3RqsfD8vvu6W03omtXL/nKoLoj7Cgjw/tvMw6yOV8wtDZT1mvbfzDqnvO1zg0P/6Qf/rpiyXx
 1NT4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ND3TW5OOVWYT6ZY4E5Q55MUU4PY4JG2Y
X-Message-ID-Hash: ND3TW5OOVWYT6ZY4E5Q55MUU4PY4JG2Y
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ND3TW5OOVWYT6ZY4E5Q55MUU4PY4JG2Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_v_neigh_is_sob() implements the metric (throughput) similarity check
as:

  neigh2 (the reference) has a better throughput than 3/4 of the neigh1
  (candidate) throughput

But this results in a selection of bonding candidates in
batadv_find_router() which have a really low throughput. But the goal must
be to select candidates which have a good throughput.

The neigh1/neigh2 operands must be swapped in the comparison to use the
reference as such and select only neighbor+interface combinations with good
throughput.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b05bbab5e1fc ("batman-adv: B.A.T.M.A.N. V - implement neighbor comparison API calls")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0c27447c..2d304573 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -519,8 +519,8 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
  * @neigh2: second neighbour to compare
  * @if_outgoing2: outgoing interface to use for @neigh2
  *
- * Return: true if the throughput of @neigh2 is at least 3/4 of the
- *  @neigh1 throughput
+ * Return: true if the throughput of @neigh1 is at least 3/4 of the
+ *  @neigh2 throughput
  */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 				  struct batadv_hard_iface *if_outgoing1,
@@ -540,10 +540,10 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	if (!ifinfo2)
 		goto err_ifinfo2;
 
-	threshold = ifinfo1->bat_v.throughput / 4;
-	threshold = ifinfo1->bat_v.throughput - threshold;
+	threshold = ifinfo2->bat_v.throughput / 4;
+	threshold = ifinfo2->bat_v.throughput - threshold;
 
-	ret = ifinfo2->bat_v.throughput > threshold;
+	ret = ifinfo1->bat_v.throughput > threshold;
 
 	batadv_neigh_ifinfo_put(ifinfo2);
 err_ifinfo2:

-- 
2.47.3

