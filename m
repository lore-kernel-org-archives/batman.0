Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCE7C3DA41
	for <batman@archiver.kernel.org>; Tue,  9 Jul 2024 06:19:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C354B825EB
	for <batman@archiver.kernel.org>; Tue,  9 Jul 2024 08:19:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1720505970;
 b=aIVu/hUKyEBV1lIlKgaVH3SVQt3PGT8T1wKvpQe0sLoR6eaweANc/Uv8MulD1kFvfcHf+
 wY3d/GpefWw6iYnzRCelHphWR+QBqya80AHEBk7eZCV7Wnt9qQMBqQ0et1zSLAXnhg4pYiq
 DJI3jPe76dB8dm3FylDhXDLBQA4v8wo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1720505970; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iTcOd6S5hjqJaw4entfORyAfTyoeoPtGdQQtiW3Xu+0=;
 b=RvptLq0DpegTUeB91rpnCvnZVhgNmUPaAKl6l5WCyAE9WSMEd+7DEzonP1lR4e+1x31gx
 48q8Tlr6Io3ip3zgIzYss8eWCmBVp62Pn8zLSX2TxFv+BAv84vrMEnEQT8sm8bdcK4v5F4c
 /tp0ezME6D8swa1cmaPA0YKStI7fBQo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AF24881BC6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  9 Jul 2024 05:12:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1720494741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=iTcOd6S5hjqJaw4entfORyAfTyoeoPtGdQQtiW3Xu+0=;
	b=p4Z4unngYxdHzgxlR6IYZ2YAk1Ky6/i6RbfIol5TTL3/pQVQISq2I1M6FpfUMa2FMY70UB
	+gk5ld5iYrdDDCEQTLGQyxjlDnXjsV7/24pzuw+K8SbdVle+ceIWDziA5bskzX4eZeet45
	CHHuuWR1re7S7q40y4nO+j2RfiCyKX8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3k6qMZgkbAFYGMN8y992FyDD61.4CC492IG2F0CBH2BH.0CA@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.70 as permitted sender)
 smtp.mailfrom=3k6qMZgkbAFYGMN8y992FyDD61.4CC492IG2F0CBH2BH.0CA@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1720494741; a=rsa-sha256;
	cv=none;
	b=Tei2698rFcPWzAvfUhzmg+rsoj01hpaHfXXHzWIdlHYebBCN71fOXhpYzWz2ztUjhoUD9b
	ozpC8SFDQY1BS3q9doAlgmxQfOZC59EaMJm1XLW1678uoiSvw1u0b18M9iIQtOvmLPziTV
	q8+skn3L+H5WSl2rr5sYFeSD+GWIO50=
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7f6530b381bso564006739f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 08 Jul 2024 20:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720494740; x=1721099540;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTcOd6S5hjqJaw4entfORyAfTyoeoPtGdQQtiW3Xu+0=;
        b=nkjxb7tKddiW+K2QWBszYf2QFWXHOitOrjLMClNtOr6z0b+CGvnVAfYU7Ptl64E/NB
         wyde0SPMhZZDnoE1WIHbQl34LHuIpmZ12UZFGmCEc/Z2uCXg4L4XmKz6MQ5XPbMEwJgC
         4szoQRSvm+HE9oy3xmK8XhXnewzL5nQUrIYo7DusnJ64T+YvuwH5pMeBT/TZ93/bWMCw
         YtdYGGuGURCk9vi5uXtVaMVbwEcmLX2mqa7udcCYjwU7JpqUNwAzZond7JpR4BAIM4jN
         0Tlyxtpcb+cylUCbEavV7Y5L2SkhLODpJS8ieWKWKg9ebLI81+IU+6EhSP6Sa6sSA9ad
         DU1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKj7rpcPO0tSuDbFR1r/HPLZuqOyPsePAUTMZmFPPKVJGAqQxXPW1irVYDPsSYbxMR09Y9FEKYr+sb51d+lUNhNy/CZ+FkIBSMfwwef64Q
X-Gm-Message-State: AOJu0YzE/9k2phKm02wpXT+e42JneRuJsCX4JE+a0qdbmpFaR+WXVDTe
	zsBlI3OItUJokkC7ZK2qWHq2buPoPXOfIht/BEMV6T2W/6jFMVCEtf1jCfZ+xWan8ih84CS2mDK
	x6xo+85j+hGS9jJ46v2oxJhQfKzbtBNeX/jgFyuhSxdEBAaOh/jYpxWw=
X-Google-Smtp-Source: 
 AGHT+IHCkPwdiq/I65r8mVNNcFB5ddKi+JZqFLSl5kiqL1VBKN+R733LItz1xqfogQGSn+L11xbxyKAqT0hOIRtszNm6L5WoOluE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d85:b0:7fc:dfb0:4e52 with SMTP id
 ca18e2360f4ac-80006d99988mr10069739f.4.1720494739840; Mon, 08 Jul 2024
 20:12:19 -0700 (PDT)
Date: Mon, 08 Jul 2024 20:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce6fdb061cc7e5b2@google.com>
Subject: [syzbot] [batman?] BUG: soft lockup in
 batadv_iv_send_outstanding_bat_ogm_packet
From: syzbot <syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3k6qMZgkbAFYGMN8y992FyDD61.4CC492IG2F0CBH2BH.0CA@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: WYOJP3TTJOTEFXUIOEMBUAAEOTKUBB42
X-Message-ID-Hash: WYOJP3TTJOTEFXUIOEMBUAAEOTKUBB42
X-Mailman-Approved-At: Tue, 09 Jul 2024 08:19:20 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WYOJP3TTJOTEFXUIOEMBUAAEOTKUBB42/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bf7976980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c950e46ec3ea637a
dashboard link: https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/393fdf1d08dd/disk-795c58e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724001a1b4be/vmlinux-795c58e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ede352392b0/bzImage-795c58e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 143s! [kworker/u8:8:2833]
Modules linked in:
irq event stamp: 1708674
hardirqs last  enabled at (1708673): [<ffffffff81e178c0>] ___slab_alloc+0x870/0x1870 mm/slub.c:3577
hardirqs last disabled at (1708674): [<ffffffff8ae84a1e>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1043
softirqs last  enabled at (1708660): [<ffffffff8aa82f2d>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (1708660): [<ffffffff8aa82f2d>] batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:661 [inline]
softirqs last  enabled at (1708660): [<ffffffff8aa82f2d>] batadv_iv_ogm_schedule_buff+0x97d/0x1500 net/batman-adv/bat_iv_ogm.c:833
softirqs last disabled at (1708658): [<ffffffff8aa82ee3>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (1708658): [<ffffffff8aa82ee3>] batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:639 [inline]
softirqs last disabled at (1708658): [<ffffffff8aa82ee3>] batadv_iv_ogm_schedule_buff+0x933/0x1500 net/batman-adv/bat_iv_ogm.c:833
CPU: 0 PID: 2833 Comm: kworker/u8:8 Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:kfence_alloc include/linux/kfence.h:127 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3986 [inline]
RIP: 0010:kmem_cache_alloc_noprof+0x1bd/0x2f0 mm/slub.c:4009
Code: 5d 41 5e 41 5f 5d e9 2d aa 2e 09 31 c9 e9 71 ff ff ff 41 8b 44 24 08 a8 82 0f 84 5b ff ff ff a8 08 41 0f 45 de e9 50 ff ff ff <8b> 05 fd b8 f4 0b 85 c0 0f 85 c0 fe ff ff 4c 89 e7 44 89 f6 44 89
RSP: 0018:ffffc90009717840 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000002120 RCX: 0000000000000000
RDX: 1ffffffff1bace70 RSI: 0000000000000028 RDI: ffff88802ba3b3c4
RBP: ffffc90009717888 R08: 00000000ffffffff R09: ffff8880250de500
R10: 0000000000000000 R11: 0000000000000004 R12: ffff88801544f8c0
R13: 0000000000002120 R14: 0000000000000028 R15: 00000000250de500
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64bd0ce2d8 CR3: 000000006623e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 fill_pool+0x26b/0x5d0 lib/debugobjects.c:168
 debug_objects_fill_pool lib/debugobjects.c:615 [inline]
 __debug_object_init+0xf7/0x480 lib/debugobjects.c:627
 __init_work+0x4c/0x60 kernel/workqueue.c:678
 batadv_iv_ogm_aggregate_new+0x2dd/0x4a0 net/batman-adv/bat_iv_ogm.c:584
 batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:670 [inline]
 batadv_iv_ogm_schedule_buff+0x99b/0x1500 net/batman-adv/bat_iv_ogm.c:833
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:868 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:861 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x31e/0x8d0 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
