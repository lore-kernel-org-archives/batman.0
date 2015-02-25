Return-Path: <ufo@rund.freifunk.net>
Message-ID: <54ED37CC.1040802@rund.freifunk.net>
Date: Wed, 25 Feb 2015 03:47:40 +0100
From: Ufo <ufo@rund.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] use_count = 1 / device stuck on reboot or netifd
	restart
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

in leipzig since months we have problems with batman-adv and these
start/stop scripts or netifd-stuff.

we thought that this might be our own special problem, because we are
using more than one batman-adv instance (separated by vlan).

but its still there, also on openwrt-cc-trunk, now also on our
batman-adv super-gluon-node-servers (using fastd) on virtualized
x86-openwrt.
so f.i. i can crash that system in a way by: etc/init.d/fastd stop

please help us and have a look at our local ticket number 23
https://github.com/freifunk/firmware-leipzig/issues/23

good luck
ufo


root@vpnb9:~# batctl -v
batctl 2014.4.0 [batman-adv: 2014.4.0]
root@vpnb9:~# fastd -v
fastd v17
root@vpnb9:~# cat /etc/openwrt_*
DISTRIB_ID='OpenWrt'
DISTRIB_RELEASE='Bleeding Edge'
DISTRIB_REVISION='r44497'
DISTRIB_CODENAME='chaos_calmer'
DISTRIB_TARGET='x86/kvm_guest'
DISTRIB_DESCRIPTION='OpenWrt Chaos Calmer r44497'
DISTRIB_TAINTS=''
r44497


-- 
---
Freifunk Leipzig http://leipzig.freifunk.net
