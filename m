Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE916CD11DB
	for <batman@archiver.kernel.org>; Thu, 21 Mar 2024 18:26:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0A1EF81977
	for <batman@archiver.kernel.org>; Thu, 21 Mar 2024 19:26:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711045604;
 b=rR7I3K9nDlIFxSa2G4fRt6U2GeIVfrPmu6P2Th0/DUHb47k9Dk18NGjlz1SxVn0coex6N
 zOMV2P6jsybEVNqDJQGMhx7aFz2ZelqQcO/lwoRFD4ImuAHp9fg8DE4i5NFfg52EnQbp05a
 RwZNHOZLKIv1lXPUDcHVVOBAVGA4+nk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711045604; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gGGGJ6hS+NX1gIEP6zG3HfxGpBxruXr4DhrSeWnJUq0=;
 b=d4UviLCUCqiUaUNIOzgcbM81HSQeT9jRuZLG1VWxFUctKIGEY/1GFOlYNceNAImHbrrbG
 zz9vq/SznaAybZQbx1runKjk8CkhmGduuM4xoVLqlsNHaUSm5CyQazq1ZoyCWVbs1zxU5ds
 C2dSYsZ0vPye8gvF6nNJUjocYPJK+M8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1E4E681208
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Mar 2024 19:26:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711045584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=gGGGJ6hS+NX1gIEP6zG3HfxGpBxruXr4DhrSeWnJUq0=;
	b=0/wmejeWIXb6pwYIn6zIe3684vdixu8qJtmBcK1AQxJLTbRb4c7Ljqx32ODTc3BIj4iRyl
	LncLornDHja+2Cu3+Udx+JVrvIyZzgiTkEX4xidNJx6Qhqynd/DELjDkJ4z8nFyOFO1I1z
	Lh3zqI0vigCVXQA4us34Dx8ltKud8X0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711045584; a=rsa-sha256;
	cv=none;
	b=nS1cxj8dY9BAx/dBp1XBIV3w8xcHZxy3fiA3PWd8rKTUiHSoGCDYrVBYyESLT/yfRoMRH7
	BU++L/P6H2+Efc/clUOnH04miydn7azLqHpVg47afEFP8xK+6+oaTmd8HI0ddTXp8Ny2CT
	jUvHNjBVdw6PDseKM08LuZ1Ftw5UjS4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3znv8ZQkbAO0hnoZPaaTgPeeXS.VddVaTjhTgRdciTci.Rdb@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.70 as permitted sender)
 smtp.mailfrom=3znv8ZQkbAO0hnoZPaaTgPeeXS.VddVaTjhTgRdciTci.Rdb@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7cf179c3da4so134768039f.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 21 Mar 2024 11:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711045583; x=1711650383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGGGJ6hS+NX1gIEP6zG3HfxGpBxruXr4DhrSeWnJUq0=;
        b=w/zrpILTXYWH4EfLBCGHkBA9rDjZ8E2++1FEK5UioDkeaudN+hIjrSRc4cEH0DMavJ
         KSGXHYPC3zAr1AWBoshjLHtqGZdxjQe6nu+8DBjftzedQ56eVjAMrGCj0aDc4UdYlG7d
         CbtIgoPjwF5J2El/jx8a+BJyTB+AQulZCMWkpm5XLZ1eLkFk+a5Cvc65B0PvJuUdSMQP
         niB3ntgdyowYTKvGzvPxO44DKECaOwuG8rvsoQZY1HebSwguEhSDJeEUw2jJZCfoQNKq
         sEhMgtImmNrk/FosVbghLs6EOogJc8QP+hvbonuqVxMfkLbrbb2aErNDPGb3Sm+JnoW7
         IbQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOymjwBgUQTUKdF5dZv2bLQ+t2OSXUX5tFNStQzD1VVc639ZBMnAea+Xd7v4WJtmKl+dSx8lBUGaVMufYtfNSmG0U3FiOGZozd1OKnqY3o
X-Gm-Message-State: AOJu0YxFksVFTvEQVUCXMtMks8VGNiVctDICAbGA5qXmgL8ywxP8JI3H
	bXBsq0nVDKA1kY9wOn3HSK4u0wN8i6pgQY2d97kz9hYZ9VjKlpv5QMRCdXTSE8gstFaTbZl9ptK
	Hd0VK/Fwehd0dWK/0e8SA1ZrrABo6HfN7D7ORXydjvzb3mWsEDx1kjhs=
X-Google-Smtp-Source: 
 AGHT+IEzP9RQul65NSXzneKuudOdALyA2dyeNUf+LKuf/Nf3oynssdZsGa0i02ku//6FChBjtl5SnfQsZDXJK5VBLP6v7KRISl4N
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270b:b0:474:c3b5:a8b7 with SMTP id
 m11-20020a056638270b00b00474c3b5a8b7mr238jav.6.1711045582799; Thu, 21 Mar
 2024 11:26:22 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:26:22 -0700
In-Reply-To: <000000000000ae28ce06112cb52e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002854eb06142fd863@google.com>
Subject: Re: [syzbot] [tipc?] [batman?] BUG: soft lockup in sys_sendmsg
From: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, jmaloy@redhat.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: MDQMWZSI5AJSYXDIZS273AGHDLGPETDV
X-Message-ID-Hash: MDQMWZSI5AJSYXDIZS273AGHDLGPETDV
X-MailFrom: 
 3znv8ZQkbAO0hnoZPaaTgPeeXS.VddVaTjhTgRdciTci.Rdb@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MDQMWZSI5AJSYXDIZS273AGHDLGPETDV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

syzbot has found a reproducer for the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=134d4fa5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139a4c81180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108b0ac9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [syz-executor227:7772]
Modules linked in:
irq event stamp: 5373
hardirqs last  enabled at (5372): [<ffff80008ad68de8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (5372): [<ffff80008ad68de8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (5373): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (5373): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (542): [<ffff800088e9a56c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (542): [<ffff800088e9a56c>] release_sock+0x154/0x1b8 net/core/sock.c:3547
softirqs last disabled at (548): [<ffff800088eaf8bc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (548): [<ffff800088eaf8bc>] lock_sock_nested+0x74/0x11c net/core/sock.c:3526
CPU: 0 PID: 7772 Comm: syz-executor227 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
lr : queued_spin_lock_slowpath+0x168/0xcf8 kernel/locking/qspinlock.c:383
sp : ffff800097ca76c0
x29: ffff800097ca7760 x28: 1fffe00018e1be6b x27: 1ffff00012f94ee4
x26: dfff800000000000 x25: 1fffe00018e1be6d x24: ffff800097ca76e0
x23: ffff800097ca7720 x22: ffff700012f94edc x21: 0000000000000001
x20: 0000000000000001 x19: ffff0000c70df358 x18: 0000000000000000
x17: 0000000000000000 x16: ffff8000809fd934 x15: 0000000000000001
x14: 1fffe00018e1be6b x13: 0000000000000000 x12: 0000000000000000
x11: ffff600018e1be6c x10: 1fffe00018e1be6b x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff800088eaf8bc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008ae5db50
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline]
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline]
 queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x320/0x348 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:127 [inline]
 _raw_spin_lock_bh+0x50/0x60 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 lock_sock_nested+0x74/0x11c net/core/sock.c:3526
 lock_sock include/net/sock.h:1691 [inline]
 tipc_sendstream+0x50/0x84 net/tipc/socket.c:1550
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
