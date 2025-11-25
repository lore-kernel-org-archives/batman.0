Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E618D0EE0A
	for <batman@archiver.kernel.org>; Tue, 25 Nov 2025 16:37:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6C2468592C
	for <batman@archiver.kernel.org>; Tue, 25 Nov 2025 17:37:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1764088659;
 b=NKFESKYx/S1Elp5ZVBA7HIOKa/HHK0BbprUhTkFCTnSVBJfjAMDSgbRaFxqeSfmFPEk2m
 kCM5QhdnwJbwjRzlbo+I734C+3rjSM7v9OCMmPxMLRoplZpMHktjAVPZc3FZGJ/C9BZLQCE
 i1c69Bmb9KmtKymNGI7pX96dfLV4qdU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1764088659; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gfXZ3XK6DpHsWJXameHSeCP+SGhHaEw9qBBrLcmfyvg=;
 b=mtGT/1YDGvTxhKatYk4Zla5kkY4KQ9nqYTDSTJ58lK2SL0p9fGoH/4PWyzj/vv+26VbT5
 oiK0/alI8RxJlNKxPdGSzclkKTwP/BbOIklyNnuU0o8Pwx8MoTSX2RyEhduR79nHNOsPc38
 DxnnzG+Ct8vNynA0ciaYRb1c76j7d4o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com
 [209.85.166.206])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 51E1F83091
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 25 Nov 2025 17:32:29 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1764088349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=gfXZ3XK6DpHsWJXameHSeCP+SGhHaEw9qBBrLcmfyvg=;
	b=c3xvxlpFKcOwxRjhuPSo+Qil//kCMerm/naVvytoGxcNK10p/XJuDRkjdBGMJzKSlZTExL
	C0JVAtyzGtmV2TT+EpUQ29HhO8N96eDaLpvhRfNU9o1VtvKK1QB9RAXBTDMJYnS09azriA
	qeLD9nkZMkihf68FQ4hWnYd82fFGmcg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3G9olaQkbALYouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.206 as permitted sender)
 smtp.mailfrom=3G9olaQkbALYouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1764088349;
	b=FyBOd07LWDzk9gdirr3cypwQih4uNnNELmpjykWGKm/+w1oICjHneBRWPao7fn9vrnyaQn
	kADZ5Exr9+Wfg04Md5hk2OXHobozowocc+8jwf7K51ubb0ABswHfJD5otK2ITaOW2HTfgq
	bC9B/4v9/l8xplxnhsRSE1KrKxzDvFI=
Received: by mail-il1-f206.google.com with SMTP id
 e9e14a558f8ab-433770ba913so57356775ab.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 25 Nov 2025 08:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764088347; x=1764693147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfXZ3XK6DpHsWJXameHSeCP+SGhHaEw9qBBrLcmfyvg=;
        b=ip0nw1KsLz+8OPzlrHQNiIx3DgwYMBOgztnPYCX2soVUgPjdShgTE3eUQmxKDJ3tRD
         qXwQnuHmSAN0mZPfcrqfWcwvXGZCOn1+qVjSroT5jqCSuQZETMKJF2OBVeYBnsJGcG9p
         azZf6ZXurcH+/ZToVBsG9/VyMHeAR3Mgn+lnjLDumNzxOxHcy5LVN/Mv6wQq80FKWG29
         4wO9S0MYEtKps/nBh2ThDkxUztnainQxSm2LN+5B0GlZGCvkH69qh4qFmaSi3SwCuArp
         2qcVsTJKlBed/7yNucOdm+orZ4MLcczcPf9VvJbyc3ErRmN+ynsPtP30vQxNINYZ0FK6
         zcnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvZMxEoE/h79kXWLXkY1DofGDcbnRANhDIi34+iP7xX4Zl4Po9MwL6Ba4t2l4Rcn/PscB3fI8QIOYMQg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yzr2N6Xd+FNdd3AqvEa4Q10InzDgJ36YpKO/R45ut/VXsLuXdLR
	AmXArqmj9reR6upNHPVTwCl3wtbESrenpPfWRW0WGpnRQRABKcqL7MBKUOrK9NjhdARX+rJOv9L
	uIcX7lbz9OCRV65+qgs8tAYxNm9U6ChNOhOUyaA9fqLDfZ0qjor5xunbVFHE=
X-Google-Smtp-Source: 
 AGHT+IEccsvlKZG5dGvuqW554f73GUIIAi74tnh3xbg+OxgkYwfplJaWHZY/8jm+IZPasDtwCYQ1exmkziXTC4idi/IYLkAVb/Nn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349d:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-435b8ec96e8mr178679055ab.32.1764088347179; Tue, 25 Nov 2025
 08:32:27 -0800 (PST)
Date: Tue, 25 Nov 2025 08:32:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6925da1b.a70a0220.d98e3.00af.GAE@google.com>
Subject: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
From: syzbot <syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3G9olaQkbALYouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: JW4RVX3HOOZWYELAX7YJBOBN2HL4MYDG
X-Message-ID-Hash: JW4RVX3HOOZWYELAX7YJBOBN2HL4MYDG
X-Mailman-Approved-At: Tue, 25 Nov 2025 17:37:18 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    d13f3ac64efb Merge tag 'mips-fixes_6.18_1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16333a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123f4e92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15418612580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d13f3ac6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a7fb613c712/vmlinux-d13f3ac6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea4e1a2bb3be/bzImage-d13f3ac6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com

syz_tun: entered promiscuous mode
bond0: (slave syz_tun): Enslaving as an active interface with an up link
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 0 UID: 0 PID: 5625 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
 hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:741
 hsr_handle_frame+0x6ce/0xa70 net/hsr/hsr_slave.c:84
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0449f8e1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007ffd7ad94c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f044a1e5fa0 RCX: 00007f0449f8e1ff
RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
RBP: 00007ffd7ad94d20 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
R13: 00007f044a1e5fa0 R14: 00007f044a1e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	03 42 80             	add    -0x80(%rdx),%eax
   3:	3c 20                	cmp    $0x20,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 f7                	mov    %esi,%edi
   b:	e8 23 29 05 f9       	call   0xf9052933
  10:	49 83 3e 00          	cmpq   $0x0,(%r14)
  14:	0f 85 a0 01 00 00    	jne    0x1ba
  1a:	e8 94 dd 9d f8       	call   0xf89dddb3
  1f:	48 8d 6b 7e          	lea    0x7e(%rbx),%rbp
  23:	49 89 ee             	mov    %rbp,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 d1 01 00 00    	jne    0x208
  37:	44 0f b6 7d 00       	movzbl 0x0(%rbp),%r15d
  3c:	41 83 e7 0c          	and    $0xc,%r15d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
