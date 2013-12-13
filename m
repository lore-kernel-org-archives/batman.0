Return-Path: <gui@altermundi.net>
Message-ID: <52AB595E.8090104@altermundi.net>
Date: Fri, 13 Dec 2013 16:00:46 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] alfred init.d bugs
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

alfred will refuse to start if bat0 doesn't exist yet

root@48cfeb:~# alfred -i br-lan -m -b bat0
Could not find transtable_global for interface bat0. Make sure it is a 
valid batman-adv soft-interface

at boot time this can create a race condition, since wifi interfaces can 
take longer to be brought up, making bat0 appear much later than the 
time alfred init.d script is run. In the following example, 4 seconds later.

Sun Nov  3 05:09:13 2013 kern.emerg /etc/rc.d/S99alfred: starting alfred
Sun Nov  3 05:09:13 2013 kern.emerg /etc/rc.d/S99alfred: starting batadv-vis
Sun Nov  3 05:09:13 2013 kern.emerg can't connect to unix socket: 
Connection refused
Sun Nov  3 05:09:13 2013 kern.emerg can't connect to unix socket: 
Connection refused
Sun Nov  3 05:09:17 2013 kern.info kernel: [   28.620000] batman_adv: 
bat0: Adding interface: wlan0ah.145
Sun Nov  3 05:09:17 2013 kern.info kernel: [   28.620000] batman_adv: 
bat0: Interface activated: wlan0ah.145
Sun Nov  3 05:09:17 2013 daemon.notice netifd: Interface 
'lm_wlan0ah_bata' is now up
Sun Nov  3 05:09:17 2013 kern.info kernel: [   29.060000] batman_adv: 
bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
Sun Nov  3 05:09:17 2013 kern.info kernel: [   29.080000] batman_adv: 
bat0: distributed_arp_table: Changing from: enabled to: disabled

sending a patch for this in a minute, along with another bugfix which 
needs less explanation :)
