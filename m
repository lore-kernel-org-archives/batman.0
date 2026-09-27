Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D88EC9832F
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 15:23:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8AD41841BB
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 17:23:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790522621;
 b=deZdgv+rWOwwl0k6CO66P2262cILLCv7qHVI92p5RQfqAOtskYl1WQNz18AWe38jbjB8H
 geZ2pabTm1BThbaxpwDBMiCoeu6GyuQrn7oQ22j3hFiorjd5UoUrKV4SNv4XIte95O6Gxe3
 ngPivoBIrwywPGfjgHoh062l368FEeA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790522621; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EktGw4enD65pPY563T9BGOeNMe73ZF2aeoVbosEdboU=;
 b=EDFPhjlPmqmjLw9CAyc+RVf4Q7PUeR1cbEEpko6OVW5qko2oAS7ayJNgmKRlQHY5XJn6R
 /OKemw9HqiFgLL4RyOH3qmowduc3waAGLgf0fPkeTHA3eRkBxSBlkRwi5P8tOgM4QZ+yFE2
 bZsJJ8Oy/vPa8JGair5NmL1B+iEcQ9w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E31D580C88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 17:23:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790522611;
	b=X7LupqVw0VpyUFhG0hDVVvMcw28yJ4nhEJHzKWur2xwZ20beSwtONsamx8kX2D+5F8C1G5
	iXoq1Zv6AhgpZE6IG8EskRD1DpVzeM4aWKprSCLQtrjb3NMGF4/Lu95bnmxmwZFAqzhKiF
	L5uwlmLIaXw9gKkz0enZOtkaeTDHEUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790522611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EktGw4enD65pPY563T9BGOeNMe73ZF2aeoVbosEdboU=;
	b=XO4yo4+bK8g2Ux6WVtXOKitQ/YlDnGCeUzUvTwqzlOWgDTMOsJa/wbrfpvHe34XYqgegMI
	a9z47k89VT33A4EEuUg8OtI9uJXVCN7WByLnVGgtE7Ctkm+/y7MC2PWU2o8UvM3Y/0o4j1
	2dT0qEO9vVci8IZC7/0VfMN0s4aIRF8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=al71kINh;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 7B4721FE24;
	Sun, 27 Sep 2026 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790522599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EktGw4enD65pPY563T9BGOeNMe73ZF2aeoVbosEdboU=;
	b=al71kINhWC4JWfWBBMLX5A2gj/UT7LW1Qji/apdNpaTqO8CsPHXe0/5AcIVmN9dWU9ZbD+
	If/FV439dRlg54dIVBOldfz7ba9hJGpzobZ90+mcCqO1FJgqrc9kZXPpvRHZwwpGm0hh4f
	GPXQnxNqKAQfBDR9j1cib58z7+/PBD0=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/2] batman-adv: tt: improve pending/CRC handling
Date: Sun, 27 Sep 2026 17:23:10 +0200
Message-Id: <20260927-tt-order-local_remove-v1-0-8951549e4a38@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN40uWoC/yWM0QrCMAwAf2Xk2UAX3XD+ioh0baqRuY60FmHs3
 636eAd3KyRW4QSnZgXlIkniXKHdNeDudr4xiq8MZKg3g2kxZ4zqWXGKzk5X5WcsjP0QwvFA1FG
 3h9ouykHev+8ZRputL3D5+/QaH+zydwrb9gEhnugigQAAAA==
X-Change-ID: 20260901-tt-order-local_remove-69ff84225253
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=sven@narfation.org;
 h=from:subject:message-id; bh=LdQdk26cFDiWlN+vGRQPtA+q/yxOG1tHQjUG2v2t9hc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7TR5vybv9sbvDd82alnXLw9dnVLLz89yrzmx888qJ5
 8VDj3nvO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATcZjJyLDlQtiLlwknu0sj
 tYOK922OThNhW+asblWX21nvWVBWwMbwP6Pln8aTrzGbyjvCrUS3+JybqLG8QkwuucKhzUxI/fp
 fZgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5LUGYST2KO5LBEIUCWN5VM5Q7SCNVIHG
X-Message-ID-Hash: 5LUGYST2KO5LBEIUCWN5VM5Q7SCNVIHG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5LUGYST2KO5LBEIUCWN5VM5Q7SCNVIHG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Sashiko complained in
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
about ordering of the pending flag and CRC recalculation handling. Let us
adjust the locking/order to avoid these potential pitfalls.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: tt: queue local DEL event under bucket lock
      batman-adv: tt: queue local DEL event before marking entry as pending

 net/batman-adv/translation-table.c | 95 +++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 33 deletions(-)
---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20260901-tt-order-local_remove-69ff84225253

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

