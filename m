Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814C2CD4851
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 07:03:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C6D3F85CAC
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 09:03:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778655829;
 b=XxM/yGt4dVhVFHFs3qa6CWPeGKWAChh94OlEst/MYertDq0nTUjryJEn832QQToJATmcE
 WB0yySbRJGHQKo2biSWXcJW5pFc+zaIRL7wHtUJH9uTs8J6lWNJA6g9DYO/UpiSgLVzXNR+
 nU7l0JsyRkmbMSVEX79YMnc6iPGAicE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778655829; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EzT634+yFmw1dli6oT1X6fkjTPS0kQmK3o0aapNtdhU=;
 b=OnLJX54w++O/dxGjzCqM1aUn4f2xi7Wg0zTFPYBTP5VNa6pPFUgrqoHD20kfFvmdXLoMv
 CggugvyK5k6LYX10oMq4VtV0R3CMwSOinzIFkjDiVK4YkqG/6MTS9Gdxi/DUJZRUvEmZs1B
 iG0Bfd2k1pXz3enxaQE1XSVKSUWcw9Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D6807823C1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 09:01:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778655710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EzT634+yFmw1dli6oT1X6fkjTPS0kQmK3o0aapNtdhU=;
	b=dHm1sdztMGFVhAv0HM7TG9VKIKAg+H1COcCHr5MeDPwtCNHBERJYTJqk8uSshCOVcfKZNU
	UwtLJJqEk1tKea5wdRCKO3+aB40fVnDfMPcCtkOeDkjtnaOb74hTYyTKDRbPwZY8+zhN5i
	TtdLDe5dPbCblDLWf+puH5zpEUbaWtQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=phq2qi3t;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778655710;
	b=jvzELfCc2RIT03LkCcz8CrLrShO8yOMyL1iAZEfDNOs2ZL+GlLsXyoBpVxEwaKY8p7Fp3J
	i6sji2UF1AIvcdeonEzauQUuFgUXoqW6QfChTA51FT0aR/B3pw8j2kFvVUDE5wOB+fTdtJ
	NViUAbqW0VQ3c1FPtoN3MNn/cvOpdcI=
Received: by dvalin.narfation.org (Postfix) id 2D54121977;
	Wed, 13 May 2026 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778655705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzT634+yFmw1dli6oT1X6fkjTPS0kQmK3o0aapNtdhU=;
	b=phq2qi3t6sBV0/8NfXuhzNACThnXGGygeCgzipSdfMqOcRDYhpREoFBb0eylxXwqwGpcQa
	JGq9iIteXfx3GOLDbxglj0SMHCE49evQ3gXsthcGJQg36fejZgFU8cluiuoPOX7RMnhR1U
	PhrFcU8LdqoDQoM4/FUCeSJSciuvtzQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 09:01:35 +0200
Subject: [PATCH batadv v2 2/5] batman-adv: tp_meter: avoid use of uninit
 sender vars
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-yuantan098-bugfixes-v2-2-863e9caa2a57@narfation.org>
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=sven@narfation.org;
 h=from:subject:message-id; bh=2AKDp0y15/++Pqna87fu4JjwAJuZ73GnTSlKV52IXaQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFksiueXbwpbVpfnnddgqr2UwUOa41DVB5vTKWpVv91/K
 n7zu3uwo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARr8MM/yNW/OW1+nBEwqow
 euIZS1vuTw6vJy87v8Q0eOXMf8/+BGcz/DO7oqS7QX2heXBjzb/MJE8BqaIA3/iMM3MEmB7PbbW
 s4QEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AJBPHP3JLNI7VH2V7KUAXFGLQU37EL6A
X-Message-ID-Hash: AJBPHP3JLNI7VH2V7KUAXFGLQU37EL6A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AJBPHP3JLNI7VH2V7KUAXFGLQU37EL6A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tp_recv_ack() and batadv_tp_stop() are only valid for tp_vars in the
BATADV_TP_SENDER role. When called with a BATADV_TP_RECEIVER role, it
proceeds to read sender-only members that were never initialized, leading
to undefined behavior.

This can be triggered when a node that is currently acting as a receiver in
an ongoing tp_meter session receives a malicious ACK packet.

Guard against this by checking tp_vars->role immediately after the
lookup and bailing out if it is not BATADV_TP_SENDER, before any of
those members are accessed.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ca6c3f63..a3593d10 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -664,6 +664,9 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(!tp_vars))
 		return;
 
+	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
+		goto out;
+
 	if (unlikely(atomic_read(&tp_vars->sending) == 0))
 		goto out;
 
@@ -1101,12 +1104,16 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!tp_vars) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: trying to interrupt an already over connection\n");
-		goto out;
+		goto out_put_orig_node;
 	}
 
+	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
+		goto out_put_tp_vars;
+
 	batadv_tp_sender_shutdown(tp_vars, return_value);
+out_put_tp_vars:
 	batadv_tp_vars_put(tp_vars);
-out:
+out_put_orig_node:
 	batadv_orig_node_put(orig_node);
 }
 

-- 
2.47.3

