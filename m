Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833BCD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:38:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E9661816B6
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:38:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052724;
 b=oLHQ7qT6vJE2zZK/6aIUm63FyFCWhburLiUylFJfcH1LfSVaSoh6szKC4OlBuQSd9fkMe
 Lwpur4Wy3+pUM0oflKHG6nj0YCQLL8KxBKF8SoHW5pAXl4lPo94LDCmWLXKdcJ2wGlUcxdy
 9ii6eWUDhZSAUK/w8SCoKRPEvEMRYT4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052724; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PRhugwfdfwN9hhfJGlzTy694sV3yrviulUNv7r1De4E=;
 b=puFxdQlL4n/HkomgPPij0wV5SX+/ZV4vbih1RB5k8Qu2PckHgxwKk3B/axzLHnFlfv9mH
 MW46Z9tlwiPw7CzaDSGKugfDXNqY8Efq0IK/OPx9nDKdF2uuISTSaZPQthvcxImuTxe/L0l
 gKvvmtk98MLDWzi9ksMH/VkrLU7LIII=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F02A784234
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051941;
	b=jL9zRWvYGL+hlDFAnjEuBrQE31+Q8fMgBQXHVGdigu5VkPVGpHYzkT/ol4qtz6AU++V+Qw
	jdQJ8LESGDEOT5bMubnZOTgg780IU/54WTe/rCRhQFr0qPMoPGnfCssQkRBE27WBBMX9nU
	lb9s6O6X0Gurqgd7OsQO6WTQfV/fYGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PRhugwfdfwN9hhfJGlzTy694sV3yrviulUNv7r1De4E=;
	b=t3pYgiyMoALKM1WYkppLkvPmpCr9+xL+1gZ7U3KGtH2C8N2wNrUpBCuuo6gceTz8HCxVQa
	eER0l9SHrChLaCl+gbswwkuaXeLvhHdyOKGDri4lDzl3rN3l4T+dRheJAxuwWRP8i86/MC
	x3MaNTllasEtUX1/m325XWdjp14GVhs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uAeKVRGn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 71A8E20131;
	Sun, 21 Jun 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRhugwfdfwN9hhfJGlzTy694sV3yrviulUNv7r1De4E=;
	b=uAeKVRGnIJGJ8sJziK7+dSRBlM3x/8hBtqw9ffdAry3IsmuZZetbdajF3r8qxd+XtjKke0
	hL19mDvC378wIksrC4ipaCrvwSXutUpsmJyzaMq8S3vcOCSk87PVE5MRXw0AqmpVyP2up3
	fs+4IUR3Nm3Z3nl6nX6dXXm9GGZEIRc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:09 +0200
Subject: [PATCH 19/28] batctl: netlink: always 0-terminate hardif name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-19-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=sven@narfation.org;
 h=from:subject:message-id; bh=oTEDjzjrCWAUQ/MsrtHIebQq+9iCAhQGltrlvOgnd8g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9jFD2UbVnU9WhT4eW5tRexVo4yLGRwTTmrE+mXWZ
 Jb3T4zsKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwkeDnDX+Gw25Zz39RK5fNk
 LTjzqLvD/4GTrfPO14Xh4e/ffl+elMnIsO8le57t3bPmPxY1zuNJ5c7dtuiKUWm2lAh/N7MMS+U
 LdgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VPLSFU6PIC67UGYDWBD7QGHSMBOLE6I5
X-Message-ID-Hash: VPLSFU6PIC67UGYDWBD7QGHSMBOLE6I5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VPLSFU6PIC67UGYDWBD7QGHSMBOLE6I5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The kernel should not send non-0 terminated interface name name or an
interface name larger than IFNAMSIZ. Just to be on the safe side, still
force the last byte to the 0-delimiter.

Fixes: 426e48c8d9ca ("batctl: ping: Get outgoing ifname from netlink")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index 3a1c3a5..14100c3 100644
--- a/netlink.c
+++ b/netlink.c
@@ -822,7 +822,8 @@ static int get_nexthop_netlink_cb(struct nl_msg *msg, void *arg)
 
 	if (attrs[BATADV_ATTR_HARD_IFNAME]) {
 		ifname = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
-		strncpy(opts->ifname, ifname, IFNAMSIZ);
+		strncpy(opts->ifname, ifname, IFNAMSIZ - 1);
+		opts->ifname[IFNAMSIZ - 1] = '\0';
 	} else {
 		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
 		ifname = if_indextoname(index, opts->ifname);

-- 
2.47.3

