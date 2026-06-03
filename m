Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B789CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:22:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CBBF4807CE
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:22:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460567;
 b=w/YhnJdhdkG/iIaIh239FCG6lCCRY8s114GUXR9/DYk6yTXchEBjFhVWASdthZq8fSfML
 r+M30MdisKrZYOFm015QFBFzK0fXuiOu+9m4v4q/UoFnOZ2KXNqHfxGWCmJZ4dd8Xmi1OWi
 9L0ilQ2a9EaxqiQJrElOFVidjuBYO44=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460567; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0/0gb2wYOJt+F0NSE8oxIOM69YqIt8mE/tPhJ4MLU5U=;
 b=nplmI4vvNOoi87eTKJPNmVAxVliNF1rwlh/6zo4xiSxegKCpL5HugmEjlfccpXxt5ibRl
 a301roBuEPIqAmjVWv0x19OaNLedH7BPeaZnA2x/bBPhUfIpHoyNHR7X9GHJqtrL1E2Q0qD
 nKbTu+yObuX7KSyx7x/Jy+ydPAyZb2U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 38D0C83F6D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460279;
	b=dF+z5yRizGt0gwkQ2JkOt3Ug54vC20C5yi/LHWPE5cWDSCIaEU1CxbLP+/qqcQYEO3xemg
	BSAnA3+PbFCfci9lq3ZUkQ5CTEAxezA77+CMsr4WAI5a2JekXRG17f398ACmU95xZobgvn
	5qsTzdunyh3X8htp0E+9Fqn6dhkVDTc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="cElU/EAz";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0/0gb2wYOJt+F0NSE8oxIOM69YqIt8mE/tPhJ4MLU5U=;
	b=xWUn+ksfdPc9cKX7HmUlO/g9Ta7P3ZaeihqHeRQNpKoC0Mp1fp0du+fbsMoepKRUadJXXw
	Du2c1fNlyxaC62kthqpZ9QtVMuC0yeYXsDAm1qeBNXsJwZpCEZeEQjytDr3uSJLXHnBWiL
	gIgmqAHwjRJlzwsJNuNDq/JddCC17Q4=
Received: by dvalin.narfation.org (Postfix) id F16C620131;
	Wed, 03 Jun 2026 04:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/0gb2wYOJt+F0NSE8oxIOM69YqIt8mE/tPhJ4MLU5U=;
	b=cElU/EAz2msIqZ1iwZlkUM044oTd98Rg4dZr70MiaPMUg+8PPVA6pXI5zZ8/uO0M5lk6ln
	Mpt7SWtno98DNgcTlDuIw0lm0psokO1m7jDPo9/TuU1tfVA0UosPZJvjXD9RoUF/TH05ev
	+zPYN7eJjJVb6KDffHoyc61tLnbbEV8=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:17:19 +0200
Subject: [PATCH batadv v6 07/11] batman-adv: tp_meter: handle seqno
 wrap-around for fast recovery detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tp-reason-missing-v6-7-7011620f93a5@narfation.org>
References: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
In-Reply-To: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=sven@narfation.org;
 h=from:subject:message-id; bh=RzDnUoX3VAlyVDY1oAKMRcnQpZABcQmPZTK7HwrF1OU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq86I/V1vvev5ya61vzzeTGn5V7PleNKTj6FCdkczj
 bOjDHK/dZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0r2IkeG+vKA9Q80Tl/ao
 tr+WPPt2Lu/aHOt63cZRTndTm9u/H1WMDE13vj1zVk6svHczYrFl0lIP3t+VP2st5slfZ1dTXrv
 2PSMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FUPSALWIQPPGSMECXVUJ6LA3VBR4KYUH
X-Message-ID-Hash: FUPSALWIQPPGSMECXVUJ6LA3VBR4KYUH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FUPSALWIQPPGSMECXVUJ6LA3VBR4KYUH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The recover variable and the last_sent sequence number are initialized on
purpose as a really high value which will wrap-around after the first 2000
bytes. The fast recovery precondition must therefore not use simple integer
comparisons but use helpers which are aware of the sequence number
wrap-arounds.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 72ff3526..1a715f0c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */

-- 
2.47.3

