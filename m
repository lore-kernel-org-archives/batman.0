Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EB606A31C
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 07:31:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 28E4C846EF
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 08:31:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794382292;
 b=rWm97rEp142Y6wBTxpN1aePwMrjlr4Olqb042n+3lg57/XPisyH0HfK0onv1jUgmX7BB1
 KshCy0vMb6ZNc0N2UphDZ0LgEPQUXnkW1K8E3oDUaMoGofV7/DaxZ5mzrAQskXFPpPsdRHj
 aFTizk3hN55+CqjQqqQuUuqXnMGAZTE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794382292; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bqAQthlYWXd2wB1UC1Kq1+fP5T/K7rstim8fmGmQbZY=;
 b=NgeIt5azv4vg5FbSxldHJDKFKTqCZtjKGZobFgW+Pi8rWZnqEYRiPrOplAPuDK9vIaoGo
 dzIiBcXx26LI1ZFzrhtZxMywpo3FPxCwXS49sSZLjajtdSS4uvCzdR6pofyBoX8HPYgARLL
 RscTV9etazHEyXnY4lmIPIIv4hw0dFg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 35A78820CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 03:26:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794363997;
	b=Ex3kkjW/OdqO0av+yiXp5NDEA9mkc7XnVyJykIBAhyS9shOX1KWaML1ttMCZG1OOSnxJOr
	3maXgFsmQpdQohxRD5sGRVZeb39sC4UdpJZgHh9qR8bclMlCuu2FcUEnjKYcsbHC/N6VD3
	oUj5MHfjYXCU8ntA8qTGADE98SMUc44=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794363997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=bqAQthlYWXd2wB1UC1Kq1+fP5T/K7rstim8fmGmQbZY=;
	b=OFyaQ7xh/a3P0eiAawASLIi6LMsMkYKKaCLIUL9RKmj3zc4323hpVp6AdgLKxAgGyK0OFI
	9yvE6A32UKHFBsiVruzUcsL+q7J3rlQYafkBJM2f+g3x9Cv5smgUWasgKSMKSTVrvDMHmF
	Q6NDxy9SCE1AzJbaoGF8YbCJSt7l1tE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3W9LzagkbAC4cijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.210.69 as permitted sender)
 smtp.mailfrom=3W9LzagkbAC4cijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-81b20bea169so1868677a34.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 10 Nov 2026 18:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794363995; x=1794968795;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqAQthlYWXd2wB1UC1Kq1+fP5T/K7rstim8fmGmQbZY=;
        b=EVK1eD6Kcz2ttDghqxttEP48Pljm8XvRP83G5GsnTFvH9Q4knkJdmtwaJosXTId6er
         O2nBUCGz2E4nJwOC+KzVXhdYkGdUxbBsoNv0rKhgJ6i0ZQ4xn/hq4/aN1/gWX8UeSZhf
         2HFPjoO3SwD2z3kCztugQiDncUvH87k+laXe9e0VHb5K+B/D2sg6C+sTFiw3zYG3ntVA
         MigDhhk/Sezos5z6RMv7+wIzj/684+KR6QL7rnWRn3q7J8UIj86NNY1c9g0/IUERBYnz
         b2Tn6woAh7ecVBuu/0XTpAy5J0uAoKWPf2D+JcNGW6uuiEUicM1D+liC/1Aq6qUx4K7u
         WMWg==
X-Forwarded-Encrypted: i=1;
 AL+hErGnf0/8vhjPHuzgnneGljnHUM0xUtMQ5NvbvWNN0uoUbmeKpUK7O5x3+beFm1UgjMueX7q93UEyrhVUww==@lists.open-mesh.org
X-Gm-Message-State: APuU4Z/CaFJMkxBh4vOCBLa4e3vuMyhSij81pa6DhWqXLIdo27XzYVx7
	FXoJW5LqwFwJxJd9eijQK3BNA0Q8sDHtPS/SuS4hDrM2BGvmjHsBXYtrtHraQM38pywmMNrjfmv
	4RsdEDNu5tZnIONmizK0bAy/d/0JMlxR7N0WiCdPzVdWVrgJMrrxfh5ppsJc=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4442:b0:53e:3b0b:fc1f with SMTP id
 5614622812f47-56b961950b9mr845236b6e.22.1794363995259; Tue, 10 Nov 2026
 18:26:35 -0800 (PST)
Date: Tue, 10 Nov 2026 18:26:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af3d25b.17ff5aea.1b027f.01a2.GAE@google.com>
Subject: [syzbot] [batman?] WARNING in __batadv_dat_purge
From: syzbot <syzbot+89f07b62d8237346ecab@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3W9LzagkbAC4cijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: HSA3D3TABH3V3Q3BPYET65HP45KAQX4U
X-Message-ID-Hash: HSA3D3TABH3V3Q3BPYET65HP45KAQX4U
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:31:08 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HSA3D3TABH3V3Q3BPYET65HP45KAQX4U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

syzbot found the following issue on:

HEAD commit:    b3dfbde62cf1 Merge tag 'linux_kselftest-fixes-7.4-rc3' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17356f35580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16c0eae9c338e3c
dashboard link: https://syzkaller.appspot.com/bug?extid=89f07b62d8237346ecab
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/403baefe34aa/disk-b3dfbde6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7f58e7003b8/vmlinux-b3dfbde6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83e039a928f8/bzImage-b3dfbde6.xz

AI-generated root cause summary:
Under PREEMPT_RT kernels, `__local_bh_enable_ip()` enforces that hard IRQs are
enabled using `lockdep_assert_irqs_enabled()`. When `batadv_dat_purge()` invokes
`__batadv_dat_purge()`, `spin_unlock_bh()` calls `local_bh_enable()`, which
trips `kernel/softirq.c:289` because lockdep's per-CPU `hardirqs_enabled`
tracker was 0 despite CPU hardware interrupts being enabled (`EFLAGS.IF == 1`).
The lock and bottom-half operations in `__batadv_dat_purge()` and its callee
`batadv_dat_entry_put()` are properly balanced, indicating lockdep's per-CPU IRQ
tracking state became desynchronized from the CPU's hardware interrupt state.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=89f07b62d8237346ecab

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89f07b62d8237346ecab@syzkaller.appspotmail.com

------------[ cut here ]------------
__lockdep_enabled && !this_cpu_read(hardirqs_enabled)
WARNING: kernel/softirq.c:289 at __local_bh_enable_ip+0x1ea/0x2b0 kernel/softirq.c:289, CPU#1: kworker/u8:12/1182
Modules linked in:
CPU: 1 UID: 0 PID: 1182 Comm: kworker/u8:12 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Workqueue: bat_events batadv_dat_purge
RIP: 0010:__local_bh_enable_ip+0x1ea/0x2b0 kernel/softirq.c:289
Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 90 0f 0b 90 e9 66 fe ff ff e8 02 78 ec 09 41 f7 c4 00 02 00 00 75 d8 eb d7 90 <0f> 0b 90 e9 92 fe ff ff 90 0f 0b 90 e9 6f ff ff ff e8 e0 77 ec 09
RSP: 0018:ffffc9000694fa30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000046
RDX: 0000000000000001 RSI: 0000000000000200 RDI: ffffffff8b3e742e
RBP: 0000000000000400 R08: ffffffff90d5a8bf R09: 1ffffffff21ab517
R10: dffffc0000000000 R11: fffffbfff21ab518 R12: ffffffff8b3e7790
R13: dffffc0000000000 R14: ffff888061f74b90 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88812480e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1171a6000 CR3: 0000000034222000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 spin_unlock_bh include/linux/spinlock_rt.h:122 [inline]
 __batadv_dat_purge+0x343/0x400 net/batman-adv/distributed-arp-table.c:252
 batadv_dat_purge+0x20/0x70 net/batman-adv/distributed-arp-table.c:271
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
