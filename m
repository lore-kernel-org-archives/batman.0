Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EACC83029
	for <batman@archiver.kernel.org>; Mon, 30 Jun 2025 17:08:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 24C3E84777
	for <batman@archiver.kernel.org>; Mon, 30 Jun 2025 19:08:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1751303320;
 b=D9Im4xe3BH57QHqJn15DOCS4GzJ/b2y8PjWz7hlLdYeztHhd/if5suVazCxlGDeaQ22VG
 lsiDKUNODEJMkLUQE2ICboRo5BJlENLnXfStCvQ3symgPBAf+IvNoR62abWdHHU5BpHf2h+
 GLtRN/IFp2gJQIAQTAK0KtAi49PAhTU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1751303320; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4eVH34/JyElyGCncpABHXHf6kfIN2WmIJvCTUgA3HEQ=;
 b=sBu6g0zsjbi/aw7Wg1LlA083TfljSR0SGxZmlysdseZ+nXrg7r7KNEmCFgCXFkvWR7RYw
 ePFafaUd5O9sRtUuW0FWYsOa0+hklHKNTXQe7wHZiVp1JnDH3CDkPnfpI+YtvL7+4PfXs8Q
 1J67uFb45wdkwYrc4HEYsZcSR2lXvyA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com
 [209.85.166.206])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A419A805DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 30 Jun 2025 19:07:42 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1751303272; a=rsa-sha256;
	cv=none;
	b=AF8q0Qhs7cdqEi9sIaPpPv0JE5PtO5PQ5AZRU6Z6DpbVAPbQ7izohbr4xa+t2PGR6xvvU3
	DLw3cENQCkgwneNlfEIHr7G3cCTYSNxT93zoOYjr91eAiE3EeMkg/ga2JM//40sVG+A7o0
	XXC9CsSOUP1KBvHTyI/+xmOi7cMDTk4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3XMRiaAkbALkrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.206 as permitted sender)
 smtp.mailfrom=3XMRiaAkbALkrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1751303272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=4eVH34/JyElyGCncpABHXHf6kfIN2WmIJvCTUgA3HEQ=;
	b=Vn9wLltd5xlsquevlPBuFKA7ODPcUlZb/w0axn5lWjL4Tqb34iXqHMfpZ/xwRYze9rw5qw
	rvZw3ClQLS356MVOHpdjHtHxR7S/NQaYjHHw25GFhPzL6LnfQ266+cj6T4wn73SPzcebm5
	fST4zLOuaPKMSsiMsTqRr3ukTNSGeSQ=
Received: by mail-il1-f206.google.com with SMTP id
 e9e14a558f8ab-3ddc0a6d4bdso29567915ab.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 30 Jun 2025 10:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303261; x=1751908061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eVH34/JyElyGCncpABHXHf6kfIN2WmIJvCTUgA3HEQ=;
        b=MX1UuDEax/atIQaRqYuVwOWTMnFda7oe5DgOk1xG8k0UNXoa4Ph6YipJVWZOxK1Kas
         M6osSe6W5Z/LpQyOsdayQX35xdv/z1znT6QaSK2LQcWytQOEnVg/9Vq+U/9+ShR1A4zz
         kwNXArNy4saafxs9v0zC3HErVuLFzyvwL1l7YDhBEUrCqwejkCXRUsYeaA0R24JJk50a
         lDNPW746MCJfLLXKq3IhS6BwsK24LNXw8QIgsx0SEh2BKpMTDQXJWZUOaQxgnq5cmHVj
         Mvga7/RZ1pL3TLzx72DHDBwU6flMJnwUSib5SkIDfozzKULtYemQcN/BX9axlm/cIkB+
         tl/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbWvw8Gqw4UhU5j6jwb9NxGStO44shgNVk0DEGgXJYJ4U5Qn9U55gLCWqLYdR3bd4Rps/lERJoJe/bLw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yzo15AdEpHomsZETHciGwWqbs0Mzpw8OsSce9/ft8rrLgW/2NeJ
	Uc+UoVfqdF27hCX+T5ztgWqyfCN9qRdHhwiYqdnkYsnMuFueiA5eblLP2JcQM70T+hE+yebqNou
	sMm2QXI5ddAk+zxz4PweRpaqomwFUneO7puCKhH4Jmhmw9PF21bAjILeF+kc=
X-Google-Smtp-Source: 
 AGHT+IFnc7V73z7h/yTZD0NLdobDmnUYkaIBhp0J7a3EbG/eiKtDvFtwI3av4DgI57JfmgOGsh/VTEJ+bL5aJvfAIgeVVThTd/4T
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3df:3ab2:cc7c with SMTP id
 e9e14a558f8ab-3df4abae83emr151790175ab.13.1751303260942; Mon, 30 Jun 2025
 10:07:40 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:07:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6862c45c.a70a0220.3b7e22.10aa.GAE@google.com>
Subject: [syzbot] [batman?] KMSAN: uninit-value in batadv_mcast_mla_update
From: syzbot <syzbot+1daa6a8aecb922ad3c30@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3XMRiaAkbALkrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: VKSX7LGLKOKD3TE25SSHIW2RMKPSOI77
X-Message-ID-Hash: VKSX7LGLKOKD3TE25SSHIW2RMKPSOI77
X-Mailman-Approved-At: Mon, 30 Jun 2025 19:08:20 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VKSX7LGLKOKD3TE25SSHIW2RMKPSOI77/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    ee88bddf7f2f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b1db70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595d344ff0b23ac5
dashboard link: https://syzkaller.appspot.com/bug?extid=1daa6a8aecb922ad3c30
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/405f6113ec86/disk-ee88bddf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57f4fa239393/vmlinux-ee88bddf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32892fe29e1c/bzImage-ee88bddf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1daa6a8aecb922ad3c30@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in batadv_mcast_mla_is_duplicate net/batman-adv/multicast.c:347 [inline]
BUG: KMSAN: uninit-value in batadv_mcast_mla_tt_retract net/batman-adv/multicast.c:692 [inline]
BUG: KMSAN: uninit-value in __batadv_mcast_mla_update net/batman-adv/multicast.c:920 [inline]
BUG: KMSAN: uninit-value in batadv_mcast_mla_update+0x35f4/0x4f80 net/batman-adv/multicast.c:948
 batadv_mcast_mla_is_duplicate net/batman-adv/multicast.c:347 [inline]
 batadv_mcast_mla_tt_retract net/batman-adv/multicast.c:692 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:920 [inline]
 batadv_mcast_mla_update+0x35f4/0x4f80 net/batman-adv/multicast.c:948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3321
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3402
 kthread+0xd5c/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e3/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __kmalloc_cache_noprof+0x7f7/0xed0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 batadv_mcast_mla_meshif_get_ipv6 net/batman-adv/multicast.c:477 [inline]
 batadv_mcast_mla_meshif_get net/batman-adv/multicast.c:535 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:911 [inline]
 batadv_mcast_mla_update+0x1c17/0x4f80 net/batman-adv/multicast.c:948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3321
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3402
 kthread+0xd5c/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e3/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

CPU: 1 UID: 0 PID: 68 Comm: kworker/u8:4 Tainted: G        W           6.16.0-rc3-syzkaller-00072-gee88bddf7f2f #0 PREEMPT(undef) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: bat_events batadv_mcast_mla_update
=====================================================


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
