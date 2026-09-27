Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C959FC9830E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 13:32:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2327F841D0
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 15:32:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790515978;
 b=CU0Mqq/CPXe6ipn/5LvuIEkPinBPoIFWY7hOtxv4/DcG0o1PYQe+eDGB5iTxjFeBBsdCR
 ACLQBElaCNcIttS7f9R3WVy8DEC3WeWpZtWgQmTNVpINkjhGupjGiPQh1N1j4MQf8ziKGAT
 07htQK0t0ynEd4sHwZmUxTUd7yFHRj8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790515978; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
 b=cmSzHU1VDbmCU+NW0/48hRUogTv8SUAQndmsZMCA41TQHC56W7GMAHhlBgHCPLwJQUOU7
 b8mp4Jgg2r07I2Wh/AfhKmP1rcVgjbXfhT1+uqT2xCew4yMfedpBVS2xuJ8WPDt/x6EjpmW
 KcJ0AMp/zAyHNs7vDV8sJWBFXDct+9M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-dl2-x0e.google.com (mail-dl2-x0e.google.com
 [IPv6:2607:f8b0:4864:38::e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D24A88114E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 12:23:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790504636;
	b=z7u3sdn7/uGJ3h+1CJ4H/FvXw65spTX1mP9g8Nf/RkzrqtjPcmBCDNtya856DnNDaqWGJ3
	SgiHVLF1Nt6fSStvsSCwxRsYRGh+nvf3KkY91IIxIGEuFg5Ze3m9KCFNwrhUD/D8DAArjk
	FnMvR1ppn+pe5NDQ84HccvrHH2HvkQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790504636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
	b=cQXdVWo2J/Yy18JlEb+zCJIbC0jlnfVrrzR4uL3xPgC3dkOZdYzdB8ueVrAiQYPNQ1fuGS
	BXxmrwC1viiAd7TfhsLOEtxmuHzAx2zFeg9aBUsFi6fbx2w0jru5ddYZvQcJZOGJgHtLfO
	eYhVjLySxaKG/vB7eDCuXBDBY8dj7ww=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dugqg9AN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of nicoyip.dev@gmail.com designates
 2607:f8b0:4864:38::e as permitted sender) smtp.mailfrom=nicoyip.dev@gmail.com
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144ef651963so38709c88.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 27 Sep 2026 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790504635; x=1791109435;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
        b=dugqg9ANQgmKzzYCSIwi0R9TX+CzvnpBf4HC1kqmVXdSqtVPmtTFEB77eXa6nq8c9N
         DI65OGT2ode07kgIGS6n8uabRa15rn10H7jx5v/D/q5CpJYAi6CPWKIcfvpj1DEQB0yU
         GLcWJbiuRPT4Gu+5PWhCuim+LbboxAC7vbVw/RtdcVkO7pqo0LXOammfhroIc2pWm4Rt
         FmWDHUDRglSyAHKCJl7qkHfMkw1ygZGSbPwOh4qpRFkfB7O+wYnoO1hae/ypIF5PXA9m
         cNeCctbxtrYa+RtzIKOMEhf1zaB0y9Dg/s6V/40U40ZEmUbx+o2+kCWEukFTC+DsOyct
         yPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790504635; x=1791109435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
        b=LcaJ3L5Kdz29DWJrdscyqF+e52QarzwrEbVSIVuCwku9YtEM23fIDeaxIr5BQrxbmj
         itoezUd+996nYuKkus0cjnbE0xS5u4dhWv6s1mCC9wi+LC96B6e86m73xjYQwlJ8jsTU
         xhSFvkCJB5t9tMl1tH99owXVJghD8JZJ3LKXltPZZed1J9EGNjxsFgj9z17vKonz8MLH
         fXsEVYQv+RLRFZBbQtce4/Tcix+MgiwK6Yb/mFJfKmZ8hccBS43qLW8eeRsXZ6JOUk6Q
         Ff0faj0OoRS2ZEMl2OmEgYg2snDIvlXb4wousxUJbNXJElMDSbulL3ov0tO9g2PygHjy
         /2BA==
X-Gm-Message-State: AFuF++mFHao4s+e0iLLB/ET14z+V3BwyVxVpNlQ/IB+zcVavnkLL00fa
	h3VPzKhuCd8Iq3sryzjMeIZ+SVnRgAfR5ajaxYRUBwiX6kq8wjZ6GNm0
X-Gm-Gg: AYBFou2U1V4RNUNuXD8CkvLSCpql+BEmzwtdF+eMbctqvmYVM9takBdV6s26FtFqPH8
	9lqqQEwoNgGTSUwb1imlFuTmbfvwnbHg1uOtsGpV9OqsV7hDmixY/BSkevAWy1G3tieQr1a4ABP
	nIkbNkAkFoTJvU3cKWkggW3GnZr8i3mbQI1/6tSCy/LgjBeSjkSvUw1vKjwy6muA7sIOka8coIQ
	LMqJsSIbqGvLPM+niZQnyXaVeAQv0CIL6akWihtDGT1rYkiAKPNVV1pLdroM+hS5Osw2XlZB1V3
	ROR9dW2J87ezByEeb/+ucUL6QhkL1FPkPG3JtkXmc/jtgX6B3Xkshqt1Js6We58JnAe7T62vzey
	vCooUVatgzdVwH4XrUMIvpT7urwkNShhkzfkD1UAzLM4ZkC3kpvgxqHeWY0C4ssrZetmYaA0M60
	jKTYA1S9zKbCy+cSCqBfycokKQbiu1Wm+hdNjumtBuLvn67kNAAvH8gcb9RyJiBDz/yXXDUZVQW
	CGVHiw8kiuAGAPjhqUpb+RuAT7MYyfPlrUUNYYYHplQ5g4iBZC7iADjyxNR8iCbY74hKA==
X-Received: by 2002:a05:701b:4508:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-146cfbd49d8mr8784075c88.2.1790504634664;
        Sun, 27 Sep 2026 03:23:54 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com.
 [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145a7318afcsm17093142c88.0.2026.09.27.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:23:54 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] batman-adv: Close OGM aggregation before transmission
Date: Sun, 27 Sep 2026 18:23:42 +0800
Message-ID: <20260927102342.3813222-1-nicoyip.dev@gmail.com>
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
Message-ID-Hash: XWFC76TTWJSPAWH7F2KPSEN43CVAGT7G
X-Message-ID-Hash: XWFC76TTWJSPAWH7F2KPSEN43CVAGT7G
X-Mailman-Approved-At: Sun, 27 Sep 2026 15:32:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWFC76TTWJSPAWH7F2KPSEN43CVAGT7G/>
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

Mark the aggregate as full under forw_bat_list_lock before emission. This
waits for any ongoing append and prevents further aggregation. Emission
uses packet_len to walk the OGMs, so all queued packets are still sent.
Keep the packet on the list so interface purging can find the worker,
wait for it to finish and free the packet.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Rebase on batadv/net and route the patch to the batman-adv maintainers
  and mailing list, including the introducing author.
- Add a comment marking the aggregate as full before emission.
- Drop the stable-backport request and defer backport consideration
  pending maintainer assessment of practical impact.
- Add Assisted-by: GPT-6-Astra.

This revision is based on batadv.git, branch batadv/net.

The reproducer archive, batman-ogm-aggregation-race-reproducer.tar.gz,
was sent in a separate reply to this discussion. It contains the PoC,
prebuilt kernels, build scripts, configs and QEMU launcher. Reproduction
uses KCSAN and a conditional kernel-side mdelay(), capped at 50 ms, before
appending the ninth OGM. On Linux master fd179f8a05be, the vulnerable run
reported the target race; the fixed control reported none. Both runs
completed 240 cycles. These are instrumented runs.

The v2 batman-adv subsystem build and git diff --check passed. The code
change relative to v1 is the comment above the existing locking fix.
 net/batman-adv/bat_iv_ogm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d8a6a0f64ce2..084970404d3e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	/* Mark aggregate as full before forcing emit. */
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the

base-commit: abfe281aeab4d26b8e262ca9efc979a92c494aed
-- 
2.43.0

