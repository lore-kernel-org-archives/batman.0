Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D04D68BF6
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 21:35:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4D45083F98
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 22:35:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731792928;
 b=SuO5O3FfS6C+HErNmfAxR3XPmPQlnmzwuGTXm+8bP7ZTtE68yxQgHBf1vQtklVLL0sLAw
 WqBgOQw8L+4vwv+Bd57c+N5GJ/WPxTscutHjMWvmUaU11EBo0DHTTqIUf9o+4Q7uCR4YzoK
 azT5z2EghrROPbvmv2PjDDMMCJsAEzU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731792928; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lWhkZCCzgCW8vCWkau0Ze+ipuBdeEi5EAc9P8Jy3LjA=;
 b=NBaInr7/vFwpcjfgElSSqvvTlB9X9hq8v3jWPjJ1LRaGTmKRnfz+SSowgPwm4jX+8DOo6
 hibP6fqHfDD3dFRnK8IkiXRlt7uA3Bupl/h7bIpP4/e5CO4Idn7+iTaQKL+kUj2GFPb+7XF
 wdH3IJpNubr8Sa0R/BTzJXn2uMSAlFs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EBE7A80F41
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 Nov 2024 22:33:16 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731792797; a=rsa-sha256;
	cv=none;
	b=ERWcKvhmJHkABQ8pk5NsF1glC3/7OtohoB7N3CYM/Tx32OZQ4glUZDCYG1M/6vwe141sYV
	QrM46cfYMehkc81k8M0T8w80wHAzBWxg3G/RRNtVIxruBee4HRkSzE/i3FF6lqV/1nwNUV
	696bUEXnHQ6wyCQy7FFwfyt9KgFrXHY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b="c/sA65pO";
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=QE1qnxqG;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.4zwizspkw2x2694=d87ik7vd36cn=6ups2e7b2wyl8i@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.4zwizspkw2x2694=d87ik7vd36cn=6ups2e7b2wyl8i@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731792797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lWhkZCCzgCW8vCWkau0Ze+ipuBdeEi5EAc9P8Jy3LjA=;
	b=NcIfQ0jzaph43jyTmKzGbzsPEYOyuw9weOJTL+P/1a5Beb1foG8AfxGo/ggjwYeEsBh2qw
	lyKFUm3Tlomu/iTR4L81Dl1v6Y5UqtY3t8ffPTQyAt0a5WjyhVN0QQ2GT6Hb4yuaozCcB0
	mzB+3/9EaOx0jhg1Z2DWxbANfszWIuQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1731793696; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=lWhkZCCzgCW8vCWkau0Ze+ipuBdeEi5EAc9P8Jy3LjA=; b=c/sA65pObbzsvEQ8oJYRBaNAt8
	ID8DY3apwBjuAtOkQ/beO6kktGbLEVPkB9my8f74HllaeDc8qpmu7aHRMNkrVc3cio+P/ymXkVezS
	RuTEN9z4Uh6OPPjByHkCnjxSyGpUn0j7H74kdSnkk7YqAuw5bVsXrtwL3ra5qXHBy59FQVjgFhJU7
	/ClGzdIJbb2a1bzeMAFwMieoyZtOv7IHm60OzBaEitUknBXhZjNLxMhBWh31c/EK8HJZizSt0Wu8+
	ss+MAUi8+ma0P1AhmFtL/H9KUlIDWRKY8eHL0ES94tAALgtjO3aApSP4AzZueddDaUZOkK8DejJZL
	whPju6Mg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1731792796; h=from : subject
 : to : message-id : date;
 bh=lWhkZCCzgCW8vCWkau0Ze+ipuBdeEi5EAc9P8Jy3LjA=;
 b=QE1qnxqGpU0bEcIp+SkL6VH8VeAUorUnruHJNW4hEqPWG50qziUBArxJjO89FMaRw/yeh
 aFqxxI5ol+yVUdze7vNp1+MBiRG5M1n6MvTILL86Xr6b1qqDySzOO+SGOHdWonOfzFs9qcq
 9G2sgUMIILSva7/XQnzeojv4jHGiQFz4eu9S63zwxrTANhtNfzTadhIeGMfsYbX3bd8I6UO
 HoIVa4hQCkZorSpbzcQnHS9xuNWmHbCjEPiKpR4l0Ln5heP9XQZAPTnv5q4mdzVGgCuRCrA
 jBDQI4yL2OMd3BLcGC6YFvPLiJ9IZIiQaEOSnqAil9CBtaSsgWXvyvn8Dt5A==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPr-TRk499-Rl; Sat, 16 Nov 2024 21:33:15 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPr-4o5NDgrpLKg-pyD7; Sat, 16 Nov 2024 21:33:15 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 3/5] batman-adv: Do not let TT changes list grows
 indefinitely
Date: Sat, 16 Nov 2024 22:32:07 +0100
Message-Id: 
 <2edb71795ee8c18b4275925b4fd338dea1ad5957.1731792497.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: TaU5i3oi_-gv.qMdR2ycCohPx.se1qZgi7Bi-
Feedback-ID: 510616m:510616apGKSTK:510616s-XLYWOQlo
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: HBZVE2MSWEWEW2R4O3AVLWS2DEADMNTG
X-Message-ID-Hash: HBZVE2MSWEWEW2R4O3AVLWS2DEADMNTG
X-MailFrom: 
 bT.4zwizspkw2x2694=d87ik7vd36cn=6ups2e7b2wyl8i@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HBZVE2MSWEWEW2R4O3AVLWS2DEADMNTG/>
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
creatind a new empty OGM every OGM interval expecting for the local
changes to be purged.

When there is more TT changes that can fit in packet, drop all changes,
send emtpy OGM and wait for TT request so we can respond with a full
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

