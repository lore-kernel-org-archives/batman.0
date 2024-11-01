Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C007FE6F092
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 22:07:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41B6883ED4
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 23:07:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1730498831;
 b=DqrGWH8CvIFmX6qcJq+uzI8fyZRSzRT6s0VzklCdjla3x1nSEIIv8qhDrwm3mRXGpok9x
 0VWQI9zMF3t33GSQ2s0xP4Icjp8anDknwanehmNkbHUPa1f9vh4V1LisCiCsjEcxLixUFzk
 k2jaPGAPDZYEX6AwcCdiFGnkB7pi9nM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1730498831; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IveEP2X7jrTAvWzb1q0J/x29KcGWnCG2VYMO6ZpjbgQ=;
 b=HnoiCnw3R5fgX/1naoaz9OD5X0WF6eabUCNCZGSSgp/R8NGYdIMTqigpoFvGaOCUNKc8K
 IwTlO3xtWrG0PT8Lw0ycXMkN5Gpt40yjaB5effPv6fwJsKaztyx4ilzI2psYO8iyuLsrXot
 9kwcENBOAKM41dDCoJA93622Zn6c//w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B628282714
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  1 Nov 2024 23:05:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1730498742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IveEP2X7jrTAvWzb1q0J/x29KcGWnCG2VYMO6ZpjbgQ=;
	b=o/IIfehEFMnCEQfiUXgEXLHDO5tl5BY8vKszT3o7h2uizNWsTWTZs2I16VO0Qu1bKQUhxG
	vxEFbTiixapgZMbnWC1G8GSRLBnxYGP+61lZXP2D3xwQ07uyHOiRLOukJzX7wdgWu0a/LA
	mRhq4jyRE4LqJiE9bcFrpizQaeVjmjc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1730498742; a=rsa-sha256;
	cv=none;
	b=voeKhKQZxTBCu/hULEvMzduDb2G79PFXOVI0HodA4su8AIT1nYsPmmKkrbKI1BEw3t7LCF
	ecgQdjaGDim/Tar8zyDPpxlMpda/rLhax3Miay9HRauZDfJzmwLSs+SumOuyNM1ygGlV+T
	HAJIDP3bo/lu9576OKC20p9c+Mt8TDY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=S48H1QBa;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=mMSVimqb;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.f30wenro0suazq2=gp4qj95lt7yr=h87uajyvzy7zwq@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.f30wenro0suazq2=gp4qj95lt7yr=h87uajyvzy7zwq@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1730499641; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=IveEP2X7jrTAvWzb1q0J/x29KcGWnCG2VYMO6ZpjbgQ=; b=S48H1QBavrav0E2ePInhF7lXUl
	yfmAjcAaaR3K1YlUSCCseFSphQkxiQRgTNbuNb0Ou2wXoJ+bPM+qT7pJa4x3Y/BYedc8Iov6xlkoH
	cJZOb8KPiRH97d10b7SFX164FcX6SAZ0bHEuM16NCQBBIGOs8gDnJrHgdBx8SPfokPgdK52GjkAne
	K10buD4VM6iLH/WWiFGP/tX/Mq5l2QSb6xsSxhKHTsy82M6bwiAnwid7MQvNGPE5i01kUvT119x31
	858da/5FAlnWuJ9252tGcnFjBOw1C7UQs2RVibharsURryU6hHEh0nrwFgQJb5CNIrI1Db9sIr2Dh
	g64qI5hw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1730498741; h=from : subject
 : to : message-id : date;
 bh=IveEP2X7jrTAvWzb1q0J/x29KcGWnCG2VYMO6ZpjbgQ=;
 b=mMSVimqbixBaBHY/MTPT6ChpUNFT6rlRCYNVLsCoRCiHSJcIg0LD3bAtW2drwj1MZdM1I
 +cLmTvxgTV0LdZT6vtEin2uo8QL8Kt17GepuujHoJz5R1wILn+DLyLY4KFCiHwlcFgihaZB
 Tv7Ef3JNjhJ0iV3nid2w9prpW7Lmr815Bk/V0/A64XZNxUOxkhag7ZiesKlo4cHG2mArPys
 fSURhofKOg3qscADZAitlYViBc3IlVtYohz+x/KGOU4evRwR/TGX1H6jUei9P7iqr9ChBbI
 AC2bENYb9nnR41S8fcJ3QvsivqlOPY1cAcXpXiE270A/frzA+N7207FM3vrQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm0-TRk4kD-Hq; Fri, 01 Nov 2024 22:05:40 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm0-4o5NDgrqMzl-pUqN; Fri, 01 Nov 2024 22:05:40 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>, Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 2/4] batman-adv: Do not let TT changes list grows
 indefinitely
Date: Fri,  1 Nov 2024 23:05:00 +0100
Message-Id: 
 <2496501ec84ce1b33abeb868c038eec782fdb907.1730497875.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1730497875.git.repk@triplefau.lt>
References: <cover.1730497875.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: J6ymRoENXzK3.c7-xBgp4Y1nn.NEeXiQJr3K8
Feedback-ID: 510616m:510616apGKSTK:510616ssW2ct_rvu
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: BBPQDLEAS62U2JQ7NCPOSLDZLYOYGDIK
X-Message-ID-Hash: BBPQDLEAS62U2JQ7NCPOSLDZLYOYGDIK
X-MailFrom: 
 bT.f30wenro0suazq2=gp4qj95lt7yr=h87uajyvzy7zwq@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BBPQDLEAS62U2JQ7NCPOSLDZLYOYGDIK/>
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
index f0590f9bc2b1..50af82e7b50a 100644
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

