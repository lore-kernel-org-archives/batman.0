Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A2DD68BF0
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 21:33:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8D33081B71
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 22:33:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731792802;
 b=XcvzmXLVbzE7L1gbwAB8T/9p64rTe4rPTpz6Lx4j4bE0JOOzwME7maa3UYJLZLYzpWVqj
 Zhs+UoSP94MU7D4zpjytI6OtR+XOMtbtCOXc0XvWYZy48bZHUBUn1MTS0dgC4jvdItojl7T
 hKUP+pCiBu16ZSaCr2BFetehuPbF44k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731792802; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=;
 b=yhBABHxk9eTrCBR4cmR9Kz1SMRxiERBJfS8Taslgta1BO8aZc4MmXvr7m3WQidA/Vrwpl
 6oEpHBGYVqrpQ9z0nF2j8pwgq85Wv0+FXL0MIp7V3fGoVEmKwV/gFE57QGcDSN2HIQ32T+7
 iQpSjhHvqKPG5gqdptojZ8Cde9Dsn14=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1CD8F832F6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 Nov 2024 22:33:14 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731792794; a=rsa-sha256;
	cv=none;
	b=CV3nHbY1+wVlxLb4st3aP9Dfz9v1ZZmaSiPpaQenAaCESjZzAwBLIp6CNhs5L/XtfgxwDQ
	HWHTDbV1/Jn1tqsr3eKXZMDcPZ4yt6S9XItWHMbO3firTLcfikaWDgUpSuuHuzQzpgT2rU
	dPsdh6qPL7vwve/SgJo7tvzALKTdUmM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=rBGdXkwj;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=gCRWhPWO;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.kfvp1xgkq78sa59=6m8m8heth3as=jzd7v3dv93fwy9@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.kfvp1xgkq78sa59=6m8m8heth3as=jzd7v3dv93fwy9@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731792794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=;
	b=G9mfFn66IR+HSs6WatH7FlwHQ2Ozk0aVUjf2SNhWSTZ525IjBXHRX866ztyGkq1vwsG+Aw
	CG9qq611KZF0A7Ad1KKVySeI0YphojeHP2tqRBjRlilOe3sN4xaPBgVZOypwhTe1xJTqzs
	ivNOaNIyOAu36BCC6jiEZMuodWvdeC8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1731793694; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=; b=rBGdXkwj2BOisFMCmNIN3jsmSt
	sm+GyyQjnbfaHnB45sR/dn9ffNgDSbcZO32jzgfpgmGKZ9Z/fg1dCkcCJz1U3GnhkudhKyIcOyXMa
	McE/5lxMRSSrM0CoA4+g4AqBLYp5/ehXuFCW72J68sjfzLNH/J6xeI5f1Zrl/WvAP9tkgw6xlD737
	bBTS1JSU2bD48GTKh96EEmRlN9HWvae/5u3WWTA+qtHaB14ITVkTnIzQ+JKZkepwtFg1dXzh57rC7
	tVfKf+TH5gW4DrXrI5Thib94QbZYbm9bYKduFjGetEWcaP0p21iWzObfniV3ldkEU/K7mOMZvZo7S
	VA4CyuqA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1731792794; h=from : subject
 : to : message-id : date;
 bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=;
 b=gCRWhPWO0xPEJQGM4H2J1gBcoPbAllisczp+F2V2wEurgA5w6ZZJ30uhb9dHJAgRPQXZl
 R+TpjArmlY2XYzVOL0zfY1cnLzHrDPKd8AVYu/KkeBksQCIdGwgHwSpfFJtUB1BYDxLANxW
 eUf7MT0IPa2zbYQuIUhY0a1Yz8d2/LaYehULLO7+nYnP009wVnkgRLmoZyrLYTAR69aP7ue
 F51mH50Bkops1XY5yVTqWxfgAS1MqKFqjGm0wLXz7oNG0fsWiRusYItN/GEFLdItG1yd5o5
 WcthIGcwmPnLwEM7RfKBiTv3gqPsokxEfV/sNModLb5pHe5YtgDZvoMHqYXg==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPp-TRk3qi-89; Sat, 16 Nov 2024 21:33:13 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPo-AIkwcC8wlAQ-Kn3H; Sat, 16 Nov 2024 21:33:13 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 1/5] batman-adv: Do not send uninitialized TT changes
Date: Sat, 16 Nov 2024 22:32:05 +0100
Message-Id: 
 <fbc17f32703930e711353d82146a916106acd2f1.1731792497.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: _af7wBTE6phH.pNPRTZ_-9sjr.NA2EGgiH_pD
Feedback-ID: 510616m:510616apGKSTK:510616sEBlNEGTBc
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: HRBXBSOEG2CS2GIF6GWRLRFMS53TIYHW
X-Message-ID-Hash: HRBXBSOEG2CS2GIF6GWRLRFMS53TIYHW
X-MailFrom: 
 bT.kfvp1xgkq78sa59=6m8m8heth3as=jzd7v3dv93fwy9@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HRBXBSOEG2CS2GIF6GWRLRFMS53TIYHW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The number of TT changes can be less than initially expected in
batadv_tt_tvlv_container_update() (changes can be removed by
batadv_tt_local_event() in ADD+DEL sequence between reading
tt_diff_entries_num and actually iterating the change list under lock).

Thus tt_diff_len could be bigger than the actual changes size that need
to be sent. Because batadv_send_my_tt_response sends the whole
packet, uninitialized data can be interpreted as TT changes on other
nodes leading to weird TT global entries on those nodes such as:

 * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
 * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)

All of the above also applies to OGM tvlv container buffer's tvlv_len.

Remove the extra allocated space to avoid sending uninitialized TT
changes in batadv_send_my_tt_response() and batadv_v_ogm_send_softif().

Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2243cec18ecc..f0590f9bc2b1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_len, tt_change_len = 0;
 	int tt_diff_entries_num = 0;
 	int tt_diff_entries_count = 0;
+	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
 	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
@@ -1027,6 +1028,9 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
+	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
+				     tt_diff_entries_count);
+
 	/* Keep the buffer for possible tt_request */
 	spin_lock_bh(&bat_priv->tt.last_changeset_lock);
 	kfree(bat_priv->tt.last_changeset);
@@ -1035,6 +1039,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	tt_change_len = batadv_tt_len(tt_diff_entries_count);
 	/* check whether this new OGM has no changes due to size problems */
 	if (tt_diff_entries_count > 0) {
+		tt_diff_len -= tt_extra_len;
 		/* if kmalloc() fails we will reply with the full table
 		 * instead of providing the diff
 		 */
@@ -1047,6 +1052,8 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 	spin_unlock_bh(&bat_priv->tt.last_changeset_lock);
 
+	/* Remove extra packet space for OGM */
+	tvlv_len -= tt_extra_len;
 container_register:
 	batadv_tvlv_container_register(bat_priv, BATADV_TVLV_TT, 1, tt_data,
 				       tvlv_len);
-- 
2.40.0

