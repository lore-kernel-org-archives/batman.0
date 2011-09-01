Return-Path: <tracer@robotech.de>
Message-ID: <4E5FF4F2.8050309@robotech.de>
Date: Thu, 01 Sep 2011 23:11:14 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org>
	<4E5E69DB.5060007@robotech.de>
	<20110831215506.GA27165@ritirata.org>
	<4E5F3F31.7000402@robotech.de> <20110901155545.GA840@ritirata.org>
In-Reply-To: <20110901155545.GA840@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

Am 01.09.2011 17:55, schrieb Antonio Quartulli:
>
> ok. It seems there is a bug somewhere :-)
> Can you again copy/paste this creating/deleting part of the node log and tell me
> which is the correct bat0 MAC address of the node announcing the change?
>
> E.g:
> on fon-53 you have this log:
>   >  [     87390] Creating new global tt entry: 00:02:81:b9:42:c8 (via
>   >  5e:e6:fc:ae:55:a8)
>   >  [     87390] Deleting global tt entry 00:02:81:b9:42:c8 (via
>   >  5e:e6:fc:ae:55:a8): originator time out
>
> then go on node 5e:e6:fc:ae:55:a8 and write down its bat0 MAC address, please.
> Moreover, is bat0 bridged with any other interface (e.g. bat0 + eth0 within br0?)

sure:
root@1043-49:~# batctl l | grep "0a:18:84:1e:f6:05"
[    125592] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 20443 
num_changes: 0)
[    125592] Deleting global tt entry 04:11:80:ca:6a:c8 (via 
0a:18:84:1e:f6:05): originator time out
[    125592] Creating new global tt entry: 04:11:80:df:ce:c8 (via 
0a:18:84:1e:f6:05)
[    125593] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 19376 
num_changes: 0)
[    125593] Deleting global tt entry 04:11:80:df:ce:c8 (via 
0a:18:84:1e:f6:05): originator time out
[    125593] Creating new global tt entry: 04:11:80:2f:c6:c8 (via 
0a:18:84:1e:f6:05)
[    125595] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 47287 
num_changes: 0)
[    125595] Deleting global tt entry 04:11:80:2f:c6:c8 (via 
0a:18:84:1e:f6:05): originator time out
[    125595] Creating new global tt entry: 04:11:80:50:3a:c8 (via 
0a:18:84:1e:f6:05)
[    125597] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 24775 
num_changes: 0)
[    125597] Creating new global tt entry: 04:11:80:2f:c6:c8 (via 
0a:18:84:1e:f6:05)


root@fon-53:~# brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan          8000.0018841ef604       no              eth0
                                                         edge1
                                                         wlan1
mesh            8000.0018841ef605       no              wlan0
                                                         edge0

root@fon-53:~# ifconfig
bat0      Link encap:Ethernet  HWaddr DA:54:2C:E4:B9:1E
           inet addr:192.168.111.53  Bcast:192.168.111.255  
Mask:255.255.255.0
br-lan    Link encap:Ethernet  HWaddr 00:18:84:1E:F6:04
           inet addr:192.168.1.53  Bcast:192.168.1.255  Mask:255.255.255.0
edge0     Link encap:Ethernet  HWaddr 0A:EA:66:19:D8:72
           inet addr:10.0.2.53  Bcast:10.0.2.255  Mask:255.255.255.0
edge1     Link encap:Ethernet  HWaddr 6A:D6:C4:C0:D6:76
           inet addr:10.0.1.53  Bcast:10.0.1.255  Mask:255.255.255.0
eth0      Link encap:Ethernet  HWaddr 00:18:84:1E:F6:04
mesh      Link encap:Ethernet  HWaddr 00:18:84:1E:F6:05
           inet addr:10.0.0.53  Bcast:10.255.255.255  Mask:255.0.0.0
mon.wlan0 Link encap:UNSPEC  HWaddr 
00-18-84-1E-F6-05-00-47-00-00-00-00-00-00-00-00
wlan0     Link encap:Ethernet  HWaddr 00:18:84:1E:F6:05
wlan1     Link encap:Ethernet  HWaddr 06:18:84:1E:F6:05
wlan2     Link encap:Ethernet  HWaddr 0A:18:84:1E:F6:05

As you can see we have a bridging to an n2n-tunnel but the tunnel is 
down ATM.
And the other wlan-interfaces (0 and 1) are secured and no one can 
connect. (no RX-traffic)

I even removed the n2n-tunnel but the bat53 is still causing these 
inconsistencies.

root@1043-49:~#  batctl l | grep "inconsis"
[    126479] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 47287 
num_changes: 0)
[    126480] TT inconsistency for 0a:18:84:26:35:9d. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 40594 last_crc: 26555 
num_changes: 0)
[    126480] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 26555 
num_changes: 0)
[    126481] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 11185 
num_changes: 0)
[    126481] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 24775 
num_changes: 0)
[    126482] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 19671 
num_changes: 0)
[    126483] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 16977 
num_changes: 0)
[    126484] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 26555 
num_changes: 0)
[    126485] TT inconsistency for 0a:18:84:26:35:9d. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 40594 last_crc: 47287 
num_changes: 0)

On some nodes i get a bunch of those inconsistencies within seconds on 
other nodes i don't get any within minutes.

Let me know if i can provide you any further infos that might help.

Tobias

