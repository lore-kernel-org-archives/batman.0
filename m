Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB8606A31C
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=ptztYXef
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CBF7E846FB
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 21:02:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794513779;
 b=GInAVuB0xB5bSTdbyZgX9x97lzh0qsaTLM1LZRE4z22ole1a+qjNjHCyvGkVBtYPMjnvJ
 hdwcSwd2w/dX4lLGMGDGXSMlTbT7QUy0NbpDFjtVmJSNSFKqRV2pL/iGf3F7Et9Cs1Xoa9u
 lDYwIoRQUY1ALmEptSB6Nf97rk4hvPM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794513779; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=e8iXJdEiinKcDEMpPYuu7J3gl9/Ja9AsaxZMY5Ey2ZA=;
 b=YiaLDJLrtvLDbuDXRQBfPO0oUtesyGK1SdClomgoGforBIuYabXq0kGXY0O04eMyHUDdz
 y8J9Z93HgnS9TdxrQB4QV6pC7khIFDTTUzCMtaCTPK2xlro241Rhgj+xrDcpqkI5hM0kcm3
 IRMVwvsgViXRZsUV6iuWQTAaQzvW7FU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2171080D4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Nov 2026 21:02:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794513756;
	b=EEMHWyO9SGMbkKRs1w06sVwxlPIZ8t3D9YdZAPurWMEvdmfryTom6fOTo7pWTALKts/i6l
	ezaFDuFWS5UhcjH0TlPmzURAFu/Sb1kuha/ezG9wyRKjH/QiujUEF7zVo7A+n+HUa/jpmT
	PjrVv8xLUcCavX74EOZDhk6RdrPm2Ac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794513756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=e8iXJdEiinKcDEMpPYuu7J3gl9/Ja9AsaxZMY5Ey2ZA=;
	b=j2VHrxVmprOglKagSxpAf+FSwq7ttujbXxB04iVul1WiyL4218dZeo9gf1EQc4XpzWtvQr
	vHs0ZX4zBWxHvJxX3+/J2m/B3bWHwPpPrv51kLN5OiA6T9cRoNq4LAtZE5DT7XnXOAIDHy
	oksTbp2Izc12GoGulCt7hAXhnAw9y9g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ptztYXef;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C9B311FD16;
	Thu, 12 Nov 2026 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794513743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e8iXJdEiinKcDEMpPYuu7J3gl9/Ja9AsaxZMY5Ey2ZA=;
	b=ptztYXef2SHFO+lSC9IWmJLoZGRMbpXqh+UKqYTIgisUVyP36Q7TFCWKdJ5QXhqjfhVQd4
	sOleNZhoH9A5SVR6G5GUU4l8w7MW9yPjdXIznrNfKH0sBrWEZiqX/++TsSJka6xIFFBDcC
	GPRUGXSpl6mOsS4SehIIZjsB4dymR6k=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Nov 2026 21:02:14 +0100
Subject: [PATCH batadv] batman-adv: mcast: document rtr want lists in
 want_lists_lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-sashiko-20261112-v1-1-227ac001c98c@narfation.org>
X-B4-Tracking: v=1; b=H4sIAEUb9moC/z2MwQqDMBAFf0XeuYEkgmh/pfSw0VXXgpasiiD+u
 7EFjzMws0M5Ciue2Y7Iq6hMYwL3yFD3NHZspEkMb33hnPNGSXv5TOYWZV4Fay2F3BNS9o3cyvZ
 bvhBopmbF++91CQPX8/XDcZxGpKeFfAAAAA==
X-Change-ID: 20261112-sashiko-20261112-839b000ab32a
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=sven@narfation.org;
 h=from:subject:message-id; bh=KWo5e95dVQZrwwPZqfPxp2rJvc5lUbQESemRFL32dgw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnfpN1ZLwXKq815f3ZSLu/W+ANTzHmWP1iQenj9MT/F8
 ubPF8pOdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmIvWb4X/ig9PPJpt9ustV
 GHLlrtG89Jn1W9gOcG8vO7H0BYvl+n9SDP9M27Ofq11+H/pFet22I5MuCDfKODVN/PHhVW1Ymb3
 8nM0MAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OR7JNGABPZQAXWFHELP53ASXHRODT72Z
X-Message-ID-Hash: OR7JNGABPZQAXWFHELP53ASXHRODT72Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OR7JNGABPZQAXWFHELP53ASXHRODT72Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel-doc for want_lists_lock only mentions the unsnoopables, ipv4
and ipv6 want lists. But batadv_mcast_want_rtr4_update() and
batadv_mcast_want_rtr6_update() also hold this lock when modifying
want_all_rtr4_list and want_all_rtr6_list.

Document the two additional lists protected by this lock.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111102729.2096241-1-sw%40simonwunderlich.de?part=1
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8e590f19..6b674438 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1344,7 +1344,8 @@ struct batadv_priv_mcast {
 
 	/**
 	 * @want_lists_lock: lock for protecting modifications to mcasts
-	 *  want_all_{unsnoopables,ipv4,ipv6}_list (traversals are rcu-locked)
+	 *  want_all_{unsnoopables,ipv4,ipv6,rtr4,rtr6}_list (traversals are
+	 *  rcu-locked)
 	 */
 	spinlock_t want_lists_lock;
 

---
base-commit: a793cf82308e57a0e21c97e889c143cdbba67e5f
change-id: 20261112-sashiko-20261112-839b000ab32a

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

