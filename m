Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C0EC4828C
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 11:10:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9719383ED0
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 12:10:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706785844;
 b=f3wOxYZVinpcCWGvf9dqh235V2xAYtEiquG52rqnNbr7FKPqrzf/8MjHm/OfEgW9mrvah
 6GKb765Zujv35lsqI/pCLjlRQOGXAFUzDcn/59Xtq1Si//YCNYJamnCmO5y7bzAvf4kjCWV
 8frVIIXIReM9hLu/xGJY6OhHQYU9a00=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706785844; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UxVL7EVSfSD0mDXEs6rTEyJmXsWE9U3oydSKyS2UoTQ=;
 b=cnEBpkavE1HgL5UlQOoC2VVII+sbbiknhUyIjLbV2eunCibMxQxz5rDiLLGkjEg/lGZrj
 drvNDwz2T/eZif0A1CoyOMoSt6vd2pJfksuv4IEakRXfGvSseM+TI+Am4C/6w+Az8gCBqE2
 qPmUnOtttCEaSots5+79YHIqlxQ+Blk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0311E83478
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 Feb 2024 12:08:01 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706785681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxVL7EVSfSD0mDXEs6rTEyJmXsWE9U3oydSKyS2UoTQ=;
	b=pY7HF83baErltEwUktDFReDOMpAp809tVP/qE444U04bV2dpUnYpn1Bb+lV1oUS+YeRoXo
	knYht9vHPMttlGNjtUIry0JdkM5G6qY+fU0bRm4XqG6wWXw7dtpObq/lSv97wrVcqvdEfw
	mhVK5ssjRBOmIxU6liiUwO2xPpf0UDM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706785681; a=rsa-sha256;
	cv=none;
	b=UAR7hIcZg8YFTFUMw2SOq19SzDlIywyX97pEj0bLc4U4Zby3hOhbspCvjyIaHa3If+VROg
	jet5jE1L6ZUcDLDAaEiYQeA1YQVCDLJLqj8h7BnBhKN+15tdOiAlXNQ42ClXP/GD2i4VFP
	Q6I4idOu7qQH/l/dhcdetD0CyWTDqv8=
Received: from kero.packetmixer.de
 (p200300c59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id A6904FA9B6;
	Thu,  1 Feb 2024 12:08:00 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/4] batman-adv: Drop usage of export.h
Date: Thu,  1 Feb 2024 12:07:56 +0100
Message-Id: <20240201110756.29728-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201110756.29728-1-sw@simonwunderlich.de>
References: <20240201110756.29728-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BGU5OO3ZI274C6YIB6VVGTUVS2B565XI
X-Message-ID-Hash: BGU5OO3ZI274C6YIB6VVGTUVS2B565XI
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BGU5OO3ZI274C6YIB6VVGTUVS2B565XI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The linux/export.h include was introduced in commit 9bcb94c8617e
("batman-adv: Introduce missing headers for genetlink restructure") to have
access to THIS_MODULE. But with commit 5b20755b7780 ("init: move
THIS_MODULE from <linux/export.h> to <linux/init.h>"), it was moved and the
include for export.h is no longer needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1f7ed9d4f6fd..0954757f0b8b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -15,7 +15,6 @@
 #include <linux/cache.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/export.h>
 #include <linux/genetlink.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
-- 
2.39.2

