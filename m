Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7CAC30653
	for <batman@archiver.kernel.org>; Thu,  4 Jul 2024 19:38:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9205B82F0D
	for <batman@archiver.kernel.org>; Thu,  4 Jul 2024 21:38:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1720121880;
 b=cQ+HldPRtGo7GSDu/844jEyrhep93PuXneOyQJihCZyW01HyOIlGPDHx4IffaKaWNWuX7
 4Gt93kQvS8HqAzyCXUb/zpkWq3i9v/P4lTwWwgEsGhPGN6f/RHaYBFoE6olxmxJ5dQrX2Sg
 MFJslZrPRhT26VrdaZW2q9+d+M0mj0s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1720121880; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3/hTUg3pYzV9mlCpTtKrwdrAm8S49KzYZfOTrkxnosk=;
 b=mApp0bZbk6gTvoV8tsZmBRfzdgxwo8n9V3jO7uMto475trPlOsWOh1gs/+9u9jjx/lAMd
 SYzE2tHpgT0UVgRFyiP4w9Jrir4u45ftX0e3NyFWQW+S5KmmKZg3un5+pDQhVORTKy3Ww4k
 rihww8M/kM9h8sTeRDa0KKx6Vzuspho=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BEB1B80A57
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  4 Jul 2024 21:37:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1720121867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3/hTUg3pYzV9mlCpTtKrwdrAm8S49KzYZfOTrkxnosk=;
	b=l1ocqbRckPVWSO76XSZbncS9ihqa8xmO9pfWp+M+VtdXUIfDfS9CvHoeK9855vEhhS/dEu
	TqbKvbGRqfQPDtqb533K6bV47E/dfzElz7Cx8j/VdIOXoj6vj3hHRl11kza7rE8O22O2t+
	g8IjyitQEFRL0Jv0fO1qf1pwa995TiU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="maPwd/QN";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1720121867; a=rsa-sha256;
	cv=none;
	b=DiEpM5EZ3DKnIh0xkgnqc4fK7idsCwYsYu2h9fn5+hNvRcOUo5f/E8RKP4Zhms8XhhoSfT
	QDLjjA1YO+STXMZEFfqRZE0c5riulInjKj0DfOhA5SxRZnNvkmvXygNsEgxb5FjBuEdfuP
	S+1LL7NlIn1wwDZxpRWSBSL0hIGg9n8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1720121866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/hTUg3pYzV9mlCpTtKrwdrAm8S49KzYZfOTrkxnosk=;
	b=maPwd/QNnboc9gGXewoVG08jIJWepjk1uiUBe7Q8zNGQtxMXiLIuFY5FgUrOfGrvjPVIdg
	0UTqsWhDYHYdyQc3FaNmhPvou99RhPSazAN0+2YGUATeyYOl1pVPquBHsV3dxAB8L2H/RN
	F81srEA4XMORzpXwZh71IN6F/0duPR0=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+7beee86dd68b7ee38e4a@syzkaller.appspotmail.com>
Subject: 
 Re: [syzbot] [batman?] INFO: rcu detected stall in
 batadv_iv_send_outstanding_bat_ogm_packet (5)
Date: Thu, 04 Jul 2024 21:37:43 +0200
Message-ID: <12484608.O9o76ZdvQC@sven-l14>
In-Reply-To: <00000000000045f576061c6e8142@google.com>
References: <00000000000045f576061c6e8142@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5811613.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: T4MCD36YANGYKEJWGFWXU42HWHNYFTVL
X-Message-ID-Hash: T4MCD36YANGYKEJWGFWXU42HWHNYFTVL
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T4MCD36YANGYKEJWGFWXU42HWHNYFTVL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5811613.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jul 2024 21:37:43 +0200
Message-ID: <12484608.O9o76ZdvQC@sven-l14>
In-Reply-To: <00000000000045f576061c6e8142@google.com>
References: <00000000000045f576061c6e8142@google.com>
MIME-Version: 1.0

On Thursday, 4 July 2024 18:33:21 CEST syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1182b083180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
> dashboard link: https://syzkaller.appspot.com/bug?extid=7beee86dd68b7ee38e4a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64

#syz dup: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
#syz fix: batman-adv: Avoid infinite loop trying to resize local TT

> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7beee86dd68b7ee38e4a@syzkaller.appspotmail.com
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:5:575]
> Modules linked in:
> irq event stamp: 132863
> hardirqs last  enabled at (132862): [<ffff80008ad68de8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
> hardirqs last  enabled at (132862): [<ffff80008ad68de8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
> hardirqs last disabled at (132863): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
> hardirqs last disabled at (132863): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
> softirqs last  enabled at (128034): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
> softirqs last  enabled at (128034): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
> softirqs last disabled at (128036): [<ffff80008aad75f4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> softirqs last disabled at (128036): [<ffff80008aad75f4>] batadv_tt_local_commit_changes+0x24/0x44 net/batman-adv/translation-table.c:3717
> CPU: 0 PID: 575 Comm: kworker/u4:5 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
> lr : queued_spin_lock_slowpath+0x168/0xcf8 kernel/locking/qspinlock.c:383
> sp : ffff800098c77720
> x29: ffff800098c777c0 x28: 1fffe0001b8a126a x27: 1ffff0001318eef0
> x26: dfff800000000000 x25: 1fffe0001b8a126c x24: ffff800098c77740
> x23: ffff800098c77780 x22: ffff70001318eee8 x21: 0000000000000001
> x20: 0000000000000001 x19: ffff0000dc509350 x18: ffff0001b4015840
> x17: ffff800125414000 x16: ffff8000809fd934 x15: 0000000000000001
> x14: 1fffe0001b8a126a x13: 0000000000000000 x12: 0000000000000000
> x11: ffff60001b8a126b x10: 1fffe0001b8a126a x9 : 0000000000000000
> x8 : 0000000000000001 x7 : ffff80008aad75f4 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008ae5db50
> x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
> Call trace:
>  __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline]
>  __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline]
>  queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x320/0x348 kernel/locking/spinlock_debug.c:116
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:127 [inline]
>  _raw_spin_lock_bh+0x50/0x60 kernel/locking/spinlock.c:178
>  spin_lock_bh include/linux/spinlock.h:356 [inline]
>  batadv_tt_local_commit_changes+0x24/0x44 net/batman-adv/translation-table.c:3717
>  batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:811 [inline]
>  batadv_iv_ogm_schedule+0x1ec/0xdf0 net/batman-adv/bat_iv_ogm.c:868
>  batadv_iv_send_outstanding_bat_ogm_packet+0x740/0x900 net/batman-adv/bat_iv_ogm.c:1712
>  process_one_work+0x694/0x1204 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x938/0xef4 kernel/workqueue.c:2787
>  kthread+0x288/0x310 kernel/kthread.c:388
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


--nextPart5811613.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZob6BwAKCRBND3cr0xT1
y3sgAQDIFmAiPK+wLdWuMygqhJWeiEz1QixiYNjPcgVcBpsb2wEAqad3DTqrEmz1
UGsiSTE/yCNrC2v3AVFySgSMx8UfBg0=
=lWVc
-----END PGP SIGNATURE-----

--nextPart5811613.DvuYhMxLoT--



