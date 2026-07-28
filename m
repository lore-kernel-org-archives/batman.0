Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14CBC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 18:55:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E0CA081685
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 20:55:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785264931;
 b=e4ePqcy1Z5s3bZvOhX5YCP3QBVPeS5LESw52YgfmmeM+qQ8zc3iF33iSriZ6YI+nvp4hH
 hI8b/ZVZLgUqhdoW9xcDJBKbFwMsReAMX0RAatvTbGAZDiW0wP5yxjXoPLsgeRhaBo8Tifd
 FFKvKmVrq7LjXlmfFssynXMExKv0v1Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785264931; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HwbtXxhI46QRi+jnFl/oqdGobyJdcAvTm6bkR6rLD78=;
 b=DwRV6MRroU4cjq889NGmXdNqXE9r2cQocz/vMa0+ExTre4kRT3zDzjTaqfR/QSIV437FV
 R/ir5J6Q4gfJecRTDQbDG58TclqFYjm2rmStaSk4uG9tLiQguBKMOAqEkq8MwsC+6UqocWp
 XJwnILEteJ7T6oZzXshHX+2WpcEMkMc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B83AD841B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:03:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254620;
	b=NXVXKZyWu+/zK7tVDK+l7103o/VxZt67JBxJjtPju2vC6zzkwAJTfnhGWWLqqxchQjmhAq
	XbB/Z0hcdbAvgnNdT0EhBKMYA3hZ8YtcTlltHUUgqHso2zmF8wNVoGXJ9h5/WGtxTXrcKi
	VRFYQCMRg84BGYIVSScjL1D0n+hedQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HwbtXxhI46QRi+jnFl/oqdGobyJdcAvTm6bkR6rLD78=;
	b=hEXfyoHNndO+nDgBna061OXjhwVasAqvRnx6j1UgQjUkac/Wai1cHdH080YCc0aVqICnnw
	s97LvlJ1webf3awvwgAmPt5VjD/gYPAgRD6kXTLDqvtg1mrD1d5bk6hiDo4pDTEuSFzPwp
	mLLIfhb2D3dwVcGW3rQ6nSH9j+VQI9g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xhf8nOPK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5C0F7204EB;
	Tue, 28 Jul 2026 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwbtXxhI46QRi+jnFl/oqdGobyJdcAvTm6bkR6rLD78=;
	b=Xhf8nOPKC/ntIzeLgAac2BnjR+T2bNYNhEVn1ctDq/SlOx3SUZMFjjdITkQJ3WIPbT4zkj
	opC0IPSa1PSKQGezB8wzhJIrnRCaZ7iCUrZ1GMFjP8UqV/WX3In4r0isvXT+ajLmQAJcHB
	EBe6n7uTsyiiFA5b1dhZ+hwzrIHeI8Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:37 +0200
Subject: [PATCH 8/8] alfred: vis: skip originators with unresolvable hard
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-8-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=sven@narfation.org;
 h=from:subject:message-id; bh=igT0T8yx4ai0Uu5mQYY1w5IXd+kXzB5hJhCJOpiVwc8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2JnJ/oL1Zz8lb5pldFLjrbjJ3nkHf433vaPWnTL2
 16o/NzKjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEuJYz/LN7F/gmMz5Tx2eL
 ItultKjyafWVGT38sT9CJPZ1hS0LEmJkaNiVJS9eUswqMvP7tVKffZfir28qOHNnttiBxjzHH51
 7OAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LRQHWECSN2GT2YB5GFHIAJCK2S2OKQZW
X-Message-ID-Hash: LRQHWECSN2GT2YB5GFHIAJCK2S2OKQZW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LRQHWECSN2GT2YB5GFHIAJCK2S2OKQZW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

get_if_index_devindex() returns -1 on an error. But the result can also be
larger than 255. In both cases, the originator cannot be reported using the
vis_v1 type which is using an u8 for the ifindex storage.

The index must be prechecked before the entry is allocated. The value 255
must also be avoided because it used as marker for TT entries.

Fixes: bca55a86fecd ("alfred: vis: Add support for netlink")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 025745d..b7a50af 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -531,6 +531,7 @@ static int parse_orig_list_netlink_cb(struct nl_msg *msg, void *arg)
 	uint32_t hardif;
 	uint8_t *neigh;
 	uint8_t *orig;
+	int ifindex;
 	uint8_t tq;
 
 	opts = container_of(query_opts, struct vis_netlink_opts,
@@ -567,12 +568,16 @@ static int parse_orig_list_netlink_cb(struct nl_msg *msg, void *arg)
 	if (memcmp(orig, neigh, ETH_ALEN) != 0)
 		return NL_OK;
 
+	ifindex = get_if_index_devindex(opts->globals, hardif);
+	if (ifindex < 0 || ifindex >= 255)
+		return NL_OK;
+
 	v_entry = malloc(sizeof(*v_entry));
 	if (!v_entry)
 		return NL_OK;
 
 	memcpy(v_entry->v.mac, orig, ETH_ALEN);
-	v_entry->v.ifindex = get_if_index_devindex(opts->globals, hardif);
+	v_entry->v.ifindex = ifindex;
 	v_entry->v.qual = tq;
 	list_add_tail(&v_entry->list, &opts->globals->entry_list);
 

-- 
2.47.3

