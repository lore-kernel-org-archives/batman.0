Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DE4EE4996
	for <batman-adv@archiver.kernel.org>; Mon, 21 Aug 2023 16:37:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 22A728346A
	for <batman-adv@archiver.kernel.org>; Mon, 21 Aug 2023 18:37:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692635860;
 b=EtWFF/dZfhaVnd07h1oAZdLIO3C5tgtviW14HSGbJrjK0pmSs4LEdNnu4teAz9kcXgI6b
 ajPyJdAaLI5xuVs+x4W51ThMogVQWiyKbYtWXkavB97ifOk1IIAhhcNC+7yyGmkjqe4RUnZ
 +3oVi2hUTY5cbEeq3YYkulxZHGf5MIc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692635860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BDD5USCdzF0XvTmbtjPRBCArv23N9UaRYYO+TRRg6w8=;
 b=hYTCE9GaxzxJNTr25X8boBjURcT8Bi9wNV0rzo0fIBNSI4zyk12+Og/4Oo8DkXnBfeZyL
 zV3CLs4fNp54gItz77JtBV/YmGFCBJgvzRRsLWXliYtIKE/m5V0FEVBAxucr+q+rB3mOPMz
 bg3LWks7k/aSYAof2il5EnOXGdB++ds=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com
 [209.85.210.206])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A2F97814CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 21 Aug 2023 18:36:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692635818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=BDD5USCdzF0XvTmbtjPRBCArv23N9UaRYYO+TRRg6w8=;
	b=dHE6qpDQtzAPxV826BprTcC5UbISOn6470gU0Fad6c9a+YKa2IDwSgkWC0R2+bONjTuZvb
	2CPZ6aKU+DR6SX5yXqujcOXXeN4zcc2WJ+ntjKM4ieFct+t+EXAJOG/YBmhXh0bpMQoIJY
	OqaoowupMhoafkblVHjTBDmlrzRaJB8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3qZLjZAkbAIo6CDyozzs5o33wr.u22uzs86s5q217s17.q20@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.210.206 as permitted sender)
 smtp.mailfrom=3qZLjZAkbAIo6CDyozzs5o33wr.u22uzs86s5q217s17.q20@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692635818; a=rsa-sha256;
	cv=none;
	b=L+qUlN1ADb4D7MfCFXKM6svUb3Q0iflXfZyamJg/aHc2OJG061ZDxDZym8pXz9+jMzfUtg
	7ZaClOsHNoXjws02UHK4BPQMHJCFb2eTd0V2DjuH9nDZ5OME6UHTRR/aEA931VfGXhNwbs
	uiXUvVNuNGy5w0UjqNgk06SEw+dggqI=
Received: by mail-pf1-f206.google.com with SMTP id
 d2e1a72fcca58-68a4457af0eso1417902b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 21 Aug 2023 09:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635817; x=1693240617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDD5USCdzF0XvTmbtjPRBCArv23N9UaRYYO+TRRg6w8=;
        b=AeHVLEZ1gCb31+PO5frKo9qeC5PxMxxoJZAwpo8G1L8iWQLg7PkdhIH+0of4CmFXMI
         AIcEvehqrmqdrO/q8+GJ14HMxOuXWEzmqfQJTRNlf34DPqa84HsOCTDZdcqbAWmRsve7
         yLVU7tX5BoLCp11Tilk08nHJdOR8HewJTmeXBPuNkYryirkpVTRHyER46+NPyHca9b1Q
         +kCkDfrDxKnoqRyNVSgHoK6uH28uxXXHXWhiAYjqij9QjR+uadUCKppfDADKCXKZPui1
         Jcx5BgfolfaeZc53ZA1fqHbmXIU2tAKayWL6d3YrZYywtANZ+Q3QHERwhZIDNnhfHU7d
         5imA==
X-Gm-Message-State: AOJu0YzF0ribmxkAnlZNzm/uCSRPYs/9FRDyYoMCXW6hkXQnkWH/ubJP
	D9RhDjMLgzUj72TzDAaJ60lKZ0PVK6yMKJZlbQVQquu/x/xp
X-Google-Smtp-Source: 
 AGHT+IEjMZppxKe6/6h+fwsEG0O5XIgUEwl2q0PdLq/HL1dzzEReFBVuktFqgNu0ZmKfI45ftF2gtBIWDgmYMJqNxb03tr29wlIy
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2488:b0:68a:58e1:ebf5 with SMTP id
 c8-20020a056a00248800b0068a58e1ebf5mr1131975pfv.2.1692635817030; Mon, 21 Aug
 2023 09:36:57 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:36:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bbb4b0603717cde@google.com>
Subject: [syzbot] [batman?] WARNING in call_netdevice_notifiers_info
From: syzbot <syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: 36RRTJ4MEIFQPM3CWIBE5FO37PKZ3KY2
X-Message-ID-Hash: 36RRTJ4MEIFQPM3CWIBE5FO37PKZ3KY2
X-MailFrom: 
 3qZLjZAkbAIo6CDyozzs5o33wr.u22uzs86s5q217s17.q20@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/36RRTJ4MEIFQPM3CWIBE5FO37PKZ3KY2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    d44036cad311 net: dsa: felix: fix oversize frame dropping ..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f7ce23a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=f8812454d9b3ac00d282
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125cb53ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131847f7a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9936144a6193/disk-d44036ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1278ad87465f/vmlinux-d44036ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1a057709018/bzImage-d44036ca.xz

The issue was bisected to:

commit c6a953cce8d0438391e6da48c8d0793d3fbfcfa6
Author: Sven Eckelmann <sven@narfation.org>
Date:   Wed Jul 19 07:29:29 2023 +0000

    batman-adv: Trigger events for auto adjusted MTU

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104ef373a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=124ef373a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=144ef373a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")

------------[ cut here ]------------
RTNL: assertion failed at net/core/dev.c (1953)
WARNING: CPU: 0 PID: 5033 at net/core/dev.c:1953 call_netdevice_notifiers_info+0x107/0x130 net/core/dev.c:1953
Modules linked in:
CPU: 0 PID: 5033 Comm: syz-executor368 Not tainted 6.5.0-rc6-syzkaller-00126-gd44036cad311 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:call_netdevice_notifiers_info+0x107/0x130 net/core/dev.c:1953
Code: f9 40 84 ed 75 8d e8 d8 68 5e f9 ba a1 07 00 00 48 c7 c6 e0 34 81 8b 48 c7 c7 20 35 81 8b c6 05 07 35 6e 06 01 e8 f9 2a 25 f9 <0f> 0b e9 62 ff ff ff 48 89 df e8 ea 75 b2 f9 e9 15 ff ff ff e8 e0
RSP: 0018:ffffc900039df2b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffc900039df320 RCX: 0000000000000000
RDX: ffff88802d421dc0 RSI: ffffffff814ccc86 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000018
R13: ffff888078c30000 R14: ffff88807d45c0e8 R15: 0000000000000001
FS:  0000555555ccd380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066a4e0 CR3: 000000007c0e3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 dev_set_mtu_ext+0x1e8/0x5d0 net/core/dev.c:8664
 dev_set_mtu+0xb1/0x160 net/core/dev.c:8694
 batadv_update_min_mtu+0x6e/0x90 net/batman-adv/hard-interface.c:645
 batadv_netlink_set_mesh+0x7d8/0x14e0 net/batman-adv/netlink.c:498
 genl_family_rcv_msg_doit.isra.0+0x1ef/0x2d0 net/netlink/genetlink.c:970
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x559/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff089227659
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdbc91ce88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff089274390 RCX: 00007ff089227659
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007ffdbc91ced0
R13: 00007ffdbc91cea0 R14: 0000000000000001 R15: 00007ffdbc91ced0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
