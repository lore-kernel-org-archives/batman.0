Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74689C43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:47:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A7B258403D
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:47:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450030;
 b=aSy4iiTUpn5JfvuOE5yMZuS20Cww2cmzAzRxXM4Ch3tSWXb5/CPMPENwm7U9PR7ign03D
 GpoaxppYITC1eu8TVz1n98fATliPEr1OKLYxLs8UY7ePrvf6bKeixaemtZqt/zCMYTL09lS
 caKHIgVxbOzjcJ0MoIBSMNUkBm3xsf8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450030; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rCF4Nj7j6MccVQh3k1tDqJNozvQvX6d5n8wC4iBJYaw=;
 b=edm6qRTY0Ti4Q40qtgBK9+5B6Wk7tTZXjtUSYI+nwO14s7mWuVGZcDsutNPVizIH3EO0y
 MwnKNG9th9sePbJHmKSY3Sk0MwTa75PwcMk9Nr4bL5RkHAoFJcsB/pRl3Uxsb4S02AqzvO1
 MTn9fCpT0J+28AY+Im9QYZ6aj6YYxzQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2E9C580C7B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450020;
	b=DzQDdB5lFWVwIyw6aTfeCYJbp8FSFCajPGZXAsBf+y1cEzRgX6bEHCFkmnwsEVw5xgoTtY
	QWf78hBB5R/oxepeZCDZkFlRC4trbcVRt8hSwBWxvifDGmK1eq8JMOc/AH2ZNoYdUpvesd
	BVwaLeG8F7hb8Q8u25x2UuzBIuV/3Ow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rCF4Nj7j6MccVQh3k1tDqJNozvQvX6d5n8wC4iBJYaw=;
	b=laoptigOgSULMWyPQriDFaVE0nbw/Ti8z2qdU+OTwhTN5ZmUy/7XYyGUlDDWUchbDOzXkO
	zYU8DkHsJU5LueDo6kd0moSDxKavbm89qTqxha8fszFL2d5YX0+3zX+d7TvaOqghtJmxAA
	lW84IFCQWvE4SuNrheTN7cJZ18he488=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=V0jSiMjf;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7AC2C20636;
	Tue, 07 Jul 2026 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCF4Nj7j6MccVQh3k1tDqJNozvQvX6d5n8wC4iBJYaw=;
	b=V0jSiMjfRCcpS32bOSTMGlzKpwyIgyQsO6ap2YC4yZA7x+0SNKYWaPyRqhTCjc2QPq7VFx
	8zr52qJJryHykVeQpHYaqiJcxILaic8acdSYS9VOyrUtCK2hUNHWLxQKa/KQ4B61peALgE
	O6J4NHAesHSkAtKyoVxLY1+fSP+tzeg=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:45 +0200
Subject: [PATCH 03/11] batctl: ping: count sent and not received pings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-3-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=sven@narfation.org;
 h=from:subject:message-id; bh=jlrUU+4i1tzsxI282vMtxiuvE2eLkmZLVEBhFKyCeCI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+nlPvPuputZ0y5+m6pW+W+qQe5Ytk9P9d+8lM7PzK8
 iDeyWnzO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATOXqakWHqy467XKcXsvz1
 CJnyyLjN+qXls7O652/yBDs+Xa5+LkyI4X/sg+ygxfGtn+a3bA1Z3u71ecpspic287YdEea61/O
 rRokPAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 33DOBUUSIXMA26RWAR3SXHMSEBQMGEX5
X-Message-ID-Hash: 33DOBUUSIXMA26RWAR3SXHMSEBQMGEX5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/33DOBUUSIXMA26RWAR3SXHMSEBQMGEX5/>
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
index 9eb73c1..5eafdad 100644
--- a/ping.c
+++ b/ping.c
@@ -213,6 +213,8 @@ static int ping(struct state *state, int argc, char **argv)
 			goto sleep;
 		}
 
+		packets_out++;
+
 read_packet:
 		start_timer();
 
@@ -222,8 +224,6 @@ static int ping(struct state *state, int argc, char **argv)
 		if (is_aborted)
 			break;
 
-		packets_out++;
-
 		if (read_len == 0) {
 			printf("Reply from host %s timed out\n", dst_string);
 			goto sleep;

-- 
2.47.3

