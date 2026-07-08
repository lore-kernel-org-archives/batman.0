Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B059C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:03:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EEC1A84B96
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:03:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541030;
 b=yGl2T3/FaQbPdKZLTU5xgDHQzgfxh/Nr4wW5g12O7b26aQ27WIXAwp8Fqz0UNotHRww/C
 c2X6LZFNmBYhKJAX7lnaezEB+J3Y/yeFV/eknrrUpwaD39bDfsZuoyESypzpLP1jJVHRF9w
 YK6iRIv3Jex8oi2/eq5/0EI4BvoQ+Uk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541030; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FCKgJ2DYWkscBTrND68wiLIJCltejFwMLvi7A2DSTlw=;
 b=oX/1D+VxR6SRFjPJIs5p8KceCS7te2j163d/vLS3IC5Cm+v6aEefxFk+l53EnfR636sTZ
 SE9EWZCRd/Srog3QOC9TmBs5VhzNRlLFkO5cKqZba52C/PHWBJBs2ttRTRLp6Mk3fdEYGRP
 B+1baWmayLGnjQhVHTTXaxWpsAcrd0w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 428AB83EF3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540830;
	b=0bIHjworbeQdUuEyWBN2ZOXdXfde+tl/oHW1LcEGqU+Tyi9OLH0B3cgSRlvxSoq9us7g8n
	uWjDprFkL4wVBktuqTyH1JyzEx8QECgOK6J0qMvtN58CPuBG7hrvWnNcjsI1B3J4ic8jUg
	lvBJ/bph2pVCnmh0rN01oU3AjExQCAA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FCKgJ2DYWkscBTrND68wiLIJCltejFwMLvi7A2DSTlw=;
	b=qxZCtmRKgXfW8H2HQyIui0rJNUN/vB33PP0FdpdESdrF0AQxnWlWg8FDXIXpfsLXplX/nr
	pkZTTvr97hziHXaqRosGtXk2j3OOtfZugNsyvTZZWceYGVRJSr+f9GOi2KjSEPPHuuScL5
	lfe3gBOnD1vx9XDQhP3ucJ1bg9or0ZA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kee4O5Jd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CD2771FD9C;
	Wed, 08 Jul 2026 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCKgJ2DYWkscBTrND68wiLIJCltejFwMLvi7A2DSTlw=;
	b=kee4O5JdpBoNnksNg4a6QlGIJaGf2iERsEYu7c53IN6xI1/5/PmgSuRgCk4caoc9dITumB
	bW78Bgwzse7o/tf+lZgZq/uTvunL2ggTQ0wmdkK+LS5JC8uHBDW8XAKnAovtNExkfp6gEf
	1z1VpFIyghRCnc7PZ2xwpHq5NLC9/Go=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:11 +0200
Subject: [PATCH 05/12] batctl: netlink: detect receive errors in
 netlink_print_common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-5-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=sven@narfation.org;
 h=from:subject:message-id; bh=3h/z9DA8GEEWqlW0HzVMYup/SfkQKhCU3TBwoDM2FoE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azwOFlTXuq3ZIH68jTGg5+m9D1bplsvZBE9/+Oee0
 mY+f8urjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE3v5k+F/zYE5cj6nhnl/B
 /kcm9Dg48mR9br4fs6c+pizfduX2C9GMDHuMf4T4zMpibGpnnlaY5DUta1Ls/iKVzNPnHqwQ+iW
 RxwEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZZJ5GHTPOMKKEKWRBLABPU7M72CIFAZA
X-Message-ID-Hash: ZZJ5GHTPOMKKEKWRBLABPU7M72CIFAZA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZZJ5GHTPOMKKEKWRBLABPU7M72CIFAZA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netlink_print_common() clears last_err to 0 before each dump and then
ignores the return value of nl_recvmsgs(). It will therefore only print
errors which were received in netlink messages - but not the major errors
when communicating with the kernel.

Capture the nl_recvmsgs() return value, matching the sibling helper
netlink_query_common().

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index e8b41cf..6e0d35a 100644
--- a/netlink.c
+++ b/netlink.c
@@ -537,6 +537,7 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 	};
 	int hardifindex = 0;
 	struct nl_msg *msg;
+	int ret;
 
 	if (!state->sock) {
 		last_err = -EOPNOTSUPP;
@@ -588,7 +589,9 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		nlmsg_free(msg);
 
 		last_err = 0;
-		nl_recvmsgs(state->sock, state->cb);
+		ret = nl_recvmsgs(state->sock, state->cb);
+		if (ret < 0)
+			last_err = -EIO;
 
 		/* the header should still be printed when no entry was received */
 		if (!last_err)

-- 
2.47.3

