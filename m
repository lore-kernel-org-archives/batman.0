Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98486E77197
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 07:14:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C2A53841CF
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 08:14:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736406860;
 b=xWmxilEgXuVLpLDgG8xHL8kvuxM3gs1UcOw53tKqrfZzExzmEsOpIhRfls6oqfv/AGQM+
 k2ArADsdUlgh9ROuQukF/LYl78Iv3oYwzoCYpoZHMRrh21mNCbfXxdGIlfFrCsBsijkFotz
 iqKZKFnx2VfWJNE4xZb1thahLg09YM0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736406860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7963/j3ijxmNzd4UZyvG0rfnfQKQcA1+NMLNgZFC6vk=;
 b=ALow4CbvzW3dsz/pHGkfqmPdv6OBy/0hJsSJb0tyGysQgprdr2LX8ZazUfAOdWQ2V6SDA
 WdQCdojYmtyeLAmGA/BOX150peNOO2WoalujdKHfOnE9ndaC3ZS/AYZ2DEOXCZf4N+mEAnw
 FYnoLCd1IRlbXAjK1Q88wmJRvEXRQL4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 65B0F81073
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 03:22:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736389325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=7963/j3ijxmNzd4UZyvG0rfnfQKQcA1+NMLNgZFC6vk=;
	b=oqCYFFsB7wEAA7Km9xmtOOyjfkD606Wmj1jKekGmK9vMsGGXdP8yRXiZ17BS1gFMTNQBdf
	eK43+D36nnlTqAVrN9R2i/mzoXUnrNp2Tdq5C+HDUdKrjf8QF8tHYnxIfjvRBhMEB5WgC9
	jNKpcfjmQfHaQRjMZaKi/lcCfHW2bAM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=PLUbYtvP;
	dmarc=none;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::630)
 smtp.mailfrom=andrew@andrewstrohman.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736389325; a=rsa-sha256;
	cv=none;
	b=iqsis+ppHeVMBP+2YlxFaL5m6uYmb6cywzf+XnBCe86/Mbdor0dJFmqdlF42WlF7R/VFcu
	6On5J5pl+qtPzDxMpUO2mBhwjr8x20CGHWD7/IMEXd2V0RfFOwYSxdY8H96NJVH0LqY37q
	duiKn6NuMfifana6kt9Yd2f7bl2fdeo=
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163dc5155fso5917315ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 08 Jan 2025 18:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1736389323;
 x=1736994123; darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7963/j3ijxmNzd4UZyvG0rfnfQKQcA1+NMLNgZFC6vk=;
        b=PLUbYtvPNwhByVFVO77Qqiz6KEUQDukR1iIP9x+DigIg2iSSJuccElgE+EKIchQBB9
         H3pGTXeI9QxzhwJ2BPiMGu3Hx+WzPP/KCRNuwfczHnI56OGIO++7c+h82+BWPp3wo2Tu
         OsKdSikKLPMSWaSmag/7O8v7cnDProud9J9+aK3BKhyxYNHZiH6O0/FbBPqRBqjlOCZK
         Og8/M7RLmI5RAVdpMHsLziwTWJ0HtQ/rZ5RSTu8WlvXbFLbKAlVZBHM6vmCmLtx2GzQQ
         TTajZZQt0+NDaCNsSAIn+29wUAYZFc2irTnZZvlSuXks9wimzuVBXckF+E8xQt2vpWV3
         MWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736389323; x=1736994123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7963/j3ijxmNzd4UZyvG0rfnfQKQcA1+NMLNgZFC6vk=;
        b=IRQmaIyMLVO6cqiiEN5zQIlvuZJqY3XG2sAc5nAVt4LUsvoh9VpuEHTb2IXlxADaMH
         9406XlVnJtTkNzCC/mEE/TCQjeUiKjMs54fUFJeMZtxEgUBvVQYsL4im99VHzQ+UAZss
         aOHPFVDO8zubtkuxftJmGHwKTQJlihaAI+ruQrruMATjkNZgytpjvD3OzORAKBYwry7/
         O5pN+7frL5txPZJEHnEzCzmElRcwtUNpmIyJi4dKU23CMMAAuUozHNjtwKWRw6X8QL6q
         zdIgjSiwJ3hJ0azogBHyJhXaB50sojsCFuxX8uM1AzGZ/GlENpjKVOiSVAZImI7NwVGy
         zwjg==
X-Gm-Message-State: AOJu0YxT5iSkwMIvLlYToKrIC1ZdqQh1LWjY2tXS0Paw6lC0EGvkgUPX
	kEr55ypOdSlfMyhTyOdqYWChwvxxWCUOZ7YEZpJipDlQ6AlwWjP2p4RDNOU7vjuwb4wHw180CgX
	Q
X-Gm-Gg: ASbGncug5McYfgSJNA+LBTO9iLIbp0kViTDrUDx823vJnvXpYtNk4OQdTDSJRAlWZX+
	E4VVhKy7BJuKa/BB+dL0q1HZxBbpCh/YtVNhsYn7WCpJX//xN8kwjAe52IBwB/kdla1tG8yAkbe
	+VkyPa66bSg6hcyU7dU3WHeFWQUpRVSpEAyxpB5TNaQ5QZfXzMpZ2IZveSRgDSbCO3otEaIlAhE
	eCtaUxaZkckSxJyGDxMMNJCrP2SckoyIawnP0o0cGnt6eBOoytrp6CR0n0HF/q6hG5pVS7e7iTG
	iym0IcOktUwpuV1Niz04NhpDv6bhL86z07SHgEU=
X-Google-Smtp-Source: 
 AGHT+IHUfhWv2wsoUUGjSmXSaC9BnBd3sPy+OgMNILV+qDsD2JpdWuDK5/8QcuY+q6OnwAYaHCrbaA==
X-Received: by 2002:a17:902:d4cf:b0:216:3466:7414 with SMTP id
 d9443c01a7336-21a83fcaafdmr76570805ad.44.1736389323442;
        Wed, 08 Jan 2025 18:22:03 -0800 (PST)
Received: from localhost.localdomain (c-71-197-149-76.hsd1.wa.comcast.net.
 [71.197.149.76])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a91744183sm1358435ad.80.2025.01.08.18.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:22:03 -0800 (PST)
From: Andy Strohman <andrew@andrewstrohman.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: andrew@andrewstrohman.com
Subject: [PATCH] batman-adv: fix panic during interface removal
Date: Thu,  9 Jan 2025 02:27:56 +0000
Message-Id: <20250109022756.1138030-1-andrew@andrewstrohman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: andrew@andrewstrohman.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: ICQTZFOFPB2OQSRVVFF56LIYUVK6EFQ4
X-Message-ID-Hash: ICQTZFOFPB2OQSRVVFF56LIYUVK6EFQ4
X-Mailman-Approved-At: Thu, 09 Jan 2025 08:14:02 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ICQTZFOFPB2OQSRVVFF56LIYUVK6EFQ4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Reference counting is used to ensure that
batadv_hardif_neigh_node and batadv_hard_iface
are not freed before/during
batadv_v_elp_throughput_metric_update work is
finished.

But there isn't a guarantee that the hard if will
remain associated with a soft interface up until
the work is finished.

This fixes a crash triggered by reboot that looks
like this:

Call trace:
 batadv_v_mesh_free+0xd0/0x4dc [batman_adv]
 batadv_v_elp_throughput_metric_update+0x1c/0xa4
 process_one_work+0x178/0x398
 worker_thread+0x2e8/0x4d0
 kthread+0xd8/0xdc
 ret_from_fork+0x10/0x20

(the batadv_v_mesh_free call is misleading,
and does not actually happen)

I was able to make the issue happen more reliably
by changing hardif_neigh->bat_v.metric_work work
to be delayed work. This allowed me to track down
and confirm the fix.

Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
---
 net/batman-adv/bat_v_elp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574..7daaad9c 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -140,7 +140,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	}
 
 default_throughput:
-	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
+	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT) && hard_iface->soft_iface) {
 		batadv_info(hard_iface->soft_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
-- 
2.34.1

