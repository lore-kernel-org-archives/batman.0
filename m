Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E30C9832F
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 16:21:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D5B51840A6
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 18:21:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790526116;
 b=stlgTIm9meh0NSRsgQnuYgbmOyfCUP54lXvcnuGa+eHRWY73mLomL9FlCe9InXEvPdjyM
 lSL97yiA4okXDhbWTVkPQWNAZH3dienXTdYqlKHPIeRD7IYW9mPt87+fA+OyVoxHBDnGhsF
 NDDp5I0OSCe2fe08q/uvT1a4npce204=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790526116; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+VC6LO4a+qVk8vfYxQLqftEzHJ64efGG9LUE2UOAQ9E=;
 b=ccGRUPrbFOhVwoXX7v1xw7/LR3Fslnj4WppCI5Q1f87MxFXQ1B44o4vqw/WcbHi3kYDXF
 L8W3rfqBSiro/mHNCfEF/oQlrxwfdAJa/yy/ZWqwNqS0XVrgrN6WiX1ewA8mXaUrfnBwyoh
 SEXbyVPsw8ULSo4iCrLoYEK65ZhCEWw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 91A80815D7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 18:21:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790526107;
	b=uL3tdcX9xxk+kjbGwhW0K1WvMNKupdWVTVZMUYhoe9l42ajstkZVd/LchEV2oS2gQz0x+a
	2oc6uc7A/DyWVGUdnhEtgrsschlfb+6uZvKUwaEwviDHXn+9S7ObAKVWgMe6a8QkdrKL0y
	BiNGdOHU6Ht53+ba6tIqXwevdvn9QBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790526107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=+VC6LO4a+qVk8vfYxQLqftEzHJ64efGG9LUE2UOAQ9E=;
	b=uCZcVuXLIY/uDueqjfOkzcpNap5p0qm2PNaYmUOgen/CBjufDgAed/Iyg+uhGxG1PoXL7Q
	Wy3lMXqaRhBBU0eX0ZwJZi94vUXyHgrS1jhylCfiPOD0Q25u/VnkxfGrYKgmHWxAiApbJd
	vQP5t6TFTCAuZ7u6nB2s72aD7CT1EZ0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=p+alRICg;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 036241FE24;
	Sun, 27 Sep 2026 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790526096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+VC6LO4a+qVk8vfYxQLqftEzHJ64efGG9LUE2UOAQ9E=;
	b=p+alRICgLEkhb4FF+Ru9TSdut7UvIddQGnFy6n9os3WK/IEzOpzW3pPA9omKDxhtvm+S5R
	Qnwa7zIL25uPxPOUD5V9buQa3OcUJbcOe2/+yfCs02NwGzH/nKtE90+thDaI3VKjmH5rJ3
	x8xnrFtfiJF6inyrDdkOmYu21zJIJOw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/2] batman-adv: tt: improve pending/CRC handling
Date: Sun, 27 Sep 2026 18:21:27 +0200
Message-Id: <20260927-tt-order-local_remove-v2-0-547d8de2e35d@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdCuWoC/3WOTQ6CMBCFr2JmbU0pFKkr72GIKTCFGqRmWhsN4
 e4WWLv8Xt7fDB7JoofLYQbCaL11UwJxPEA76KlHZrvEILgoueIZC4E56pDY6Fo93gmfLiIrlTF
 VIYQUMoeUfREa+9l6b9DooLsI9a77d/PANqylq3OwPjj6bgditvn3LXH+sxUzxlmlZCYLhYXOq
 +ukyeiQnp8c9VAvy/IDMQgywtgAAAA=
X-Change-ID: 20260901-tt-order-local_remove-69ff84225253
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=sven@narfation.org;
 h=from:subject:message-id; bh=d2ouc8Uz465Uf+79oAZUUIRtvwwvLFzZKlrB5Yn/YKM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7nXo4feIuHeLLSXaKaF7l4nou6uwOL3WXh5cUH03Tn
 /YmNGdtRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiLswM/2NbLmT0Ta3L3Lrv
 WmDJXy5XLoUr5q8cnNZYGNzv7zf6U8nwm+3d3Hc1V6quPTfZt+W3R6CJo/erne0ZmXM/t77nP//
 WjgEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TJIN2MBYZT34YQYXGDL5KNDKVZLO25QT
X-Message-ID-Hash: TJIN2MBYZT34YQYXGDL5KNDKVZLO25QT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TJIN2MBYZT34YQYXGDL5KNDKVZLO25QT/>
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

Sorry for sending the patches again in less than 24h. We need to get these
patches out soon for Linux 7.4.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- ensure batadv_tt_local_set_pending (which sets the pending flag) can run
  in the same flag_lock as the flags checked running before the call
- Link to v1: https://patch.msgid.link/20260927-tt-order-local_remove-v1-0-8951549e4a38@narfation.org

---
Sven Eckelmann (2):
      batman-adv: tt: queue local DEL event under bucket lock
      batman-adv: tt: queue local DEL event before marking entry as pending

 net/batman-adv/translation-table.c | 150 ++++++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 59 deletions(-)
---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20260901-tt-order-local_remove-69ff84225253

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

