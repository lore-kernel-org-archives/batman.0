Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E28C54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 07:42:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A5E048405E
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 09:42:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785483734;
 b=eFBTVNZOsA722V0UExDZJfCY/CCdgy2p+Rr7z//EWZBytER2pIPneauV0GDVYS0TFt1tz
 jpK52o3n8uInykcAq3FHBo2jDHkAR31UlPmY+uJ6QaS2pVaGJV6gh0jZj5nABGv+qL5yo9G
 mGO2I/9fcoGdRvBZ/EbRX6wLQ3FpdKg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785483734; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=psXJLzOxkMk/JqyXIz8HpVSQ74s9ZUIBzO7ArDk3vRo=;
 b=Wbr/BM74Sp0G5B022L/IgGwFpZP4DMlNYsxPjFLq+NBJrG1rb9rcPcZzQTtsvQinjvcBE
 rXrnrNy35+ZfwV8A3U83QlN5/eSCqEJl5ynXfrhR9GL4mLpQeDuh5gnJ5WABEBVzEmRsNQz
 nDGMloMGIiWymIeJK6xAaDeigwixduo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1230D84008
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 09:41:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785483677;
	b=xLdezHHq0HfAq2LCstrO5s4S07qN5eZinzXdVqK50uONXkSnbS1BpFPau7FBE7a1FyOHPQ
	fpXTCU1HIOFJhCV2e6szo1H9SJe2Qw3bDuK92oFQE/d4WBnjKxqG9gHQn2lAjn7A70IgzV
	JVyOrTRhq3RbH7YDP2/IK9qh0A55Pt4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785483677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=psXJLzOxkMk/JqyXIz8HpVSQ74s9ZUIBzO7ArDk3vRo=;
	b=soTbUnXPdDtzeCXxIjcF1myFG9/vnL3Hm+VYW+tIANpD3LVHfmiD97L2AomrJ1LEOSpKuY
	uv+5gAq1HuQOEn7aAtzVY3TbsHYz8m3Ya/tUroQfy+ClA+9AOf3HAfHGT8XESzF/QBB6mP
	st5wpeEv2hT3bzAz3KjU6q0Ky1RklIM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=yIH2z9AI;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 84B671FE2D;
	Fri, 31 Jul 2026 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785483661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psXJLzOxkMk/JqyXIz8HpVSQ74s9ZUIBzO7ArDk3vRo=;
	b=yIH2z9AI7VWi1PFLl+W+6wYQqVXVyD/3eimAVBnQBnxjwr6mDp71U/rdDdTmU0UjBpFOVK
	+gPlWPWWbNWUwdXJDhSfiTdLtLERxhGuXCHwaEuNyt1R61eQEMhnfs2oCZ2MWU/uHBQijk
	OKeZUSy/WDpY7Tx4HR5INh1Y0Rb0ruA=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 09:40:13 +0200
Subject: [PATCH 1/4] alfred: fix error code from unix_sock_req_data_reply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-client-v1-1-83d8c7a26421@narfation.org>
References: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
In-Reply-To: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=sven@narfation.org;
 h=from:subject:message-id; bh=vjUEUTS+btKXtyh8ggJ6wsb40nGseNnVILCIp1YGJDM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5gbGXUtiubf8dF1J4/W+vwO+ia8yly+/Pm7RrvZ1iW
 8qksibTjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEFl1nZPgnOlfs79wpJtcl
 HGp/T7yXy29137ebd89+Q7n//gln4kwZ/korrVX4+8ElOKg+oGT2jDdf79+fqPvWZM/r55HrNvR
 vKuMFAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RR2DVE4GZUD6ZMKN5GJEGUCIMDFUEXCE
X-Message-ID-Hash: RR2DVE4GZUD6ZMKN5GJEGUCIMDFUEXCE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RR2DVE4GZUD6ZMKN5GJEGUCIMDFUEXCE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The error code of unix_sock_req_data_reply() was stored in an uint16_t
before being returned from the int-returning function. A failed write to
the client socket therefore returned 65535 instead of -1.

Fixes: 4a77be458853 ("alfred: handle failing write() in unix sockets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unix_sock.c b/unix_sock.c
index e6b44da..e24c788 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -207,7 +207,7 @@ static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 	struct hash_it_t *hashit = NULL;
 	uint8_t buf[MAX_PAYLOAD];
 	uint16_t seqno = 0;
-	uint16_t ret = 0;
+	int ret = 0;
 	int len;
 
 	/* send some data back through the unix socket */

-- 
2.47.3

