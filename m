Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE0CC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 15:10:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D11CC81467
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 17:10:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783264226;
 b=WRWXATb5wXqVLpgLr624mdO/irdaSxMu4FrOqjkN/x2sEi48m4egIW1ZpI+Rth2AlEgn0
 QVCQdzrdJjO3KXwMToJ4jCwBbLQp6jkLdNumC0qkjQligfGYTsZz2GcrA5Pi0MOyabW4LtX
 m/2nZO2RuzRFTt6py+uysVgfUaCGJFU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783264226; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Frv7MXokSqP6RIf/xePCHpTenpXD1Mw9Luq/KiblNq0=;
 b=cMoVdO7LajH0e1bmSW2bRKzEnYa3AcJAv0rIg/EojBen6n/bzyppfLnuj+BFTkC3zPUIR
 rs9jHrGo1XBsxO2ks3FfULbvcQEXgO8o+v6rROtIdW1wiBsXdZPymmgZzTSk3rapp6PXlzw
 gt86IBG+uv7JlvdIHdykyb8JS5ws/ZA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4BA788085A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 17:09:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783264206;
	b=Nds+lkDcvqivX3L+105qvnWBZBlNDkzm5pveERWjyeAhzWHgACXuI8YzSC5uRl+SUMvLS4
	Nen42LuQ1Gz8Qne1dFsolqtaStS3iiE/lkig202dGzAqOaF/8njWmGpMnUEONxsFLr+66o
	8tFqSziM6DDF/Nfhin+6vG9vfxVCiNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783264206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Frv7MXokSqP6RIf/xePCHpTenpXD1Mw9Luq/KiblNq0=;
	b=vHOcNC6TbOofigsNvtoNjmI/zUjjPogc2YGszXtEjZAwhqtxketSAyc6SgSdv5qHb3YSl+
	ZG4AoXvIPlRamEpc+zW+aJ4DYWtvsLD5d9dNQOhj7YjVbDbqvepUsFs+zRcwErGVXtifxZ
	Ar4lpP8G6rgNT8dlTrIT/GhZrMWRruE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RAO10TMJ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 406A61FEDD;
	Sun, 05 Jul 2026 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783264194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Frv7MXokSqP6RIf/xePCHpTenpXD1Mw9Luq/KiblNq0=;
	b=RAO10TMJq/ysBNOvmykngixXTxTKppEf/NgKqciMHqZqV9+R+aQJr6PW8bAgrOa7m6RAiv
	uy96eo13Ph4EGM/+nzX5vIccZ8Xifu15QyHKpssCd+dKtRSkmzw6zuh0QOoXn6qm9CWHi5
	BQ9po+/WXr+rVfVFWKxEVFBrn+is/bU=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 17:09:45 +0200
Subject: [PATCH] batctl: translate: don't overwrite the search key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-translate-v1-1-8a09ee0728da@narfation.org>
X-B4-Tracking: v=1; b=H4sIALhzSmoC/yWM0QrCMAwAf2Xk2UI3i4K/Mnxo0zgj0o2kFWH03
 436eHB3OygJk8Jl2EHoxcprMRgPA+A9loUcZ2OY/HTyZx9casuN36SuSiz6jJVcwmP0IaMpCBZ
 uQj/Fuvn6Z23pQVi/J+j9Az7kHoJ2AAAA
X-Change-ID: 20260704-bugfixes-translate-bc3a04dc026c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=sven@narfation.org;
 h=from:subject:message-id; bh=qrRL2JoJ5TPbJQvqLPPm/xM9pVdINFI13IFXPSPXbB0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlexXtyW+Lsjqw8ztGc/HCL5/dMR/kHuoYi/b8Mhed67
 dhku76/o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRtxIM/yz2vz7fYNVwr0e1
 9MlRYdbJtd8TvGLn8pjoz3k3feXqaRcZGXarXt962SnOmd9w3fpnHM/aXpm8Xc35fV1cyaOsM8t
 t3fkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QGUY4UO4OMRWJ2LBUHMKOCHMBHOOSQUJ
X-Message-ID-Hash: QGUY4UO4OMRWJ2LBUHMKOCHMBHOOSQUJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QGUY4UO4OMRWJ2LBUHMKOCHMBHOOSQUJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

translate_mac_netlink_cb() walks the whole global translation table dump
and searches for an originator address for the provided TT mac address. It
stored that originator back into opts->mac (used for the search key). But
since NL_STOP is no longer used, it might continue to traverse the
translation table but would now use the wrong search key.

Split ethernet address in search key and result field to avoid this
confusion.

Fixes: e2a3d3599cb2 ("batctl: Use common genl socket for netlink_query_common")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
I have now splitted the bugfixes for batctl in topic branches to make it a
little bit easier to review. Similar to the "random bugfixes 2026-06-21"
patchset, they are just various (mostly minor) problems which should be
tackled at some point.
---
 netlink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/netlink.c b/netlink.c
index 46fb993..5ee6c02 100644
--- a/netlink.c
+++ b/netlink.c
@@ -684,7 +684,8 @@ static const int translate_mac_netlink_mandatory[] = {
 };
 
 struct translate_mac_netlink_opts {
-	struct ether_addr mac;
+	struct ether_addr search;
+	struct ether_addr result;
 	uint8_t found:1;
 	struct nlquery_opts query_opts;
 };
@@ -725,10 +726,10 @@ static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
 	if (!attrs[BATADV_ATTR_FLAG_BEST])
 		return NL_OK;
 
-	if (memcmp(&opts->mac, addr, ETH_ALEN) != 0)
+	if (memcmp(&opts->search, addr, ETH_ALEN) != 0)
 		return NL_OK;
 
-	memcpy(&opts->mac, orig, ETH_ALEN);
+	memcpy(&opts->result, orig, ETH_ALEN);
 	opts->found = true;
 	opts->query_opts.err = 0;
 
@@ -746,7 +747,7 @@ int translate_mac_netlink(struct state *state, const struct ether_addr *mac,
 	};
 	int ret;
 
-	memcpy(&opts.mac, mac, ETH_ALEN);
+	memcpy(&opts.search, mac, ETH_ALEN);
 
 	ret = netlink_query_common(state, state->mesh_ifindex,
 				   BATADV_CMD_GET_TRANSTABLE_GLOBAL,
@@ -758,7 +759,7 @@ int translate_mac_netlink(struct state *state, const struct ether_addr *mac,
 	if (!opts.found)
 		return -ENOENT;
 
-	memcpy(mac_out, &opts.mac, ETH_ALEN);
+	memcpy(mac_out, &opts.result, ETH_ALEN);
 
 	return 0;
 }

---
base-commit: eb9597d4ca6db17c579f5ae9443c51b013e2fe65
change-id: 20260704-bugfixes-translate-bc3a04dc026c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

