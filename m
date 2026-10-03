Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36879CA5FDD
	for <batman@archiver.kernel.org>; Sat,  3 Oct 2026 07:29:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C91C884653
	for <batman@archiver.kernel.org>; Sat, 03 Oct 2026 09:29:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791012545;
 b=wr39hn3rWwcZ5d6LZRfPFO+efZusuFrgCDdZBxja9baLqLfdcul4o6tULQ+MEkXjR4Z0Z
 SRERjsla8GFAMiOVZ+HNlFRVdx8ELIHeroVmtF1EC4Yjr3BvtUpPcLpB+rG8mrm5R7CyVmJ
 8pDvEX2sqi7GGBPVd6YYPO2dLjhz1dk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791012545; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bZ0Xfr0VTL8U9OMtaLqWG3DzhB6SrrDoz0x17p0L5pE=;
 b=01UfS3KOygYlZqBpGO1mh3HzFJXXX9+NgTiIjFk3hqt3LPxMy+TTOxnvHQjxTY/Tq3jL8
 yOcGPkHEvj8rDUHcOQNSwdTmJqJtJO0MerXJWUE+79cIM7+mIFzpdGrUwAQocTfRKzMkEss
 nU1DkhyTPihgehKIcgAT7Sx0JFx4INg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4B348841D3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 03 Oct 2026 09:26:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791012411;
	b=zmnPrxI4ZM6zXxkib/ThqWDkOfm3zfx9t1G1bRLc6cX3VCF9ZA/ZKlsrmAdNvn9EAzaolS
	9dMLUZbu2WxV0X1xbJTRJho4ZA/67r1NXZL3q39Cl2yc8jQBHnHQ+rOdvWga3Zgyo0oSwr
	dFu0nnnSbT/gZzkCquzcKeIi9nneSQc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791012411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZ0Xfr0VTL8U9OMtaLqWG3DzhB6SrrDoz0x17p0L5pE=;
	b=csJw585WsA4uocFOt+6N8J363Mhyn0HFDIeZd9qlM61IUOffVnGDTIyssSQHQzr+I88WvZ
	jT+YxcDG+B4RtzXCW24a56x0QBOodrlS4l6Vex+QQLgGl+k/0EfgXNq7zx/EpZio72VPSc
	h3Zxy/Hgy+YxMQu48jQdw+i7fU3727Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEAB523358;
	Sat, 03 Oct 2026 09:26:40 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v12 4/5] batman-adv: avoid superfluous DAT DHT_PUT if
 self-candidate
Date: Sat,  3 Oct 2026 09:26:27 +0200
Message-ID: <20261003072628.28052-5-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003072628.28052-1-linus.luessing@c0d3.blue>
References: <20261003072628.28052-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: SMSWBD5HKP6FWYTFUSMMBVO72HBYQVTL
X-Message-ID-Hash: SMSWBD5HKP6FWYTFUSMMBVO72HBYQVTL
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SMSWBD5HKP6FWYTFUSMMBVO72HBYQVTL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If we are one of the three closest DAT DHT candidates for a given IPv4
address then three DHT_PUTs to three remote DAT DHT candidates, especially
the last selected DAT DHT candidate, is unnecessary: A DAT DHT_GET from
another node would typically not get to it anyway and would reach us
instead. Because the remote node will take us into account, while we so
far don't take ourself into account in batadv_choose_next_candidate().

Instead of reworking batadv_choose_next_candidate() to take ourself into
account, too, simply, potentially kick out the "worst" remote candidate
at the end of calculation if we are a better candidate. To avoid an
unnecessary DAT DHT_PUT / DHT_GET transmission.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/distributed-arp-table.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 321df338fb8d..52dff46a7c52 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -779,6 +779,9 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * Check if we are a better candidate than the last placed, selected DHT
  * candidate for the given IP address key.
  *
+ * If we are a better candidate then deselects the last placed, selected
+ * DHT candidate.
+ *
  * Return: true if we are a better candidate, false otherwise.
  */
 static bool batadv_dat_cmp_self_candidate(struct batadv_priv *bat_priv,
@@ -822,6 +825,14 @@ static bool batadv_dat_cmp_self_candidate(struct batadv_priv *bat_priv,
 	    memcmp(own_orig_addr, last_cand->orig_node->orig, ETH_ALEN) >= 0)
 		goto out;
 
+	/* deselect last placed, selected candidate, we take its spot */
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "%s(): deselecting %pM for hash(IP)=%u\n",
+		   __func__, last_cand->orig_node->orig, ip_key);
+
+	last_cand->type = BATADV_DAT_CANDIDATE_NOT_FOUND;
+	batadv_orig_node_put(last_cand->orig_node);
+
 	ret = true;
 out:
 	if (ret)
-- 
2.55.0

