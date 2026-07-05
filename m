Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727F0C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:35:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1032F846AC
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:35:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783272947;
 b=qJiH/LtjFCn5I4Lt23anL+vY9FA/Hu/6O3NFG5dqLGpoeph+ylZv8RZIQnziEQ2lMAnmH
 pkTenNb9+an1lTERxH46z5D3U4e7qlJO85RaXRgJvuqLNqsnrQK6GWsrWkryS8g9SiXKxgH
 6Qku7CKXVdljrGfE1gGpxaZTiuFwYII=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783272947; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gmLCgM9s6DBwcZ5AjU7hW6gO+NTxwkqqCHpDefHaG/Q=;
 b=QOEkGuBPgino+jb3zneADcb8SMWWByFPzirBy52FTEnARvLyHBBAq1pIRSYKgvA4M8kSh
 gb4+hVO35zjMtyvVb0j3nMNubRKlLbgxXQOwKo4U1Um7vsuqg+r7rX+UMeKu0EIDVNJHksG
 BrREF1UssV0Pv74vh2kNjThc8h3TTM8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CE2A882F12
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272624;
	b=XeSexkVGzEiAK+SxzkwoIKo+1bU0cC7yRxjus/G2dgpdlrWyeWkUD4baM3GOZ2/f3N1Vua
	EVrauFkpqNnvCtpDgatqjooY1o54wCTwIJr4FIGgySMmrCy+o0OSP+SZ64NzIDPf6bVSGg
	JriQqywlhrUoAlp/fdoESSFPEMgH6gQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gmLCgM9s6DBwcZ5AjU7hW6gO+NTxwkqqCHpDefHaG/Q=;
	b=W8k1ZEBMyLj/fFd6SaaU++XSd/R+7/7so17jnU24U2BUi475pzaGE16RCJG8V5+UPosrCl
	2/HWYA3AvrfwLr/NVKJlbc6p2DrOxDRHJ+kbslHrgrdtFG7LJ2BckWmPTaGu072UXM94ic
	uMDEmCq4imSN87gXdWya3di4bBV1WlA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=l7eNIWzP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 879181FEE6;
	Sun, 05 Jul 2026 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmLCgM9s6DBwcZ5AjU7hW6gO+NTxwkqqCHpDefHaG/Q=;
	b=l7eNIWzPRcH//sADuqL2O+q/wquyB9o9tWyhMzs0mPdID2aWx/D+JONknFwFeZbFgXD4cp
	7izLMciBC1xwc3drArOL8DETSSWZjn5yEaPm0/OUSDfYsD5gcVydJQ5c+2Jok8rMA/GeG/
	trKz1cGtC3n0Ow2aHDP2eK9pLCcygnw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:10 +0200
Subject: [PATCH 7/9] batctl: tcpdump: don't label unknown ICMPv6 types as
 unreachable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-7-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=sven@narfation.org;
 h=from:subject:message-id; bh=7fo3vS7Mh5TcOurHXbwpBO+eP/e8oFAAqYcO3KQBScA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+ZnyvoGlZ67V6beX31vqWnJa/7LkkE1elcObN3Q+
 T5/gf+vjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEzgowMnx8cN1PzqFk/pIF
 ok/efkjndKkWUujm2vmj9uvEZ4v6dV4w/M/rdn+rzbLh+W2FaS4fdkTPF3SflP93dmDdYkbnVyF
 HrjADAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XGKIM4WAY7RQPHU5N7YGX34O2JUWRUFT
X-Message-ID-Hash: XGKIM4WAY7RQPHU5N7YGX34O2JUWRUFT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XGKIM4WAY7RQPHU5N7YGX34O2JUWRUFT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The default case of the ICMPv6 type switch prints ", destination
unreachable, unknown icmp6 type (N)". Every ICMPv6 type that is not
explicitly handled is therefore mislabelled as a destination unreachable
message.

Just report "unknown icmp6 type" instead.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 1094069..f9fb0c1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -692,7 +692,7 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 			       nd_nas_target, buff_len);
 			break;
 		default:
-			printf(", destination unreachable, unknown icmp6 type (%u)\n",
+			printf(", unknown icmp6 type (%u)\n",
 			       icmphdr->icmp6_type);
 			break;
 		}

-- 
2.47.3

