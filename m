Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1025C88E40
	for <batman-adv@archiver.kernel.org>; Sun, 13 Sep 2026 07:53:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D8D6F842FF
	for <batman-adv@archiver.kernel.org>; Sun, 13 Sep 2026 09:53:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789286006;
 b=VEbysvVtL5UWCOuPSl2aJbWBx92dOLcjnWWsPL+zT6roHo33pCKszcAtKQZDLwrfBbdcA
 Tp3uw8cW268qyDL1eExdADZWh+GcezgUwGAslX05OSJwLN5ZBYhc4/yJofppdVyWgzZdrSh
 q3uVNiFWRUkvtqGEebR5Q5o8ONVctZk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789286006; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bvFXA7ZMQ0Qs9h5Sn4zOQqZDFnGcVyURyKazgFI6Ib8=;
 b=MiZzHBsiR2yRPI2J68OG4OIg5MWM4yAMK3EkQjsH7iFjrpA/qCAnqG9BLOa9sdxaDk9GL
 q2QhQEp6HNavl8gdbn/fYvMvwNSTNSzor1EEQN5JGxSM8Dyrsma7TV55LJsrXMUQLw5JKRi
 JCy2vlhOTkPxcdXpi53fGSIPl5n2zCs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com
 [74.125.231.133])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 509B580317
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 13 Sep 2026 04:47:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789267669;
	b=2w3AAUKyqUbrQszaS5L09P3p+Agr04ojpE64LUrvTZyHH5BCGoSINdPD9CNNWyZmhkt1a2
	6Oy5bxVe2l8GN+Ms7SPVj4/9TOrrJo7SAQ4GRp8I2xFxfN23gyG9L/TAqdlWu16KVI3GBp
	HVeitnSWRXGnI55LWnZZPQ0pe72D1Sg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789267669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=bvFXA7ZMQ0Qs9h5Sn4zOQqZDFnGcVyURyKazgFI6Ib8=;
	b=doJ1d9x3ECZ+fMNrBsPfyt4j8u+ZohHyzGcIpiDAoYuimPNpakhT3l+JFuKtUkkClArlxe
	V7p8vVKvJOCHZcsvZk16QKOv3JWSaH57pTZf2oT07+wVKF4Yh4jo9xGCKue/FHB2gvdSxt
	vfw1D2A3fb4WEi1Et5dj/d+mEh5CJTA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3yQ6magkbANoOUVG6HHAN6LLE9.CKKCHAQOAN8KJPAJP.8KI@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 74.125.231.133 as permitted sender)
 smtp.mailfrom=3yQ6magkbANoOUVG6HHAN6LLE9.CKKCHAQOAN8KJPAJP.8KI@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f5.google.com with SMTP id
 46e09a7af769-7f66624aa21so445897a34.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 12 Sep 2026 19:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267657; x=1789872457;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvFXA7ZMQ0Qs9h5Sn4zOQqZDFnGcVyURyKazgFI6Ib8=;
        b=juOb0YV0x20CXH9QaQ53QC0xpJ15G1j24+bPzk+M/aAVNadw0zL030njpUYA+el4GC
         wWTll51gXV/NQEZlxu99STxtdSoiFSCLfy6sR3WM0oLI2VyDCfpmybvcCUVzoe1x3woX
         kzbcJFg04z6FQ19aBs+Vt87aqMa7hZh1bTy7X0NJwBOqzlOSxdzWW2BAbR7YMKNhHCc9
         Go9EZNCT5c9+dewmkjQkakmBTfXrxnYvTmeOiN/EzMKQO8l9wg2+JirBhuleWvWl5j2u
         OAAIwr37RGUhNAoSDviMtRAEcENTokRoL4Su94iLyfP/BHXKTwPxEFdY48vlworllR3z
         2cjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR332xyFzSw1+j2huG+fv3mVTZoj9PXeN2rVEdFXU/5H5s5SMkoQk3td9btADFqEUNXxN3wfgvb8aYiw==@lists.open-mesh.org
X-Gm-Message-State: AFuF++lc7xwTtcmb7i28taroqFWXKVWmcLYVswEQpRDtT9LrIUEQQ6K5
	Pi+DoFDgP/uTTZ9+Ean3TvqRFuc55GdRLhndGiD8WJNEY3faRSqcth7nGCIak1aApY9Vx3CTb9b
	LpNhGdvcjdVB9zvsTloOsDcUMlrANVyXqilp4inhhM6ypLJnqQBSjAfqajls=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:169e:b0:6aa:da04:b56f with SMTP id
 006d021491bc7-6c24c6ca779mr2331851eaf.3.1789267657282; Sat, 12 Sep 2026
 19:47:37 -0700 (PDT)
Date: Sat, 12 Sep 2026 19:47:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa60ec9.f81106d8.2ab401.0032.GAE@google.com>
Subject: [syzbot] [batman?] WARNING in batadv_iv_ogm_process_per_outif
From: syzbot <syzbot+a079f084653164a652d1@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3yQ6magkbANoOUVG6HHAN6LLE9.CKKCHAQOAN8KJPAJP.8KI@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: VHE4ZWFF5GPSACXHW5TGR5W2QXFFKZRI
X-Message-ID-Hash: VHE4ZWFF5GPSACXHW5TGR5W2QXFFKZRI
X-Mailman-Approved-At: Sun, 13 Sep 2026 09:53:19 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHE4ZWFF5GPSACXHW5TGR5W2QXFFKZRI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170ef749580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=a079f084653164a652d1
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108ef749580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b696f9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daf497619736/disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/748fbd82f647/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61c59099d07/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a079f084653164a652d1@syzkaller.appspotmail.com

RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
!orig_ifinfo
WARNING: net/batman-adv/bat_iv_ogm.c:1413 at batadv_iv_ogm_update_seqnos net/batman-adv/bat_iv_ogm.c:1413 [inline], CPU#1: syz.1.17/5794
WARNING: net/batman-adv/bat_iv_ogm.c:1413 at batadv_iv_ogm_process_per_outif+0x1fe4/0x25c0 net/batman-adv/bat_iv_ogm.c:1550, CPU#1: syz.1.17/5794
Modules linked in:
CPU: 1 UID: 0 PID: 5794 Comm: syz.1.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:batadv_iv_ogm_update_seqnos net/batman-adv/bat_iv_ogm.c:1413 [inline]
RIP: 0010:batadv_iv_ogm_process_per_outif+0x1fe4/0x25c0 net/batman-adv/bat_iv_ogm.c:1550
Code: ff ff e8 af ad 1c f6 49 bc 00 00 00 00 00 fc ff df e9 80 f4 ff ff e8 9b ad 1c f6 90 0f 0b 90 e9 47 e1 ff ff e8 8d ad 1c f6 90 <0f> 0b 90 48 8b bc 24 80 00 00 00 e8 6c df ff ff 48 c7 44 24 50 00
RSP: 0018:ffffc900030e7280 EFLAGS: 00010293
RAX: ffffffff8bab1d03 RBX: ffff888078df0a00 RCX: ffff88802efc3e80
RDX: 0000000000000000 RSI: ffffffff8e475f59 RDI: ffffffff8c6d9a80
RBP: ffffc900030e7410 R08: ffffffff907a2b7f R09: 1ffffffff20f456f
R10: dffffc0000000000 R11: fffffbfff20f4570 R12: dffffc0000000000
R13: 0000000002020000 R14: ffff88802bce4000 R15: ffff888078df0a00
FS:  0000000000000000(0000) GS:ffff888124dd2000(0063) knlGS:000000005807c480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7153200 CR3: 000000007a636000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 batadv_iv_ogm_process net/batman-adv/bat_iv_ogm.c:1866 [inline]
 batadv_iv_ogm_receive+0xc13/0x1740 net/batman-adv/bat_iv_ogm.c:1974
 batadv_batman_skb_recv+0x4b6/0x870 net/batman-adv/main.c:529
 __netif_receive_skb_one_core net/core/dev.c:6264 [inline]
 __netif_receive_skb net/core/dev.c:6377 [inline]
 netif_receive_skb_internal net/core/dev.c:6463 [inline]
 netif_receive_skb+0x4af/0xbf0 net/core/dev.c:6522
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1571
 tun_get_user+0x2be0/0x44d0 drivers/net/tun.c:2045
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x27a/0x6a0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f480ec
Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
RSP: 002b:00000000f752fa5c EFLAGS: 00000206 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080000800
RDX: 0000000000000026 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	85 d2                	test   %edx,%edx
   3:	74 0a                	je     0xf
   5:	89 ce                	mov    %ecx,%esi
   7:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
   d:	89 32                	mov    %esi,(%rdx)
   f:	85 c0                	test   %eax,%eax
  11:	74 05                	je     0x18
  13:	c1 e9 0c             	shr    $0xc,%ecx
  16:	89 08                	mov    %ecx,(%rax)
  18:	31 c0                	xor    %eax,%eax
  1a:	5e                   	pop    %rsi
  1b:	5d                   	pop    %rbp
  1c:	c3                   	ret
  1d:	90                   	nop
  1e:	0f 1f 00             	nopl   (%rax)
  21:	51                   	push   %rcx
  22:	52                   	push   %rdx
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	58                   	pop    %rax
  3f:	b8                   	.byte 0xb8


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
