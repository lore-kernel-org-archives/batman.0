Return-Path: <dbeberman@gmail.com>
MIME-Version: 1.0
Date: Fri, 20 May 2011 09:40:01 -0400
Message-ID: <BANLkTim+tDtnKidN7XOrs=FJz=u6Jkqoyw@mail.gmail.com>
From: David Beberman <dbeberman@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv bug 149: odd broadcast behavior --
 generated CRC errors (Sven Eckelmann)
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

First, my apologies on not monitoring the irc channel.
A bit consumed at work.=A0 (if anybody happens to know how to
get the broadcom bcm4329 driver to change channels in ad-hoc mode,
please feel free to share.=A0 iwconfig ... channel XX command fails, but
driver code looks correct. Target is HTC Desire).

Regarding fragmentation -- this is strictly coming from the UPD/IPv6.
It it not fragmenting in the wlan driver.=A0 I have fragmentation
threshold set off.=A0 I'm assuming it is responding to the configuration
parameters correctly.

I'm using Omnipeek on a PC to sniff the packets.=A0 The antennas are
about 2 feet apart.=A0 The network traffic is relatively low, in the 1 -
10% on average, with virtually no indication of corruption from hidden
nodes or other sources under regular operation.=A0 That is, I only see
the CRC error flags set with the broadcast packets at 802.11g data
rates.=A0 This is the 802.11 packet CRC, nothing internal to it.=A0 The
Omnipeek does not know about the batman-adv protocol.=A0 Also, I have
other nodes setup with batman-adv which are
repeating the broadcasts.=A0 I can see that only the packets without the
CRC error flags are being rebroadcast.=A0 This indicates to me that the
packets flagged as
CRC errors by Omnipeek are also being dropped as error'ed packets by
the other nodes.
I do not see this problem with packets sent directly to the bcm4329
device.=A0 However, I will continue to try to see if I can get that to
happen, would then mean it is bcm4329 driver and hardware problem.=A0 At
the moment, using UDP broadcast with IPv4 directly onto the wlan
driver without batman-adv (bat0), I do not see the behavior.=A0 I've
been using my own code for this.=A0 Noticed netcat and nc last night.
Will try piping with those tools today in both modes, with and without
batman-adv to
reverify what I'm seeing.

I do not know how to do kernel debugging with kdbg/gdb across a USB
port on the target side.=A0 I do not have JTAG or serial access.
Google'd for how to setup the kernel to use USB port for kdbg, but did
not find anything.=A0 Just lots of info on how to debug the USB driver
itself.
I'm using the cyanogenmod version of Android with the HTC Desire
version of the Linux kernel, and the insertion of modules like
batman-adv.=A0 I did verify that the modules are being built against the
correct Linux kernel sources, just in case there was something silly
going on.

I'm building with NETCONSOLE enabled today and hope to be able to see
driver messages sent over the WLAN using netcat on the host side.
That should allow me to see both batman-adv and the bcm4329 trace
messages.=A0 I should also be able to send the console to ttyUSB0,
assuming I can get the HTC Desire USB to behave properly.

I'll change the line to skb_copy as was suggested by <T_x>?=A0 and Sven.
Will post my results.

Thanks for the follow up.

David Beberman
