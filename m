Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF83CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:29:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4FF6A8442E
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:29:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052191;
 b=DftfXN/3IBHcGyFejNmMWo76e9vFyCExGf415KJZGfrQpiAo0oFiRD8ZSbNm6i4yGyIDY
 B+sOdaSRP3rDQWzeMRWmAj9WtzwYAJekANrr+je9TUi2ijmSA8pQeMK+hGQevEnhzyOcJme
 BjuyaJ3DJnIjCQ/hBtWG8yLCJgRKCvM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052191; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IkFsw5uDtgwNRbBaLKr/0cp6vRnqXWvYfsLu5FO699s=;
 b=Dt8PlEoCRhVLuhBo3w57kZjPKFbA1iQUp4fBDlNN22Oz0GlGY2v9ZU5nQZDSGCheXpGrD
 UEaC4P8q9u+9aLGmCmr0ksSs0b7fZ+2aJOS62oEpPFlRmM0NvbbjqayCdA++xjOIQvR/qUR
 M6WhlefigBhBSAiyL8o7zerh9h7rAFs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1EF3D81125
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051897;
	b=x/WicKarQyIR8lssfqTW54fTbyIEvnxmlPwu1RSAY6/KVQ1hUEGxmCkAL4+Q8wS5HAI5D5
	qHD+yu1a1eEAdmim+8rxprIIJAwyFRa9HhkTymVLqpvRDQLpAQGSkg5QYEOfQIKvygjmsc
	235REzuDs6pMx82qYsIGpB0KQEDkA84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IkFsw5uDtgwNRbBaLKr/0cp6vRnqXWvYfsLu5FO699s=;
	b=x+GK7TiVDvvmO/2iA0Q9F/9qZwCwUUKAG0y3dxAz/5wkUpkcV5gG0cJxvoSAaxG+lH0qgP
	KcIYOSmmj5ZprNqO6QjVHz3ba8xAXjc73sbPDpOEctNVm2W67gxbbFVYkL4deWJHjd9yHv
	kiV9NIiqyTs0Y0YuVFfFv/H3QzGO8SA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wjDMpdbg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CCAE220059;
	Sun, 21 Jun 2026 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkFsw5uDtgwNRbBaLKr/0cp6vRnqXWvYfsLu5FO699s=;
	b=wjDMpdbg31RBi456Q6D0x3m6Wm93BqfLPe1wAc3cbeWAgMQ9lVdyb+iZJfaCfQKHaB8qZg
	+yAXyy4lFmZL889sGxZGyaiFpGIPuy1fwlixPhB7HlGksO7WfYWcLgkVsoQ/gwMP4TaZ4W
	Ho1TqAYVd7YR/uIAiKAzyCI/O/ch5SM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:57 +0200
Subject: [PATCH 07/28] batctl: ping: count sent and not received pings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-7-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=sven@narfation.org;
 h=from:subject:message-id; bh=8LnwiXHKuxUIYyyeSkYrJ+KnhUF6Wo5jsOCJh8bXBeg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1gzzZleObFMuPjv/ulY5apXRlWRT0TdrpQc/Wiyb
 2p07CfujlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBERF8w/K8zmVxr6Huskm3H
 vWv7gxdfzW4pfGAleYZJ7u7HH2UsiXMYGXr6GJz0BOzELBUdrq4M5Ld9N+P5Eudfm1mKldUv9n2
 O5gUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HT7VJ433CVFTVRY2VWJBZOTG4Q5DKHJA
X-Message-ID-Hash: HT7VJ433CVFTVRY2VWJBZOTG4Q5DKHJA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HT7VJ433CVFTVRY2VWJBZOTG4Q5DKHJA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

packets_out was increased whenever a read of a packet was started. But the
read was repeated whenever the sequence number of a received packet was
incorrect. The packets_out would then be higher then the actual sent ones.

Fixes: 2474249a6312 ("[batctl] ping utility updated to latest batman adv")
Fixes: 2ecb2c8b060b ("batctl: tr / ping - ignore packets with wrong sequence number")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ping.c b/ping.c
index 4dbbada..98a4570 100644
--- a/ping.c
+++ b/ping.c
@@ -207,6 +207,8 @@ static int ping(struct state *state, int argc, char **argv)
 			goto sleep;
 		}
 
+		packets_out++;
+
 read_packet:
 		start_timer();
 
@@ -216,8 +218,6 @@ static int ping(struct state *state, int argc, char **argv)
 		if (is_aborted)
 			break;
 
-		packets_out++;
-
 		if (read_len == 0) {
 			printf("Reply from host %s timed out\n", dst_string);
 			goto sleep;

-- 
2.47.3

