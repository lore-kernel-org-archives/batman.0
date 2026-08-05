Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE73C55ABA
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:10:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F217283443
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:10:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942607;
 b=bwzQp3gu4U3oBMUkPeYmdlFjVuf4vDDeL3+CH887X6/qXBgNI5Q9m34evIpLr9F21LcQI
 pbjJw3DWvjUuWozCcJaLnqQjsia/ybkfPhYAerw7O9C/6awHYwkl4QetxP8e9nt6Y6vLuM9
 iTEWdLGiCQLdsX6OptMveAfHwP1tCnU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942607; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bRkFro8mVn2n0AGMzh8rNFlUksfWTas3iD926F07yqk=;
 b=2omL2oB6Fcse5urJ2cchhgYx66i/zVPXGgnKO/HnzFpVKd3x9ENW894tKqbCUuHRpSTV7
 +1iaHPZA355Yp/jJ3lyHcFgc7vIZcrN+eCOliWaMWgvROlIiLpSN5JfZUrVVrOmzynrNw50
 +75Vq6s+TSwS8AqhWe67E+UzBJooxVI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D90FB80E71
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:09:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942590;
	b=sj8VnQmTj/bVIZyqW3vT0TPc1bCAfOu+jXN8skCJPUa3KzuQDN8eYajcawSay2aJ5G18AL
	JfI1aOzQW3vMkWr4s5534C0PwtyOB4mGuSPFfC6PMbNpAVZPGf+yVIwxuouD+TKr4EsZIQ
	oTCjk8AiHpCDKmLIHP/f7nMU4tP86Z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=bRkFro8mVn2n0AGMzh8rNFlUksfWTas3iD926F07yqk=;
	b=2NTGDU7jQo5BBpfqWYk2JiTlRsbRBdLWdPbapvTWYWpH8bBCV+80X8wWhWopLuYWaepwbI
	1fzB+V0f5YekbGtigEV2x768kEZUCi933iAuSlH1SXMHTr1SAJnuTETvuysDBwwUJzQoqP
	K4ZDGm/DOFAO0vclPXzFheCUg08iwrs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xwjOjQHi;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6741620241;
	Wed, 05 Aug 2026 15:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRkFro8mVn2n0AGMzh8rNFlUksfWTas3iD926F07yqk=;
	b=xwjOjQHi6Wk4oB9vBN1k+Sp32gsHz4rIO7WQGVkTz8bkR7DW4OQPvkIu1KtMnlVfWbdrVh
	QnWgmgs3RJ8u6MrheQ+UjwbHY3Vr5SpalJOS6qEunRmYhs00Ec0cj/brJbx1PPglz7jJ5C
	A1Qjl4mLOiuNsl3fbPIVwEQcTJXy69o=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC batadv v3 0/6] batman-adv: tt: atomic sashiko fixes
Date: Wed, 05 Aug 2026 17:09:34 +0200
Message-Id: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5Sc2oC/2WOzQ7CIBCEX8VwFkMplOrJxMQH8Go88LO0eGgNI
 NE0fXcpHjR6nJ35ZnZCAbyDgHarCXlILrhxyKJer5Du5dABdiZrRAltiKgJjhFb94CArZZUCUp
 BKYNy/OahGDl9RqfjYbkpGaVJ6PK2w11dQcelbjF7F+Lon2U6VQX7X0kVJrhhsAVOueGc7wfpr
 Yz5zc3ou1Kd6AduCfuCaYZZKzRrrRZWs194nucXkw7wUAIBAAA=
X-Change-ID: 20260730-tt-fixes-fca2b722ebbd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=sven@narfation.org;
 h=from:subject:message-id; bh=mJnX4NrM5Ndf2FX0M5n8EKAQGZaq9PoIFj3KX97c3T8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFQSZKj1RPVWx2eH2u/rK3tKKU8e6gK1n2v/vNOJSie
 bgFT7R0lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACaito+R4ceh1bzcFr5qM0Vl
 zH5NmiWRtOqNuxlT9wbd+vu1W3XKWxn+O5teuiK95HZ6k00f+wnDpKWWC77/2uwiXCuqHzl9yxw
 lDgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BULCHEC4TFRJ7SP2FDDCTVT25WYWHUF5
X-Message-ID-Hash: BULCHEC4TFRJ7SP2FDDCTVT25WYWHUF5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BULCHEC4TFRJ7SP2FDDCTVT25WYWHUF5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were a couple of sashiko reports regarding the
batadv-next-pullrequest-20260728 PR. I went through the TT code and tried
to handle them and at the same time already predict what else sashiko might
report as next. I needed to change the batadv_tt_local_remove() hash
interaction as preparation for the related NEW flag (and counter) handling.

And the netdev maintainers rejected this approach (for now). I had to
re-add the atomic_t code parts back in this patchset. But since the netdev
maintainers didn't like the atomic_t implementation, everything was changed
to atomic_t with the help of scoped_guard().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v3:
- switched to spinlock_bh due to rejection atomic_t by netdev (and
  potentially easier code)
- switch back to RFC
- Link to v2: https://patch.msgid.link/20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org

Changes in v2:
- rebase on main
- add "batman-adv: tt: use atomic flag modifications" and "batman-adv: tt:
  simplify NEW flag transition code" because they are reverted on main
- add patch to extract the roam "add" code in a separate function
- make the "simplify NEW flag transition code" patch independent of atomic_t code
- Link to v1: https://patch.msgid.link/20260730-tt-fixes-v1-0-64e9e525d555@narfation.org

---
Sven Eckelmann (6):
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: use atomic flag modifications
      batman-adv: tt: decrement count for committed client on local_remove
      batman-adv: tt: don't uncount never committed clients on pending purge

 net/batman-adv/translation-table.c | 693 +++++++++++++++++++++++--------------
 net/batman-adv/types.h             |   8 +-
 2 files changed, 448 insertions(+), 253 deletions(-)
---
base-commit: 46e983472304d8875436a23ccb996ea18856081a
change-id: 20260730-tt-fixes-fca2b722ebbd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

