Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2623C30653
	for <batman@archiver.kernel.org>; Thu,  4 Jul 2024 17:25:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C941382FDF
	for <batman@archiver.kernel.org>; Thu,  4 Jul 2024 19:25:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1720113907;
 b=uxUP745OPxZO1i2ds3cKmu4w8KdJ7PoKQYo9i/k4J9jKDRn9ya9R7tXZlkh3PfrNzZqce
 wbhiWxyInmBUMEMuUFC4780uXbFcEM3O7gbXvC6Bg2xO0dXETn/VSqMSBcSj5+FkO3FBswh
 45t09s3tP3sG3rH3rd+3TJesGCMh+JM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1720113907; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qUKxMIsnh86EKvdFfJf776bnEDX8f4aMiOh9C/pfS/o=;
 b=GkBy7p+S5kdCJXUBZdFBajb45+ppfsyPcXuGww3R9DuEF+QJO0GVfaQBa7/iHtXvMLCft
 b+napqyGGxTcxvA1MgVE6oOutVcWqVvGRHQws/kZSj9rtsxCnIbsnpNUFbsGzTp6NCABQIE
 zekCe7Ryv2nzSAgjGbiEL4HmpHYrLTA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6768281425
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  4 Jul 2024 18:33:22 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1720110802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=qUKxMIsnh86EKvdFfJf776bnEDX8f4aMiOh9C/pfS/o=;
	b=gLh+v6RnWZXpvYrfqnVoMrL/FBQ1XGkWx6q+6cHHBtgcxQXExzSC3KBreNqWHRDNsbL/lw
	FuHLXcoND5SJCau+Ga0hGniIUjbbB73eXBbHAlEnIk657pFZzSmW2VUyP88zcWv3o3CvmV
	jSwx/4yNiqhep+d0v2+EmPHfxlhjRQE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 30c6GZgkbAMQ289ukvvo1kzzsn.qyyqvo42o1myx3ox3.myw@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.70 as permitted sender)
 smtp.mailfrom=30c6GZgkbAMQ289ukvvo1kzzsn.qyyqvo42o1myx3ox3.myw@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1720110802; a=rsa-sha256;
	cv=none;
	b=nvVrQlichn1vPcXCpvLCIxXUinHvSmIqMGdySzXLBqaP1LiRE7CxNdRYWrgcCX3u4n+eQ1
	pIGMw5AwkvOPehaGJQ5juEZmuU+2ZeKvJA6DlM0Hj4pcULAtJdfcZ4ToSWDpqv3H+lPM34
	VoXK/RiQCdu6s51YwBZ2Es5BCCz11bA=
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7ebd11f77d8so104824739f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 04 Jul 2024 09:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720110801; x=1720715601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUKxMIsnh86EKvdFfJf776bnEDX8f4aMiOh9C/pfS/o=;
        b=R1Qp2JkU5wVe++cqr38zSwKEPGArVBVv7LbRIJudwlNV9Rru3dK2rERLJFjBrfnjgJ
         PD64omyodouyzgbXw8tLR0///NseLZWh5yl1FW6y8qKq9mtg/uvszuC7TeFwHv/1Hcpc
         6ft4P2XUW1C7vvKYSltjmjoLHxWJ9cVJxv10RaTqRfXfVHA/65UXUv5OLnYoH26HU3oH
         LLkT0G+tth0hjqw7TJBEszmFYlXn2QMAXzHiJXhpUIF7/DGoTrYO87/NDodglNwX0sVu
         PjxXyvgvL8Z13rM53pbuu6amBoXvAHa68GAgQszKGnb6EXCDZWulks1ij6cgfthD2yT4
         F+Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW14xnrvZ1Ly175UYb9JOqSIYonDoTwPe1fH/zMJMmkeAhH5VtbpvhkqXAXnwIoEapiQnxyDDAgP0vFexSgJwWiqVKODXiZ5FAbwgs5xQFn
X-Gm-Message-State: AOJu0Yw0R4/cBFhH8xx/VMDXpVqvtmrdOyY/lfLoeX88qxTf+icdYhAs
	1NCqADt/0wRPhIpFg6qfK+J0dfZywLgX9x03RwmZiTY1pehWY65JXqdQSBusShY1LeRnvqtPQ35
	NO330i3ISbtMgPXW0yx7/xYcsgW5Ybo3FSYsL1fFLBlBMykr4E9kAzvA=
X-Google-Smtp-Source: 
 AGHT+IHWysKmk8S/npyqeKHy2fCBHQ0tjog4ECmymqcWf0CzoBCgl3niFulWEkUAN0knz+qOG6w83FwEhbZEe9xToq7ABFNUgu/A
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4118:b0:4bf:38f9:eb1b with SMTP id
 8926c6da1cb9f-4bf643fbae3mr110699173.6.1720110801082; Thu, 04 Jul 2024
 09:33:21 -0700 (PDT)
Date: Thu, 04 Jul 2024 09:33:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045f576061c6e8142@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in
 batadv_iv_send_outstanding_bat_ogm_packet
 (5)
From: syzbot <syzbot+7beee86dd68b7ee38e4a@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 30c6GZgkbAMQ289ukvvo1kzzsn.qyyqvo42o1myx3ox3.myw@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: NYVRMW5KWQ6N2QW2Q2CKFR6I4JLC3OJP
X-Message-ID-Hash: NYVRMW5KWQ6N2QW2Q2CKFR6I4JLC3OJP
X-Mailman-Approved-At: Thu, 04 Jul 2024 19:24:57 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NYVRMW5KWQ6N2QW2Q2CKFR6I4JLC3OJP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1182b083180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=7beee86dd68b7ee38e4a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7beee86dd68b7ee38e4a@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:5:575]
Modules linked in:
irq event stamp: 132863
hardirqs last  enabled at (132862): [<ffff80008ad68de8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (132862): [<ffff80008ad68de8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (132863): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (132863): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (128034): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (128034): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (128036): [<ffff80008aad75f4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (128036): [<ffff80008aad75f4>] batadv_tt_local_commit_changes+0x24/0x44 net/batman-adv/translation-table.c:3717
CPU: 0 PID: 575 Comm: kworker/u4:5 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
lr : queued_spin_lock_slowpath+0x168/0xcf8 kernel/locking/qspinlock.c:383
sp : ffff800098c77720
x29: ffff800098c777c0 x28: 1fffe0001b8a126a x27: 1ffff0001318eef0
x26: dfff800000000000 x25: 1fffe0001b8a126c x24: ffff800098c77740
x23: ffff800098c77780 x22: ffff70001318eee8 x21: 0000000000000001
x20: 0000000000000001 x19: ffff0000dc509350 x18: ffff0001b4015840
x17: ffff800125414000 x16: ffff8000809fd934 x15: 0000000000000001
x14: 1fffe0001b8a126a x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b8a126b x10: 1fffe0001b8a126a x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff80008aad75f4 x6 : 0000000000000000
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
 batadv_tt_local_commit_changes+0x24/0x44 net/batman-adv/translation-table.c:3717
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:811 [inline]
 batadv_iv_ogm_schedule+0x1ec/0xdf0 net/batman-adv/bat_iv_ogm.c:868
 batadv_iv_send_outstanding_bat_ogm_packet+0x740/0x900 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


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
