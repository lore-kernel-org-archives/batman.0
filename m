Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64527C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:33:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ED5AB8445B
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:33:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783272807;
 b=s/kmAqiBOxRTelqtPLHTR4tbLWy/D7jQFwAUFTRvCmTxgIPnuNwQZRJuHM0jFdO4g2z6b
 UUeC9naMGVe+cbc9nKL7WzbQ6DEoy/E7vnZgBAjLTsZEUkppWBaaPZLj8E9NIVKyDnwnOyL
 Ysb+l/BIsDRnW4G91AUGDJ3/iLfUgvo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783272807; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hYn0K9W1Lnf8OIGbjCQewduNXimhqnai/T8Z/Oq7Bys=;
 b=1oH8afq14yURX6p5A8T/t0XCOo5IfWgz5MS8FyDeUmM5QCJS8jvamuG5BDrMDDUIU1BGr
 FdEbOvcpMzqDmqhwa8kt5k+nNZOuybVZdMw5inXnqSw/jaBmn+/NlN2wNL4xMxTGVGTbNNB
 Z8CTzHRQ4vO2nDZ2md5pN3JQn74JZVU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1F2A7810BF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272619;
	b=ku3cAPgU2SMMUfrg5HLbUT7p5ei1Lmp3KrobkMFja8FExgiz4BzKkilyzJ5e15rrYxvYYW
	fLtX0uhsEGiEgSYN8pEZ0jj0Z7An0xErw1HRIvOZHus7S6SrEO0NGD58rgYpwfjcGnCY2p
	RsBdi6FcmlsyNIkIO1o7pDeDepVKlQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hYn0K9W1Lnf8OIGbjCQewduNXimhqnai/T8Z/Oq7Bys=;
	b=Vmh0IZGsz1VIJbtRseFCwTSKXel7cxeTD4aM06axlcMheUIs1uO7vAgM0V6K7A7jQjR7Sc
	95qBA6Q0VWtnjwzTyhOJ4WSaPG3UrUdT4wHD7ZSuueDAmsFb7bijR13++ghgthGYLWV26W
	DhYUQCp2goh97UE3zH3Grc65+iO+/QU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0q9BMO4B;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D47F51FEE6;
	Sun, 05 Jul 2026 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYn0K9W1Lnf8OIGbjCQewduNXimhqnai/T8Z/Oq7Bys=;
	b=0q9BMO4BJEKI4Ie+Xmu37ajjD7DAM8U9Jy29kXD223dknJyC2nqy25aaiIc/uSGaZAC+Pd
	G+/AuMuCHaGE6MuAqqKOypiVqGQ33RKZEOu2N8JF1tu+a/h0K9yIjp4g7R04oLl2yKvD57
	RoD5dq8BFWg4+RkOAEynij89Jm2qNmk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:07 +0200
Subject: [PATCH 4/9] batctl: tcpdump: resolve bat-host name for ROAMv1
 client
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-4-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=sven@narfation.org;
 h=from:subject:message-id; bh=SCq/ZoFy/p4iqu/0WJ7mqIc4urGpPWYRknx+JHq+9yk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+YpFgozL5qqpatpO/GvLwuz0a0ggzPcmX8EeO3fn
 tm/YB1TRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiYasZfjI+aCo45/fXMikj
 sK463tn9zY/0X1KX+AsufYvTT9Xs1GZkWK7N/dHdKfMP68o2MfEJmtp5C+wtV9iXd/76Yut4Ye4
 5LgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AYGQBJQVJXCKY6QZ3ODIQVMDHOCEVWWZ
X-Message-ID-Hash: AYGQBJQVJXCKY6QZ3ODIQVMDHOCEVWWZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AYGQBJQVJXCKY6QZ3ODIQVMDHOCEVWWZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Every packet parser in tcpdump forwards its read_opt argument to
get_name_by_macaddr(), which only consults the bat-hosts table when
read_opt carries USE_BAT_HOSTS. This was (without reason) not done in the
TVLV ROAMv1 parser and the NO_FLAGS is hardcoded for the
get_name_by_macaddr().

Just forward the read_opts flags like in all other functions to have the
same user experience.

Fixes: 4c39fb823b86 ("batctl: tcpdump - parse TVLV containers")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index b6305fd..b01581e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -202,7 +202,7 @@ static void batctl_tvlv_parse_tt_v1(void *buff, ssize_t buff_len,
 }
 
 static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len,
-				      int read_opt __maybe_unused)
+				      int read_opt)
 {
 	struct batadv_tvlv_roam_adv *tvlv = buff;
 
@@ -214,7 +214,7 @@ static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len,
 	}
 
 	printf("\tTVLV ROAMv1: client %s, VLAN ID %d\n",
-	       get_name_by_macaddr((struct ether_addr *)tvlv->client, NO_FLAGS),
+	       get_name_by_macaddr((struct ether_addr *)tvlv->client, read_opt),
 	       BATADV_PRINT_VID(ntohs(tvlv->vid)));
 }
 

-- 
2.47.3

