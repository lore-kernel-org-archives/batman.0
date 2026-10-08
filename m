Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8848DCA600C
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:54:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BE0EE8408E
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:54:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791474858;
 b=oqRXBw4NaJV1V3bTbrmWCeUxIOI6DzivPsjBV/qetwICp7ufjKDJK+wTZ+0vf70xJQkcg
 JvHnFzBjq2jqCLV0FQfObrLOGwd/LhQzuu+U0HE5U5xqCYtQ/HbzJ3ZDZIC9gvme2JvWNCL
 J/cOjkupDS0h/5TmHWxqZMVt/8wNWgg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791474858; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jkXQV/IH60hAjhMJa7Lfq2OdT1aLmfxSza7MhKqkLl4=;
 b=rzgZUGDWNGN48ZiIrMHvV+mUMYmbPuVS47mkcXl240dc97mRKq7FG4CG2M6Jp3sA1w4pl
 xGnudWAXHMMA9Ln6FEUtr9XxXznF6/bgZJ45QKwXHsndU/0hzfjuslSe3Te43G3VFWHzRbm
 y1ciZ6jI5CReSpmYXFnwNu5xZ4EB8PM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9FA9584230
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:53:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791474791;
	b=wB6IK+eScnbL8L6uRjQKqbKWPnEWDFTzpW0z2vd1B+eEhizdp/+bDlmCWskSg81gl/kudM
	j8e8UPfs+FQSrSdlSQa/UuhAk1FdUGtwnKKr9MxVswXcnZbTbHmaoNbC5YcKeT7bP34x0T
	3MrpNtPbaK5NByEFdqvJwo1nU1swu7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791474791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jkXQV/IH60hAjhMJa7Lfq2OdT1aLmfxSza7MhKqkLl4=;
	b=JfZOV6V7jyZ0E6rbnKdM5EZQzwlTt3F5V2WLb80IqQHOOtL4jn8tvzFaTjQGS5b53nQkaq
	2o5Pd5OoeySpcYwdFFf2EL8NS/Yffu9IumQf341dWnqaenO4S72ae/gOSUMLl8nLk0126c
	Xsbz+cMVNXLko6+L/0z+yQsu+kazTUg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uXVJaP8U;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4AF541FEA4;
	Thu, 08 Oct 2026 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791474791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkXQV/IH60hAjhMJa7Lfq2OdT1aLmfxSza7MhKqkLl4=;
	b=uXVJaP8UngGSpk3yo5NrWu/9+fVVMKVt9j6j3lVqN14qLTPigsK1leNmtZzWi7lS7+by/P
	eRqzrepAoB25+1sMQ+IJnFc12Eol0rr0N2sUQMLB70bmZFcVr1MdPhXIPfGetnWXkR14Yn
	ZGsWnbngiLNzft2G7Iz5h+q3JLpW1d0=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 17:53:00 +0200
Subject: [PATCH batadv v2 2/4] batman-adv: dat: increase hash generation
 when purging entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-hash-generatopn-v2-2-72b61e956a81@narfation.org>
References: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
In-Reply-To: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=sven@narfation.org;
 h=from:subject:message-id; bh=h5SIr34I6njwD9NMgxkV9FfMo+ySo1Xu/przaHsoccY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH98R/tlooevjDdcd5rG6rfjhI63jtPdl+aOtf7dWTQ
 vQmMjS+7yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZMkHRoZz4h4bH5jP4377
 sPtNrMCcdTM5ospXfnjPcu7o45RFyr4pDH84zkz7Nd+/osTglGvRza1Z5dc4i59uElJPX+y4cdK
 SJn8GAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GNVGY37TYPKKQF2DQYYAUDGZJ6LJJLUR
X-Message-ID-Hash: GNVGY37TYPKKQF2DQYYAUDGZJ6LJJLUR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GNVGY37TYPKKQF2DQYYAUDGZJ6LJJLUR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If batadv_dat_cache_dump() is preempted during a netlink dump and resumes
in the middle of a hash bucket while __batadv_dat_purge() concurrently
removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
Fixes: 0f2cafcb455d ("batman-adv: Add inconsistent dat netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..5e78fd7f 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -247,6 +247,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 				continue;
 
 			hlist_del_rcu(&dat_entry->hash_entry);
+			atomic_inc(&bat_priv->dat.hash->generation);
 			batadv_dat_entry_put(dat_entry);
 		}
 		spin_unlock_bh(list_lock);

-- 
2.47.3

