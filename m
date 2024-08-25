Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96E6C5321E
	for <batman@archiver.kernel.org>; Sun, 25 Aug 2024 07:12:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E41C683CFE
	for <batman@archiver.kernel.org>; Sun, 25 Aug 2024 09:12:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1724569956;
 b=kLD+2QTQQhuR9D2LNcCSYWXxLGZlTTiz1RNk5Jl4RFK+htfOdQUh/T8HKXTABo+2UwhYk
 Tl3NLI/+/G34tH64esnTy+Vi5HcjvF/RgCo4NzTPKIaxe80pJS7z4CGNs0xBl0ut8w0jv5s
 5zc5pf5Bf37T5WAWNGn+/9hKSfX7dGU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1724569956; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
 b=kqQq/ZattduUbGbBDyBARaI2xHsNInYGpIRuK9xVIPSOa+rC+JNzGhOvT1DiaJNnq4F6C
 RIYCbHBisnmIbNPfbiKZ65W4DJ2XagfZU9QnMa/fuAV2JV1Kve4FnA5TKkbkwSaJ+ae6D7C
 lC8hG0WqDIFD83CHXKiK0oYoVo4by9U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=ucr.edu header.i=@ucr.edu;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=fail header.d=ucr.edu header.i=@ucr.edu; arc=pass; dmarc=none
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E4AB6820B7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 25 Aug 2024 06:15:01 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1724559302; a=rsa-sha256;
	cv=none;
	b=rV0ovCWmO3hpXU5qkMFSm2KudIcfLKryRouggH4J0IhMLgNKZM43vDiq9qUN+XiSfaWM7e
	kJwimCE7Mna/zTz7KzemrYBWyWZbTuDn03EDoyEkyRP49MCpOi+Lgvb5he6YRskBZlgUzm
	w/Rs55TJqxiIflLhwjry/TY3e15UL/U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=ucr.edu header.s=selector3 header.b="TCis/0Jp";
	dkim=pass header.d=ucr.edu header.s=rmail header.b="VoK/o9ol";
	dmarc=pass (policy=quarantine) header.from=ucr.edu;
	spf=pass (diktynna.open-mesh.org: domain of xli399@ucr.edu designates
 169.235.156.35 as permitted sender) smtp.mailfrom=xli399@ucr.edu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1724559302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
	b=T+0yr4qOxNd7j0tVoxkxPm6EpWI/H1+Tw9NqCq8KxdBw++oF02UiH8ywdYl+eqcDWX66Ir
	3gU4iEwJC7L76/n7c159DsYSsilKaNdWSmrJrcQzRAzM+jI6clA+yXbcdGwkQ8ikiiuq54
	Xuo4xTL8uTVDEUWyyPIqqP/B6OJ1/cE=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724559302; x=1756095302;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=L4pwj5e/Du/ZHfMerLHq/vRTblg6mzfiuz1IZooeInk=;
  b=TCis/0JpkTovo9iFql3dhB5CjH/0GVNK9lvfHt9GBWJ7Sd7VgR2b0HGN
   NEjo+s12jqS1jUYKr1Jst5aAPfJVPbsgxGW2knqGXdHwgfV/Y/ZNxhFPQ
   ptbh676oJqt/VxgTwiXxYofGqd7+fkFmrjUfx3qJd6Agl/wU1Ok8yvsdP
   p/l7lgdlNPnD8YD5LG/X4LNPlUwfjhUDn3PokVl+igxXYkTmCBqN7/3EG
   h0KAFRJQoPj20nrPf3JaPAxQzd8nDHVWS0wJx4iDQKfw2rliP8VG06WEv
   WUTcjBYrhRloSwuV/8SsWNLbXfH+u2pLk8ookJfrtGeRj2SN6xhb4iB2r
   A==;
X-CSE-ConnectionGUID: vj0k75pCR4+IlVDbKRMV9g==
X-CSE-MsgGUID: o78tDc4xTu2N0aqPAiLq/w==
Received: from mail-ot1-f69.google.com ([209.85.210.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Aug 2024 21:15:00 -0700
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-708f8258621so4258439a34.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 24 Aug 2024 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724559299; x=1725164099;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
        b=VoK/o9olcPP0Lm/VnTMX8HuK4TCmb8QMjebIrTmebBHzDAuZp/vp+egtOncFf/Fhpn
         Y1P9QnrwO962Pkla0SvMj7uIaqhNPQofCswYhHiy+tAN8Pru2SNNfNNheM1bFwcrj1pq
         IsjK+sPliIr//wurIVgEDzdXh6x4iZc+en4qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724559299; x=1725164099;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
        b=crSwbA/SYa3CBqQvfx5meF4HZ5BwIBFEEkcHDatAYwnF4D1PqP2SbfGQgW2QYCKmWr
         iP8gEXM88P+cy8neOSmxekYplx9WROPUNGN1OHPz8k3LI6XW430Z21NdDvunUH0/Qial
         hIq2q4D+dqPyw5wRU/WQScBcWTUryfiduTrP7dLVNtynouszF/kQ3ceudeS93JkFnq3X
         2pIe2ToNYHV4OpxqTWMWHOWUQYKGVc1x2QUtaaJEZiaIujWO25e/gtpghGeEMiAt0OHZ
         JmTCRj9YInhUSO8wKABVW4EjfNp8YznSTK1M5Yhb/t8CArmnI4zg65//UBHiYqlP0w2K
         4ycA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkdDv8/2djC1j7ZT2JBcrrLt6ahn8RSxtggfugbX2EdR5MCGeSmuvRWdUvuc70ZnvPFAsGpaPljjJ+0Q==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyBjENRU7WiHNG1UIROrZX43cDQwqFKCBkxEiHy/CSw0LjwggLV
	Q4iI32K5av6XgQySM2bRw/37Z40WcZ8/jAuOKcqSfdsrgTXwIB45uyvdWgtCEXJ5tBBhqEIoE/X
	lolUbDmXK30yS4BLJfiOYGvdJJ1x8+IMl/xrzZqPgH2xlM9zpdBTQeqDGiFy94okECFtBOal0K5
	iHzs1cv+JJ9/7X53WAL42beA9j5w1dtrBrgVrVI4zOpg==
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id
 46e09a7af769-70e0eb37e5bmr8708474a34.16.1724559299005;
        Sat, 24 Aug 2024 21:14:59 -0700 (PDT)
X-Google-Smtp-Source: 
 AGHT+IFxPHBCKI46nI/OXfg8etlSxv0aFfYfimbk9eAadzbb0zpTySvht50sBxkQI4YKVHEE0cb9T1zzLhMZjNP8G3Y=
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id
 46e09a7af769-70e0eb37e5bmr8708459a34.16.1724559298687; Sat, 24 Aug 2024
 21:14:58 -0700 (PDT)
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:14:48 -0700
Message-ID: 
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
Subject: BUG: general protection fault in batadv_bla_del_backbone_claims
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
	sven@narfation.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: xli399@ucr.edu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: NXAKSDZUROVZZWDTUYA2BVN7LFTBMTFS
X-Message-ID-Hash: NXAKSDZUROVZZWDTUYA2BVN7LFTBMTFS
X-Mailman-Approved-At: Sun, 25 Aug 2024 09:12:14 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NXAKSDZUROVZZWDTUYA2BVN7LFTBMTFS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

We found a bug in Linux 6.10 using syzkaller. It is probably a null
pointer dereference bug.
In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
"hash =3D backbone_gw->bat_priv->bla.claim_hash;", it does not check if
"backbone_gw->bat_priv=3D=3DNULL".

The bug report and syzkaller reproducer are as follows:

bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc000000004a: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000250-0x0000000000000257]
CPU: 0 PID: 45 Comm: kworker/u4:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
net/batman-adv/bridge_loop_avoidance.c:307
Code: 18 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89
df e8 01 72 33 f7 bd 50 02 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 ef e8 e3 71 33 f7 48 8b 6d 00 48 85 ed
RSP: 0018:ffffc9000090f9b0 EFLAGS: 00010202
RAX: 000000000000004a RBX: ffff88802cd7c018 RCX: ffff888015370000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802cd7c000
RBP: 0000000000000250 R08: ffffffff8ac0433d R09: 1ffff110059af805
R10: dffffc0000000000 R11: ffffed10059af806 R12: dffffc0000000000
R13: ffff88802cd7c008 R14: 00000000ffffcf80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556956047f2c CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 batadv_bla_purge_backbone_gw+0x285/0x4c0
net/batman-adv/bridge_loop_avoidance.c:1254
 batadv_bla_periodic_work+0xc3/0xa80 net/batman-adv/bridge_loop_avoidance.c=
:1445
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
net/batman-adv/bridge_loop_avoidance.c:307
Code: 18 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89
df e8 01 72 33 f7 bd 50 02 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 ef e8 e3 71 33 f7 48 8b 6d 00 48 85 ed
RSP: 0018:ffffc9000090f9b0 EFLAGS: 00010202
RAX: 000000000000004a RBX: ffff88802cd7c018 RCX: ffff888015370000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802cd7c000
RBP: 0000000000000250 R08: ffffffff8ac0433d R09: 1ffff110059af805
R10: dffffc0000000000 R11: ffffed10059af806 R12: dffffc0000000000
R13: ffff88802cd7c008 R14: 00000000ffffcf80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556956047f2c CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 18 48 83             sbb    %cl,-0x7d(%rax)
   3: c3                   ret
   4: 18 48 89             sbb    %cl,-0x77(%rax)
   7: d8 48 c1             fmuls  -0x3f(%rax)
   a: e8 03 42 80 3c       call   0x3c804212
   f: 20 00                 and    %al,(%rax)
  11: 74 08                 je     0x1b
  13: 48 89 df             mov    %rbx,%rdi
  16: e8 01 72 33 f7       call   0xf733721c
  1b: bd 50 02 00 00       mov    $0x250,%ebp
  20: 48 03 2b             add    (%rbx),%rbp
  23: 48 89 e8             mov    %rbp,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 20 00       cmpb   $0x0,(%rax,%r12,1) <-- trapping instructi=
on
  2f: 74 08                 je     0x39
  31: 48 89 ef             mov    %rbp,%rdi
  34: e8 e3 71 33 f7       call   0xf733721c
  39: 48 8b 6d 00           mov    0x0(%rbp),%rbp
  3d: 48 85 ed             test   %rbp,%rbp


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox:none SandboxArg:0 Leak:false NetInjection:false
NetDevices:true NetReset:false Cgroups:false BinfmtMisc:true
CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:true
VhciInjection:false Wifi:true IEEE802154:false Sysctl:false Swap:true
UseTmpDir:true HandleSegv:true Trace:false
LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
write$syz_spec_1342568572_346(0xffffffffffffffff,
&(0x7f0000000080)=3D{{0x0, 0x4, 0x6}, {0x5, 0x0, 0x111, 0xe,
"c2beae5c4e"}}, 0x20)
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r0 =3D syz_open_dev$sg(&(0x7f0000000180), 0x0, 0x109400)
ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})
ioctl$TIOCSTI(0xffffffffffffffff, 0x5412, 0x0)
openat$ttynull(0xffffffffffffff9c, &(0x7f00000000c0), 0x109841, 0x0)
r1 =3D openat$ttynull(0xffffffffffffff9c, 0x0, 0x109841, 0x0)
ioctl$TIOCSTI(r1, 0x5412, 0x0)
syz_open_dev$tty20(0xc, 0x4, 0x1)
write$syz_spec_1342568572_233(0xffffffffffffffff, 0x0, 0x0)
ioctl$syz_spec_1101043199_396(0xffffffffffffffff, 0x80104d12, 0x0)
ioctl$syz_spec_1342803520_149(0xffffffffffffffff, 0x5501, 0xf9d)
write$syz_spec_18446744073706268967_8(0xffffffffffffffff,
&(0x7f00000002c0)=3D0xfd80, 0xfffffc34)
ioctl$syz_spec_18446744073707301390_3197(0xffffffffffffffff, 0xc0a85320, 0x=
0)
ioctl$syz_spec_18446744073707301390_3092(0xffffffffffffffff, 0x40a85321, 0x=
0)
openat$ppp(0xffffffffffffff9c, &(0x7f0000000100), 0x200, 0x0)
mmap$IORING_OFF_SQ_RING(&(0x7f00003ff000/0xc00000)=3Dnil, 0xc00000, 0xe,
0x9a172, 0xffffffffffffffff, 0x0)
mmap$IORING_OFF_SQES(&(0x7f0000000000/0xc00000)=3Dnil, 0xc00000,
0x1000019, 0x42832, 0xffffffffffffffff, 0x10000000)




--=20
Yours sincerely,
Xingyu
