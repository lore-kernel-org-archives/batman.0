Return-Path: <paskripkin@gmail.com>
Content-Type: multipart/mixed; boundary="------------hDxpLWma1ZuOZqBZQxT8IIN9"
Message-ID: <b792adc1-ebf2-d0f7-4007-ed5c99ec3f79@gmail.com>
Date: Fri, 22 Oct 2021 21:33:47 +0300
MIME-Version: 1.0
Subject: Re: [syzbot] WARNING in batadv_nc_mesh_free
Content-Language: en-US
References: <0000000000000c522305cee520e6@google.com>
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <0000000000000c522305cee520e6@google.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

 This is a multi-part message in MIME format.
--------------hDxpLWma1ZuOZqBZQxT8IIN9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/21 02:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=115750acb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d95853dad8472c91
> dashboard link: https://syzkaller.appspot.com/bug?extid=28b0702ada0bf7381f58
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1026ef2cb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c9c162b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com
> 
> RBP: 00007ffef262e230 R08: 0000000000000002 R09: 00007fddc8003531
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
> WARNING: CPU: 0 PID: 6517 at lib/debugobjects.c:508 debug_print_object lib/debugobjects.c:505 [inline]
> WARNING: CPU: 0 PID: 6517 at lib/debugobjects.c:508 debug_object_assert_init+0x1fa/0x250 lib/debugobjects.c:895
> Modules linked in:
> CPU: 0 PID: 6517 Comm: syz-executor011 Not tainted 5.15.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:debug_print_object lib/debugobjects.c:505 [inline]
> RIP: 0010:debug_object_assert_init+0x1fa/0x250 lib/debugobjects.c:895
> Code: e8 4b 15 b8 fd 4c 8b 45 00 48 c7 c7 a0 31 b4 8a 48 c7 c6 00 2e b4 8a 48 c7 c2 e0 33 b4 8a 31 c9 49 89 d9 31 c0 e8 b6 c6 36 fd <0f> 0b ff 05 3a 5c c5 09 48 83 c5 38 48 89 e8 48 c1 e8 03 42 80 3c
> RSP: 0018:ffffc90002c7e698 EFLAGS: 00010046
> RAX: cffa606352c78700 RBX: 0000000000000000 RCX: ffff888076ce9c80
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffffff8a512d00 R08: ffffffff81693402 R09: ffffed1017383f2c
> R10: ffffed1017383f2c R11: 0000000000000000 R12: dffffc0000000000
> R13: ffff88801bcd1720 R14: 0000000000000002 R15: ffffffff90ba5a20
> FS:  0000555557087300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5473f3c000 CR3: 0000000070ca6000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   debug_timer_assert_init kernel/time/timer.c:739 [inline]
>   debug_assert_init kernel/time/timer.c:784 [inline]
>   del_timer+0xa5/0x3d0 kernel/time/timer.c:1204
>   try_to_grab_pending+0x151/0xbb0 kernel/workqueue.c:1270
>   __cancel_work_timer+0x14c/0x710 kernel/workqueue.c:3129
>   batadv_nc_mesh_free+0x4a/0xf0 net/batman-adv/network-coding.c:1869
>   batadv_mesh_free+0x6f/0x140 net/batman-adv/main.c:245
>   batadv_mesh_init+0x4e5/0x550 net/batman-adv/main.c:226

Looks like cancel_delayed_work_sync() is called before 
INIT_DELAYED_WORK(), so calltrace looks like

batadv_mesh_init()
   batadv_originator_init()  <- injected allocation failure
   batadv_mesh_free()
     batadv_nc_mesh_free()
       cancel_delayed_work_sync()


Quick fix can be moving INIT_DELAYED_WORK() from batadv_nc_init() to 
batadv_mesh_init(), since there is complex dependencies between each 
mech part, if I understood comments correctly


Just for thoughts and syzbot testing

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



With regards,
Pavel Skripkin



--------------hDxpLWma1ZuOZqBZQxT8IIN9
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9iYXRtYW4tYWR2L21haW4uYyBiL25ldC9iYXRtYW4tYWR2L21h
aW4uYwppbmRleCAzZGRkNjZlNGMyOWUuLmEyNWM2NDRhY2Q2YyAxMDA2NDQKLS0tIGEvbmV0
L2JhdG1hbi1hZHYvbWFpbi5jCisrKyBiL25ldC9iYXRtYW4tYWR2L21haW4uYwpAQCAtMTg4
LDYgKzE4OCwxMCBAQCBpbnQgYmF0YWR2X21lc2hfaW5pdChzdHJ1Y3QgbmV0X2RldmljZSAq
c29mdF9pZmFjZSkKIAlJTklUX0hMSVNUX0hFQUQoJmJhdF9wcml2LT5zb2Z0aWZfdmxhbl9s
aXN0KTsKIAlJTklUX0hMSVNUX0hFQUQoJmJhdF9wcml2LT50cF9saXN0KTsKIAorI2lmZGVm
IENPTkZJR19CQVRNQU5fQURWX05DCisJSU5JVF9ERUxBWUVEX1dPUksoJmJhdF9wcml2LT5u
Yy53b3JrLCBiYXRhZHZfbmNfd29ya2VyKTsKKyNlbmRpZgorCiAJYmF0X3ByaXYtPmd3Lmdl
bmVyYXRpb24gPSAwOwogCiAJcmV0ID0gYmF0YWR2X3ZfbWVzaF9pbml0KGJhdF9wcml2KTsK
ZGlmZiAtLWdpdCBhL25ldC9iYXRtYW4tYWR2L25ldHdvcmstY29kaW5nLmMgYi9uZXQvYmF0
bWFuLWFkdi9uZXR3b3JrLWNvZGluZy5jCmluZGV4IDlmMDYxMzJlMDA3ZC4uZWFmZDk5MzZl
MDIxIDEwMDY0NAotLS0gYS9uZXQvYmF0bWFuLWFkdi9uZXR3b3JrLWNvZGluZy5jCisrKyBi
L25ldC9iYXRtYW4tYWR2L25ldHdvcmstY29kaW5nLmMKQEAgLTQ3LDcgKzQ3LDYgQEAKIHN0
YXRpYyBzdHJ1Y3QgbG9ja19jbGFzc19rZXkgYmF0YWR2X25jX2NvZGluZ19oYXNoX2xvY2tf
Y2xhc3Nfa2V5Owogc3RhdGljIHN0cnVjdCBsb2NrX2NsYXNzX2tleSBiYXRhZHZfbmNfZGVj
b2RpbmdfaGFzaF9sb2NrX2NsYXNzX2tleTsKIAotc3RhdGljIHZvaWQgYmF0YWR2X25jX3dv
cmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOwogc3RhdGljIGludCBiYXRhZHZfbmNf
cmVjdl9jb2RlZF9wYWNrZXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwKIAkJCQkgICAgICAgc3Ry
dWN0IGJhdGFkdl9oYXJkX2lmYWNlICpyZWN2X2lmKTsKIApAQCAtMTU4LDcgKzE1Nyw2IEBA
IGludCBiYXRhZHZfbmNfbWVzaF9pbml0KHN0cnVjdCBiYXRhZHZfcHJpdiAqYmF0X3ByaXYp
CiAJYmF0YWR2X2hhc2hfc2V0X2xvY2tfY2xhc3MoYmF0X3ByaXYtPm5jLmRlY29kaW5nX2hh
c2gsCiAJCQkJICAgJmJhdGFkdl9uY19kZWNvZGluZ19oYXNoX2xvY2tfY2xhc3Nfa2V5KTsK
IAotCUlOSVRfREVMQVlFRF9XT1JLKCZiYXRfcHJpdi0+bmMud29yaywgYmF0YWR2X25jX3dv
cmtlcik7CiAJYmF0YWR2X25jX3N0YXJ0X3RpbWVyKGJhdF9wcml2KTsKIAogCWJhdGFkdl90
dmx2X2hhbmRsZXJfcmVnaXN0ZXIoYmF0X3ByaXYsIGJhdGFkdl9uY190dmx2X29nbV9oYW5k
bGVyX3YxLApAQCAtNzA3LDcgKzcwNSw3IEBAIGJhdGFkdl9uY19wcm9jZXNzX25jX3BhdGhz
KHN0cnVjdCBiYXRhZHZfcHJpdiAqYmF0X3ByaXYsCiAgKiAgY29kaW5nCiAgKiBAd29yazog
a2VybmVsIHdvcmsgc3RydWN0CiAgKi8KLXN0YXRpYyB2b2lkIGJhdGFkdl9uY193b3JrZXIo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQordm9pZCBiYXRhZHZfbmNfd29ya2VyKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykKIHsKIAlzdHJ1Y3QgZGVsYXllZF93b3JrICpkZWxheWVk
X3dvcms7CiAJc3RydWN0IGJhdGFkdl9wcml2X25jICpwcml2X25jOwpkaWZmIC0tZ2l0IGEv
bmV0L2JhdG1hbi1hZHYvbmV0d29yay1jb2RpbmcuaCBiL25ldC9iYXRtYW4tYWR2L25ldHdv
cmstY29kaW5nLmgKaW5kZXggMzY4Y2MzMTMwZTRjLi5jZmNkMTIyM2E5MmIgMTAwNjQ0Ci0t
LSBhL25ldC9iYXRtYW4tYWR2L25ldHdvcmstY29kaW5nLmgKKysrIGIvbmV0L2JhdG1hbi1h
ZHYvbmV0d29yay1jb2RpbmcuaApAQCAtMzcsNiArMzcsNyBAQCB2b2lkIGJhdGFkdl9uY19z
a2Jfc3RvcmVfZm9yX2RlY29kaW5nKHN0cnVjdCBiYXRhZHZfcHJpdiAqYmF0X3ByaXYsCiAJ
CQkJICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYik7CiB2b2lkIGJhdGFkdl9uY19za2Jfc3Rv
cmVfc25pZmZlZF91bmljYXN0KHN0cnVjdCBiYXRhZHZfcHJpdiAqYmF0X3ByaXYsCiAJCQkJ
CSBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsKK3ZvaWQgYmF0YWR2X25jX3dvcmtlcihzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspOwogCiAjZWxzZSAvKiBpZmRlZiBDT05GSUdfQkFUTUFOX0FE
Vl9OQyAqLwogCkBAIC01OCw2ICs1OSwxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYmF0YWR2
X25jX21lc2hfZnJlZShzdHJ1Y3QgYmF0YWR2X3ByaXYgKmJhdF9wcml2KQogewogfQogCitz
dGF0aWMgaW5saW5lIHZvaWQgYmF0YWR2X25jX3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
KndvcmspCit7Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9pZAogYmF0YWR2X25jX3VwZGF0ZV9u
Y19ub2RlKHN0cnVjdCBiYXRhZHZfcHJpdiAqYmF0X3ByaXYsCiAJCQkgc3RydWN0IGJhdGFk
dl9vcmlnX25vZGUgKm9yaWdfbm9kZSwK
--------------hDxpLWma1ZuOZqBZQxT8IIN9--

