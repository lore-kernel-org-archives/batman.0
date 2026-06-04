Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3B1CD6E75
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 19:15:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3F1D784643
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 21:15:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780600515;
 b=iOEvIpAlQnLmUhjbiBKJjoNVsbY2X6YAYXetc+vm9Y+rMadMoVQQnTkQMRnJGe6Rs3ORO
 arlwChMBKSVJGwL9CdlsZ419pfFHmd0i3RrJGcOur01+E4PbTKKxUN4SL1CyfHIIzpcSU8M
 bAlMPXdM5Z2jtm1nY2SUYM+pnyExVkI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780600515; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SR8qrUGnxTT1m9Ev2JIUiNe7KeXKmgn/el8c+VHW0nU=;
 b=t1qrOpAWoN5QjAFIlcaNoF6MI0SB6+QK4aJ1Ag+PfedR8C+XNzGLe8Xu8Wqoco0OwbjD0
 3fsgt+RrxlUb0VVEzfBDu0QjZr50IhTpHzXNAJFoxj1U6W/TLlL1/FvtvpvabLlnvHw/PFA
 zAhNJLsvFY93DQLcmFo0Xez1hivvv90=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B3EC0803D9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 21:14:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780600503;
	b=T5c4Jrsp45Y2lXHxtTrUBrOwnyg/ho99b3bQ2dBf/5+YSQbYUSxVpifH6ZnX2PVGJlTx+U
	yF1XAaNZbUSFna1beOKLyaVff4RzJZY03SkWBrUSHJ4vzMVQO3ZCsJOE+1s6DBiG+0umdh
	f72xb/yiiysCQOCOLKcrXVhvyiI6cu0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BTpPwTvn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780600503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=SR8qrUGnxTT1m9Ev2JIUiNe7KeXKmgn/el8c+VHW0nU=;
	b=IVJ4pJHoQk+tmEBsFwWEgsuOq2RpJe9KIrQIP4IuqXEE93msyBf9FpTnd6P562PGoyita8
	HaQLNcGSgxnwm+88KsBalzw+QWEunZEYJYlE8msmHaHBEZpCOqYO1a/nLMoyCujbsI6pmL
	QRh6cDjiUbkJ8RrwUuPcmKxuf9h9Npw=
Received: by dvalin.narfation.org (Postfix) id E7F5E1FEF0;
	Thu, 04 Jun 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780600493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SR8qrUGnxTT1m9Ev2JIUiNe7KeXKmgn/el8c+VHW0nU=;
	b=BTpPwTvn7QWiYP01yiLAq1bQJyY4eOcczQVoiqB/rtSMJgrfqqPaFyholb2JuIEq8eYBj6
	TDXo8SlvpqF2lfZ77i7FQabbGK7JBXGv3/cfPp+QcGYbVQW9PgAyt/bXkBtRUDD4e2PG88
	ddudI0Prtkz8Rlkuc7xBq50EgV9t3YU=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 21:14:45 +0200
Subject: [PATCH batadv] batman-adv: tp_meter: initialize last_recv_time
 during init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-minor-fixes-v1-1-97162920f120@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKTOIWoC/yWM0QqDMBAEf0X2uYFUbMD+SunDnTnbExpLTkUQ/
 93YPs4ssxtMsorhXm3IsqjpmApcLxW6N6WXOI2FUfs6+OAb99E0ZtfrKuZa4htT5D4EQSm+WX5
 DCR5gmigueP69zTxIN51X2PcD9/yNaXcAAAA=
X-Change-ID: 20260604-minor-fixes-9ab5badbf66e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=sven@narfation.org;
 h=from:subject:message-id; bh=PTpVeL4ruS+SYhsV+NNoDgLmVx0VhsirvxagS8qqUl4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmK51Y+61TbIXjl7+/i5HXfomyurO3IsQy2/yb35WKw9
 0aWVYF3O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATmdTHyPA54/R3zqvtW0Mn
 +6aa/mVfG8ARW9Jwc/YR1plnfj3SjG5l+B9sX5L/9+HnLd2pM8LWfGHewMS8zfRxVfL9EBGlu93
 /bzEBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: C5BLH2KGVPKBGSY3XDXE7U4EXBLM34SZ
X-Message-ID-Hash: C5BLH2KGVPKBGSY3XDXE7U4EXBLM34SZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/C5BLH2KGVPKBGSY3XDXE7U4EXBLM34SZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last_recv_time is the most important indicator for a receiver session
to figure out whether a session timed out or not. But this information was
only initialized after the session was added to the tp_receiver_list and
after the timer was started.

In the worst case, the timer (function) could have tried to access this
information before the actual initialization was reached. Like rest of the
variables of the tp_meter receiver session, this field has to be filled out
before any other (parallel running) context has the chance to access it.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 978e32d9..e2368d4c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1539,6 +1539,8 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	kref_get(&tp_vars->common.refcount);
 	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
 
+	tp_vars->last_recv_time = jiffies;
+
 	kref_get(&tp_vars->common.refcount);
 	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_receiver_list);
 
@@ -1587,9 +1589,9 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 				   icmp->orig);
 			goto out;
 		}
-	}
 
-	tp_vars->last_recv_time = jiffies;
+		tp_vars->last_recv_time = jiffies;
+	}
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK

---
base-commit: 7fb5fc7265f6ce4962357c5383873fd2ef9d50d4
change-id: 20260604-minor-fixes-9ab5badbf66e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

