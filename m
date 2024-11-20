Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFECD711D2
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 17:50:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 49CAF8433D
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 18:50:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732125021;
 b=rOHpukJPdWgd8Dqfds8jkTwVv2mz2v7Vhu3tTg4H5uG1KHZJFJ4XxInxwV+AspkLLeYHR
 p1CixA/wHxOmgYKbUEi24aGNQg4TmZKcyf439LsF5qCSGneCXup2sVlHlvTHlbm2WdYkOmD
 PFh5bkxk/GshSWg2eKBtgv0ARxxy1xA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732125021; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gaRKEWC9jFAayifFPDHqcmnL8NaNrjY4WpjCXVaF898=;
 b=lPYNpWI6HZXhE0RSbf1bB95+IbaSOgIU+AocI5v4yWKEa+pORncjamMAUUBbdjZFx4rXe
 Nx7rJ83ucyzFo6CGJbYbjjgltXkYsBnFNakgO7JsycXisCm4VRyF2HLYI0fs19W/80hnLrK
 yEQ8hiBYnpcSyUmB9RzakbBmPFrPJ6k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8DACF826CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 18:48:35 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732124915; a=rsa-sha256;
	cv=none;
	b=cEInFV56eOBzOd7exncYw9Fkm1cYL7Qonw34plDSSVVj3tDyfkM6XX5x+JmWVrwkJCgmkX
	fXfx1Pnrwjart/NOHTYQMSBLY/qu5QBJKhVN/+bNzryDygS4cNyJEDf8ST0MwM6L0CtY4O
	ldEEX8hgYUS8WQDfC/GNl0Dio95MG2s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=kt5pVVHQ;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=OYatbNTS;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.lbog04dmqpeli39=7f6exmvl3lhu=y3m78in0nkavy3@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.lbog04dmqpeli39=7f6exmvl3lhu=y3m78in0nkavy3@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732124915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gaRKEWC9jFAayifFPDHqcmnL8NaNrjY4WpjCXVaF898=;
	b=ZyHrFqfFwHsPYTH6O8LXlvf/ufPojHpgx9zQsDxMxv1cLsr9f9XG6DqbabZKfkCrEYW5kg
	qioSvcl6asGxPTD2sr3AVJqMjlF7rqjbuUYLJy89t3D6WOutfdMsXaWP5ntb3WM8hvyIOE
	jI78phLewTRJURkzaGO8PPQIXhqb+cM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732125815; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=gaRKEWC9jFAayifFPDHqcmnL8NaNrjY4WpjCXVaF898=; b=kt5pVVHQQqqSekdjVcDZNDLnOo
	LIo4U8dV5ryKOSbkHw09bTJUVC+R/DshnK5ChK5lhge7MTkxnIYAG2cy7SDgYLjNM5apasuSO44mP
	dWBzoBJjT8HhySEXl7bWqsOg+cgorVdlafyGheznDHH4af6O05U/4OzTYehyUQ2o96SfYkEOf8Hey
	vo6xzw8dGuimb3pIqz0mHkzsPmJgw6Tx/AH52hy/JFnrwGEeUEseJGZesroPgP4ktYE3Hw+WRqZ1D
	LKJDz5Maznwq8c2RwaoQozg602zrSVRv7W/5/PlIDoN9zAq6vd+VVjHmmY37LI8irN6lJFwKLmBFw
	9SHwQyhA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732124915; h=from : subject
 : to : message-id : date;
 bh=gaRKEWC9jFAayifFPDHqcmnL8NaNrjY4WpjCXVaF898=;
 b=OYatbNTS1+MgVwek58wHWFC2DnEwXnDabb6iTrWBICIWfut2Xfy11BYaItjciXePBMPQ+
 LREx4yN8lkyl3I8T94QHVwHxmNPORb9r80SoFpX0Xxw6LuYJTFhTdt/mTlJ164xTrbPgNtp
 5lvXWUssbflqx+X8feTpFZrUY0dzBo5jnWzbczLFX2Mo5mFd1bT9PbAjIAo804aXplO93JT
 gK/l0fgwK6TpqfnN72qnXyyQdSmV4sd68dh3E/j+pBIYNc9w7LKLmLTFHiZm/B7IYBLQ8b0
 O7vYxlKjAQ6/i0BeWVfCwikRnAIuXy+QROKsDrnwvMyFeb51KXfpW5IeMFfw==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooc-TRk37B-RN; Wed, 20 Nov 2024 17:48:34 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooc-AIkwcC8rP0a-J7Jn; Wed, 20 Nov 2024 17:48:34 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 3/5] batman-adv: Do not let TT changes list grows
 indefinitely
Date: Wed, 20 Nov 2024 18:47:16 +0100
Message-Id: 
 <c8ebe15252c31d9cc0dd025830ddd793345948ac.1732124716.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732124716.git.repk@triplefau.lt>
References: <cover.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: _EdC0gSyH2d6.tstqtG6MdZnV.HftFMQfABGG
Feedback-ID: 510616m:510616apGKSTK:510616swj04kSrQB
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: CBGYPAQ66BEVHGY2SMUQ7NWFOFD563X2
X-Message-ID-Hash: CBGYPAQ66BEVHGY2SMUQ7NWFOFD563X2
X-MailFrom: 
 bT.lbog04dmqpeli39=7f6exmvl3lhu=y3m78in0nkavy3@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CBGYPAQ66BEVHGY2SMUQ7NWFOFD563X2/>
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
repeatedly sending the same TT response changes over and over, and a
creating a new empty OGM every OGM interval expecting for the local
changes to be purged.

When there is more TT changes that can fit in packet, drop all changes,
send empty OGM and wait for TT request so we can respond with a full
table instead.

Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index bbab7491c83f..d7b43868b624 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_len, tt_change_len = 0;
 	int tt_diff_entries_num = 0;
 	int tt_diff_entries_count = 0;
+	bool drop_changes = false;
 	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
@@ -997,21 +998,29 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
-	 * and wait for the tt table request which will be fragmented
+	 * and wait for the tt table request so we can reply with the full
+	 * table.
+	 *
+	 * The local change history should still be cleaned up or it will only
+	 * grow from this point onwards. Also tt.last_changeset should be set
+	 * to NULL so tt response could send the full table instead of diff.
 	 */
-	if (tt_diff_len > bat_priv->soft_iface->mtu)
+	if (tt_diff_len > bat_priv->soft_iface->mtu) {
 		tt_diff_len = 0;
+		tt_diff_entries_num = 0;
+		drop_changes = true;
+	}
 
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
 	if (!tvlv_len)
 		return;
 
-	tt_data->flags = BATADV_TT_OGM_DIFF;
-
-	if (tt_diff_len == 0)
+	if (!drop_changes && tt_diff_len == 0)
 		goto container_register;
 
+	tt_data->flags = BATADV_TT_OGM_DIFF;
+
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	atomic_set(&bat_priv->tt.local_changes, 0);
 
-- 
2.40.0

