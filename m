Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DEEC369DC
	for <batman-adv@archiver.kernel.org>; Thu,  1 May 2025 15:38:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DFEE48497E
	for <batman-adv@archiver.kernel.org>; Thu,  1 May 2025 17:38:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746113903;
 b=IRGNWAY5qqMtTdVKdpuWSC+fJRaTlw4/KG5GZpsm+NSZw5q1qjISCy+yNwOyZ6w19aH6k
 4GWCPs0G4BNYT/+DVnFToX6nWR0RuDhvhfbaRyhBqWjNxIS+t2QTgrj3BVk8aa+fhK7yc1h
 +4NyvJTvn/GULSoyin1iycD0/zue3Ao=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746113903; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bKT3CYx5Pp/t3vJLkcUCm39fapLPEuWc8A4ri9U3ddY=;
 b=Frw4EDDg8sXtwXIxVNGiCg66uxfemIVG0Mp/841aRYIpPr2DXppOjJvKFx+JCPMRh4pmZ
 kLSM5ruprSBU7NACLdazqdRPt9q13tDxJlLWJlTgRam1anzhslvjBT5D01ywftIFnbUvx//
 lxuGil5K2jLUN0y4lh1Stk9Jq3q65P4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-qt1-f208.google.com (mail-qt1-f208.google.com
 [209.85.160.208])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4D8C183E8F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 May 2025 16:45:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746110752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=bKT3CYx5Pp/t3vJLkcUCm39fapLPEuWc8A4ri9U3ddY=;
	b=3etJQDzqLv5LL+gJlwNbOkPEHYZLZkwP+lAqeJ1ksbLa72Rf4dM/ALwC5e4gEyuxB3wYPN
	okTwJZPwDanpNjw+megv5sTO07YVIZhVG6EgmA2ZvGNO9SG3WC+BwMXoNheoohKOd28VaX
	ZMmjMNbS8q79dY2tAhgCNLW2Hn8+908=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3a4cTaAkbABA8EF0q11u7q55yt.w44w1uA8u7s439u39.s42@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.160.208 as permitted sender)
 smtp.mailfrom=3a4cTaAkbABA8EF0q11u7q55yt.w44w1uA8u7s439u39.s42@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746110752; a=rsa-sha256;
	cv=none;
	b=IHOjSEzij9zp2CdgjXJBvv1ZW8m+tw82gMVwEh9sQR3MfGDqEPYUXLW8jHxa6qLZFzAByr
	UMm5vBGbWGoGBN3ETzLyZ4flQ6LaPI/wg8npwMQZFzmk3Sr5h3rNJxfbMrmp0nGU70FBYc
	Et4RWSEWAm/PyXLH0E75PQ3fH1WR/VA=
Received: by mail-qt1-f208.google.com with SMTP id
 d75a77b69052e-476c2d1c582so20210541cf.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 01 May 2025 07:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110751; x=1746715551;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKT3CYx5Pp/t3vJLkcUCm39fapLPEuWc8A4ri9U3ddY=;
        b=k+yOXP/02jaF2y/d1Gm9RuAaUWE+Bm4rgscRF86J+s0V2uwlPj0EGkzy8XwqcWc15N
         Tl+LY8KIZGgud3LXSFrViBcuVqVje8C52JWj2OW3zDu0qKGxVevDrDG2/IGpk7UYJM1O
         UcgOHBq3mvXJ1oExBNZUYHve3LJuuF+XkRNIxYe2QpP4jLflcSaIjhtsEp2skeMa7DMY
         YV6y3ckFBju2ywCY00iDUVd72bWv5DFIVr0FEQBr9nTqdZLrEeIF4fdd2XfYXlDUuGmI
         RgVYnALA1f5Oyx6BeuIO2qlEL5bPcUk8639i6bRrYlJCSOvbtrlI2pDAYgBudRjXdKEN
         tapw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFyNU5UAF2yUHfvlriJYaHFM9mA6bYhNgvktOCIy8H8OZFLL0d5thCCvVQaCN1fdDf5BjijFhrMt+DbA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzOd65w/i+4UUibunYHW4eUEpeBNu2A4KZVtM08kQUDQTRJFxVZ
	S5l5owMxGwdMSdttHVwSrk8x7zMz2Fy1/xe//oT7Gce2003cNmT3mvxQTdlMUiJeOLVTjc2eyj0
	AlTs69vIzWtT0nhKcPK2p51chIu5Y47uyXcxAWoBthL69mR9r1PbKy0k=
X-Google-Smtp-Source: 
 AGHT+IFW1RvcxF1W+8esYW4nnWpbjFRstR87BcxGy+Vj6deAijA+e1yU/Ssn1eDn0QZXOUSVDHXBBs/RCbKLqlT/X66vvcgUrgZa
MIME-Version: 1.0
X-Received: by 2002:a92:ce4d:0:b0:3d8:122f:9f07 with SMTP id
 e9e14a558f8ab-3d970babe0fmr26951955ab.10.1746110315769; Thu, 01 May 2025
 07:38:35 -0700 (PDT)
Date: Thu, 01 May 2025 07:38:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813876b.050a0220.14dd7d.0011.GAE@google.com>
Subject: [syzbot] [batman?] KASAN: slab-use-after-free Write in
 batadv_forw_packet_queue
From: syzbot <syzbot+4a354e37723883878eed@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3a4cTaAkbABA8EF0q11u7q55yt.w44w1uA8u7s439u39.s42@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: DFLNMS5MUGXUIZTZJLYN43PCLSOKLXM3
X-Message-ID-Hash: DFLNMS5MUGXUIZTZJLYN43PCLSOKLXM3
X-Mailman-Approved-At: Thu, 01 May 2025 17:37:57 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DFLNMS5MUGXUIZTZJLYN43PCLSOKLXM3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    4f79eaa2ceac kbuild: Properly disable -Wunterminated-strin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11996f74580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42a9d552788177b
dashboard link: https://syzkaller.appspot.com/bug?extid=4a354e37723883878eed
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/822d3af2e031/disk-4f79eaa2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a60cd781b04/vmlinux-4f79eaa2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37d5d556e0a9/bzImage-4f79eaa2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a354e37723883878eed@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1026 [inline]
BUG: KASAN: slab-use-after-free in batadv_forw_packet_queue+0x187/0x260 net/batman-adv/send.c:688
Write of size 8 at addr ffff888026fc7c08 by task kworker/u8:2/21326

CPU: 1 UID: 0 PID: 21326 Comm: kworker/u8:2 Not tainted 6.15.0-rc4-syzkaller-00052-g4f79eaa2ceac #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 hlist_add_head include/linux/list.h:1026 [inline]
 batadv_forw_packet_queue+0x187/0x260 net/batman-adv/send.c:688
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:857 [inline]
 batadv_iv_ogm_schedule+0xabd/0xea0 net/batman-adv/bat_iv_ogm.c:876
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1720
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 21326:
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
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:857 [inline]
 batadv_iv_ogm_schedule+0xabd/0xea0 net/batman-adv/bat_iv_ogm.c:876
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1720
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 21326:
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
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xbd9/0xfe0 kernel/workqueue.c:2345
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1835 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x646/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff888026fc7c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 freed 512-byte region [ffff888026fc7c00, ffff888026fc7e00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26fc4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a041c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a041c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea00009bf101 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3510, tgid 3510 (kworker/u8:7), ts 186249926857, free_ts 186186911857
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21c7/0x22a0 mm/page_alloc.c:3688
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
 device_private_init drivers/base/core.c:3537 [inline]
 device_add+0xbe/0xb50 drivers/base/core.c:3588
 netdev_register_kobject+0x156/0x2f0 net/core/net-sysfs.c:2336
 register_netdevice+0x126c/0x1af0 net/core/dev.c:11009
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:960 [inline]
 nsim_create+0xb19/0xef0 drivers/net/netdevsim/netdev.c:1028
 __nsim_dev_port_add+0x70a/0xb20 drivers/net/netdevsim/dev.c:1393
 nsim_dev_port_add_all+0x35/0xe0 drivers/net/netdevsim/dev.c:1449
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1501 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:988
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_pernet_pre_exit+0x1d9/0x3d0 net/devlink/core.c:509
page last free pid 5188 tgid 5188 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0xb05/0xcd0 mm/page_alloc.c:2725
 discard_slab mm/slub.c:2730 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3199
 put_cpu_partial+0x17c/0x250 mm/slub.c:3274
 __slab_free+0x2f7/0x400 mm/slub.c:4526
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4217
 vm_area_dup+0x2b/0x5c0 kernel/fork.c:488
 dup_mmap kernel/fork.c:672 [inline]
 dup_mm kernel/fork.c:1734 [inline]
 copy_mm+0xbe1/0x2100 kernel/fork.c:1786
 copy_process+0x16d3/0x3b80 kernel/fork.c:2429
 kernel_clone+0x224/0x7f0 kernel/fork.c:2844
 __do_sys_clone kernel/fork.c:2987 [inline]
 __se_sys_clone kernel/fork.c:2971 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2971
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888026fc7b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888026fc7b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888026fc7c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888026fc7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888026fc7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
