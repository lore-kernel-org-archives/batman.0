Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [syzbot] WARNING in __v9fs_get_acl
References: <000000000000789bcd05c9aa3d5d@google.com>
From: Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <d40528c5-aa3c-45ff-ed99-e741b63f6351@gmail.com>
Date: Mon, 16 Aug 2021 15:01:52 +0300
MIME-Version: 1.0
In-Reply-To: <000000000000789bcd05c9aa3d5d@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+56fdf7f6291d819b9b19@syzkaller.appspotmail.com>, a@unstable.cc, asmadeus@codewreck.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, ericvh@gmail.com, linux-kernel@vger.kernel.org, lucho@ionkov.net, lucien.xin@gmail.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, nhorman@tuxdriver.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, v9fs-developer@lists.sourceforge.net

On 8/16/21 12:58 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    761c6d7ec820 Merge tag 'arc-5.14-rc6' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d87ca1300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=730106bfb5bf8ace
> dashboard link: https://syzkaller.appspot.com/bug?extid=56fdf7f6291d819b9b19
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ca6029300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bf42a1300000
> 
> The issue was bisected to:
> 
> commit 0ac1077e3a549bf8d35971613e2be05bdbb41a00
> Author: Xin Long <lucien.xin@gmail.com>
> Date:   Tue Oct 16 07:52:02 2018 +0000
> 
>      sctp: get pr_assoc and pr_stream all status with SCTP_PR_SCTP_ALL instead
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f311fa300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f311fa300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11f311fa300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+56fdf7f6291d819b9b19@syzkaller.appspotmail.com
> Fixes: 0ac1077e3a54 ("sctp: get pr_assoc and pr_stream all status with SCTP_PR_SCTP_ALL instead")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8426 at mm/page_alloc.c:5366 __alloc_pages+0x588/0x5f0 mm/page_alloc.c:5413
> Modules linked in:
> CPU: 1 PID: 8426 Comm: syz-executor477 Not tainted 5.14.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__alloc_pages+0x588/0x5f0 mm/page_alloc.c:5413
> Code: 00 48 ba 00 00 00 00 00 fc ff df e9 5e fd ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 6d fd ff ff e8 bd 62 0a 00 e9 63 fd ff ff <0f> 0b 45 31 e4 e9 7a fd ff ff 48 8d 4c 24 50 80 e1 07 80 c1 03 38
> RSP: 0018:ffffc90000fff9a0 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000014 RCX: 0000000000000000
> RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90000fffa28
> RBP: ffffc90000fffaa8 R08: dffffc0000000000 R09: ffffc90000fffa00
> R10: fffff520001fff45 R11: 0000000000000000 R12: 0000000000040d40
> R13: ffffc90000fffa00 R14: 1ffff920001fff3c R15: 1ffff920001fff38
> FS:  000000000148e300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa1e9a97740 CR3: 000000003406e000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   kmalloc_order+0x41/0x170 mm/slab_common.c:955
>   kmalloc_order_trace+0x15/0x70 mm/slab_common.c:971
>   kmalloc_large include/linux/slab.h:520 [inline]
>   __kmalloc+0x292/0x390 mm/slub.c:4101
>   kmalloc include/linux/slab.h:596 [inline]
>   kzalloc include/linux/slab.h:721 [inline]
>   __v9fs_get_acl+0x40/0x110 fs/9p/acl.c:36
>   v9fs_get_acl+0xa5/0x290 fs/9p/acl.c:71


Looks like syzbot tries to mount malicious image. Easy fix just for 
thoughts:

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index bb1b286c49ae..242a3bc7aaee 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -33,7 +33,7 @@ static struct posix_acl *__v9fs_get_acl(struct p9_fid 
*fid, char *name)

  	size = v9fs_fid_xattr_get(fid, name, NULL, 0);
  	if (size > 0) {
-		value = kzalloc(size, GFP_NOFS);
+		value = kzalloc(size, GFP_NOFS | __GFP_NOWARN);
  		if (!value)
  			return ERR_PTR(-ENOMEM);
  		size = v9fs_fid_xattr_get(fid, name, value, size);




With regards,
Pavel Skripkin
