Return-Path: <martin@hundeboll.net>
Message-ID: <4F8D9511.9040805@hundeboll.net>
Date: Tue, 17 Apr 2012 18:06:41 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Module crash when reading log and deleting interface
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

I can make the module crash by deleting eth0 from bat0, while reading the log with batctl log:

root@OpenWrt:/# batctl ll all
batman_adv: bat0: log_level: Changing from: 0 to: 31
root@OpenWrt:/# batctl log > /dev/null &
root@OpenWrt:/# batctl if del eth0
batman_adv: bat0: Interface deactivated: eth0
batman_adv: bat0: Removing interface: eth0
BUG: unable to handle kernel paging request at 00002000
IP: [<c4961424>] debug_log+0xe4/0x220 [batman_adv]
*pde = 00000000
Oops: 0000 [#2]
last sysfs file: /sys/devices/pci0000:00/0000:00:03.0/net/eth0/batman_adv/mesh_iface
Modules linked in: e1000 batman_adv crc16

Pid: 826, comm: batctl Tainted: G      D W  (2.6.32.27 #4) Bochs
EIP: 0060:[<c4961424>] EFLAGS: 00010246 CPU: 0
EIP is at debug_log+0xe4/0x220 [batman_adv]
EAX: c3049000 EBX: 00001000 ECX: 00000000 EDX: 08eca070
ESI: fffffff2 EDI: 00000000 EBP: 08ec9070 ESP: c3049f40
  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process batctl (pid: 826, ti=c3049000 task=c3b70360 task.ti=c3049000)
Stack:
  010611a7 00000000 00000000 00000002 c34b8b90 c34b8b90 c3049f58 00000000
<0> c38cac00 08ec9070 c3049f9c 00001000 c106e4ba c3049f9c 00000000 00000000
<0> c49613b0 c38cac00 fffffff7 00000003 c3049000 c106e8b1 c3049f9c 00000000
Call Trace:
  [<c106e4ba>] ? vfs_read+0x9a/0x160
  [<c49613b0>] ? debug_log+0x70/0x220 [batman_adv]
  [<c106e8b1>] ? sys_read+0x41/0x70
  [<c1002ae5>] ? syscall_call+0x7/0xb
Code: 00 31 f6 85 db 0f 84 3c 01 00 00 89 e0 89 ea 25 00 f0 ff ff be f2 ff ff ff 01 da 19 c9 39 50 18 83 d9 00 85 c9 0f 85 1c 01 00 00 <8b> 87 00 20 00 00 3b 87 04 20 00 00 0f 85 84 00 00 00 31 c0 31
EIP: [<c4961424>] debug_log+0xe4/0x220 [batman_adv] SS:ESP 0068:c3049f40
CR2: 0000000000002000
---[ end trace 4eaa2a86a8e2da26 ]---
[1]+  Killed                     batctl log 1>/dev/null


-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
