Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7DEC282EC
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 12:40:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C397C83B8C
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 13:40:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742215226;
 b=uG+QI7W2jQZ30YsszrEJLnGyBecreY6XeRHX7TB/uRFKg6Y1ZFXx3DzWyTvISS0bji6DM
 Y8G7oUAD4oRTKI+q05vv0pdqbi/U5r1tkR7ohdYImEPOScooLJxxvm6+IAUGOINR1hBgn4h
 jhmLIACRo26D8tHc4lpB1w4jZZNuqiM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742215226; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wKfBAgk5f3cCYfOgxErZyeG70QVb+gbzwiQ9Z9dvYys=;
 b=MpqX6b0fZRiEVKmIDbPI2HV6+miXlmPrrBKn44F5n1qWSrXwNEUM7jgPpB9+tYY04yBKp
 QGTWloOMHmIXitWCsR2TXZWMwlvmTJ2JuCG2v+XsUocp1w3lvFH91lHWvbZKdy/a2WTH7OC
 7WdyvuJR4OxfE1UliHy2c8sZ31PaGn8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mandelbit.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=mandelbit.com;
 arc=pass; dmarc=none
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7FF6082113
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Mar 2025 13:40:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742215218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wKfBAgk5f3cCYfOgxErZyeG70QVb+gbzwiQ9Z9dvYys=;
	b=1xCUWdWeM/cuhaiOcObq/d3uS4iP2VZZ/PldA3XDtpOgfeZOp56OuGXMCrjm6dZuDxoOaC
	apqY+iiChAeeXFvv7xd2ddwmE0CFRD7pIhzZytKqFda7H65X8ex2Arogzg4O0ki8924T7t
	babYEdxNnbMY/ppVSQtyCPtI2zmzk9w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mandelbit.com header.s=google header.b=ZH2j8wdM;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of antonio@mandelbit.com designates
 2a00:1450:4864:20::131 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742215218; a=rsa-sha256;
	cv=none;
	b=bpBxlViUCBAPxynICxMpC5YaTbR370JKWqYGMLVGBDDOH1MySlXtHmVagqsXqKz4uctAjJ
	B9C0N/13+MZUrY4tVwrlh7WrLC7dmYaYoEmISInvj6yfBpyW7A+7MiG4+eLjppdUFTePAF
	mhOv28veWNODiHmOjMMEpd7oHLJOQ30=
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-549b159c84cso4298792e87.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 17 Mar 2025 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1742215217; x=1742820017;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKfBAgk5f3cCYfOgxErZyeG70QVb+gbzwiQ9Z9dvYys=;
        b=ZH2j8wdMHtpNMgR/dXHH7pnwgrycyRpfL0gADhTqgAa4tJTv8RvzNgHzbp+f5sLTo/
         RF16QajC9NK60Kzx3wou9UvZAUzy+boDEsLw/EYYfxnW3qoYsnEPvMa+MvKLX67TGOl4
         ibqoTb1IBv15itcu+QOVugI4S0pBMIh/3ytbmkiyqapIfFv6WdQQt9f4mwq5gcAvhs+a
         nSN/KdInmPrGKbFs6K8L8hoFk0cq9viYZMoAQ4Ao1mR2gnVW0nrX6Wlk72fqPPoTeSYJ
         PK1yo9kDTCFVQy/Hjof7WW2C4W3CFf7PJ411Jku/CfnfRnNFasaZ7WwQ/gHo0AjL5QYt
         Dt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742215217; x=1742820017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKfBAgk5f3cCYfOgxErZyeG70QVb+gbzwiQ9Z9dvYys=;
        b=U/3zmfAJQ5gIB+FddBkhqmkv5nZ2y1mh6deJa3VZm6l20BeH9BrX5eleUn9T0ZQSW/
         VpFeapST5AL0BnkwLERJyY8iCQaZkUEsFU1iyRy7lV/kaME/ZPG0Yq+DNzFwblUltr1c
         oHy4hekuWh0hBE5S2hBPGIKQfNH95bqzYSn7v3RWbV88WyqEUJy7NTl3xuc8VEBCvI6S
         WFAKXMHJZfORZBT/4hcxx53sA8CghLJCpVKIFdtRpT4v32E73osKY/BouppTqdkA2oa3
         OZqmjENFseE5UCw7qIfUO1/ygC87KZ6opiqGbv5L1c+NdLrNJaZFGCcOegl6JfN0/jPn
         QN9Q==
X-Gm-Message-State: AOJu0YzgBOtr2iv251aKZB9j4Lq3KDY2j8VCRbF+HNfBMEnC8r6ZoKPe
	YzIoZb2e3b8R4FkKz/mbNKF/lxn+0v2NHe7zurvwy9cYWb5D7NiTZTR6oDH8xbHvxv5a+yhQO0w
	W
X-Gm-Gg: ASbGncttoIonv2BO0efjuuceYS3ns4zNz7ruwF2oxcSE0hA+wW4nUjtKvlqMNqLAOze
	7pwwqQ3/ZZYJa0SbtCkiNYmNgVR7cjsR7HS14BZ/LJhERG+oq3cO0JXBs+jMHQwhFXfUiIRzUnb
	oCwXQl488un0QkbE5MZr3g+hbzJK90s/70WuwfdlBBhiG3WDshzVuy/IPI5LJLAp+R4ghMX0Ty5
	9BO+Rb2BWKxASN83m9seYDmWlA2+LoStuXyWUhunHGwB2R3AYS6xIro5jo6tULN1K+3d5s/puHZ
	ue4zrKVPdg0Fj07hiLuOpcNPxWFUSzF4kkE2F0vbvg3orn408yBITQV8PHKG
X-Google-Smtp-Source: 
 AGHT+IFS91Gi+AkmgTC+ArNl8FYanWkbJPmXcrosk1CtcyYYs1AtNIDmZNK4GmtrzEpEDhmFLxIrXQ==
X-Received: by 2002:a05:6512:2250:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-549c39aebb7mr7061108e87.49.1742215217394;
        Mon, 17 Mar 2025 05:40:17 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-549ba8a9219sm1309772e87.249.2025.03.17.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:40:16 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH v2] batman-adv: no need to start/stop queue on soft-iface
Date: Mon, 17 Mar 2025 13:39:59 +0100
Message-ID: <20250317123959.2344-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <5871015.DvuYhMxLoT@ripper>
References: <5871015.DvuYhMxLoT@ripper>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7U5A4OJ2BPKSMONDHEU3EGOR7LMSPAPZ
X-Message-ID-Hash: 7U5A4OJ2BPKSMONDHEU3EGOR7LMSPAPZ
X-MailFrom: antonio@mandelbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7U5A4OJ2BPKSMONDHEU3EGOR7LMSPAPZ/>
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
 net/batman-adv/mesh-interface.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 6d8afff6..c1d7b681 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
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
  * @bat_priv: the bat priv with all the mesh interface information
@@ -890,8 +878,6 @@ static int batadv_meshif_slave_del(struct net_device *dev,
 
 static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_init = batadv_meshif_init_late,
-	.ndo_open = batadv_interface_open,
-	.ndo_stop = batadv_interface_release,
 	.ndo_get_stats = batadv_interface_stats,
 	.ndo_vlan_rx_add_vid = batadv_interface_add_vid,
 	.ndo_vlan_rx_kill_vid = batadv_interface_kill_vid,
-- 
2.48.1

