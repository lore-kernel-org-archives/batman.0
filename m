Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D20AC87FCA
	for <batman-adv@archiver.kernel.org>; Sun,  3 Aug 2025 06:49:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 708EB8487B
	for <batman-adv@archiver.kernel.org>; Sun,  3 Aug 2025 08:49:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1754203744;
 b=jkib/EPvZdhK/24IAIGiC3YaCLpmq3hqPKatZ732LoFvdFhHI631jZML4+9VdeXEvCyz/
 nxDCJezfslCwyjIopzndd69mVv7YkycMpxiUB626LoCK4+To1obBL1X/wUZUYz7Ucd1CwAG
 01K21wtngMtYIk5t3yDZbs62983b78w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1754203744; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AYsIZ3LA/h7cSatGWGGLdVDc2GDFYxm/MNZeQ3ZyUQA=;
 b=dHytvKqLtEPsvK/yMvvgumdJ3R9YaWgh9HHpLOCGSXCUZ3YILVChfSMwk9VC/LWAQLlKz
 3/DY+QPX3B7ioQ9YVm33PA2vM7tdSJf9brGmJveE9CnqEYQV+35VLD4yBUjp/x+kkghhpQ7
 8dFamzEGbKYv5OhNY10ErGoyw1J04uY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8598A81AB7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  3 Aug 2025 08:48:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1754203738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AYsIZ3LA/h7cSatGWGGLdVDc2GDFYxm/MNZeQ3ZyUQA=;
	b=tn+pL4JNF3MTSGUa9aKQbBYQ6dOUJm+lQuf7sS5kzXohOPWfrvFm0IfKYDlndBQihhbvuR
	M/PmjiZ5LOGmvggIa/LICuKtgeQ6ZALM/VoUWRFhKvdyk6A+lj7HsZyQNnV+j2Prs111eS
	kykdqNtjyI0VaZDAWDT1hBIVDlo/5YQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HrK4oGtR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1754203738; a=rsa-sha256;
	cv=none;
	b=ntrNAuG2/EZwd9EGg+ioWPkFcDRl5FPF+x5jRRH9Lk/3jbbPRoFogsqyeQB+0GtQIJwwdQ
	wCVBrIlS8sDLI8F3YycvrFfx1Dq8jI/IiFvdyvS4PhJNxeMQ7rNVOSqD2k7NNmAjgUre8a
	UIhwIZvPzRL2VpDUQ+vU22MohLf3q5M=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:99fc::8c24])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 73DF62070F;
	Sun,  3 Aug 2025 06:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1754203737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYsIZ3LA/h7cSatGWGGLdVDc2GDFYxm/MNZeQ3ZyUQA=;
	b=HrK4oGtRKGQtNb41atsLFyn5aDwQ6R9KZPp20TYdXHRadocrLgcMTN6M3JuB988dqT0nDn
	5cD5cPAymnha8GCy2Tcd3zt8NEsD7h8tGjEYoLw5w7WddQUy4yAZMjf8Tg852LFlKkl+Lh
	3g6Y05e10qDzSj80j4TU9O3BrF1DU14=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batctl: event: Fix direct parsing on hardif for
 set_hardif
Date: Sun,  3 Aug 2025 08:48:40 +0200
Message-ID: <20250803064840.702003-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250803-various-bugfixes-v1-0-017f917ea98c@narfation.org>
References: <20250803-various-bugfixes-v1-0-017f917ea98c@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XMGGQQHSUA4I62N5OLYL6WQ6SD66GGK4
X-Message-ID-Hash: XMGGQQHSUA4I62N5OLYL6WQ6SD66GGK4
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XMGGQQHSUA4I62N5OLYL6WQ6SD66GGK4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The code to get the hard interface name for an even was accidentally
checking for BATADV_ATTR_MESH_IFNAME instead of BATADV_ATTR_HARD_IFNAME. As
result, the fallback code was always used when BATADV_ATTR_MESH_IFNAME
would have not been available.

Luckily, at the moment, BATADV_ATTR_HARD_IFNAME is always available when
BATADV_ATTR_MESH_IFNAME is set BATADV_CMD_SET_HARDIF events.

Fixes: d12322eeb361 ("batctl: event: Get ifname from netlink message")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/event.c b/event.c
index 33764e3..85234ce 100644
--- a/event.c
+++ b/event.c
@@ -319,7 +319,7 @@ static void event_parse_set_hardif(struct nlattr **attrs)
 			return;
 	}
 
-	if (attrs[BATADV_ATTR_MESH_IFNAME]) {
+	if (attrs[BATADV_ATTR_HARD_IFNAME]) {
 		hardif_name = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
 	} else {
 		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
-- 
2.47.2

