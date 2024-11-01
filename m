Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDAFE6F08E
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 22:08:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B871583D3D
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 23:08:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1730498934;
 b=L3pIzqpLTOrv/WhCYRMkgVUzSnwpTJnQ+nS+Dpc6neHbB9Skq0woogGqURcj9fUoM/3r8
 T1Ul7UoGPEBR6blB6J88UbqcYQ8MV5LEjZhX73VqS2mo7KqfiBNR+wNHHKxKDVAYQydbd+r
 QKExsWJ4/h9bQ6fT3Hx8TcipPUvCxRE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1730498934; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vdM5SRDDmui8Is1rfSkI506zj3M7HuysI6wgSRgy7+g=;
 b=0+SOoxxyFvt8ChqHvwIB39HbpMjctU6U9pBwvwaQofYWHo4iaLeck8FfP8JAF3MG4SzIJ
 DE3FOrYuA3N/t3aVR+EzJwRkkqe/FIcW2H/yHRCiDC3240tguLAqXHudRAAaxoegA3GAygM
 ytTyiiPJn5GP1ZN3sJZbbsrUXSyzNz4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B53E483CA0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  1 Nov 2024 23:05:45 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1730498745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vdM5SRDDmui8Is1rfSkI506zj3M7HuysI6wgSRgy7+g=;
	b=3xfb3eUNbW4qlEA7+LAZUaQ2zzGvNWtlQbOcAKNUZgFkb9f5YG5zwgagsvyNXgVmPOV3e/
	4jUIZN//uipGepqtgD5+04Tew/bM2y2ym8uLGWucc4or3x21T/61U2tlCotw9GonJQM10Q
	yBaj+amCBCHIOFkR+fLq45NdeK5qL9s=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1730498745; a=rsa-sha256;
	cv=none;
	b=eCzTLjrRKnZSVHR8FFDuGdUmWF4pENd5mqGD+3POXWnLcoqoFx2xY7/gVxOyjGoYxumyYN
	2XU2654sp9Qi+YMcUcTZ1z4zzp1Eyezbcp+JG2TlYG2TPZWyH5xYsjYJdc1NpeVxEojTck
	n4KV3irCU/onxolIXecpR300qQoOHwg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=Ke0PcaDP;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=Pwv0id0I;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.aimj6c956hqfv69=j6um73nqh2sb=1kb40e8homs1e1@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.aimj6c956hqfv69=j6um73nqh2sb=1kb40e8homs1e1@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1730499645; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=vdM5SRDDmui8Is1rfSkI506zj3M7HuysI6wgSRgy7+g=; b=Ke0PcaDPFTOFvSXkV6Y5nrS0LS
	bW3NlfZZxLPmr50Z353er0JLOEd7KTnc3lMoabEEGI1eP6Gb35x8DknGrta4+2sLfDQ0gTxtFLh22
	/VNDDbTQqWYFdZ1w2viGgomGXqHttHg1+Taw7b58VDSq7fe3hkA/syhVI9A+G/Lj9DS1fqIeY5amd
	xrpMVDXJl5auJpcC4W2qggzwvvaHaP/BQl20foZdX+y7cNbBDi+FchghHvvt+vXH/g2/XJ+WBUP4g
	OGMTZhV+8LlSsqYOxbPv9ddG4RhfU0+vD6rTYI/2dpAQr8eJYPDBVZSSS7l4Rctan0BATrudMNelg
	kSjhPcBg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1730498745; h=from : subject
 : to : message-id : date;
 bh=vdM5SRDDmui8Is1rfSkI506zj3M7HuysI6wgSRgy7+g=;
 b=Pwv0id0ItEQmdBKDGDE8TRKCUNk8sX54+9XDLQMmq5hrFRM8rT44xUcO+vS/rrZPY2tSo
 SGByi/VSBUETVNN7iIkxjqFwlFvCs2sTaJYa0s5pN445AKwPDm1kNiL0ZnF09I1MYh64J77
 0llWotx652Kz/noSXx/EbA0DepD8Z4nQV1NAo+CKm/KvRD0MS8wal2C3OT3q59hzHx46nXD
 vJpzfP1HPwvR/mrHDVrsvYZUqJ0qpjbD02c1jbujLmpG0gLBm68Bdggfx4SyL3yLWH9PgB8
 B8Pbj0WisVT61/qMLRPNToVQkMsRcTzOA8BGFVzKl9wpNrd0aPwjjQAVHCiQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm5-TRk4zb-4Q; Fri, 01 Nov 2024 22:05:45 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zm4-AIkwcC8uxyx-KEad; Fri, 01 Nov 2024 22:05:44 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>, Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 4/4] batman-adv: Don't keep redundant TT change events
Date: Fri,  1 Nov 2024 23:05:02 +0100
Message-Id: 
 <ff9117253ce8e46744a459502a00ed607b86ce90.1730497875.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1730497875.git.repk@triplefau.lt>
References: <cover.1730497875.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: _u5XGM-cfz03.qkK9GQGsPJkD.6elkYwBhQYh
Feedback-ID: 510616m:510616apGKSTK:510616say1Vf6Ye2
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: HGNXTWVZMEGO66WNQ36MOAK5JED4LZJK
X-Message-ID-Hash: HGNXTWVZMEGO66WNQ36MOAK5JED4LZJK
X-MailFrom: 
 bT.aimj6c956hqfv69=j6um73nqh2sb=1kb40e8homs1e1@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HGNXTWVZMEGO66WNQ36MOAK5JED4LZJK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When adding a local TT twice within the same OGM interval (e.g. happens
when flag get updated), the flags of the first TT change entry is updated
with the second one and both change events is added to the change list.
This leads to having the same ADD change entry twice. Similarly a
DEL+DEL scenario is also creating twice the same event.

Deduplicate ADD+ADD or DEL+DEL scenarios to reduce the TT change events
that need to be sent in both OGM and TT response.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a22029511eb2..01fc19803304 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -500,14 +500,17 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		/* this is a second add in the same originator interval. It
 		 * means that flags have been changed: update them!
 		 */
-		if (!del_op_requested && !del_op_entry)
+		if (del_op_requested == del_op_entry) {
 			entry->change.flags = flags;
+			goto discard;
+		}
 
 		continue;
 del:
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 		bat_priv->tt.local_changes--;
+discard:
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto unlock;
 	}
-- 
2.40.0

