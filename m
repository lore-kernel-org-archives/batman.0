Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC6AD68BF0
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 21:37:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D1D6484221
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 22:37:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731793025;
 b=bY91w0XHSnf+1HrnnjaxekxTJ30vNB7+G0u+EUw6P3p6mykcrzTwSZjSvgpEEiWJX7M3X
 tQ/xqdpeUFphFSVBlErxhRx5i5T0qBGyCjVSCsUsw8o/eGjdAf9u9wulALVQHiiY0l4WaZx
 MvRf7wafk1u1cigrToSq/ozJu0Uv3Bk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731793025; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=43KYER6I8y6+KDVjhT8DcGdKRHWYM+yH2KqbvaTh15w=;
 b=rwQgaD745S+hP16klktDtSFNot9q77B/CZVKzu2t/idF+4Cgvu3YzeVVnBCFXt/uXCX0/
 osfXsd9KEKBXJQKlazQ8EzL52vYniDTRh1iaGWTW8r/2PLSqpkNLBvKfllF50XEn3LedfXb
 i6rdyp78BTLVjyxzd8W2l7gcq/U8hjY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A3D7C81CAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 Nov 2024 22:33:18 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731792798; a=rsa-sha256;
	cv=none;
	b=tnp1Tq0fxBRoUfDOVbGTJSCGDKQ2JPn2ozLCZSKG+/Wp1Doy5lBESPVwlIqeJy2paMfUeq
	CWYJIL2seyinykz883kTSRMJm6AZYd9Y94Radu5BjZMfMHNIwa7fPrdO36ABAvHYLjRph2
	NIj1WmzjXSB5twRXUMHYvmGuoxhHEPw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=Kep0kfeo;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=m6Fx5uFf;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.44d0dmh5o4o6wf1=70vy3344f3mg=tzwf63jik5f86v@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.44d0dmh5o4o6wf1=70vy3344f3mg=tzwf63jik5f86v@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731792798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=43KYER6I8y6+KDVjhT8DcGdKRHWYM+yH2KqbvaTh15w=;
	b=wzPKbCBknjEbFTbOXKLdKg4TxopYEZtksJk20QcIwcpTZiupmKUaT3lTf+99ATcXDbPEj4
	YuvirRGuOnoSDuNPhycPtey0x3cfpliL5rgaG5DesL/n+24Xo0xO2o92cN25IQc3EYQwBM
	tNPbvnimY0RRjBKIfll9Cakm270WfPA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1731793698; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=43KYER6I8y6+KDVjhT8DcGdKRHWYM+yH2KqbvaTh15w=; b=Kep0kfeoTktifyupMRdwsGi2ck
	XEym3oIzTdlqRkrkVOi9pmKe5HmUneMIo7LeKrXkG5fLD1gGGZu94zT1i1cOrCEsxfRmVjWaL9DLe
	EpidlkfaTxMSw9thxgx/QpmnpwqP+qUL0O6wQTdbu6yGYZz7FvKW+VVZTw1kgbWoxiTfYFRhQXhI3
	HaDiIxDN1B13tO6Bb4B/0WQwFpODC+5kiWVA+LDq2V5z3Y1P8ty7htsfFWLdGDi2qZqQtxcmnuY0v
	25VlGCLc2qqlgLM/al2CoATEJ0uNShylwJ8Rrb5H4qwpD+R+AR7+kG+kvfHOjlCxvCt7jNoJWdI+z
	b7QzQB1Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1731792798; h=from : subject
 : to : message-id : date;
 bh=43KYER6I8y6+KDVjhT8DcGdKRHWYM+yH2KqbvaTh15w=;
 b=m6Fx5uFfBnbcUm6QQpLCAlnbyAlRxejujY3XuPC0TyrmCsVpO8SifROlknKVE3uuol9Gn
 KFVtO3/ljhgVd8GOFUXuDp8LjyNyJjBikYQRt/tR1tMww9FQN6tjgbwLdcCHbAI9CYGeak0
 9636TtlvD0lE0wRyo09tkNtx5MKLICnG4i6LruLMI4w0t1b5q3oDdxqh7yWbb1AxWLkeN7G
 j+cfsL9nU2QBYD9WxGgl4q7JzNIoBJ9QXINl4+3iI0QHcZHHhLt61wKR4cUK7IdHfxhf7Bz
 c3HgW9DltUDZNoEH/GRSKVDK91X2+D9cAUNwR9kBgYPQ9UGQthgB6jfcOU4w==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPt-TRk4No-O6; Sat, 16 Nov 2024 21:33:17 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPt-AIkwcC8wlDZ-If9i; Sat, 16 Nov 2024 21:33:17 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 5/5] batman-adv: Don't keep redundant TT change events
Date: Sat, 16 Nov 2024 22:32:09 +0100
Message-Id: 
 <1c8b34d63121834bdf6d39c7ed1447ae3536be7d.1731792497.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: A1B8Ibb72XZm.7RhoyLFUROi3.ZMViRglZKnq
Feedback-ID: 510616m:510616apGKSTK:510616sgQ0CG08HI
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: QISVSSFCS5CZBYSIV5SYNOBSUM7ST257
X-Message-ID-Hash: QISVSSFCS5CZBYSIV5SYNOBSUM7ST257
X-MailFrom: 
 bT.44d0dmh5o4o6wf1=70vy3344f3mg=tzwf63jik5f86v@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QISVSSFCS5CZBYSIV5SYNOBSUM7ST257/>
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
index 39704af81169..2e0e71845df1 100644
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

