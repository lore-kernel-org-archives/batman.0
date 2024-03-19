Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7B0C54E60
	for <batman@archiver.kernel.org>; Tue, 19 Mar 2024 10:46:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C2A281AE8
	for <batman@archiver.kernel.org>; Tue, 19 Mar 2024 11:46:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1710845197;
 b=r5eGVzrAU/IBHMf/pXQ7IMs+M66sZl5ammLQ5qkQ0mYtcB42Q8U4gjCCPbByY2aqI9Z0m
 76ceT4qtk2XMPWbqJcaGSeCf9Hq3Z3WvIk6b71k2Ze9L+EVukhsxI/FeWb38Xfh2E3G2Dbx
 OO2Q17IMSCjD3WCfRzQeAp0OjeZFf8s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1710845197; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AfH616evJHoxgc9RlKueSdsKtzrhRnXKCq+xBkHhWYc=;
 b=CY+cjGAQ37PUXw2dZUXI0MCKFwpb/sHTFn/edamiot1nFIMUor/lBlbdE6YBmBZ2MUyZj
 VyhA403FE/yTB64zTYH6ttDgN9F74gwMgBr29EDJrVFtUKHKSgNtlXkJVFrJ1LeZuorWpcT
 YJRtTqRuUvrAYGb4yW9M/Gt9vr+KRA0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 89C1B80B7A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Mar 2024 11:33:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1710844398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=AfH616evJHoxgc9RlKueSdsKtzrhRnXKCq+xBkHhWYc=;
	b=WvohFKIvn/KoxI+hn3xVqoEwji/QKt331v218Rd52Y02pu7UuGslSRZbZKXQwNeL++xeb2
	zeQmNi0921suGWr67YC2KSZd2ffVZcyOphbPFLK40CbwwsccowXG3HsBVIRa11iZR/h7Xm
	9qi89zTNpFoH4DexfOz66Oi9ohUAbeI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1710844398; a=rsa-sha256;
	cv=none;
	b=3dUY4yqlFMuvHhlyv3aAI78B7KTxWGQS3oDFF7dhS+GCFKcXst+ItwRsnZrorTlCThw/zL
	7x0oCbsoczOaQqVpJuUDwHUOaq/DgNxytekWQFi+7j/TwgUI+J7nPz6nesLetQRR0R3Cg+
	JTN6PZ53ClS03IzjqLi0WsuOC45FoyM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 37Wn5ZQkbANwQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.70 as permitted sender)
 smtp.mailfrom=37Wn5ZQkbANwQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7cc74ea9c20so188307439f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 19 Mar 2024 03:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710844397; x=1711449197;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfH616evJHoxgc9RlKueSdsKtzrhRnXKCq+xBkHhWYc=;
        b=TZoDTDHkkH0NF3uuL07ID/9ccqXTmkyJNJUcEYIil2Mb4nEG6A3YzXK75w0iXmTvSo
         WwTj+7+CJw+VbxvgM7yigCBUB2Jc4tAOsveJ0eefetD1qexX+whaaVjhOH0vfvuTyZU2
         nt9kDv6iRo4gSkwtbQGp+V/GnOThB4jw/X3muIs9M6moiZSPUCVvG41HLJbl4BaeTeQn
         wXH4jPm+ctw2V8IIIwGrZNjcXUdSsDGulRGgRByIIwzoWdFPpXfmWw96ydCJuDbvVPu3
         c5Z5YyJ+NFZg8k1b4l2jHXaj5CrzGGAiZjhKeRZ+keVNNI7czVNNl9qkUkYjto/1b/zQ
         7AXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU16/sPbYM0IH9Mqiwaw5l11oDpt6450cpKRdSg9LaVw8Wir6kFvEkhWmWiS173Y7rukHpmDn4LGH/PcU7LQN/78dYXlF7ZM4l89RdOSzz1
X-Gm-Message-State: AOJu0YwAaw7rsXxm6C5NPp7eJxpnVNqFfgvmOpFFfnk6Ro2x3T381pVU
	2vXZROK963uGsnpCFYd/+355c8JRxifnbGbddTkfAWFoipsJFCeyc9HBkOHPvF8QSejg2Uv2lh1
	9Lvgj1AbEcP0d7OA8hm5YTuXwQy4mxRUPRYTlPPZuJsExY/Vv9Z1l4ck=
X-Google-Smtp-Source: 
 AGHT+IEQ+82wEpKYZLgs0UzhGbaG/fopGadQHCSj12KG9g2jPIb2Kpj1qbNa3YUd/izEr61RA3aDY1mqpqSytY3Ow+SuKPX2jPrG
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641f:b0:7cc:4c0:65c5 with SMTP id
 gn31-20020a056602641f00b007cc04c065c5mr175800iob.1.1710844397224; Tue, 19 Mar
 2024 03:33:17 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:33:17 -0700
In-Reply-To: <000000000000c0645805b7f982e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000901b1c0614010091@google.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
From: syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
To: a@unstable.cc, akpm@linux-foundation.org, andrii@kernel.org,
	ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
	christian@brauner.io, daniel@iogearbox.net, davem@davemloft.net,
	dvyukov@google.com, edumazet@google.com, elver@google.com, glider@google.com,
	hdanton@sina.com, jakub@cloudflare.com, jannh@google.com,
	john.fastabend@gmail.com, kasan-dev@googlegroups.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mareklindner@neomailbox.ch,
	mark.rutland@arm.com, netdev@vger.kernel.org, pabeni@redhat.com,
	shakeelb@google.com, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 37Wn5ZQkbANwQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: W7ORKBVSNHQQCS4UDVJ5SLHQMDXTI5YQ
X-Message-ID-Hash: W7ORKBVSNHQQCS4UDVJ5SLHQMDXTI5YQ
X-Mailman-Approved-At: Tue, 19 Mar 2024 11:46:19 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W7ORKBVSNHQQCS4UDVJ5SLHQMDXTI5YQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

syzbot has found a reproducer for the following issue on:

HEAD commit:    35c3e2791756 Revert "net: Re-use and set mono_delivery_tim..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10569181180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d9fa4e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137afac9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26b55a26fc12/disk-35c3e279.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f39fa55c828/vmlinux-35c3e279.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1e0501539e6/bzImage-35c3e279.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05228-g35c3e2791756 #0 Not tainted
-----------------------------------------------------
rcu_preempt/16 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888021c65020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888021c65020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff8880b952a758
 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
which would create a new lock dependency:
 (&base->lock){-.-.}-{2:2} -> (
&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&base->lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
  add_timer_on+0x1e5/0x5c0 kernel/time/timer.c:1366
  handle_irq_event_percpu kernel/irq/handle.c:195 [inline]
  handle_irq_event+0xad/0x1f0 kernel/irq/handle.c:210
  handle_level_irq+0x3c5/0x6e0 kernel/irq/chip.c:648
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  __setup_irq+0x1277/0x1cf0 kernel/irq/manage.c:1818
  request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2202
  request_irq include/linux/interrupt.h:168 [inline]
  setup_default_timer_irq+0x25/0x60 arch/x86/kernel/time.c:70
  x86_late_time_init+0x66/0xc0 arch/x86/kernel/time.c:94
  start_kernel+0x3f3/0x500 init/main.c:1039
  x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
  x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
  common_startup_64+0x13e/0x147

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
  bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock
);
                               local_irq_disable();
                               lock(&base->lock);
                               lock(&htab->buckets[i].lock
);
  <Interrupt>
    lock(&base->lock);

 *** DEADLOCK ***

2 locks held by rcu_preempt/16:
 #0: 
ffff8880b952a758
 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
 #1: ffffffff8e131920
 (rcu_read_lock
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&base->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
                    add_timer_on+0x1e5/0x5c0 kernel/time/timer.c:1366
                    handle_irq_event_percpu kernel/irq/handle.c:195 [inline]
                    handle_irq_event+0xad/0x1f0 kernel/irq/handle.c:210
                    handle_level_irq+0x3c5/0x6e0 kernel/irq/chip.c:648
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    __setup_irq+0x1277/0x1cf0 kernel/irq/manage.c:1818
                    request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2202
                    request_irq include/linux/interrupt.h:168 [inline]
                    setup_default_timer_irq+0x25/0x60 arch/x86/kernel/time.c:70
                    x86_late_time_init+0x66/0xc0 arch/x86/kernel/time.c:94
                    start_kernel+0x3f3/0x500 init/main.c:1039
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                    _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
                    __run_timer_base+0x103/0x8e0 kernel/time/timer.c:2418
                    run_timer_base kernel/time/timer.c:2428 [inline]
                    run_timer_softirq+0x67/0x170 kernel/time/timer.c:2436
                    __do_softirq+0x2be/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    console_flush_all+0x9cd/0xec0
                    console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
                    vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
                    _printk+0xd5/0x120 kernel/printk/printk.c:2317
                    cpu_select_mitigations+0x3c/0xa0 arch/x86/kernel/cpu/bugs.c:148
                    arch_cpu_finalize_init+0x20/0xa0 arch/x86/kernel/cpu/common.c:2325
                    start_kernel+0x402/0x500 init/main.c:1043
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   INITIAL USE
 at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
                   __mod_timer+0x1ca/0xeb0 kernel/time/timer.c:1132
                   queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:2595
                   queue_delayed_work include/linux/workqueue.h:620 [inline]
                   crng_reseed+0xe7/0x220 drivers/char/random.c:258
                   random_init+0x1a9/0x300 drivers/char/random.c:901
                   start_kernel+0x253/0x500 init/main.c:991
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff945023c0>] init_timer_cpu.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
->
 (&htab->buckets[i].lock
){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
                    bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE
 at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
                   bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
                   process_one_work kernel/workqueue.c:3254 [inline]
                   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                   kthread+0x2f0/0x390 kernel/kthread.c:388
                   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff94882300>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
   bpf_prog_2c29ac5cdc6b1842+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
   trace_timer_start include/trace/events/timer.h:52 [inline]
   enqueue_timer+0x396/0x550 kernel/time/timer.c:663
   internal_add_timer kernel/time/timer.c:688 [inline]
   __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
   schedule_timeout+0x1b9/0x310 kernel/time/timer.c:2571
   rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
   rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 16 Comm: rcu_preempt Not tainted 6.8.0-syzkaller-05228-g35c3e2791756 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage kernel/locking/lockdep.c:2865 [inline]
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x4dc7/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_timer_start include/trace/events/timer.h:52 [inline]
 enqueue_timer+0x396/0x550 kernel/time/timer.c:663
 internal_add_timer kernel/time/timer.c:688 [inline]
 __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
 schedule_timeout+0x1b9/0x310 kernel/time/timer.c:2571
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
