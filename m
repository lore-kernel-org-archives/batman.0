Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA45CD3426
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:27:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 330C685AA7
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:27:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811238;
 b=J1PHKOM4CuxaVN+1FV+Eb+D0qQ6tAMXSc4Hmu/XKAT8Bm38YYTKPJaOg2efc127v42UB5
 O/vZPsBVIikmcbJv8YfmquNYNg/QZ5f5MOgWBCw8F0wqWu54iJBaOLIUeAdCr+rUSDlvo1+
 DuK3g2hZHdNtKFJnYZhCpKUCDskVsHQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811238; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uf3A8ZlDl5176O66f9kBFMAsj3J5yTzZmJ++kvL/4Xk=;
 b=eLv50TJp3YJ7C+MysXCX7loEjuG3AEkXB10i7p2X3qcCFUswBmY4PmxAk8/ltYfwzIMGf
 AOYNr7STuiCJSzCU9j5jnBEbTYsWoPdXBmAKeKAoo54s88xBoOp+MDHIa+0wNvqrgKvHKKi
 Mn9kvEjVAX0ljYbyBgBN0Xg67zBmN1A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 15D0285341
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777811003;
	b=4ITVbCoOWH6IkaZc5ia+yhxQZoBXNJSoVHCNdMyxyv849zlTZi+arqxOVaZe5t3MYEC2hk
	PuWW8y12fGlQPvaA/ERcqtpdzTT9/Ddzq7vIdTNlOViZFOvWx89/ETTQOORByWa7OHsC4M
	FGFGeJhoEmM7rl8SuzSbhwb/XDt6uZ0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TXnTugjs;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777811003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uf3A8ZlDl5176O66f9kBFMAsj3J5yTzZmJ++kvL/4Xk=;
	b=CYbn36HuYuShB1Naowt7+8DbGTo+S2qL/qPYP97GNvajXmcxEITiGGGn+hoHkRTSaH5+Yt
	0Rz0lGpIwVDihzAqguHbw9psqpojIYUnJNvTfwlGODMhpr5DhwwhEp3kgMx+bi84Rbhcuq
	Hx9izDaa7TqKyDaVrjd0QFg25TldwKA=
Received: by dvalin.narfation.org (Postfix) id C87531FF1D;
	Sun, 03 May 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uf3A8ZlDl5176O66f9kBFMAsj3J5yTzZmJ++kvL/4Xk=;
	b=TXnTugjsCtjqpgblZC72+BQV0r4JUoLe5zisPxAnqE70oZdfrgvwyUsDhDv5ou3CYZz/b6
	ry4whvlcMFG3NxfqTT6HO0srATnN2mhAP35H8GAOaDLumF8fQjJIjbSslr08C2Ojq1Lb4w
	5ySQMfiqZhpQnQgm1nDKoK/1cepspLg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:37 +0200
Subject: [PATCH batadv 4/8] batman-adv: tt: fix negative tt_buff_len
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-4-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=sven@narfation.org;
 h=from:subject:message-id; bh=y4nW4Zch5/hoZ2XdmEqtSl1jLFkK3EBjUlFTE85Qak8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WQPqr574xO82ODYZeWFrLv33s18r+byNsoj6wvP8
 beLpO60dpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmspWH4X8c66XqyCO7Y6w+
 5uqp6nsqKdSqH9S+nGZ82/2di/PRidIM/5Mj1qb8vxYwvUb0e9i0gk6739+rA5crRN+QtXjseNv
 gLg8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: XDJU27WZE7LOP7KIIFPKYEBTJ7JA3JO6
X-Message-ID-Hash: XDJU27WZE7LOP7KIIFPKYEBTJ7JA3JO6
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XDJU27WZE7LOP7KIIFPKYEBTJ7JA3JO6/>
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

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index daa06f421154..0f3814b458cc 100644
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

