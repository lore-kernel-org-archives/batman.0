Return-Path: <roblourens@gmail.com>
MIME-Version: 1.0
From: Rob Lourens <roblourens@gmail.com>
Date: Wed, 4 Jan 2012 10:51:29 -0600
Message-ID: <CAAXbfMH0OmQhWja_1sjYRzkyS4x-SGu8h7uQdye6iKRTkyLt5w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Loading the kernel module
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I'm having trouble with loading the kernel module. I'm sure it's just
a dumb mistake on my part. I compiled the module, loaded it with
insmod, and I can add interfaces using
/sys/class/net/wlan0/batman_adv, but batctl says that the kernel
module may not be loaded. It's true that there is no folder
/proc/net/batman-adv.

rob@ubuntu:/usr/src/batman-adv-2011.4.0$ sudo insmod batman-adv.ko
[sudo] password for rob:
rob@ubuntu:/usr/src/batman-adv-2011.4.0$ lsmod | grep batman
batman_adv=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 83597=A0 0
rob@ubuntu:/usr/src/batman-adv-2011.4.0$ sudo batctl if
Error - the folder '/proc/net/batman-adv/' was not found within the
proc filesystem
Please make sure that the batman-adv kernel module is loaded
rob@ubuntu:/usr/src/batman-adv-2011.4.0$ uname --all
Linux ubuntu 2.6.32-33-generic #70-Ubuntu SMP Thu Jul 7 21:09:46 UTC
2011 i686 GNU/Linux
rob@ubuntu:/usr/src/batman-adv-2011.4.0$ modinfo batman-adv
filename:       /lib/modules/2.6.32-33-generic/updates/dkms/batman-adv.ko
version:        0.2
description:    B.A.T.M.A.N. advanced
author:         Marek Lindner <lindner_marek@yahoo.de>, Simon
Wunderlich <siwu@hrz.tu-chemnitz.de>
license:        GPL
srcversion:     CE6165E01E79C5D87404D6F
depends:
vermagic:       2.6.32-33-generic SMP mod_unload modversions 586


Any idea what I am missing?

Thanks,
Rob Lourens
