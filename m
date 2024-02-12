Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FD6C4829B
	for <batman-adv@archiver.kernel.org>; Mon, 12 Feb 2024 10:26:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E641C819D6
	for <batman-adv@archiver.kernel.org>; Mon, 12 Feb 2024 11:26:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1707733588;
 b=qTbcRobAN4eeFPzNGlffUMdn6OCmFmByiaHr4GWogsJ9Ev7H/MOYJuGsy8ZqcB3WH0kZh
 3bsQwXcvF0xPyHddy1qLN0NiXV7QRusK9xr3wl8TTZSXuTq6h5NnFExgodzk9rNnmkOmIDw
 7284giz+IS6kqn1mD1iyba7yYA2L+44=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1707733588; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+S1KVrX9I5Ts209Z1QyzWipPgFBmpJGS9brjneXDxOs=;
 b=mhF9xtf81S21JkGvz3qT40URI8HyY70YmKfmU5mfQuTgOLMKOcB4EtIcmGD6z882P2OQa
 jIZshSAvRFfijxINujjSNKKvvK5/bmiMiEso/muK+fmWnFDCVI31MIvEkMds4nF2kD+ima+
 K1prfiCRt0kKIL7RoHI9EuMDjHKi4So=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D7EAB8008A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Feb 2024 11:26:25 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1707733585; a=rsa-sha256;
	cv=none;
	b=Z0ZfXmZlas/h7P2bnLzO6TLlXAKu/A+lhd9c7uyL+798iBF7MmSxbOZ98WneVjb65dLl8/
	S9Sw/z81jjSOsPVqVsTz6u4CRid2jz5ptLcnc/8UlsxbLxyPBF0/XBkxK6paePZ0QkGUll
	YITV2i8ib68/rTr76bNEws/wJzAeINA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3UPLJZQkbAJEDJK5v66zCvAA3y.19916zFDzCx98Ez8E.x97@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.198 as permitted sender)
 smtp.mailfrom=3UPLJZQkbAJEDJK5v66zCvAA3y.19916zFDzCx98Ez8E.x97@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1707733585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=+S1KVrX9I5Ts209Z1QyzWipPgFBmpJGS9brjneXDxOs=;
	b=UhkTXIn+cYq5To7UlUJFgY1KBA5xu9zFcmjUOviiRqnMkOVW2Too8sm6oKjafwfj3TjpfV
	Scg0olj55TcoN2DzmYuEJUOkVcHVu52Z56SGYXt+2Ftoe8T5RoZYZxr3/ByhzR2zW8Qreu
	fCFbQXlrvDaUu3FTqaD8v/Kw2PLE+wg=
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-363abe44869so29128285ab.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 12 Feb 2024 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733584; x=1708338384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S1KVrX9I5Ts209Z1QyzWipPgFBmpJGS9brjneXDxOs=;
        b=GzDzXztcXHn0SKyLHBz2Qjcwrz1LlkNFg5c1t9rb01lDVcR95KXKeVs9JbtanLme8d
         /ENPeBHEK36SbKnjiAU1Oa/O4j/8GXHx/ktgaY5OepHTUBR0u309PCKlSKeF7CyuQP8O
         dvagzlkTW6LLck586NgvF9BbyGlEmd5qgYLO8c6jWb1eoIF7FOgFtFgM34txlKFhLtdI
         xL8mNGln36DyNaqQqJc6qHSFMVX87IOyGJmxxX8SApMjX1nN6KPP4KoDdSDhVoL5kto6
         QcIeqczotNan0cthbCsyPui6tvCl1NY6A6GMNsMl/IhNXeGY4PXoFHy3Mzobzkgu0LQ7
         y64Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwCCKPPmA2yC50xNAV0pfk4ig/4/ttMC0TbjTdJcKUjkLWPHcDwvW2wmFtt8ZdcrJws1rb+LoytwoHfkxRXnzi8wAuuvEWp8Iu/UGtiD1P
X-Gm-Message-State: AOJu0YzAY5v1GiWg8BrXEVQC0q4hVjRO6ZFyY81xNzwuAcEYB0tzoLYN
	V49c/ji0e0QCB7IZdP8B4VmLmtMHASQwlH3vKuhC4w3c2BfvEq2UTVLygaLIpIz6ClEuw+YAkbd
	H+cUIheELigQy+JjGENcdtPAXKWZmbB7Cmiwa2GlclEinslybNSi7fsQ=
X-Google-Smtp-Source: 
 AGHT+IFocCpxDhklmIVXj6a6DiahtPX5mvpPE6Y9X0Lw7VbxCcJzYqa3K4GYh97gZ0Y1dhU/YVjfyE6WDJEtfFxp0EAOQ/3lB0g2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:363:cb3c:f304 with SMTP id
 w14-20020a056e021c8e00b00363cb3cf304mr574998ill.4.1707733584584; Mon, 12 Feb
 2024 02:26:24 -0800 (PST)
Date: Mon, 12 Feb 2024 02:26:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae28ce06112cb52e@google.com>
Subject: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
From: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: TMDCWO34Y452BDDGREQHWSRNNWDBSVNZ
X-Message-ID-Hash: TMDCWO34Y452BDDGREQHWSRNNWDBSVNZ
X-MailFrom: 
 3UPLJZQkbAJEDJK5v66zCvAA3y.19916zFDzCx98Ez8E.x97@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TMDCWO34Y452BDDGREQHWSRNNWDBSVNZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    41bccc98fb79 Linux 6.8-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14200118180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=451a1e62b11ea4a6
dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0772069e29cf/disk-41bccc98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/659d3f0755b7/vmlinux-41bccc98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7780a45c3e51/Image-41bccc98.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor.0:28718]
Modules linked in:
irq event stamp: 45929391
hardirqs last  enabled at (45929390): [<ffff8000801d9dc8>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
hardirqs last disabled at (45929391): [<ffff80008ad57108>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (45929391): [<ffff80008ad57108>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (2040): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (2040): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (2052): [<ffff80008aacbc40>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2052): [<ffff80008aacbc40>] batadv_tt_local_resize_to_mtu+0x60/0x154 net/batman-adv/translation-table.c:3949
CPU: 1 PID: 28718 Comm: syz-executor.0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : should_resched arch/arm64/include/asm/preempt.h:79 [inline]
pc : __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:388
lr : __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
sp : ffff80009a0670b0
x29: ffff80009a0670c0 x28: ffff70001340ce60 x27: ffff80009a0673d0
x26: ffff00011e860290 x25: ffff0000d08a9f08 x24: 0000000000000001
x23: 1fffe00023d4d3c1 x22: dfff800000000000 x21: ffff80008aacbf98
x20: 0000000000000202 x19: ffff00011ea69e08 x18: ffff80009a066800
x17: 77656e2074696620 x16: ffff80008031ffc8 x15: 0000000000000001
x14: 1fffe0001ba5a290 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000040000 x10: 0000000000000003 x9 : 0000000000000000
x8 : 0000000002bcd3ae x7 : ffff80008aacbe30 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : ffff80008aecd7e0 x0 : ffff80012545c000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
 __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:386
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_tt_local_purge+0x264/0x2e8 net/batman-adv/translation-table.c:1356
 batadv_tt_local_resize_to_mtu+0xa0/0x154 net/batman-adv/translation-table.c:3956
 batadv_update_min_mtu+0x74/0xa4 net/batman-adv/hard-interface.c:651
 batadv_netlink_set_mesh+0x50c/0x1078 net/batman-adv/netlink.c:500
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0x874/0xb6c net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:51
lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:103
sp : ffff80008ebe7cd0
x29: ffff80008ebe7cd0 x28: dfff800000000000 x27: 1ffff00011d7cfa8
x26: ffff80008ec6d000 x25: 0000000000000000 x24: 0000000000000001
x23: 1ffff00011d8da74 x22: ffff80008ec6d3a0 x21: 0000000000000000
x20: ffff80008ec94e00 x19: ffff8000802cff08 x18: 1fffe000367ff796
x17: ffff80008ec6d000 x16: ffff8000802cf7cc x15: 0000000000000001
x14: 1fffe00036801310 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 0000000000bf0413 x7 : ffff800080461668 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008ad5af48
x2 : 0000000000000000 x1 : ffff80008aecd7e0 x0 : ffff80012543a000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
 cpuidle_idle_call kernel/sched/idle.c:170 [inline]
 do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
 rest_init+0x2dc/0x2f4 init/main.c:730
 start_kernel+0x0/0x4e8 init/main.c:827
 start_kernel+0x3e8/0x4e8 init/main.c:1072
 __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523


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
