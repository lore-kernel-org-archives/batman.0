Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7560F94CCD
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 06:14:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D5A885470
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 08:14:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776838494;
 b=K7fVO6VFB7F01vGNFLGbQjtIJHLRnzeWHRRddKCjWwBBGl8BG7mO2TgBpyQzva2AtaSQQ
 tORNUZun+IFn/67AZmppSmUpNFBaWLvmfOdWz96/XUyMqyUB6vUrS7BVtIcqAu8AdB8AK1w
 mA1qy4w+20h2hzUDJrH4G2UYUwKbRHA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776838494; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PgCpzzuc3EvfhU68f+8j+UPIVo7srbeg8aF5h8NYH+w=;
 b=d3SJTIEENVFSVrqTLLjPLaOpRO186uS6STvfn55ouk4cdN/GMtlF7acVEMYobJTLlhR0D
 NLKQMe3zGN9+AoSambMHd+aePROV2t1LUfh6cqsvV6uhTKbhDvgNXB1Lsh2pWkFf4sJhBcP
 /O1EyOatFxSb64JEY4wnDhQXtr63A9M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=fuzzinglabs-com.20251104.gappssmtp.com;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=fuzzinglabs-com.20251104.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 53F8B827E7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Apr 2026 00:21:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776810105;
	b=cBc+/fGkxCgPbDzcyxMG+fsZg2Gg5mJT8Yytyv451cYi9ZLx7fMBCQ4zzIoPlS+5amMZ/N
	HD9HJFsKVUaOiiB9yC44mIwdzRPFVdcQok2XI6mPIPW7M8B40YZAiA/rODuSMj+j3V2lDL
	iCWdf36CZvwbj44Y/g5oqD0Kqe7Ish0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=fuzzinglabs-com.20251104.gappssmtp.com header.s=20251104
 header.b=xYiN1E4f;
	spf=pass (diktynna.open-mesh.org: domain of lbourennani@fuzzinglabs.com
 designates 2a00:1450:4864:20::32a as permitted sender)
 smtp.mailfrom=lbourennani@fuzzinglabs.com;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776810105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=PgCpzzuc3EvfhU68f+8j+UPIVo7srbeg8aF5h8NYH+w=;
	b=m8DlErUpncLLNn2lsdnX69u3kaJ+byydTY3vjmRCGxhSLNBUf/q0f1uvmR0780pZwnojtu
	36qyxRetqkaoquC0G4SYuuMHZ3R/vQFaC4raLYLaZgICcSH6EksEfpHj/NH/VtKhghbwUA
	bryOHYSaW+l8rIs2O/5RXZ9QfK3Si5U=
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso21958115e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 21 Apr 2026 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuzzinglabs-com.20251104.gappssmtp.com; s=20251104; t=1776810093;
 x=1777414893; darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgCpzzuc3EvfhU68f+8j+UPIVo7srbeg8aF5h8NYH+w=;
        b=xYiN1E4f7m5G3T8DIcgdXFgwrW/4xdojjsgNjZj4CL5IjedgKwfdz56Rb2COFHfH77
         w5Fv4qMDfZw6KiEIIJ6H0Wg2o2E8MVd5orXz4hIFbhMCqglgfd97LmqCPtJ20DArHFRZ
         WW1hvsDng6oqRCmmnjbkPo9SnZPgLQZFyGDmDgEDX1TmUthCQK3Omi0z0UwZTdHE4wMO
         6TkYSJ5XoKHKnWKAuy78xe2Ym1Rg9j0mIjY2HgJHGNMKFGd+nSFwTtbY2TTfDdbn8n4g
         nnYejP0TqgCCIqJMetiaV6hsJyldG+GevtSn5qJQtI7t4IAUakW5x+VRDeClVxEPehNI
         C9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810093; x=1777414893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgCpzzuc3EvfhU68f+8j+UPIVo7srbeg8aF5h8NYH+w=;
        b=jR4zXdDmnAs0rZHqKZo+0iflcCX2i2wODpjjzlAemzjP5lSl8hkVryqaWMSYjhey/p
         ZC1vPtzoK8sv4tq0ixtCyIIiRU7bk3XBMd3eMSFJ7TuDK3K5jaxSiBSyunNZ7gMxgRzO
         ZAL4pIEpyPKGwndE2z2qQw9Ba+GIzsuv3Y8/Y/4Rz9rodpVu45hpA5JjEnfF1CxPx/xL
         AUxKy+Ialypi3MjjON9IVP9UB/hhcuZaW/qc3/cYJsTVSfmHEfm9wh1SS+hxrCpBgw63
         d5UOkpQ8DMvRyCCkoUrnZMh8+FRFkhlqg05FcwYHqPiVp0+9v0vQpdjpTZSggfwIdbwE
         EeMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Mo9C3WTYlBHAo5L7wdfQ+uXW8/7w+rFzz0WkPYORX1nnxLFQT3IqJF6TXPOW+ncHjlWk8CDxR6Lx4Sw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzDDrraUxLqPvRo43SyIaEw9vZTkq/65PMSkQKUkHXZJhZodeK2
	j67np0xZjfqKu8cpabKVsVfLuhMlCgWk6/89EdBKTP+JKf8+woIKDu8eaKeMPh9WDA==
X-Gm-Gg: AeBDiesVhM96tT15/kHJJJojavkyJOvCnRpX1+Ss3mYLlOytaFJQwY8URkX4DdhjUsd
	WP3n6yMsympmyDa2P3qG9GTHHjqJ/s3h+ttt0X8e3iB6j9CnvkD/bkiWH9SMB1czgorJXO3J+ls
	+skMnO4OyLiPK2qh9POqM2OV+kiE/i9PQnPHmmW5lSVBqIQlHK6chfceS6c70LlHeentfyOjF2h
	tM/29Bp/w/TBL1olW7VtUmDcbGrQCuWIFUVNr8Q3xzlNLpM7nIAMdL5+4XwZ3aeqNB80/OptFnV
	NZjYliWmw7qw74hvrHr63xt3yONV2b6NU2n2cEcPRieBsYBLHviboG9lBDTIMQSyYah8tUKOx5i
	zBmmUC1eI+WNqC69a5xE0E5DOdM9YIlwMD+T/wlEktvoCmOnaFh0PKKL3AqzQWeEm9AWa6EL6OT
	/8V+KstHsbS8vphDlxaH6N4cRwVQpeP6TqzkEhcc7UDvbSLdQSQVMN0v+Yqg==
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id
 5b1f17b1804b1-4890e49f7d8mr121077635e9.17.1776810093164;
        Tue, 21 Apr 2026 15:21:33 -0700 (PDT)
Received: from m1nds-pc.lan ([2001:861:4681:5b10:5055:b6f4:e5c1:bf80])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc100162sm418853475e9.5.2026.04.21.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:21:32 -0700 (PDT)
From: Lyes Bourennani <lbourennani@fuzzinglabs.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: apinson@fuzzinglabs.com,
	security@kernel.org,
	syzkaller@googlegroups.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	Lyes Bourennani <lbourennani@fuzzinglabs.com>
Subject: [PATCH] batman-adv: fix integer overflow on buff_pos
Date: Wed, 22 Apr 2026 00:20:22 +0200
Message-ID: <20260421222022.21231-1-lbourennani@fuzzinglabs.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: lbourennani@fuzzinglabs.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: CBW7AZ6BJZLYANDVQIEZKF6OGPLKGB6T
X-Message-ID-Hash: CBW7AZ6BJZLYANDVQIEZKF6OGPLKGB6T
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:14:24 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CBW7AZ6BJZLYANDVQIEZKF6OGPLKGB6T/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Fixing an integer overflow present in batadv_iv_ogm_send_to_if.
The size check is done using the int type in batadv_iv_ogm_aggr_packet whereas the buff_pos variable uses the s16 type.
This could lead to an out-of-bound read.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")

Signed-off-by: Lyes Bourennani <lbourennani@fuzzinglabs.com>
Signed-off-by: Alexis Pinson <apinson@fuzzinglabs.com>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index f28e9cbf8ad5..618d1889c04e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -335,7 +335,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;
-- 
2.43.0

