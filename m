Return-Path: <beth.flippo@telegrid.com>
From: <beth.flippo@telegrid.com>
References: <015501d4be3c$d64ad290$82e077b0$@telegrid.com>
 <2382079.7bZRkTAdJY@sven-edge>
In-Reply-To: <2382079.7bZRkTAdJY@sven-edge>
Date: Wed, 6 Feb 2019 13:47:14 -0500
Message-ID: <022801d4be4c$60a1dec0$21e59c40$@telegrid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [B.A.T.M.A.N.] Alfred problem reading other nodes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: s.pinsky@telegrid.com

We are using a gateworks board and built the latest version from their bsp
but we had batman-adv, batctl and Alfred ipk built at version 2018.0.
Batman and batctl are both working.

root@OpenWrt:~# uname -a
Linux OpenWrt 4.4.0 #16 SMP Tue Jan 29 19:41:46 UTC 2019 armv7l GNU/Linux
root@OpenWrt:~# cat /etc/openwrt_release DISTRIB_ID='Gateworks'
DISTRIB_RELEASE='Gateworks Ventana 16.02@dd98aee-dirty'
DISTRIB_REVISION='r48868'
DISTRIB_CODENAME='designated_driver'
DISTRIB_TARGET='imx6/generic'
DISTRIB_DESCRIPTION='Gateworks Designated Driver Gateworks Ventana
16.02@dd98aee-dirty'
DISTRIB_TAINTS='no-all busybox'
root@OpenWrt:~#



-----Original Message-----
From: Sven Eckelmann <sven@narfation.org> 
Sent: Wednesday, February 6, 2019 1:14 PM
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: beth.flippo@telegrid.com; s.pinsky@telegrid.com
Subject: Re: [B.A.T.M.A.N.] Alfred problem reading other nodes

On Wednesday, 6 February 2019 17.56.00 CET beth.flippo@telegrid.com wrote:
[...]
> I am having a problem getting alfred retrieve info from other nodes.  
> I am running openwrt and alfred 2018.0.

Which OpenWrt version should that be? There is no release with 2018.0 and
the current version in master is also newer.

> I am able to start the alfred server with no errors both from boot and 
> the command line.
> 
> root@OpenWrt:~# /etc/init.d/alfred restart
> /etc/init.d/alfred: waiting 30 secs for br-lan address...
> /etc/init.d/alfred: starting alfred
> /etc/init.d/alfred: starting batadv-vis
> 
> I can see it with ps
> 
> 4290 root       816 S    /usr/sbin/alfred -i br-lan -m -b bat0
> 
> I can issue a set and then a receive and I see the value I set but 
> only locally.  It does not get any info from the other nodes in my 
> network.  They are all running alfred servers as master.

Have you checked whether process_alfred_announce_master (recv.c) rejects the
incoming packet for some reason and thus doesn't add it to the server list?

If not, have you checked whether sync_data (send.c) really sends out the
data via push_data to the remote server?

> I have added a firewall rule to open the port.
> 
> If I have 2 nodes running alfred and I run 'tcpdump -i br-lan udp port 
> 16962' - I see packets from the other node:
> 
> 16:21:49.279086 IP6 fe80::2d0:12ff:fe00:f0c7.16962 > ip6-allnodes.16962:
> UDP, length 4
[...]
> I think these might be the master announcements but when I issue an 
> alfred -r # - I do not see any new messages in the tcpdump.

If all daemons are in server mode then they will not create a request via
`alfred -r`. Instead, they regularly sync [1] their facts between each other
(same port but different packet type).

Kind regards,
	Sven

[1]
https://www.open-mesh.org/projects/alfred/wiki/Alfred_architecture#Synchroni
zation

