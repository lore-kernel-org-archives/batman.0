Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7352CCD342C
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:26:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 06B58853DF
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:26:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099185;
 b=izBYlMPoOuiRYtPcG0lxyjPIVwIfq23mHTF6rBu79gxI+7VIFPAhWv7kczKg+r9Pj8TyG
 ZpPoQOrOFGt1Ru75LucWC/+rhZdQZQZrU5s0sW2ZeetMHabIANe4K3WqlmRlhYd7MEg3qQO
 pC7Fw4AVYwAPDf4SaoU88uCjrNyyWFQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099185; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZiUpIzufh4m1riy1mCJl1DVSTkdtr8UYCRZGd4Mu8a0=;
 b=Tun+4c3pGhJUxzB29b4/q8TeG6JL3UaS9+G3gplKoqgHrahtxPhmRkx9kWfzrEgER2mW/
 0NftpDTo+dP5gNJWEP5hLM5Ej8gxia2AYFxlFViFlxI1uAlOVjNsAHGjmk/jxZN5xbV/Jl6
 oJpCmb7veW4X0VD2F+BgUPmVe5AAc0w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4604E84552
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:19 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZiUpIzufh4m1riy1mCJl1DVSTkdtr8UYCRZGd4Mu8a0=;
	b=h0ChP+cDojvi3gNtZ/pv3WRN9ULSF0MlSrZgDmHOK/q5X4+qUOX2rgReHA1QwG17sE7Cm1
	IvDt6NAQ54StGKiIQME+Ol2mD160QIWpgNbdcnbiIAxiAn20T+AU8Zo5F51Is+GZjxEakG
	mxhy/gFq30H8wt9+AAL55vP1rp8MWfU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2lQB8qLV;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098939;
	b=VDv+O1uANcD/wFDTIlY7ex8FbdXANn1JZaWzmnTIgD5TjlIlpLBnqcTYQP49QlCfy6bQH5
	/g4m/jmbDbfj1Hp/nXiLNPmiCGzt10xInrT0p4SFER73R+KDz8/YrbT+GA4SVMhCtvC8LS
	ch50wCpQMMvMM1AceZZNmesZX6br0B4=
Received: by dvalin.narfation.org (Postfix) id B8655217E2;
	Wed, 06 May 2026 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiUpIzufh4m1riy1mCJl1DVSTkdtr8UYCRZGd4Mu8a0=;
	b=2lQB8qLV/Mvc2tGslc/ETSu6gXjUiLizNNMgDTJ3LY3wPPI71xZwHAEVkKSZTLY3xsMupK
	jtBY+rWenzR3w3+8xh8Pa1vH5QMBDU+JPSwt+oeBBTit8lW8K3eBUk8ydU92zees9P6/XH
	z3WttuVtOl8YkfFNb6EDJe492iyOorA=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:53 +0200
Subject: [PATCH batadv v2 06/11] batman-adv: tt: fix negative tt_buff_len
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-6-ce32a2d8d4da@narfation.org>
References: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
In-Reply-To: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
 Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Luxing Yin <tr0jan@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=sven@narfation.org;
 h=from:subject:message-id; bh=+GD8drVYnA3x/+zOKkKBcyOk2oa0GLZhKZ0yTsCpYOc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx1saM/+GWx6WrXjL0Oo7sRMF1PmsiAxpg0a8e/71
 6mr+Hp3lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACYSY87wV47tPRffqQuhe3Pe
 tDuUKpb2xwe61y74PK9AIPWdzgaJ+Qz/q3TXsB9/cmC7dnnIac4CudqO1S7i6/QnTlqxx3b+HR9
 bVgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KA4UVFBBVFX22QCUOJUQBVC4C5EQYD63
X-Message-ID-Hash: KA4UVFBBVFX22QCUOJUQBVC4C5EQYD63
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KA4UVFBBVFX22QCUOJUQBVC4C5EQYD63/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_orig_node::tt_buff_len was declared as s16, but the field is never
intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_other_tt_response(), tt_buff_len is temporarily widened to
s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_global_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_other_tt_response().

Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index daa06f42..0f3814b4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -452,7 +452,7 @@ struct batadv_orig_node {
 	 * @tt_buff_len: length of the last tt changeset this node received
 	 *  from the orig node
 	 */
-	s16 tt_buff_len;
+	u16 tt_buff_len;
 
 	/** @tt_buff_lock: lock that protects tt_buff and tt_buff_len */
 	spinlock_t tt_buff_lock;

-- 
2.47.3

