Return-Path: <apgodshall@gmail.com>
MIME-Version: 1.0
Sender: apgodshall@gmail.com
Date: Tue, 10 Jul 2012 10:13:46 -0700
Message-ID: <CAAOvAThfuXjDRDbhkPWxwzdJ+zZb5uUbdkXWxYDBDMJjVTU4NA@mail.gmail.com>
From: Tony Godshall <togo@of.net>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] newbie error or repo misconfig?
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

root@OpenWrt:~# opkg install kmod-batman-adv
Installing kmod-batman-adv (3.3.8+2012.2.0-2) to root...
Downloading http://downloads.openwrt.org/snapshots/trunk/ar71xx/packages/kmod-batman-adv_3.3.8+2012.2.0-2_ar71xx.ipk.
Collected errors:
 * satisfy_dependencies_for: Cannot satisfy the following dependencies
for kmod-batman-adv:
 *      kernel (= 3.3.8-1-65fa3307447a560c3a618c4d54bfa4dc) *   kernel
(= 3.3.8-1-65fa3307447a560c3a618c4d54bfa4dc) *
 * opkg_install_cmd: Cannot install package kmod-batman-adv.

This is my foray into batman-adv land, with a freshly flashed
TL-WR703n that has been configured and tested functional as a wifi
access point

Can the list direct me to-
1. do I need to set up toolchain and build batman-adv myself against
this kernel?
2. do I need to set up toolchain and build my own kernel?
3. can I instead point configure for some other repository

I've perused the batman-advanced documentation wiki but the documents
there seem to kind of skip over this bit

-- 
Best Regards.
