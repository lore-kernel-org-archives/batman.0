Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2FEC28B28
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 10:59:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 34E6E842EE
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 11:59:33 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742209173;
 b=QbLp3It5pwK0OL1DQdShzyGiPpTtMEagr5uBDp+V9miClAUyQSHPOI8zVvW9pPouAv75D
 Ogh3FTC7RGshBdDDEFhoddbIDNUuOpCcO3qlR3I3Y90tSgKuc0U2d3JG+v2kS82HUNv2IUM
 iVuyQ1YfrJ3bRzwuU1OOF5Xc9TqoyJc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742209173; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=njG/84LUGUEErwbYzu0ITHFmF7k4yqx2zXUfF/5BMu4=;
 b=dKtS9NIZInqugdUxE/bq8qftOC8Bc6+HAUY6Fc2cpri0TT6KyltAhUYI0W8/+KlK0sbWF
 pKrtUDHJIGud8NnLIFBG3GsPwOz39Befv7hbU3FxJ/tl8HK+CsR2tGbqxJ6+C5DyVurAgHP
 IZa7j//CH+Xgd+5fnkzjYH715ItfMWQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mandelbit.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=mandelbit.com;
 arc=pass; dmarc=none
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 607B482A30
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Mar 2025 11:55:46 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742208952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=njG/84LUGUEErwbYzu0ITHFmF7k4yqx2zXUfF/5BMu4=;
	b=yKdxaT4031duqzM79PEYaSYI2oJ49ygSFbLYlFy5IkgZAPk7SFTQKoRRxhz1MteDC3WoBH
	8WnDHKyGZzAL984zBl8aEMWYiKe7pLbTZ7+tObqMEfv4qkMSqdotttri2a2ky803iIqoGg
	hgxxLlL/3qJl/aK3Ccsdr3YoW0P1Qzo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mandelbit.com header.s=google header.b=LMHA+nB9;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of antonio@mandelbit.com designates
 2a00:1450:4864:20::42a as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742208952; a=rsa-sha256;
	cv=none;
	b=vB8TFjLlK9o8r2x+jaegxgWzuGcjSEjFIII5r97gRG7GGHRwLbgtdu1z7DX3MjzQp/wIj0
	L6G83ZpNS1IT1eXYx3DBk3eln8biS+KqsnB2ov1Eu0lqW2AcVe2mBTUw+OSJ1oCPcQnPrA
	m53i0kytAfZ9r0RCn0F4oW1rrdm6A9U=
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-399676b7c41so329238f8f.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 17 Mar 2025 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1742208946; x=1742813746;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njG/84LUGUEErwbYzu0ITHFmF7k4yqx2zXUfF/5BMu4=;
        b=LMHA+nB9vh0wAhZPMrdHRNergf4uNnvJD314u3sfyJbUW22fde2WZfCT5Ndc46+PxZ
         4TFr8LRhsa+rikc73/fp46jNo2TBGC9OPtCmyApEtF0b96NA30uVkMLjcMeoeuNgOD5B
         WiRLFU1b7s3HFFQTtZ8Zc9WoDVKuF0LcBWqPvP1jaDlmiRa+7XlmpzuX5lZRbJzz/HOW
         c5ELrkCphQkGF/gsJMZ8jlj5AYXw/1kOxOANup/3z6UXdvZ2JNmET3h228QP+34I2vzY
         41i2fcVVHMJlC3UQ5h0FIjUUXQiQZqqKH9s5TqAiFeNhRQiaZAa1BvPQ4X4vDBLTGF16
         LjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208946; x=1742813746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njG/84LUGUEErwbYzu0ITHFmF7k4yqx2zXUfF/5BMu4=;
        b=Bb0pw6OKzuYKsfkkyTDv7R7+kfapBAI/pfkdyqxmmuW0fDEXvHrRg2AaErXYAjPIPD
         Pv0FaKewc0T980kMw22VM9F81nD4ItI+SKz+TaR0G3spRGGYUcl6f6+a/uavDAPQ/jge
         YuvLy5qUB3s+u7Xfq8Mdlz7W9N2eCZxGCOKMkNl4b8oynwEgaIUwtKhptz/0KyOR6R8B
         T3MNHRGUCKc9XbtvcraZogvEJUaMfSugon0iPovYEAp4UW0d2+5dllB6ZWPi92oQmRqf
         vzs7fcfWnjng9juU9hZt6qYwiaX1QzOcODfNWQoMDOCfHPEYRUCo/zufAIMIWVQ+lJrn
         GcEA==
X-Gm-Message-State: AOJu0YycdI4eshoiyLpdbEqv5Bdp+L17fccaKg0QhFhZYWkyViNBPhN2
	RJU2w6+mW3GknjcSu8V3xtJlIbUAuu+3WV7IkMELv3bFKP0O+zRb9COEZyz5A7YqarLB+UYO1yt
	o
X-Gm-Gg: ASbGncumuXpXU/uV+k6h3F6nDcerGT0Ahlms4WzV1bCBYJBu8OIlhQP07Xs2a/K55Ku
	2NMYxMmsVASTeb7CBPlcsTjZJHYOMmx72D/Cm6yEudxoAfa/JnVb0bFVKiwwTlY/j4+jbZhGQmy
	FBLoNKHr9/8uBn7Bwlc/lS0wo/lESp3X+3y6rM+MZyQLfW79Hl4LLRbhMvQXzoI/kFw9BVm7+Wg
	kjJfattdPvTlIsMcNyhMsoCDk9E32waNuGNTZbtBeoxqUsYaVOgrPTzDt7UDyY3qFK9dO4kQxOh
	vaHjB60YjMVio077hYVux9NoWNS131OL34qSbKH3MQoNotSE1zNC8OWkcz+3
X-Google-Smtp-Source: 
 AGHT+IEd3c+rmKY/PzRevZh0/o45qQjRX4s0j7yN0pzRaizh/85UWtopXyHnmsyPk8/Vtah/qvrELg==
X-Received: by 2002:a5d:59a8:0:b0:390:f6aa:4e72 with SMTP id
 ffacd0b85a97d-3971d8fc8acmr9561056f8f.18.1742208945496;
        Mon, 17 Mar 2025 03:55:45 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888117csm14383365f8f.44.2025.03.17.03.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:55:45 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH] batman-adv: no need to start/stop queue on soft-iface
Date: Mon, 17 Mar 2025 11:54:34 +0100
Message-ID: <20250317105434.17545-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: antonio@mandelbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: WYZUC4UEPVXUTYAPPGOO2FU3GJJMVBCR
X-Message-ID-Hash: WYZUC4UEPVXUTYAPPGOO2FU3GJJMVBCR
X-Mailman-Approved-At: Mon, 17 Mar 2025 11:59:25 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WYZUC4UEPVXUTYAPPGOO2FU3GJJMVBCR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batman-adv soft-iface is flagged with IFF_NO_QUEUE,
therefore there is no reason to start/stop any queue in
ndo_open/close.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 net/batman-adv/soft-interface.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c4ce8ea4..11e5e013 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -77,18 +77,6 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-static int batadv_interface_open(struct net_device *dev)
-{
-	netif_start_queue(dev);
-	return 0;
-}
-
-static int batadv_interface_release(struct net_device *dev)
-{
-	netif_stop_queue(dev);
-	return 0;
-}
-
 /**
  * batadv_sum_counter() - Sum the cpu-local counters for index 'idx'
  * @bat_priv: the bat priv with all the soft interface information
@@ -906,8 +894,6 @@ static int batadv_softif_slave_del(struct net_device *dev,
 
 static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_init = batadv_softif_init_late,
-	.ndo_open = batadv_interface_open,
-	.ndo_stop = batadv_interface_release,
 	.ndo_get_stats = batadv_interface_stats,
 	.ndo_vlan_rx_add_vid = batadv_interface_add_vid,
 	.ndo_vlan_rx_kill_vid = batadv_interface_kill_vid,
-- 
2.48.1

