Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5094BC25B79
	for <batman@archiver.kernel.org>; Mon, 27 May 2024 14:20:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BFBB8830AB
	for <batman@archiver.kernel.org>; Mon, 27 May 2024 16:20:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716819615;
 b=aUQpe+uurlbDomO6wqztuFLbFhAkEE5kbQ09e1EBh3fpwR6BUNykGWrvJcu+cTG8wkEVN
 OzyX9qxddr/DnAi0HJP72tH0gY9vFHNi2+EZ7qzHjeovOOlUwXMG6dr+P9doWLGZiVqvFlu
 5BIQmaykyLrxleApvDVyPMxgtwnOKuQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716819615; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oQVY/Bmf1wEh1T2TuZBrOjv5M0OOE8d6/i9hHHX/4/8=;
 b=c8ezw8g8jw+kgP/Uv/niCasSWXqJIn9iySNvRkk9xGGMMBC5opyaz83Xp7OeoZ/s2C07d
 ZjcW2vSpJsm8ik7rnboto1R2ExGvyxeyqPgVi5gGbaNMEq4bQOtwSVmj0b18jQhvpCz+CCP
 pynrESteWkthhMg+YxQKQdoMsRE2DxQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A9C7582FCA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 27 May 2024 16:19:55 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716819595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oQVY/Bmf1wEh1T2TuZBrOjv5M0OOE8d6/i9hHHX/4/8=;
	b=Ulw1g8G0skdI2qDXiloEooYkkrd96USjyIf+6B/gJG+Fvlbg9A9nak6e2cYBQ+n75if44N
	0zDUYV9ZcZCf+nAMko1xV6ECS0upZTrQSwGqF9gMobOfk1oWukIpJOmvpWMOqs/iRWXMAG
	2uIBsMweYZFzqIBwTI6V5iWRrSdZlkc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ctX7S3G8;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716819595; a=rsa-sha256;
	cv=none;
	b=TBVz/51MPjwT6ertfsL86f439AqyFVlk+K1tK7A8m21Khep9+il5MtfCbb49krNm6+EpsR
	exVZSykGTT006l0OosJ5NPtzmR1Bemoq0fnvjwp32fbjAkYnaLx4zonhwfAOKbfGnyf5IP
	OK2ZA4sgAzQtEKco6o3gk8RqGLT+kgk=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9736061973;
	Mon, 27 May 2024 14:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E1CC32781;
	Mon, 27 May 2024 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819594;
	bh=g7hWoxNCaHqvGbk/5I6za8mFOy7/mGYOcDJsLdJZJgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctX7S3G8/hyn99S4rg1fs4Ln3TBo/WlLlc4927pk5B/zbqTtPZlsA3SikvqLBEYX0
	 zl7SuOTIF547HHCDFJzPh1OsHcCG8kzYgCwLbK3i/GOKzVWvtsycilZRPp1nCP+hCy
	 fzCTuF/JeYGHTJgJnGAk334TKdc9zf08hg389A0yz+I5aKG1YoDXqzy+HgX6uRlumE
	 3C0AoVdiEaXdBiqOe3xCBAhzJju9KXzsrM5w2ErohM2DWYmCj0/uQkJgTwf2KsoCUU
	 eb1p9KbCXiLQI5Ed4mSi5iiFky09wKogMIHK8PtZBqb2x/fbHtHQqv/ucO5QGWr1E5
	 l5Z437+ANyWcw==
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
Subject: [PATCH AUTOSEL 5.4 2/6] batman-adv: bypass empty buckets in
 batadv_purge_orig_ref()
Date: Mon, 27 May 2024 10:19:39 -0400
Message-ID: <20240527141950.3854993-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141950.3854993-1-sashal@kernel.org>
References: <20240527141950.3854993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.277
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ADBUUWE2D57UOAJTLIBISRNHG67KA2ON
X-Message-ID-Hash: ADBUUWE2D57UOAJTLIBISRNHG67KA2ON
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ADBUUWE2D57UOAJTLIBISRNHG67KA2ON/>
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
index 38613487fb1b7..ba51b69ee3642 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1345,6 +1345,8 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	/* for all origins... */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		if (hlist_empty(head))
+			continue;
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-- 
2.43.0

