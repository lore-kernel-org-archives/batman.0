Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B078C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:05:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E27B685664
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:05:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541124;
 b=o/SZEacw2veB4vrNe+VTe5ZO1YCf9cb7MRvRZQEODrw3irDG8lg23x5FBdqtVbfmiZp4X
 WSnCEY8P38npoHdjW+8xFRK3cMpFf8MCxICKAxZbYX4MPBT9jT1cqL0+pXs5cDo3RxjURA2
 wcbLkYiBNPKxxjggfJPPq+XRaiXAyEE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541124; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PfxZGwXq4ATCgUy4e9pB4oD25V+Fw1B/JUCEG58jE0o=;
 b=wbrpDrGjpYbpBHzH7LwrWdBNM1F8eXKgtmP5kxosQMrTEspgce3+66I9e60uXOND+1eNm
 b0U8TsU9XEXSJeCe7HQJE05yD1nosMN0R/FyA2GKZH2YGXQr7gXToY9LuGs9JDvGAydcKt2
 x2X+hEcyb1a5MO8unmXbxm2rg/tsWHI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 484D883EC5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540832;
	b=TpQRsZ3DZ2HyPHX7p34qTy47AazoxNh2CnmRuRwCtDBj2m3gqgbD/LsoIaruMI3AgdcAPQ
	EJ68IOoKunZLKe1TA3QJul93v1/MRrS2OLaPwMAQGHs8JcerZs6iajJVVNq6mgKG3PhXrb
	EJLCrC2JVjki7Fc4sp9VCywT9adlSac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PfxZGwXq4ATCgUy4e9pB4oD25V+Fw1B/JUCEG58jE0o=;
	b=w7OS7V2D5a1XFHBpn9r8QWO4z/8/O0qq2yofUUrzGK5LrwcC9773HIZVqXfxaek9d5otAU
	ju9lmQl5ipsU5mVrBYZVkfnw6nvSxhGWV2ua62Ik+L4dVmMG4I9VEXE/7YzeJogBJVg8dZ
	Xjw6kQe1Jk+lk2mbrQIgQhJAquv2F3A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Rntcsage;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DFE371FD9C;
	Wed, 08 Jul 2026 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfxZGwXq4ATCgUy4e9pB4oD25V+Fw1B/JUCEG58jE0o=;
	b=RntcsageDfQ7WzZG1E2h06i2pP2cmMMWLx3z+gBMiUuukWcuPBRn9KSpNgoAGJ72N1bP8J
	k9/0Vd2bHNN/q0kZKkDqma3Qnw0F6igpmbrV22lKMvPoRAy62SnR6fvyLskjFg/3uLeH95
	+InNK9Rc9C9dwoORdEWlFo1qTvnsC4E=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:12 +0200
Subject: [PATCH 06/12] batctl: netlink: report kernel errors when writing
 settings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-6-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=sven@narfation.org;
 h=from:subject:message-id; bh=6U9RxCMNd5Ow/bzh+g0G3YlW94ykX9OFM2Zf9JD8aFA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azz+npPpU7jpenF6eOz81O/GmjMSX047tKEs/9Rtd
 fkfpzdd6ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJESQ4Z/mRLMfni+bHrHu
 DSmasoZfIJvF+eW0yOMsv3Qj5h6a82YFI8OB382L2851Ws12+M15yenNW4fejsunxaui3+kdUtg
 yRZ4fAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QFVGNICORLW64CVX76OR6ZEMLLKJXJTB
X-Message-ID-Hash: QFVGNICORLW64CVX76OR6ZEMLLKJXJTB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QFVGNICORLW64CVX76OR6ZEMLLKJXJTB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When writing a setting, sys_simple_nlquery() consumes the kernel reply via
nl_wait_for_ack(). This helper uses the socket's default callbacks instead
of state->cb, so sys_simple_nlerror() never runs and its (negative) return
value is discarded. A set request rejected by the kernel therefore prints
no error message and exits with EXIT_SUCCESS.

This can be seen easily by calling: "batctl meshif bat0 aggregation 1"
without CAP_NET_ADMIN.

Receive the reply through state->cb instead, like the read path already
does. The error handler then prints the kernel error, stores it in result
and the command exits with EXIT_FAILURE.

Fixes: 0b81e8fbaed5 ("batctl: Consume genl ACKs after setting reads")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sys.c b/sys.c
index 35a026e..a4d531f 100644
--- a/sys.c
+++ b/sys.c
@@ -110,10 +110,16 @@ int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
 	if (callback) {
 		ret = nl_recvmsgs(state->sock, state->cb);
 		if (ret < 0)
-			return ret;
+			return -EIO;
+
+		nl_wait_for_ack(state->sock);
+
+		return result;
 	}
 
-	nl_wait_for_ack(state->sock);
+	ret = nl_recvmsgs(state->sock, state->cb);
+	if (ret < 0 && result >= 0)
+		result = -EIO;
 
 	return result;
 }

-- 
2.47.3

