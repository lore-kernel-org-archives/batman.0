Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA3CE6916C
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 15:55:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DFD45844B0
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 16:55:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732290951;
 b=PeZr27FkDppFb0rTqGoFK3oqbVPzbX476MyiV4EIKo8+DmsJc/0fAM+1UMICEJ+q3G7K/
 t7Eb1jugOZy60ORXeafJrqrKNmqkB8s7xYNdjFVDtfekfV6Y4rlH9k9+mJoj11+ujqQFWv7
 lBrm7wU2abMqOYFXDpTOouv2J1HAfrQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732290951; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Lzx+Og/rywSv4YjLlWccBLHFqHV7fABbu3KjvJZBrrg=;
 b=WJoPsYO0mSgAnwlWYs/Iiolqx1cPeGFAma12YlwjxK7M3n1IOs2S2zkOKo/b61O04itex
 IpwTA5Ja+ior3ER1Ei2uT9A4GEfS6X9U0/i6e922dwmHv9n+HHtEh+MIbbZnJTTvmao0M3Z
 Y3U4RPI9g07JsCB4vbsJnCbCRJle1ZE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 05A6783EC7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 16:54:10 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732290850; a=rsa-sha256;
	cv=none;
	b=RlavAmWWOgE/cJHzaSNB/DnAjLrcf63zjJZU9Y+4jPrgW2rLIMDc2yOEzCnpq3fHsnKbmv
	d6CLc1MLnErcPZOLCB+0Pv7bsYvG64P9xhvCmLjvbswiAk0yaZOg05BYOSNVfRvO+C5Pr8
	aqT4Z/Aqp9ogOo9c42dslnZKMBey9Xg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=mig1Qu4X;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=jv1o1FgT;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.1pccv6nrmu5jcr2=sybys4a23vlz=627iqwx2bvyd2y@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.1pccv6nrmu5jcr2=sybys4a23vlz=627iqwx2bvyd2y@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732290850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Lzx+Og/rywSv4YjLlWccBLHFqHV7fABbu3KjvJZBrrg=;
	b=NmChfSDkJLRaGLFmXvDYtunMdizIgRzSOsquGsy3LkI6JxJcOk/hZi4VGWjDzDiwX2cyp4
	5OcSsmMKJ4Aka1OQito2iTJjIB2hKl+4R7iuYA5nvcwwn5yceggAkH2HiYnhGw2M5/lCLA
	CsuJPGE1reJeKsNrua4RtIJyRAjnGQU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732291750; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=Lzx+Og/rywSv4YjLlWccBLHFqHV7fABbu3KjvJZBrrg=; b=mig1Qu4XQiuGWzghROVaJFX1fw
	e/jt/oQwkS9juU7/axM4CPr9nl6TJuFnO/3qo9BYbu6aj5SVJsqFd1qvJXXOviQjPIap+pU8Dd3za
	Thw4PTZfuW9AY2zeeDYrQpzqVmtcv0aNP4KA/csDyCmYakRWLFDUCLgl6KJkos6tJMGmqzP8iR2wm
	bo7zFybtNzqz44bw9m7TYbcQv1Gr9/weW+JOuItD7hW41J+sIBaKvfca7Uou2bb5EXG0+QHy0/xIB
	ch6Zp63p1LJjzpHWMV6HrYG7T33dGzuKQ1mjCjsD6FBjvhF3hs9HxM8Hbzr0MFxFdw7q5Iiy/Ff0C
	CX84R2Mw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732290849; h=from : subject
 : to : message-id : date;
 bh=Lzx+Og/rywSv4YjLlWccBLHFqHV7fABbu3KjvJZBrrg=;
 b=jv1o1FgTvjU58Wscj0BHhwYkmDx6hcGHq1ZOlj1M00TA8NmOhFMgYXLJkI2Eebe6x28Y0
 lXd6m8AT5Es4BTGSCPcNRT12Wd9LRS2tw74/BDSqlQH7fJ/xGEiQbeXcUmuWSlYyMoKnvZA
 BonU3ob23a/tWCLCq3VGGs5y2kZJVc54+U2sc605WYSNIrrB0W19iN2ZJK0JPmO8BEGxuYR
 I/ZYLV9Hfmk4uy7+03YPo12isteeR8EO9izuQSjTsgWuXSAVmZgAcv16AndLaw11/Si+XPU
 A896DeusDl5fc9NyF7iyRPX6TEGgIwe3qfZH7JT1gddbsGvFI9AZad+ApKFA==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVyz-TRjyvh-6J; Fri, 22 Nov 2024 15:54:09 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVyy-4o5NDgrtp3M-rWqJ; Fri, 22 Nov 2024 15:54:08 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 3/5] batman-adv: Do not let TT changes list grows
 indefinitely
Date: Fri, 22 Nov 2024 16:52:50 +0100
Message-Id: 
 <7a8b08f7c9e63281cb4dbc6d43926ec5e953a306.1732290614.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732290614.git.repk@triplefau.lt>
References: <cover.1732290614.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: JBVNwZUch6wp.ACDUhNc6cYYl.N14gVQWuva8
Feedback-ID: 510616m:510616apGKSTK:510616siD4vwfscd
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: LGNX3PMOE5ALQ3GI743ZGVWKSITNEAP4
X-Message-ID-Hash: LGNX3PMOE5ALQ3GI743ZGVWKSITNEAP4
X-MailFrom: 
 bT.1pccv6nrmu5jcr2=sybys4a23vlz=627iqwx2bvyd2y@em510616.triplefau.lt
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LGNX3PMOE5ALQ3GI743ZGVWKSITNEAP4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When TT changes list is too big to fit in packet due to MTU size, an
empty OGM is sent expected other node to send TT request to get the
changes. The issue is that tt.last_changeset was not built thus the
originator was responding with previous changes to those TT requests
(see batadv_send_my_tt_response). Also the changes list was never
cleaned up effectively never ending growing from this point onwards,
repeatedly sending the same TT response changes over and over, and
creating a new empty OGM every OGM interval expecting for the local
changes to be purged.

When there is more TT changes that can fit in packet, drop all changes,
send empty OGM and wait for TT request so we can respond with a full
table instead.

Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index bbab7491c83f..53dea8ae96e4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_len, tt_change_len = 0;
 	int tt_diff_entries_num = 0;
 	int tt_diff_entries_count = 0;
+	bool drop_changes = false;
 	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
@@ -997,10 +998,17 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
-	 * and wait for the tt table request which will be fragmented
+	 * and wait for the tt table request so we can reply with the full
+	 * (fragmented) table.
+	 *
+	 * The local change history should still be cleaned up so the next
+	 * TT round can start again with a clean state.
 	 */
-	if (tt_diff_len > bat_priv->soft_iface->mtu)
+	if (tt_diff_len > bat_priv->soft_iface->mtu) {
 		tt_diff_len = 0;
+		tt_diff_entries_num = 0;
+		drop_changes = true;
+	}
 
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
@@ -1009,7 +1017,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 	tt_data->flags = BATADV_TT_OGM_DIFF;
 
-	if (tt_diff_len == 0)
+	if (!drop_changes && tt_diff_len == 0)
 		goto container_register;
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-- 
2.40.0

