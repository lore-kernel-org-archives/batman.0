Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC602C83F11
	for <batman-adv@archiver.kernel.org>; Mon, 28 Aug 2023 02:36:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2A76483349
	for <batman-adv@archiver.kernel.org>; Mon, 28 Aug 2023 04:36:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1693190192;
 b=2P5j+aoX6ngu3fn4huiSD/wASD7vTDVAY98CzmsJ2swMxCRj20btNpkwkGqvwi+aLLu0C
 T0YAEPRChT3X6+lL84vEnACbFl5LEhgWrm9qneuJ07C8xqeNPOgbiD7ag7oGNy7uRnAw0vG
 6KJ6C5NaTfnKPN7XQrQ+3Xfaa7eO228=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1693190192; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FifDf28yvuZJQzcHb+JuLWl+M8PNz/FpcXOqYTZ6xOA=;
 b=EGCpc8CGVxrslhFnBiFqluEx3pgpPhgOTgRo5/Qcb6XSp6uCnOqA7GH55PUYP9I8b7Gs8
 KfcabIKRjXEXAuCAwTwvio4ebsH2ZBFAH1ZFwgTuMJYqSXbGim1vR58tugd+kYeiBapowya
 wcIQRv3ph4VR4CJlx2icccWx4EiFLII=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com
 [209.85.215.207])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B195080EAA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 28 Aug 2023 04:35:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1693190152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=FifDf28yvuZJQzcHb+JuLWl+M8PNz/FpcXOqYTZ6xOA=;
	b=CgIN/jhyCFrzuuqI7i/uBvXxzcr3K7jTVLJtv4laNHDR4HRz6Ah8Rh+psDw/w10Sm9ZoUJ
	KcByv9IJh+7q1XindQWAYxXeTIuUjHnTD0sgMfElssmwSBflo4DVeHwD84yh0jm9j1OekZ
	bwrJ9nj/so+D5ijAPnYVeAQ6Dc00FPs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3BgjsZAkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.215.207 as permitted sender)
 smtp.mailfrom=3BgjsZAkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1693190152; a=rsa-sha256;
	cv=none;
	b=NOF8iheRO7oI8xp/zs7TpDF9hHcG3D5bFm9ZOovZeMsygLezvj5aacGb7IUzvWNeEQAmT7
	R+q0dsc0x3ZbOcuYI/W0/ny2wNIDDURnPxppX2k2Kn8BEZxhqS9yBEBg5b7ZEFKweN5hkR
	RGAVaMjZnFaMqmjS0hOfUZ72mUl7MMA=
Received: by mail-pg1-f207.google.com with SMTP id
 41be03b00d2f7-56fb25fdf06so1455506a12.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 27 Aug 2023 19:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693190151; x=1693794951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FifDf28yvuZJQzcHb+JuLWl+M8PNz/FpcXOqYTZ6xOA=;
        b=hGOsnF3J4Ii9VzOYtG4IMARMHkkKRDirlD9sjCAZ+aJtgQ4nfd5BcWxsG4Gtx5gfVM
         5I1xxHQXg5u6Kc2URwHw9yeDTYgkWanY/rfpoLiXh9ti/kqFyPdHcu/pBSGFUHpD0w3r
         tfkU6/sB9n3bFB/21UQYMJc8JJvNHcqdu+92IsF6XycORNRERbIKOOzH/kpJKWhKKFoe
         dKipTa0l2v08DkjBqyC0+LJcYwWWv47wOtMVzkm3GFiI0nhu2+jDAqLq7cJ4Z7jTkYdx
         X4xKXHzQjhFCePuVGjgsk0lKgk67T0lhmvBfTkhYHxdONKGdzUodOVwsnRvp/0BtmOfm
         GvMg==
X-Gm-Message-State: AOJu0YzCnlH6FL7Tm1GqsIUjMZfmOpUkT+1jy/yxKfBgRTgj1+ESLrwh
	28IgmtdqIqaXK2c6quR2ArMz2Kh+9/6Rya5mYAlzajhEI862
X-Google-Smtp-Source: 
 AGHT+IHnbP7U5FzNlZ6kHAL4cMXGliHk4ZBtFiDNRNVosdYIhIsFvl1za+QBfa/p11T90NI7yW3PXMyM8aXKQwlcepCd1ZgOzbWY
MIME-Version: 1.0
X-Received: by 2002:a63:6d0d:0:b0:565:d4f9:dc39 with SMTP id
 i13-20020a636d0d000000b00565d4f9dc39mr4218705pgc.9.1693190150989; Sun, 27 Aug
 2023 19:35:50 -0700 (PDT)
Date: Sun, 27 Aug 2023 19:35:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007caf3b0603f28d71@google.com>
Subject: [syzbot] [batman?] memory leak in skb_clone (2)
From: syzbot <syzbot+92f9b5fba2df252a3569@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: BKHLJLTEU2FUUVDRMKHMKCYI2UGMVX5S
X-Message-ID-Hash: BKHLJLTEU2FUUVDRMKHMKCYI2UGMVX5S
X-MailFrom: 
 3BgjsZAkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BKHLJLTEU2FUUVDRMKHMKCYI2UGMVX5S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    a5e505a99ca7 Merge tag 'platform-drivers-x86-v6.5-5' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15eea3e3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3c65e06397a9d58
dashboard link: https://syzkaller.appspot.com/bug?extid=92f9b5fba2df252a3569
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13597f90680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c534ce48946f/disk-a5e505a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724bbdaa3992/vmlinux-a5e505a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47fba0663891/bzImage-a5e505a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92f9b5fba2df252a3569@syzkaller.appspotmail.com

2023/08/24 02:03:48 executed programs: 322
2023/08/24 02:03:54 executed programs: 337
BUG: memory leak
unreferenced object 0xffff888120ea2600 (size 240):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 22 e3 20 81 88 ff ff 00 00 00 00 00 00 00 00  .". ............
    00 80 ed 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5e05a>] skb_clone+0xaa/0x190 net/core/skbuff.c:1860
    [<ffffffff8499f31f>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:387 [inline]
    [<ffffffff8499f31f>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f31f>] batadv_iv_send_outstanding_bat_ogm_packet+0x2ef/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888120f36c00 (size 1024):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554a79>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554a79>] __kmalloc_node_track_caller+0x49/0x140 mm/slab_common.c:1005
    [<ffffffff83e54735>] kmalloc_reserve+0x95/0x180 net/core/skbuff.c:575
    [<ffffffff83e5c6c8>] pskb_expand_head+0xd8/0x5f0 net/core/skbuff.c:2042
    [<ffffffff849ccbef>] __skb_cow include/linux/skbuff.h:3571 [inline]
    [<ffffffff849ccbef>] skb_cow_head include/linux/skbuff.h:3605 [inline]
    [<ffffffff849ccbef>] batadv_skb_head_push+0x8f/0x110 net/batman-adv/soft-interface.c:72
    [<ffffffff849ca643>] batadv_send_skb_packet+0x83/0x1c0 net/batman-adv/send.c:86
    [<ffffffff8499f35a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
    [<ffffffff8499f35a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f35a>] batadv_iv_send_outstanding_bat_ogm_packet+0x32a/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888120ea2000 (size 240):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 28 ea 20 81 88 ff ff 00 00 00 00 00 00 00 00  .(. ............
    00 80 ec 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5e05a>] skb_clone+0xaa/0x190 net/core/skbuff.c:1860
    [<ffffffff83f88552>] netem_enqueue+0xc62/0x1430 net/sched/sch_netem.c:479
    [<ffffffff83e80975>] dev_qdisc_enqueue+0x25/0xf0 net/core/dev.c:3732
    [<ffffffff83e8b217>] __dev_xmit_skb net/core/dev.c:3821 [inline]
    [<ffffffff83e8b217>] __dev_queue_xmit+0xdc7/0x17d0 net/core/dev.c:4169
    [<ffffffff849ca710>] dev_queue_xmit include/linux/netdevice.h:3088 [inline]
    [<ffffffff849ca710>] batadv_send_skb_packet+0x150/0x1c0 net/batman-adv/send.c:108
    [<ffffffff8499f35a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
    [<ffffffff8499f35a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f35a>] batadv_iv_send_outstanding_bat_ogm_packet+0x32a/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
