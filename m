Return-Path: <sailashm@gmail.com>
MIME-Version: 1.0
From: Sailash Moirangthem <sailashm@gmail.com>
Date: Thu, 23 Jun 2016 14:54:37 +0530
Message-ID: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
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

Hi Team,

I really appreciate for all your contributions in the mesh network.
I am trying to set-up mesh network using tplink WR1043ND routers and
raspberry pi B+ integrated with ra2800usb (wi pi). The tplink routers
are working as expected. Howoever, the raspberry pi is not working.

The configuration file for the Pi board is as follows:

config interface loopback
 option ifname lo
option proto static
 option ipaddr 127.0.0.1
 option netmask 255.0.0.0
config interface lan
option ifname eth0
option type bridge
 option proto static
option ipaddr 192.168.1.1
option netmask 255.255.255.0
 config interface 'mesh'
option ifname 'adhoc0'
option mtu '1528'
 option proto 'batadv'
 option mesh 'bat0'
 config interface mb
option ifname bat0
option type bridge option proto static
 option ipaddr 192.168.99.26
 option netmask 255.255.255.0

using the same config in tplink routers work but not in pi boards. The
adhoc0 interface is not shown up in pi board.

cat sys/class/net/adhoc0/batman-adv/mesh_iface says none.
cat sys/class/net/adhoc0/batman-adv/staus says not in use.

Please Help!!! Thanks in advance.

Yours Sincerely,
Sailash M
Research Student
