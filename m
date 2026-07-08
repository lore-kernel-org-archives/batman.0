Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BF9C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:03:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1496485517
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:03:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783540988;
 b=bqNfNphoRn6hcXtdIrDhsMGy8HgD6tKcAONtbxjQhOnjKgyaf7msXiZOHigvII9oeJ12v
 +7tzTFXjy2RxScQ493Y7bsdoQ/UnXXX5eVNWFN0cksvbeMF6A9QzqWNQeTpiSLcoWgvHX1M
 26b8UfN+XpsM4wcyDWV0vLbcJkcZXgk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783540988; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E9IbOydMl1P6Ehdc9hav9/DvycbGLHIWj6vM26DN2r0=;
 b=bEN4txJ8+/150m9q7Um82ax6/J4SFL04P149w2RH8I1IVvr3GlAHZrWa7ej827vSWPyOo
 2Gg5TCqzhsOfEDB2icclKLjq0pf4pND/mLQ9Thpg7/1Lc5wiMM9SucE28OiNL4Aqg7kUPEH
 cslqA9/sV/oYk/TvReCM8/bwvdyD0EU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 71D0B83BC5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540829;
	b=we9R26IDd5B8aR7qGR6j0s8Im3+HVB2vrmBB30qQSrwvUkL3qu567ImSPme0JjLv/OxMIp
	3j+1JW12dYR+upqCbjueMLRbIotV+41uNhBIMfe3uauZZJmlBUt3C37OxGe5xMj9V446WW
	grq05wy4Vs/vidCBkAXuBbo40meYbjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E9IbOydMl1P6Ehdc9hav9/DvycbGLHIWj6vM26DN2r0=;
	b=tdHnwXEiF4GrK4UnE9ESwL9QgH1eW9iwHC+iPRMLC9rUa25o1xhfhfHTL6ltVzwdrVRJ4P
	0sdmHA6HD8xvAgpHFCuB5mS0hCnVOkWTt4jSAJ9djH0GqVR+ednlH4M98DRW6O1zIo9CWz
	hi3fH7z/DwHRL0GBA5TwCd2XbNd56Ag=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JrAoQ6eF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 125F01FD9C;
	Wed, 08 Jul 2026 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9IbOydMl1P6Ehdc9hav9/DvycbGLHIWj6vM26DN2r0=;
	b=JrAoQ6eFRsVF2EoWQPXOQr24uTQJD+P4yGCG19eRLh86fI2cPeUiSk0GUJidQR/ekONapD
	P36IKzOGIh/Sb4EVDVw01U5w244/SufIJsG/f0UmZ0+iKAagByi7RFyH7MNiDRGE+WH/Fz
	TW3d/tsEFW0IRANyVUZ82S2N+jHKuMo=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:08 +0200
Subject: [PATCH 02/12] batctl: netlink: abort netlink_print_common when
 message allocation fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-2-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=sven@narfation.org;
 h=from:subject:message-id; bh=aHTICtuFFoD55zbzJtoBz3jzkPZS0hqLFX4m2kA8n8U=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azx4ucwWnz4Y2ci7Yb5BcUvS1gkzbULfsT7N/qDnH
 FHTEXy6o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRFAmG/xX1rtnzZ3te3lB7
 a3Po8eYpXHleO/ZxHzvyavmV4/rZNx0Y/kecU+dZwvx6cz3HfT79gCeJGmavlvT0sJ49/v9kgtP
 SBywA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FG7VRZF5N55SOMBW63Y4SO4J7L767HGS
X-Message-ID-Hash: FG7VRZF5N55SOMBW63Y4SO4J7L767HGS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FG7VRZF5N55SOMBW63Y4SO4J7L767HGS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When nlmsg_alloc() fails, netlink_print_common() just continues. In
one-shot mode this leaves the loop with the stale last_err of 0 and the
command reports success even though nothing was queried or printed. In
watch mode the loop retries immediately without the usleep() pause and
leaks the header that netlink_get_info() prepared in the previous
iteration.

Treat the allocation failure as -ENOMEM and leave the query loop.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/netlink.c b/netlink.c
index 4a3ab60..cb65655 100644
--- a/netlink.c
+++ b/netlink.c
@@ -567,8 +567,10 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 								 header);
 
 		msg = nlmsg_alloc();
-		if (!msg)
-			continue;
+		if (!msg) {
+			last_err = -ENOMEM;
+			break;
+		}
 
 		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family,
 			    0, NLM_F_DUMP, nl_cmd, 1);

-- 
2.47.3

