Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2D1C25B79
	for <batman@archiver.kernel.org>; Mon, 27 May 2024 14:19:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 00CD682E82
	for <batman@archiver.kernel.org>; Mon, 27 May 2024 16:19:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716819573;
 b=Xs8wRmGpFAkRk/YnBhnr7KaeUf9YC6KmrK4OH6zzTIpQsjtxAFPxIzSBhZaZn7fQQjwIT
 0Q/mVPErU5ojjOaJepFFyL/Xr8JWjNCZNHCpz5sKsyXuYh1upGDQ0Sky1cgOYjq+NIq7oah
 jntUR6GSx3+h853J+N23Q0VGaxEhQhk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716819573; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=01FLvqGGBDOPUBrx9MIcGtrqVoyscRPSyKuoQ2NGm3E=;
 b=d/aSy4X9zqx3Lu/xdH8k2RuJZclL+LNtMHHovTplIk2zfM/OhP5K7+JJbC9+1p5aC/gzi
 kSsrgblDAjdN+Og764/59yAaMdnjykJH8pl6IggxdYqrXwXGBUCTTw4ZXetbsvQxDv3Gjw7
 jMsESDSudTvt5rdMlWHjZ9XZc3/AI7s=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D9671825F9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 27 May 2024 16:19:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716819562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=01FLvqGGBDOPUBrx9MIcGtrqVoyscRPSyKuoQ2NGm3E=;
	b=m3XkY9hbQA33WwG0SAf0LEgeloxqb8+6pr/8bBDXTud923h9seukZOobCgNldVWhpnOQrA
	z0WLzW4NuDOViSaisVPXLwYmmgvFu9yZWRqpg9HjYcRe8B/u2d6fQs0Xewbf+JHDjQ8zXd
	Z1+losIw68yBAhNSSisySuMSd5RXYBY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=dBOo3RbE;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716819562; a=rsa-sha256;
	cv=none;
	b=2he8LIid3tUgVaEU/Es1smkHxxFexQSklZnSbXx+6SexqREROeh5yVcpgcRwYvqpTHa8R8
	mL78GMH//FBsXqMAMlH+N0CqAyxuCQeAI3qKoDkgWI83G6SxXECGt8ms5xxyYarhHapmzh
	89r5+/ie8ta7/mZTSLwNwaBc3tnly4Q=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D0B9761884;
	Mon, 27 May 2024 14:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A086C2BBFC;
	Mon, 27 May 2024 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819560;
	bh=IaCp9thyAiMfDKdSII2q3MkLwsW1lGdVP4nCCPlzZkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBOo3RbE6n+Ckn5icXCzAFmSL+grVBQg06ZlI3DcyGfiGxBChenOGq8SEQV4i/pxL
	 UGVw1s3DGL2nOuVSn0OsviiBWfUISl+DNCMUf+93FxP8bCOfHRAfwHe5S92KZ9+HW9
	 nRJ56nq6p03qmTa5JfA/a+Cw+nT+P0baLEfWpriXCNpTMTLtL0zwabYPY1RVi8gpwD
	 gK8nuaa9ekUFaZ84Jsc4MxiCmYqsOAxxvL28aoMfOYEKC6r0gnjRiW2caEBrK7qLed
	 jgoU0+TaW1Ouw1fzpp/BLryPEZif7I/Bp3HfqBubVnBjPJh1S11BG4D9l4cXiJ/+QW
	 gyOytIMyz3w6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/13] batman-adv: bypass empty buckets in
 batadv_purge_orig_ref()
Date: Mon, 27 May 2024 10:18:40 -0400
Message-ID: <20240527141901.3854691-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141901.3854691-1-sashal@kernel.org>
References: <20240527141901.3854691-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HYGHDNPDKZXJJBM7OG6PJ5JLWNNIBGQ2
X-Message-ID-Hash: HYGHDNPDKZXJJBM7OG6PJ5JLWNNIBGQ2
X-MailFrom: sashal@kernel.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HYGHDNPDKZXJJBM7OG6PJ5JLWNNIBGQ2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 40dc8ab605894acae1473e434944924a22cfaaa0 ]

Many syzbot reports are pointing to soft lockups in
batadv_purge_orig_ref() [1]

Root cause is unknown, but we can avoid spending too much
time there and perhaps get more interesting reports.

[1]

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:6:621]
Modules linked in:
irq event stamp: 6182794
 hardirqs last  enabled at (6182793): [<ffff8000801dae10>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
 hardirqs last disabled at (6182794): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
 hardirqs last disabled at (6182794): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
 softirqs last  enabled at (6182792): [<ffff80008aab71c4>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
 softirqs last  enabled at (6182792): [<ffff80008aab71c4>] batadv_purge_orig_ref+0x114c/0x1228 net/batman-adv/originator.c:1287
 softirqs last disabled at (6182790): [<ffff80008aab61dc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
 softirqs last disabled at (6182790): [<ffff80008aab61dc>] batadv_purge_orig_ref+0x164/0x1228 net/batman-adv/originator.c:1271
CPU: 0 PID: 621 Comm: kworker/u4:6 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_purge_orig
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : should_resched arch/arm64/include/asm/preempt.h:79 [inline]
 pc : __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:388
 lr : __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
sp : ffff800099007970
x29: ffff800099007980 x28: 1fffe00018fce1bd x27: dfff800000000000
x26: ffff0000d2620008 x25: ffff0000c7e70de8 x24: 0000000000000001
x23: 1fffe00018e57781 x22: dfff800000000000 x21: ffff80008aab71c4
x20: ffff0001b40136c0 x19: ffff0000c72bbc08 x18: 1fffe0001a817bb0
x17: ffff800125414000 x16: ffff80008032116c x15: 0000000000000001
x14: 1fffe0001ee9d610 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 00000000005e5789 x7 : ffff80008aab61dc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000080 x0 : ffff800125414000
Call trace:
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
  __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:386
  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
  _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:210
  spin_unlock_bh include/linux/spinlock.h:396 [inline]
  batadv_purge_orig_ref+0x114c/0x1228 net/batman-adv/originator.c:1287
  batadv_purge_orig+0x20/0x70 net/batman-adv/originator.c:1300
  process_one_work+0x694/0x1204 kernel/workqueue.c:2633
  process_scheduled_works kernel/workqueue.c:2706 [inline]
  worker_thread+0x938/0xef4 kernel/workqueue.c:2787
  kthread+0x288/0x310 kernel/kthread.c:388
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:51
 lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:103
sp : ffff800093a17d30
x29: ffff800093a17d30 x28: dfff800000000000 x27: 1ffff00012742fb4
x26: ffff80008ec9d000 x25: 0000000000000000 x24: 0000000000000002
x23: 1ffff00011d93a74 x22: ffff80008ec9d3a0 x21: 0000000000000000
x20: ffff0000c19dbc00 x19: ffff8000802d0fd8 x18: 1fffe00036804396
x17: ffff80008ec9d000 x16: ffff8000802d089c x15: 0000000000000001
x14: 1fffe00036805f10 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000000ce8d1 x7 : ffff8000804609e4 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008ad6aac0
x2 : 0000000000000000 x1 : ffff80008aedea60 x0 : ffff800125436000
Call trace:
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
  arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
  cpuidle_idle_call kernel/sched/idle.c:170 [inline]
  do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
  cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
  secondary_start_kernel+0x198/0x1c0 arch/arm64/kernel/smp.c:272
  __secondary_switched+0xb8/0xbc arch/arm64/kernel/head.S:404

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/originator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2d38a09459bb5..3b2a3759efd6a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1285,6 +1285,8 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	/* for all origins... */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		if (hlist_empty(head))
+			continue;
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-- 
2.43.0

