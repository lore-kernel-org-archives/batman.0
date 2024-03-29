Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83831CD128A
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:34:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F0ADA81B61
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:34:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715651;
 b=DDOlB+d76tIE0gFYsINFmYIFFo5c0gVsv4JTrhE6F+QJR86NSoh1AgqLBMPYtnpZ0AihG
 48zoeEjTmKH7QIioLlNxP07Ojjb2WBBC3QkbCOs4DNYHj8EPBQc9DzrU2WlyKzuMc8kuUT5
 nIrsqohUwneeFjqgVB1XS8iJFdSUfFY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715651; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gtj5TodMaj8J6TUems7MF3t3Hoy3LIj7vbvApKQCVHw=;
 b=Rev/8lJnhqmqxpKSseue4E3sdZlHMq+ffzrMuW8keRsKyM90KtfbdjSJ1xcQLUhNygjoh
 WodOJXBoeZsNHgayO3fWSRq/jF5UGjGKARVDBIhBnCN/1QVe7wQSGWCG2d4q1U/VFekEorc
 Hg2QCNHVEPrigHFhqL8d17l3HuuWc0o=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AB9E081D04
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:33:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gtj5TodMaj8J6TUems7MF3t3Hoy3LIj7vbvApKQCVHw=;
	b=n6UudC1Rr5x+4P20SUU+3UFyyIveuqQJfmsAemnnFmmVtBqyvZZ6i3i61CACs/mmLWB2YG
	fgrgPpI8ejZRG5REGGq4RzqvfJCSu4ml7SeomIMyhuWJx4jH+hU3VrQwZOft+RGK+kS00d
	0ToOm9AK72WCe1gmVCSKvv8HNPrr76o=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715600; a=rsa-sha256;
	cv=none;
	b=3mKp3fN2kyUC42qZpES4oHa/EzQxyx17GJr29zv3v/oTBkO8SwkElCeINNjc7DkZI8aQRR
	wZ0m0yTa2CQGXKn0ybDEO+r4hC9mq0kdPAWB+bCPoHPekzRxG8pPm5voOFsiyNgRMHzX8c
	QFtHkKojcephajevQPkNZQKF4VZzpfw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=N5EWxjKZ;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 139.178.84.217 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7D7E46191D;
	Fri, 29 Mar 2024 12:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB702C43390;
	Fri, 29 Mar 2024 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715599;
	bh=5Xp9deLXuySM3FPbHSvWVecwYQM4gNJbCeO4/lmlir8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5EWxjKZbhO3j9ydGM0JVE3X7hNvZfL5hhyL3W3ftUvIw+x6GuY67Drlp+6ZeEug+
	 pNZamQPWYFfdO6Xh1tAv4kA2gEhJukQJmiu7Q5vN8Sqd/RoHbf/izdz2ntbl/23kEh
	 6sjye3+qpBm5S2AvR14eBuFgcYCNNvECN09BQXaS2mv6Oq5YqylkynyP26p2f/5i1B
	 xh7nMnFC8oS2AiWbC1VdFCieWAdXZnKGTUsEr329QBVEByhogvtPWziRm4mXywGTxY
	 HQkY/tVeCDwcFmAAxke63tkjwEp4JFyNsUnPsU5ugvKvJCCeIUtfTYldpW/Yduw8i4
	 UgRQ5+ile8nJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/20] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:32:50 -0400
Message-ID: <20240329123316.3085691-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SCZEWY7P5HCNYGQKZWL75RDU5KJMVK46
X-Message-ID-Hash: SCZEWY7P5HCNYGQKZWL75RDU5KJMVK46
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SCZEWY7P5HCNYGQKZWL75RDU5KJMVK46/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit ffc15626c861f811f9778914be004fcf43810a91 ]

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label “out” which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 42dcdf5fd76a1..c091b2a70d22d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0

