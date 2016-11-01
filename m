Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <5818988B.5050600@yahoo.com>
Date: Tue, 01 Nov 2016 21:28:43 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: how to config gateway ?
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
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


Hello Dear Sir :

after i succeed to connect hostA to hostB at wifi environment this
afternoon , and i config gateway between hostA and hostB,

i run avahi-autoipd bat0 at two host only ( not run dhcpcd ) and run
batctl gw_mode server and batctl gw_mode server 5mbit/1mbit at hostA,

and run batctl gw_mode client and batctl gw_mode client 20 at hostB


Whether i need config dhcpcd at hostA ? if possible , please give me a
example .

Thanks

---------------------------
HostB status

--------------------------
[root@alarmpi ~]# batctl gwl
Gateway (#/255) Nexthop [outgoingIF]: advertised uplink bandwidth ...
[B.A.T.M.A.N. adv 2015.2, MainIF/MAC: wlan0/c8:3a:35:c9:ce:71 (bat0)]
=> 00:b0:8c:e7:25:3a (248) 00:b0:8c:e7:25:3a [ wlan0]: 5.0/1.0 MBit

[root@alarmpi ~]# batctl gw_mode
client (selection class: 20)

[B.A.T.M.A.N. adv 2015.2, MainIF/MAC: wlan0/c8:3a:35:c9:ce:71 (bat0
BATMAN_IV)]
Originator last-seen (#/255) Nexthop [outgoingIF]: Potential nexthops ...
00:b0:8c:e7:25:3a 0.840s (229) 00:b0:8c:e7:25:3a [ wlan0]:
00:b0:8c:e7:25:3a (229)


---------------------------
HostA status

--------------------------

[root@alarmpi ~]# batctl gw_mode
server (announced bw: 5.0/1.0 MBit)
[root@alarmpi ~]# batctl o
[B.A.T.M.A.N. adv 2015.2, MainIF/MAC: wlan0/00:b0:8c:e7:25:3a (bat0
BATMAN_IV)]
Originator last-seen (#/255) Nexthop [outgoingIF]: Potential nexthops ...
c8:3a:35:c9:ce:71 0.440s (239) c8:3a:35:c9:ce:71 [ wlan0]:
c8:3a:35:c9:ce:71 (239)
[root@alarmpi ~]# batctl gwl
Gateway (#/255) Nexthop [outgoingIF]: advertised uplink bandwidth ...
[B.A.T.M.A.N. adv 2015.2, MainIF/MAC: wlan0/00:b0:8c:e7:25:3a (bat0)]
No gateways in range ..



