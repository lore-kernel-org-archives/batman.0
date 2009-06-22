Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200906200323.44115.sven.eckelmann@gmx.de>
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906200323.44115.sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 13:57:07 -0600
Message-ID: <5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Fri, Jun 19, 2009 at 7:23 PM, Sven Eckelmann<sven.eckelmann@gmx.de> wrote:
> On Saturday 20 June 2009 00:17:23 Jacob Marble wrote:
>> Two Linux boxes, each plugged in via Ethernet to a BATMAN node (two
>> nodes).  The nodes talk batman-advanced to each other via WiFi.  The
>> Linux boxes can ping each other all day long.  Both Linux boxes have
>> Apache running.  Downloading a file via HTTP works only if the file is
>> smaller than or equal to exactly 1,145 bytes.  TFTP file transfers are
>> halting, but they get through (4 megabytes took a couple of minutes).
>>
>> This happens with both r1176 and r1298 on OpenWrt.
>
> Sry, haven't followed your other mails so I don't know your whole setup. It
> looks like a mtu problem for me. Please try to set the mtu a lot lower on your
> eth devices. You can do a ping test with `ping -s TESTSIZEINBYTE -M dont
> IPTOSENDIPPACKET` - dont forget to add the 28 extra bytes needed for the whole
> headers inside the ethernet frame. So `ping -s 1472 -M do 192.168.1.1` would
> send a 1500 bytes package.
> You can also set the mtu on your wifi devices higher (and bat0 devices). So
> for example wifi device to 1524 and bat0 to 1500 (like the eth devices).
> Also check if you have bridge mtu patch from Simon[1] (included in linux
> 2.6.27) when you are bridging some of the devices. Also check that icmp
> "Destination Unreachable" - "Fragmentation required, and DF flag set" isn't
> filtered anywhere.
>

The nodes running batman-advanced are OpenWrt 8.09.1, which uses
kernel 2.6.26.8.  The patch is *not* in there, so I have re-flashed
(again) with OpenWrt SVN, which uses... 2.6.28.10.  Um, if the patch
isn't in OpenWrt stable releases, then maybe something should be said
on open-mesh.net?  Also, I need to make a big fat note in my howto.

The setup is two Ubiquiti NanoStation2 nodes, which have one wifi
device and one Ethernet device each.  Atheros 231x SoC.
ath0 = wifi0, ahdemo, channel = 1
bat0 interfaces = ath0
br-lan (bridge) = bat0 + eth0, IP address set on this device only

The Linux workstations are attached via Ethernet, running Ubuntu.

The MTU, by default, is 1500 on eth0, ath0, wifi0
The MTU, by default, is 1476 on bat0, br-lan

Ping from Linux workstation to Linux workstation works as long as the
-s flag is 1448 or less.  1448 = 1476 - 28
The -M do doesn't seem to change anything.

HTTP transfers still don't go through when they are larger than ~1400
bytes.  I'll go play with the MTUs now.
