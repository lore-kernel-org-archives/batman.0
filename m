Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343BAE6F08E
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 22:06:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7000F83E74
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 23:06:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1730498788;
 b=0mywEa3Abkr/5mrgzJQUTVj8uODN4lEgMGkctfFhmB+LwWhpmRPbkS2/jFJuBGhw77rEG
 CGBuXri2ZCL03DYVp7yTlzYG2OARTQFpavXmDhuM3Kuzvl2adrGtIwATgjTh9XHYMrqIw6Z
 yHy9g6Xn6vFhryGHUbEm8q6lj4D3mfQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1730498788; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=;
 b=shiOGudDldqxNduCLzFe+L7WEJysO9IYWSyc59+9ADsZvsn2XK2e2oxFqO8C8bpiqxQlf
 0Syof3i/9iLv2o7sO7pmW6Aaj7mIa+NBKMDkWiJGzpX6SDrr8kKrjwDnOjIVRb3miNDtqBU
 eFpl5aaXNwK1lUB//yBpzCokX7eJ5Hg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 80A858176B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  1 Nov 2024 23:05:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1730498742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=;
	b=X4FlJ2kiW0XP5zJGy8jPuaMbjMQjuhQiFqEMsmgRjq+EKM+q2U9CIXxbZe9W0PcnmCG9L1
	NwWh/h+zHOFP5ACG0qvDfEgdEE0AsWRW0NQ2lRLKbPCVdyTz5UVJP3If7MUMgTUD1ev9QA
	VBhhfeQg4O8htIgUsLOU3M2+dXmKJbA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1730498742; a=rsa-sha256;
	cv=none;
	b=dHvXXUBvDkopRbMEC2kBEI/6Y+WzFjPXHM2ojU62pyv3ec8qp+BHEbXoXEpJDOFKtHSc5y
	MWe7zf1tT6WhGukMEwHNcIg35LLJDSQixWbT3/EYuogmHt33USQzgECTccb6LdF5JVxHBy
	ku4/t9RjGvZ/QAsJmI8jgMdeqGqsX6A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=Pzz57RzQ;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=O+vsLc+u;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.gd4j7je6im3lkx3=qcvergyup0pc=xe1qo0c7976jge@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.gd4j7je6im3lkx3=qcvergyup0pc=xe1qo0c7976jge@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1730499641; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=; b=Pzz57RzQnna/jZ1xvxfzSCTIKz
	OQ/xtHfixKFdiCVno1+ynYSWjYqxWtuqmKcJoreO5HeV0ZZ4W4aWCDp20DrkZ2RqZBnXoNpSH1WZ9
	se6A5ErlTzIiReMX4s30K9xAABqHBIiwUS2Rr+5YdmAh4+pSLfIkfCtvPs1bnxcH2l65mxu3KiUVi
	J8y9lHSJypEGHVI025+5FMg+tZS6vIz24drqY2wCxVAOpeXrRSN2/VW8V6CWziX7C153bZ6GbTzV5
	bX5ukOKasWLhFVE3xqA/4/5UVtgDD3PhXwPEUm/jul15bkezujFYrYc7AJ7sXl+WQlVoukxKrGyu2
	/i6jjdIw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1730498741; h=from : subject
 : to : message-id : date;
 bh=u6z1fpT89DJv+WCGgPTmM9WnXFPOlNs13l5DouQ0kuU=;
 b=O+vsLc+uePYsxRhM5chOWdScMNTHEFFJNOCUckjocff7wCq1oeoA6xFHakwaCQwUbaxc3
 HWrzHOrqX/EXCFInYxn3rrwwcifUcB/jMHhJg0Kf6Z7e8z3hb9qs9ISacigVaDS+WKbfokk
 qxWER96/ri+hEqsFWg1IBYJEE2UULs0APBJ58JE78LVUtezcoborsRk+FmeMFAOw6GQULHJ
 ayG3Bef1efeJwIZXKWu2p5X73a8cC7RgK1nRso0VtQog6BABKNmYc8yQlZSOsfiMv0JuINm
 BHGY8jyWg8V22PK0q0cRrLLrvOrdy27BOSzLWnoJTYCmQN7K7ANWQ+MwumZA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm0-TRk4ix-5M; Fri, 01 Nov 2024 22:05:40 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zlz-4o5NDgrjB2u-nxSx; Fri, 01 Nov 2024 22:05:39 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>, Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 1/4] batman-adv: Do not send uninitialized TT changes
Date: Fri,  1 Nov 2024 23:04:59 +0100
Message-Id: 
 <fbc17f32703930e711353d82146a916106acd2f1.1730497875.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1730497875.git.repk@triplefau.lt>
References: <cover.1730497875.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: RLBjiffkR9U1.wuq7D_IO-IM9.qPcCFwZ05i_
Feedback-ID: 510616m:510616apGKSTK:510616sEG0V39Zeo
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: YRZVZADUOHDBY2FMMQLHAFB4KEOZDSMK
X-Message-ID-Hash: YRZVZADUOHDBY2FMMQLHAFB4KEOZDSMK
X-MailFrom: 
 bT.gd4j7je6im3lkx3=qcvergyup0pc=xe1qo0c7976jge@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YRZVZADUOHDBY2FMMQLHAFB4KEOZDSMK/>
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

