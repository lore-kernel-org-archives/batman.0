Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54691C98324
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 13:32:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 70CCC840A6
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 15:32:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790515945;
 b=CnwOX+8+R4dZzVTTqTplUrBw4IoBifdlHr0LbU0Qe5EYHUz6xQmgVALom8vSFHn08iFJv
 /Toa2g1/KSbU7fVfKHnLs2nn8QA02pIRB3ESM1+yy1Mqmq4pbXsroS5z/PJ/a0dhFS7U7n5
 89cCs8sFq9VmMxXcOvKMg8RHyQA8lxc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790515945; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
 b=BfKog1NMnTM8ilTse8gNFYcp53k66hbE+/U9PvrftIorUtusN5YrAVe9OsDrr32FI8o3K
 5AcGk46v+6H2wYqsiYrmIW4sr2NNH4SQFDwk2v/mVkDwvGbKhLDeAeSUckLXuiIAK9BEcPL
 tXCnswAvg1FsVDAcOXMrJn64HmQK2l0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-dl2-x0e.google.com (mail-dl2-x0e.google.com
 [IPv6:2607:f8b0:4864:38::e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 47A82810DC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 12:16:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790504204;
	b=mq5llS0/wW/y1PMcnQ2RUtwi65cYk2gvS8p7vux4etkfoVkISnEbXKqNevWWymD2SkRNWN
	GhvpreDSO79472/aA7AqbyNhx8q2d3A+vWcbxbwryGE5n2eJdYAnq/cKTQFVrO6cNneP4Y
	BzPcL04Ub8UWTRkipaYSWPSry1ENb2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790504204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
	b=csVyTfDKbNubpn17UNVrzx0miKCITHZHYm2afHF2DbbMRNxG0+NEi2SSVUEcJGksyI5y9z
	AkY18MFunN1WRdhdaaYqEqhC4DDdWOiS9TshfhRYDVZQcxOAPQvxq0ChfozkJstli7Udoh
	/eCVs0MeGiViCbq1ANCHjYtiJpwvq4Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Mh5z+BXx;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of nicoyip.dev@gmail.com designates
 2607:f8b0:4864:38::e as permitted sender) smtp.mailfrom=nicoyip.dev@gmail.com
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144ef651963so38654c88.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 27 Sep 2026 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790504191; x=1791108991;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
        b=Mh5z+BXxuYMGCSH4nGgIYIrTYNCsWOi9VLInSXxJq+vJO9OEIkbxBLXQRAvHBCm8Up
         GA/TLQY0ARjmUlLUfn2PjSbxyfhrbupmIxlU4NWRJIdqjZ2PiH6DKBuRGGr8e30TGxzi
         V/uLi3NsufpFvRGfHnExQq9oh2SNCw9nbVeduPSNLda+Z1fZuvmYJR2cP/DqdxFRgEdU
         +xjWEq0OVod8cVobW0/AV3mPCPa3DElSlQZ6BFCe0gUtuuv75P0hOzOMHZq6dQdZd44c
         1BoLIOoZvhO/XQfY+YrrHbmkS7cKyqKmq1OIhp8FlelRNPPXUEH8lVVdsyifJY4RZMZ0
         tB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790504191; x=1791108991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+X90FvGp/WYOP/YNaRkMNyUQUW0Xnu+e4bt1heZW4K4=;
        b=Ex/mFGuOdCiZemBIpX3i3w307vC0H/WNboXU/0BpgbTCkkIbFnKRi44orzrNaMOeLR
         hLsomTZ664Pqlu0Ga2wnz1HUPLi15HlsQkat1e95K/j4SxBQAU7Zyj70GRtv0YQZsBdV
         Ut8/e57q2QTK6GkdD6Hx/FvPtItw5R56l79RL/+7ovIIiQE+BixsnOJ9hluki6t9dVuD
         i7r7W8PgsQqRtD6MmiYKOZ2aXv0LfB3pWYzd5eHvBZLOcxzxiX0uB9jBss5ja0S12zNs
         KBI99j3DwJhj2EX7JdIsZDrz8XE+OLSrficSxsHsrQ9YiqPJsqaInrftmN6QPEZbmEQf
         0DEQ==
X-Gm-Message-State: AFuF++nV8aavy2AbYG076z1wds9V9xRixPy0Xv3UMqYsc444S2IezgwK
	VC9jSgUzAzKj1DXEtPWJ2GurKgsGBimoE539qiQ0sPWw85V8zRCuNDMPVfoEMoU9PB5DVA==
X-Gm-Gg: AYBFou2jZ+kTBllJMc1qBEaL9H/0iNuDUP0qt7qdPIna658bhGBjFNPQS7h42l++feQ
	rlp+wcDQmTZzsuUr1dqLjLOrIQjByaACYewCLsxWgN3CcaYCQppALR4XSvt/rM8svBESPvAxERE
	F8UuFSq+RDDdZ/MgCWGqEuJlHE4sg9Qzt62Z7+vlETakI/vBfvz2VlWIzYMrLHsTacOukSwZrBG
	rZLqMujjDm2gYN15biizePFfKEli2cdDwD6X4QN3MTX2ceTSmeowkwB2hGq7EYapgDhIIQOIgod
	TIZtUkPQcW2s65zCAddpIAvzh/TSwxgenDb1HUPy2mKuP9O5aoO2ZvUZVh+MwszvY5zdJT0YAGg
	1SFf1cqAkoXPq4LAZGafevGWSirukiLIOx23gWy5tIVukSdIqpTN8lChp1xhKVqgttpGA09V8Av
	kgIDqmbR0I0ShnGDzIGYVY5BOQBperM0vSy4Up6uiWHSWwdq+jGoQJk5fzp5SN8yEEdGhbpEb9/
	/rxmevyUS4RJ6LcThCecEIBcEq6oySypRA4xHD1rX6rA97i6btUaG1D3i/c8NWxRXeRsw==
X-Received: by 2002:a05:701b:4508:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-146cfbd49d8mr8759695c88.2.1790504190254;
        Sun, 27 Sep 2026 03:16:30 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com.
 [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm16760188c88.8.2026.09.27.03.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:16:29 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] batman-adv: Close OGM aggregation before transmission
Date: Sun, 27 Sep 2026 18:16:24 +0800
Message-ID: <20260927101624.3812927-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
References: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: nicoyip.dev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: XOK5A2ZIVIAM4V4WC5H6Y45OGSNSMBT5
X-Message-ID-Hash: XOK5A2ZIVIAM4V4WC5H6Y45OGSNSMBT5
X-Mailman-Approved-At: Sun, 27 Sep 2026 15:32:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XOK5A2ZIVIAM4V4WC5H6Y45OGSNSMBT5/>
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

