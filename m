Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EFBC5B543
	for <batman-adv@archiver.kernel.org>; Wed, 28 May 2025 14:00:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2690A84756
	for <batman-adv@archiver.kernel.org>; Wed, 28 May 2025 16:00:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748440835;
 b=XCpsEDspkDHwLotIOxTZTdRbFtU/E+Ml5ocHBtn9zeVqZNlFLryH7YVgb5ul9VI03FTbq
 RWoW0hisyVTPVcvBe/Mf4EhzCJHQwu3CZdrakfJmzeHcToRH4wJEH8X5FKqhYbKMDNwXkHl
 oe5D4nqOuk+kp2b6knmi7Zi9dz9W6U4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748440835; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=moqIRBVigjhPUIqMmS2sg/So0AXKtSpC6g4RpSBMwwQ=;
 b=udIfNpvlYeCssmxv3AkjJ//Dx/rqPn89LDg8zem8jqFw8AL83T9ZgkCov/vXUymgKITAe
 Z+FKsxCAs7+uFlOcWAyoJDLiTaqmMB31gU961JW6OftlCp25EAzHd31MHbozS2IROITsUlu
 EJHlPFUIxYbuUlBnjrlNYSguHBHTUs4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com
 [209.85.166.80])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9D948821BC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 28 May 2025 12:02:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748426562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=moqIRBVigjhPUIqMmS2sg/So0AXKtSpC6g4RpSBMwwQ=;
	b=gwvSP8SkGBxqqXOL5Hi52Mju3G4Cvdu3WNRLHAJ8WmGLMU/HwMFYMhdyIIDxYaCTNptzRP
	49kTUcew3SJRGEP0C4HqNc/3p2JYPMY1StW6FU5wNfJWaUagLbJG9bLPO2o23xhBqaL4+7
	97aQ2cmJK2kMO5Xoy8EQE77nYB9yNzA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3Nt82aAkbABkHNO9zAA3GzEE72.5DD5A3JH3G1DCI3CI.1DB@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.80 as permitted sender)
 smtp.mailfrom=3Nt82aAkbABkHNO9zAA3GzEE72.5DD5A3JH3G1DCI3CI.1DB@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748426562; a=rsa-sha256;
	cv=none;
	b=dkZXcKxYMqUs5zcrVR5BziX5lH3PrwEltHm/YvCv23+BwxCsWssu1Nb7Ma1XUhg4naND56
	iPTSTnJJHHpxZxxxsgONL1c4wEhinivcYKZZWKKMnEgjzw7ALB3irfchFRuFvAoU7OYFlA
	y7xeMGQRCHNuzpecE+EAO4Lrhu9uCQM=
Received: by mail-io1-f80.google.com with SMTP id
 ca18e2360f4ac-86cc7cdb86fso406740739f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 28 May 2025 03:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748426550; x=1749031350;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moqIRBVigjhPUIqMmS2sg/So0AXKtSpC6g4RpSBMwwQ=;
        b=V2D+sGhzwqp4dJ7R31nH3RUqr6awLnoDgk31yYodow6PgOYCWENNp/BIslMqFMhQey
         YJ9ZFmM6Tmk1lMe8M522RjxieA+AlaYkxzfLrpfbC935ZjMxT6GWy99m4dklsOAbEupp
         g92MKx/yI7bp1H8zBsuXo1ko5Ks8vQo446R1OfYPvsKnYjFa2UES1NmBth7pSRifLP6B
         9a/Zd/sWOWseERHeeuiXZnTTGqu5PBabTtg/PrbNl8VQopZHTN0CAmB/x0mQV4OXxGku
         i/v9/Tsz99ILbZrNewSE5FZ18lBs1zwXLe71jPKiQJPFGmp9qmJfGbaZMKANHhhinID3
         TIvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKELe5f/mGgs3ES0HdeTMqoNrLNBJy+FkwzALifJoSz1hsVyQukU3HGqYjlOiIeX9D3Jvg2S6dB5Gm9w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwcawI7DKve4nbwlU0MmpqyB1T06qz1rHv2Wjpt1dAgIJ8hVEH6
	ZJyY4ZpAKv4b1FJNfM2b3c7iuLDhhI1VlBg96JDFSmGVCyvJB45ZWtHpeLcCG+f0EyCPm7/Os46
	p4ye4xUb8Bv8emE8xiN1ty4vz4pJ+nv6MfwKWY+rqwtSb9dJnuUfpwaP0ox0=
X-Google-Smtp-Source: 
 AGHT+IGx2gOtTa1Qo7q+C4Ls1d6wREFiqZ6VhaHbJPwPRbJpViovQcjFkxzkhOeWcT7m1U/5bl1JSNhu64vTSkx4Mpsh3XsEhv12
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4191:b0:867:6c90:4867 with SMTP id
 ca18e2360f4ac-86cbb91658cmr2089776539f.14.1748426550177; Wed, 28 May 2025
 03:02:30 -0700 (PDT)
Date: Wed, 28 May 2025 03:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6836df36.a70a0220.253bc2.00c6.GAE@google.com>
Subject: [syzbot] [batman?] KASAN: slab-use-after-free Write in
 batadv_forw_packet_steal
From: syzbot <syzbot+cf67d03e10798cc088c4@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3Nt82aAkbABkHNO9zAA3GzEE72.5DD5A3JH3G1DCI3CI.1DB@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 6OFNP55WBZX3FCM2Y5IPIY7DBMV7RQ4V
X-Message-ID-Hash: 6OFNP55WBZX3FCM2Y5IPIY7DBMV7RQ4V
X-Mailman-Approved-At: Wed, 28 May 2025 16:00:23 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6OFNP55WBZX3FCM2Y5IPIY7DBMV7RQ4V/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    ebd297a2affa Merge tag 'net-6.15-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132e89b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=cf67d03e10798cc088c4
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0ac4d2393a8/disk-ebd297a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/377911478299/vmlinux-ebd297a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3b681ee6d30/bzImage-ebd297a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf67d03e10798cc088c4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:980 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:1008 [inline]
BUG: KASAN: slab-use-after-free in batadv_forw_packet_steal+0xc9/0x170 net/batman-adv/send.c:583
Write of size 8 at addr ffff88807d60e800 by task kworker/u8:14/6252

CPU: 1 UID: 0 PID: 6252 Comm: kworker/u8:14 Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 __hlist_del include/linux/list.h:980 [inline]
 hlist_del_init include/linux/list.h:1008 [inline]
 batadv_forw_packet_steal+0xc9/0x170 net/batman-adv/send.c:583
 batadv_iv_send_outstanding_bat_ogm_packet+0x6db/0x7e0 net/batman-adv/bat_iv_ogm.c:1724
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 52:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4372
 kmalloc_noprof include/linux/slab.h:905 [inline]
 batadv_forw_packet_alloc+0x1e9/0x390 net/batman-adv/send.c:519
 batadv_iv_ogm_aggregate_new net/batman-adv/bat_iv_ogm.c:571 [inline]
 batadv_iv_ogm_queue_add+0x85f/0xd30 net/batman-adv/bat_iv_ogm.c:678
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:841 [inline]
 batadv_iv_ogm_schedule+0x81c/0xea0 net/batman-adv/bat_iv_ogm.c:876
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1720
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6252:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2398 [inline]
 slab_free mm/slub.c:4656 [inline]
 kfree+0x193/0x440 mm/slub.c:4855
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xbd9/0xfe0 kernel/workqueue.c:2345
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1835 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x646/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:164
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807d60e800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 freed 512-byte region [ffff88807d60e800, ffff88807d60ea00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d60c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a041c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001f58301 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5197, tgid 5197 (udevd), ts 90749117127, free_ts 90540158601
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4970
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2632
 new_slab mm/slub.c:2686 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3872
 __slab_alloc mm/slub.c:3962 [inline]
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4367
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 kernfs_fop_open+0x397/0xca0 fs/kernfs/file.c:623
 do_dentry_open+0xdf3/0x1970 fs/open.c:956
 vfs_open+0x3b/0x340 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4039
 do_filp_open+0x1fa/0x410 fs/namei.c:4066
 do_sys_openat2+0x121/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0xb0e/0xcd0 mm/page_alloc.c:2725
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2824
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:164
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88807d60e700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807d60e780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807d60e800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807d60e880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d60e900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
