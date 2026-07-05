Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF71C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 13:06:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 203F6845DB
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 15:06:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783256782;
 b=QCu6+IVhB2PakcX+lgjiAe0ikIHLY0ZHsbSxDJRSzUyxKDvLoISCDxYh9EPmX3ONe4C9m
 WuhK7aFz4ou6guV9nrwgKycnUWn6+6Nd8oAmAabUhWBA2YHaBSn1dNmY1DIXfDPTarEJdLA
 dhom1YtrhLudlgjYBwg9mc23GIxCKlc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783256782; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PvBuES5uHNGcxz1hKc/gtMSUrlPBoh7bL8xKbM5EeHc=;
 b=foEf9tfIGkX/46gOloiSJJWY/RvFZzlqkAtMGMHmin6ZLGy+bmhLatQDnOPdaVwhDbLuJ
 SHE6vWos9BPGro75P+27MeSqRH24bBgiLg4JvQPRzrOSmhLX40GhZYgPTED1Mc1f3IOMGNO
 UncH3oFn9u5sokVWmOq8nuoKtw3vsDQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DC97B845FD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 15:05:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783256704;
	b=xB22M29AasbmNGSE7wbQ7WfAxy1VZrXaGL4PopEEMP9XIHDX+nNTzUua4ZoS6AIBFqbEBu
	U2uPRlEdSVAyqjrzScwEfFHFWS5RB76cRFcILC63rgx29cNELY0I4L0fIOvVo7tPxKWDG9
	xpSkeuM2kz0Mn8HxSQop6koUg06nVEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783256704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PvBuES5uHNGcxz1hKc/gtMSUrlPBoh7bL8xKbM5EeHc=;
	b=yjBKBYhzII4cHCi3vUERW4zq3rea4l7oWysDhKAdSJVUEc1rMr84UnIOFnFxbqcb2NHzB/
	kSJGSzx5x+mY91nrNz+B7Kh+06s8zV/0RQ5sNunye+vAP2VFjNim7FUPK3i3rQ6qGso62u
	7G3pufTDu0OBuyok7NN67cS2OWagPGs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RNPzvELI;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4069D1FEE6;
	Sun, 05 Jul 2026 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783256704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvBuES5uHNGcxz1hKc/gtMSUrlPBoh7bL8xKbM5EeHc=;
	b=RNPzvELI5RX5rdVELZx7EQxsZqJ6CdX9EbTuCYhi1+hdtLZj6QxSaFzzRXavG2l9v/zowe
	rWkqwM+HPwR0/Pxldnw7v4wb9vYAYze3DlX2O9ouMw/g860biheCEmHEor6t5gZQ0nj1gl
	gjTeB/QCCdtlJkKRFbTAH1OUDYcGvZ4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 15:04:27 +0200
Subject: [PATCH 2/2] batctl: interface: return fail for non-existing
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-interface-v1-2-64743906b3d4@narfation.org>
References: <20260705-bugfixes-interface-v1-0-64743906b3d4@narfation.org>
In-Reply-To: <20260705-bugfixes-interface-v1-0-64743906b3d4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=sven@narfation.org;
 h=from:subject:message-id; bh=EnEUb8dZ3O9UY1jY7FjPiLhdmKP4ndCHA29qx29z+cg=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGpKVlqiaozo3LHZ8+8K/SDWgqB4dflCWvcFewNHINBeU4XYK
 Yh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmpKVloACgkQTQ93K9MU9cuunAEA6WJR
 ImsM+2p9j1sbM2QdNC0okM0OAPQ7NFGDMSBslyoA/3rXIhIUQJZ131la7M+J1ykE/MfZZgl7Ead
 G5idoiWEH
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MHQBMLUGQCUUPUYSRH4LXENIMOQJGVR2
X-Message-ID-Hash: MHQBMLUGQCUUPUYSRH4LXENIMOQJGVR2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MHQBMLUGQCUUPUYSRH4LXENIMOQJGVR2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The add/del loop skips a non-existent interface name with a plain continue
and returns a success when no other error class was detected. Which causes
scripts (depending on the return value) to miss the problem.

Remember that a name could not be resolved and return EXIT_FAILURE at
the end, while still processing the remaining interfaces.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/interface.c b/interface.c
index c734eda..03f2e45 100644
--- a/interface.c
+++ b/interface.c
@@ -405,6 +405,7 @@ static int set_master_interface(const char *iface, unsigned int ifmaster)
 static int interface(struct state *state, int argc, char **argv)
 {
 	struct interface_create_params create_params = {};
+	bool iface_error = false;
 	bool manual_mode = false;
 	unsigned int ifmaster;
 	unsigned int ifindex;
@@ -532,6 +533,7 @@ static int interface(struct state *state, int argc, char **argv)
 
 		if (!ifindex) {
 			fprintf(stderr, "Error - interface does not exist: %s\n", rest_argv[i]);
+			iface_error = true;
 			continue;
 		}
 
@@ -562,6 +564,9 @@ static int interface(struct state *state, int argc, char **argv)
 				state->mesh_iface, state->mesh_iface);
 	}
 
+	if (iface_error)
+		return EXIT_FAILURE;
+
 	return EXIT_SUCCESS;
 
 err:

-- 
2.47.3

