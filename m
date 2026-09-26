Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFC3C9832A
	for <batman-adv@archiver.kernel.org>; Sat, 26 Sep 2026 17:27:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5C777841D0
	for <batman-adv@archiver.kernel.org>; Sat, 26 Sep 2026 19:27:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790443651;
 b=uYYHB+eH0gyWa1g245l2AOhkZMBxNJQzJBdV6no5z7o6GzhUYo991xZ6fKvC1YlmUX0JG
 LpEn5DtYN1v6LXYkOUkoWBPyH8ZPvxgC4zdagbtI2jvghju+F6T5C2+MtJdgiTDmty2Ehcb
 mthqVuakk3Kr8p++gwRFsKKSB7HYgqc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790443651; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jhocdDFq9DeA/HG//FXJunjEWK5CDGAQOC1NTDBHIkU=;
 b=HD5ttc039xAP0GQ1TGT7+AK3Hu61743+xJYG+y6anNTw2dJrhWmypb0+rv4Q8IZAzzFFS
 jDJcHXAFKecr8Q8d0auMUepwTHBDVGzgiPdo4LhxmLuAwdvxYAXYxT3X+qKQ5qkYekh+2A3
 zKq0Olr/padYPD2zeU/gooPokq4HrVk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com
 [IPv6:2607:f8b0:4864:36::e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2B2DB80864
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 26 Sep 2026 19:26:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790443580;
	b=l3mkT1APIyz5zX8AUlQNrhGX8Lg4g1fx+w5MhqZzwMqj3YVqq0OiIJ0P7c/8z5UzzjIu41
	9+rMEDl1iyumlUPXiWowt110QVyWVov4Wzpd7cGllvkic6HSNSTAQAW6lPE4kwuCJm+mB0
	dNWfpwLBrPMRXAaliwuKz0Esd11NhnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790443580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=jhocdDFq9DeA/HG//FXJunjEWK5CDGAQOC1NTDBHIkU=;
	b=0Ox5J0G5R/9jn7fhwKMYrs2wxA9MV5lNs1vJ+/5OyaJGXRX5VzNILMCylmRSnYEvhlAH9T
	VGyU5LgHkMmmVhbafDMoWd6Gi+Krs+wcm26USq7jqASt5xFIqEvwtkKgYmQiZd3Tqr7hhm
	XEIx/eM8zQyoFyGyC2HVwgvhI2+icCo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EvvGpnYK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of nicoyip.dev@gmail.com designates
 2607:f8b0:4864:36::e as permitted sender) smtp.mailfrom=nicoyip.dev@gmail.com
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-342c08bf64dso68412eec.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 26 Sep 2026 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443568; x=1791048368;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jhocdDFq9DeA/HG//FXJunjEWK5CDGAQOC1NTDBHIkU=;
        b=EvvGpnYKrMPpptr8s2Eo+H1mI+3LFNXoJncWFgbuR0W9blhiKq1Bl3qbxzMXokvXxx
         YZ7HcI0YT9eRtRtJeIPNbdOLiQJVg5HIH4i7altis25CcnAvCNVmyJ1IYLACBd3Ztl1N
         D4tUbQHyfM7aQdSROARZ5l/ruIZw5XJatf+iEOuqpR87QBtJ3r5ke0JD2Stk3qfeh2v5
         qR+ZyW/Xerj5SG9qC3KyHmi1zP85l5m/0V7n5xp9LJw4eSfDM/WAZ10VV2OqrM6A5DQM
         lhOMv4jzNNBxilFWkFXOBWcsbVqpoME561Ng8sM4uAnegtFH6+/E3w7pwo0LP/xwN37U
         g4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443568; x=1791048368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhocdDFq9DeA/HG//FXJunjEWK5CDGAQOC1NTDBHIkU=;
        b=dsfytwAZgWDpUpfur6EGhQ8s/OzxaLEdgeCFA9lQ0NdPChoTko1z1LPn3D9OpyfPBO
         3GRNWybyYSLSDTvTJER2nVVMQsjQcpnrLf7lX7ivzfjPNXfAKG9NqztdhKZe9XSeHx9X
         RU4k8aHs/TPvRsCjlC0neOfm4WkGLmYvp53VPToT7gN6lIXVEOCZpCxCkwPUvJkooQ7M
         wH6eKjxqwxa8EOFmkUq9rfBeE8sqUDcH3G/I0AQpjfTdXoHE2FTNDuveVF2sQcXlEIDp
         dXJk4JPWhYXmR8lcMhmHxJosBR33qNXjQc3puTs+xfF8Ty+QU33kBUEJjuxGf3iWUJRR
         q4FA==
X-Gm-Message-State: AFq9FYJ6t9qdSgaaeMrItXceYQdKkQMOAERpNpjtaNgg02FfPKU6W4q7
	4zyqqvjkQbojyMf0wuDSHwMcIRPWuMRXytkiHG+8y4XzBbcYeJePTYdM
X-Gm-Gg: AYBFou0ahKZ29HOCNCXmhpHz5fK4ZkJzgOG+bwr0Wq03rVlyuKjZryigKoFLKhBJTHa
	QpCCRSXM0ieHqDXbftaIA9s1ssb0wYDPCWGuwlfVNksC59hp8zh65Zo8MUaWdYJS/ZPvDf9pNFW
	wo+ObipppGdJtc6Wus3Z7DpqTQbJDiGDYCAxlrCLAPww6ZjYaaJBmH1RbV/+8ZNEFM90VUIJvOI
	zoi6RP3gEyjnmibr21PCf0/0SZE35IjOljO3h2rLqp9mSiCwzxhUbn36wg3+6kKt1xhjqJl3BBC
	TlIkhb5xsT9YmHxxrKiwe74ApjFkHCNchvJdCtJigVeqi8yleAfrcnHr0NAbrCqsHwU+5CaW8GD
	yxqD38pMrwg+7kz1aWZKnfKOAchSJawLvPZHDcbddduh1FfKKO5AAU2MGU+KHf+WvKfyGdF+p5y
	EhdT72YvOKxZvzq7ZwcPBSHNvY7jgS+XysuPa7DLVmTjZWMHz66KIwRhTDVIrPVzFeOTzPIye+y
	Kt2fDkuGd0sfBM45TQY9aaEnkKzuDYm15b2qA3ih/7bXVa/2dtalUOrdOt6cQXng6Nn6TM=
X-Received: by 2002:a05:7300:de0b:b0:341:f4d6:d9a5 with SMTP id
 5a478bee46e88-3427169be76mr5652722eec.1.1790443567319;
        Sat, 26 Sep 2026 10:26:07 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com.
 [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145d0fc9fsm16943267eec.25.2026.09.26.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:26:06 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] batman-adv: Close OGM aggregation before transmission
Date: Sun, 27 Sep 2026 01:26:00 +0800
Message-ID: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: nicoyip.dev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: RZR7YNUY7U37DGL6VBEBLOJ4BRZ7FKOY
X-Message-ID-Hash: RZR7YNUY7U37DGL6VBEBLOJ4BRZ7FKOY
X-Mailman-Approved-At: Sat, 26 Sep 2026 19:27:23 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RZR7YNUY7U37DGL6VBEBLOJ4BRZ7FKOY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The OGM send worker leaves its forwarding packet on forw_bat_list until
after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
but emission reads and clones the packet without that lock.

CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
list lock, finds the same packet and appends another OGM. The sender can
observe the new packet length before the corresponding direct-link flag
is set, or clone the skb while its length and payload are being updated.
This can transmit an OGM with incorrect flags or inconsistent data.

KCSAN reported:

  BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
  write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
  read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
  value changed: 0x00c0 -> 0x00d8

Set num_packets to BATADV_MAX_AGGREGATION_PACKETS under the list lock
before emission. This waits for any ongoing append and makes the existing
aggregation limit check reject further appends before inspecting mutable
OGM flags. Emission walks packet_len rather than num_packets, so the
queued contents are still sent normally. Keep the packet on the list so
interface purging can still wait for the worker and retain its existing
ownership of the packet when freeing it.

Backports before Linux 6.15 need count-handling adaptation.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 53fbdbbe8f4f..59847299a123 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1909,6 +1909,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.43.0
