Return-Path: <gui@altermundi.net>
Message-ID: <51F5B134.4030203@altermundi.net>
Date: Sun, 28 Jul 2013 21:03:00 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Complete netifd integration in openwrt
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello folks,
i finally took the time to finish the netifd integration in openwrt.
since 2013.0.0, the "slave interfaces" moved from 
batman-adv.bat0.interfaces to network.meshblah.proto=batadv, so that 
netifd could properly manage the setup and teardown, avoiding some race 
conditions i faced at that time (about a year ago)
now i did the same for the "mesh interface", batX, which until now had 
the parameters still set in /etc/config/batman-adv.

### So, what in 2012.4.0 was

# cat /etc/config/batman-adv
config 'mesh' 'bat0'
         option 'interfaces' 'mesh0'
         option 'ap_isolation' '1'
         option 'gw_mode' 'server'

# cat /etc/config/network
config interface 'mesh0'
	option ifname 'eth2'
	option proto 'none'
	option auto '1'

### now fully turns into:

# cat /etc/config/network
config interface 'bat0'
	option proto 'batmesh'
	option ifname 'bat0'
	option ap_isolation '1'
	option gw_mode 'server'

config interface 'mesh0'
	option ifname 'eth2'
	option proto 'batadv'
	option mesh 'bat0'

[about the proto name... since proto=batadv was already taken for slave 
interfaces, i couldn't come up with anything better than "batmesh" :(
I was talking with Nico just now, and he suggested "batadvmesh"
in any case, suggestions are much welcome. Anyway, proto=bat.*mesh is 
for setting the mesh parameters]

and well, to avoid breaking current configs unnecesarily [over 
sysupgrades (or opkg upgrades?)] i included a small uci-defaults 
migration script to take care of that; it transparently migrates all 
current /etc/config/batman-adv settings to netifd-style.

Why the integration? reliability in the setup; no more race conditions 
whatsoever at boot, or runtime: i even tried rmmoding the module, and 
doing "ifup mesh0" brought everything up again cleanly. while netifd had 
some stigmas when it was born, now (in my experience) it has grown to a 
pretty solid nifty daemon.

I made a pull request on
https://github.com/openwrt-routing/packages/pull/4
comments welcome :D

if you prefer [PATCHES] over mail, just ask :)

as always, cheers, and thanks for being so cool people!

Gui
