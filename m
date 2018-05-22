Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 22 May 2018 23:12:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180522211214.GG15580@otheros>
References: <20180511185723.20138-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511185723.20138-1-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [RFC maint v2] batman-adv: fix adding VLANs with
 partial state
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, lemoer <freifunk@irrelefant.net>

On Sat, May 12, 2018 at 02:57:23AM +0800, Marek Lindner wrote:
> Whenever a new VLAN is created on top of batman virtual interfaces
> the batman-adv kernel module creates internal structures to track
> the status of said VLAN. Amongst other things, the MAC address of
> the VLAN interface itself has to be stored.
> 
> Without this change a VLAN and its infrastructure could be created
> while the interface MAC address is not stored without triggering
> any error, thus creating issues in other parts of the code.
> 
> Prevent the VLAN from being created if the MAC address can not
> be stored.
> 
> Fixes: 952cebb57518 ("batman-adv: add per VLAN interface attribute framework")
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

I tested this patch but so far could not spot any issues either in
dmesg or logread.

I've added these patches to a branch for Gluon here:

https://github.com/T-X/gluon/tree/tt-vlan-patched

And used these images (warning, they have my SSH public added):

https://metameute.de/~tux/Freifunk/firmware/ffh-tt-patched/

I've tested with an isolated two nodes setup for now.


I started playing with restarting the network multiple times:

~~~~~
root@freifunk-b0487ae7f31e:~# rm /tmp/vlan-test.log; trap '' SIGPIPE; for i in `seq 1 30`; do echo "Starting network restart $i" >> /tmp/vlan-test.log; /etc/init.d/network restart; sleep 5; if batctl tl | grep " 0 \["; then echo "BROKEN - aborting" >> /tmp/vlan-test.log; batctl tl >> /tmp/vlan-test.log; sleep 3; echo "waiting..." >> /tmp/vlan-test.log; batctl tl >> /tmp/vlan-test.log; break; fi; done; echo "finished" >> /tmp/vlan-test.log
~~~~~

And the result is the following - which looks odd?

~~~~~
root@freifunk-b0487ae7f31e:~# cat /tmp/vlan-test.log 
Starting network restart 1
Starting network restart 2
Starting network restart 3
BROKEN - aborting
[B.A.T.M.A.N. adv 2018.1, MainIF/MAC: primary0/66:c6:34:9d:58:43 (bat0/b0:48:7a:e7:f3:1e BATMAN_IV), TTVN: 1]
Client             VID Flags    Last seen (CRC       )
9a:86:17:9c:5f:4f   -1 [.P.X..]   0.000   (0x0ce60e81)
b0:48:7a:e7:f3:1e    0 [.PN...]   0.000   (0x00000000)
b0:48:7a:e7:f3:1e   -1 [.PN...]   0.000   (0x0ce60e81)
waiting...
[B.A.T.M.A.N. adv 2018.1, MainIF/MAC: primary0/66:c6:34:9d:58:43 (bat0/b0:48:7a:e7:f3:1e BATMAN_IV), TTVN: 2]
Client             VID Flags    Last seen (CRC       )
b0:48:7a:e7:f3:1e    0 [.P....]   0.000   (0xc4c7d9cf)
b0:48:7a:e7:f3:1e   -1 [.P....]   0.000   (0x62afdc24)
finished
~~~~~

However, this oddity seems to be temporary, now the local TT looks
just fine, without having rebooted the node:

~~~~~
root@freifunk-b0487ae7f31e:~# batctl tl
[B.A.T.M.A.N. adv 2018.1, MainIF/MAC: primary0/66:c6:34:9d:58:43 (bat0/b0:48:7a:e7:f3:1e BATMAN_IV), TTVN: 4]
Client             VID Flags    Last seen (CRC       )
33:33:ff:40:f8:dc   -1 [.P....]   0.000   (0xd118c666)
b0:48:7a:e7:f3:1e    0 [.P....]   0.000   (0xc4c7d9cf)
33:33:00:00:00:02   -1 [.P....]   0.000   (0xd118c666)
33:33:ff:00:00:01   -1 [.P....]   0.000   (0xd118c666)
33:33:00:02:10:01   -1 [.P....]   0.000   (0xd118c666)
01:00:5e:00:00:01   -1 [.P....]   0.000   (0xd118c666)
b0:48:7a:e7:f3:1e   -1 [.P....]   0.000   (0xd118c666)
33:33:ff:e7:f3:1e   -1 [.P....]   0.000   (0xd118c666)
33:33:00:00:00:01   -1 [.P....]   0.000   (0xd118c666)
~~~~~

Or is it expected that a TT VLAN entry with an "N" flag will have
the CRC set to 0x00000000?

I also noticed that the VLAN 0 is added to bat0 by 8021q right
after bat0 gets created and activated:

~~~~~
Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7852.985327] batman_adv: bat0: Adding interface: primary0
Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7852.990712] batman_adv: bat0: Interface activated: primary0
Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.025080] 8021q: adding VLAN 0 to HW filter on device bat0
Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' is enabled
Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.038815] device bat0 entered promiscuous mode
Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.043649] br-client: port 3(bat0) entered forwarding state
Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.049388] br-client: port 3(bat0) entered forwarding state
Sun Feb 25 14:20:28 2018 daemon.notice netifd: Network device 'bat0' link is up
Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' has link connectivity 
Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' is setting up now
Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' is now up
~~~~~

Which looks like it might have the potential for a race condition?
Also the "HW filter" remark by 8021q seems a bit odd as this is a
virtual interface, doesn't it?

Regards, Linus
