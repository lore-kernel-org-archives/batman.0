Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F302C9830E
	for <batman-adv@archiver.kernel.org>; Fri, 25 Sep 2026 08:47:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6530E84605
	for <batman-adv@archiver.kernel.org>; Fri, 25 Sep 2026 10:46:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790326019;
 b=WVnd4KCi5WfAr06qTqX4lXT042zr8jW2/ZjQz2Z7GbsEbFHSOGPpynRfLI6xG25p4IsGK
 qk6jgZbJ3C1HxyLWQOcm/XuXCv8EMAcArQd4kRKeUD6QhakO4CxJENpMu8qUyGPJR2FRpt8
 DnvyY976qlF4icTEoY7CdHZTwMFlcXc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790326019; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=moQfW7SJnQa1U6lQWszJVbEc8Wbqd0xJzc0VO9X1AW4=;
 b=X9EIWWDK31Flrslp+BI7p3BP40m+ygSLp8yzVehNcqYKe4pRvfaO9vClA0+X5x78BRB52
 LCxoHgPWMDtKCAvV4E/76kBSccBAwCyoHpy2vj4eKp6TDYaf0eG85qne/008CC8bdByQbiA
 9tR3JRzmsFzPBo+Gp8BD2Fkzh90W13Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 118CA82740
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 25 Sep 2026 10:44:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790325872;
	b=bcsP7ITTgv51/lPpYERoi2d2o9GNpEfPxqN/XrRvRHAa+kRW/HAmu8CHzUFrsw0hO52dP1
	vU3X1ntxSxnbUPPStwzGPhsNc7IIHFHKKvFWwgg/1sUoVNTw59bgV/Pvi6juMUmaJO0Sre
	8K5DBadLJf4ULPiGoWFrLdZIZJtGfac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790325872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moQfW7SJnQa1U6lQWszJVbEc8Wbqd0xJzc0VO9X1AW4=;
	b=2AtdjsdP7qWsVaR/OCjnI3ZMbK0F33D7YlyAsAQAUv+W1o5Yc4W7LrPtu+W/VhYMzQyy0u
	KD8a6ORUeGcpLLynFst+E2AX95yVi2t6guxdfAwr+fEOC0TnbmwBfAUlCBy7Kx2+8oV9LF
	uq7bczOszybxbOmGhaSuOYS3k/NB3Xs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 92D9323565;
	Fri, 25 Sep 2026 10:44:21 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v11 4/4] batman-adv: avoid superfluous DAT DHT_PUT if
 self-candidate
Date: Fri, 25 Sep 2026 10:44:10 +0200
Message-ID: <20260925084410.27483-5-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925084410.27483-1-linus.luessing@c0d3.blue>
References: <20260925084410.27483-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: D72MVOGPDXTDKJVQVQI4WKN3FP2T55B2
X-Message-ID-Hash: D72MVOGPDXTDKJVQVQI4WKN3FP2T55B2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D72MVOGPDXTDKJVQVQI4WKN3FP2T55B2/>
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
index 7fc12323e9f7..d7dd17fe83f9 100644
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
 static bool batadv_dat_check_self_candidate(struct batadv_priv *bat_priv,
@@ -822,6 +825,14 @@ static bool batadv_dat_check_self_candidate(struct batadv_priv *bat_priv,
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

