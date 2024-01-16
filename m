Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0A5C4706C
	for <batman@archiver.kernel.org>; Tue, 16 Jan 2024 09:27:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9BBE983E03
	for <batman@archiver.kernel.org>; Tue, 16 Jan 2024 10:27:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1705397249;
 b=sipvVm2Fhm34g/suuUhHU0aBrWSSyrhWSqY797rZmAmqM071jx7WSesm+bE3GGVI+PnaH
 KN5AVvmpgQwgutrk+NaWXcOIEIRqjvGsi9fylI3pEKcxe90MtgJ3VuzN4wkkodZNLUYS6eg
 lLdZ7XHD41oiYImeuLpLnnrmp4KJ1/0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1705397249; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jOsxNLpBRTGiUU6lZBOr9zV8xafpZmwbpi5r0C8L1zg=;
 b=ft8eBha67/IIMMaeXBmyZXualG78crbK0/vjQjxb6vkY4ii4YZr9UKFX4whIWcv/wO45i
 +jGO8dl0h9408RZE3EyToiSrLhOcIoJMgjD4vHpaWmCheQyHXev79tzPA7h4F1bynPSOTzY
 DecL3q3vplWKyYPfl2bYYZ9YnImgac4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 324C48087F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 16 Jan 2024 10:27:22 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1705397242; a=rsa-sha256;
	cv=none;
	b=F91s/0p767HQY0x3grpNP4wQg2JnxL8f7VbkGY6mRG8OHn57ujuArt9r/OOeGGlntGf7rI
	IZqvziGcsdAvONGj7Y7tQGUufhcLs1AmmPmLzPuu2k6kGAVtgvhHMhpe5LMDmakDJxe/Th
	5AtV/1wgmwJJ2wTAqH9A1H/5vMxB9yc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3-EumZQkbAF0NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.197 as permitted sender)
 smtp.mailfrom=3-EumZQkbAF0NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1705397242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jOsxNLpBRTGiUU6lZBOr9zV8xafpZmwbpi5r0C8L1zg=;
	b=W7hmthUF9aWliQEPzdeLfR5tfAH9GCBaYQgXCLCj5KoZ6k4WSTeJDq49/Xncc4qvDG/dry
	SoQnRqHY+lKcsyFghDABaKJMKCdrWwpQOSTiELzDfsCekj0IjlROKL0p+Hv6u49XmLr13G
	rK/CfZmBZtcl/PqafL37Do4LA+hjqAI=
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3606b8d9c64so77608945ab.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 16 Jan 2024 01:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705397241; x=1706002041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOsxNLpBRTGiUU6lZBOr9zV8xafpZmwbpi5r0C8L1zg=;
        b=HmUbHTi7IEp9rCYOd6v9pN2TkFcQAxar83BR0W2XUHS2cUJEtfRgvJW4JaIxNGfeG3
         QxsWxGWYYoCGW2JSYnU+zPhu2reYUzPDEzV9bo5JAsg2nv57j+IUR/XpWPcyIyDVeQ3m
         NIeTDHQDjGsTvREXEU6Myu4g8mQ5FKGm2hJyEsB76zwvsG6YCPA05ES65TkI/6PHVPXO
         FEeN/Geb71bXdzKLfOz/+SQDspvX82fw9s0lx9m2gxfqjwdnBSNRoIZ8YeVTCahDKag2
         Op7gJLgJOlLAIg1nyOF6xw1w8tD8/1cVfCeIgoH6QRoqzGrWBrsFU5CTJ52g3pLXB/n1
         5PJQ==
X-Gm-Message-State: AOJu0YykbsMdZKPn4EacnA9h6+usTYRLwkcwBT7rqe4te8YpwRwvnjr/
	squ9XhVWIod0e8vvprAkmERpSgRWQb0f7NdwZC8EEdd5ln8U
X-Google-Smtp-Source: 
 AGHT+IFSriItWy/h+LU6Lr8mhhRE9S5UJnpA1nLIi1CBILH2BJvuTvAJglPqCxymAvNQo4joBj6nnYdmsRVo4L5SxnTw7Mqn9f44
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:d5ea:8a86 with SMTP id
 s7-20020a056e021a0700b0035fd5ea8a86mr937528ild.5.1705397240898; Tue, 16 Jan
 2024 01:27:20 -0800 (PST)
Date: Tue, 16 Jan 2024 01:27:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000beadc4060f0cbc23@google.com>
Subject: [syzbot] [btrfs?] memory leak in corrupted
From: syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, clm@fb.com,
	davem@davemloft.net, dsterba@suse.com, edumazet@google.com,
	josef@toxicpanda.com, kuba@kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: M7NU6YQHVK6A46WLXXHKIGWN6Z44UBAF
X-Message-ID-Hash: M7NU6YQHVK6A46WLXXHKIGWN6Z44UBAF
X-MailFrom: 
 3-EumZQkbAF0NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M7NU6YQHVK6A46WLXXHKIGWN6Z44UBAF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14620debe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7031f9e71583b4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a344c1e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82a7201eef4c/disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca12b4c31826/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f07360ba5a8/bzImage-052d5343.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811c71a980 (size 64):
  comm "syz-executor.7", pid 5063, jiffies 4294953937
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 8e 7e 1c 81 88 ff ff  ........ .~.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 9f8721dd):
    [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
    [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
    [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
    [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
    [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
    [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
    [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
    [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
    [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
    [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
    [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
    [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
    [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
    [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
    [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
    [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
    [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
    [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199

BUG: memory leak
unreferenced object 0xffff88811c8561c0 (size 64):
  comm "syz-executor.0", pid 5062, jiffies 4294953941
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 ce 7e 1c 81 88 ff ff  ........ .~.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 7256c890):
    [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
    [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
    [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
    [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
    [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
    [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
    [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
    [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
    [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
    [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
    [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
    [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
    [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
    [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
    [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
    [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
    [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
    [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199

BUG: memory leak
unreferenced object 0xffff88811cd88cc0 (size 64):
  comm "syz-executor.5", pid 5078, jiffies 4294953981
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 8e 05 1d 81 88 ff ff  ........ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a919e6d6):
    [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
    [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
    [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
    [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
    [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
    [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
    [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
    [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
    [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
    [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
    [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
    [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
    [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
    [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
    [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
    [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
    [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
    [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199



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
