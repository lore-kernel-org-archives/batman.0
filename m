Return-Path: <kaushik.np.in@ieee.org>
MIME-Version: 1.0
From: Kaushik N P <kaushik.np.in@ieee.org>
Date: Mon, 3 Oct 2016 19:44:47 +0530
Message-ID: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Help in setting up mesh test bed using qemu - BATMAN
	adv
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

Hello,

I have recently decided to take up the prospect of layer 2 Batman adv
protocol as my area of interest, and want to implement a mesh bed to
get some statistical readings of my own (am very new to this area, so
ask for forgiveness beforehand if I was supposed to provide more
info). The plan was to set up OpenWRT in qemu in laptops and work on
them with batman adv. But, unfortunately, I have been facing some
problems in setting the system up. I have followed (as much as I
could) the steps as per documentation (links for them posted below).

Links:

https://wiki.openwrt.org/doc/howto/qemu (Setting up qemu - problem I
face in this is of which commands I should run , and which of the
systems are viable for me (like QEMU arm, arm 64, x86-64,etc) to work
on a 64-bit laptop having Linux OS )
https://www.open-mesh.org/projects/open-mesh/wiki/Emulation (I am not
sure if my qemu is set up properly for there is no confirmation
methods that are provided to me to check if its working properly)


What I hope to find is:-

Another documentation maybe for setting up, or confirmation for
setting up (because I can't tell sometimes if the instructions have
been followed correctly).
Clarification for my doubt regarding the different types of OpenWRT
images (like Kamikaze, Chaos Calmer, Attitude Adjustment,etc), what do
they do and which one I should use for working with standard Batman
adv setup.
Confirmation method to see if qemu having OpenWRT is setup in my
system - as now I have a setup in terminal which says

BusyBox v1.24.2 () built-in shell (ash)

//Says OpenWrt below
  _______                     ________        __
 |            | .-----.-----.-----.|  |  |  |.----.|  |_
 |     -      | |  _  |  -__|    ||  |  |  ||   _||   _|
 |_______| |  __|____|__|__||________||__|  |____|
                |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 DESIGNATED DRIVER (Bleeding Edge, 49928)
 -----------------------------------------------------
  * 2 oz. Orange Juice         Combine all juices in a
  * 2 oz. Pineapple Juice      tall glass filled with
  * 2 oz. Grapefruit Juice     ice, stir well.
  * 2 oz. Cranberry Juice
 -----------------------------------------------------
root@OpenWrt:/# [   13.897119] smsc911x smsc911x.0 eth0: SMSC911x/921x
identified at 0xf0b40000, IRQ: 60
[   13.934741] device eth0 entered promiscuous mode
[   13.978166] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
[   15.762764] br-lan: port 1(eth0) entered forwarding state
[   15.764526] br-lan: port 1(eth0) entered forwarding state
[   15.802643] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
[   17.762480] br-lan: port 1(eth0) entered forwarding state
root@OpenWrt:/#


I have more doubts, but hopefully, I will get some answers to them
from the above questions itself.
Hope to hear soon!!!

Thanks and Regards,

Kaushik NP
LI | Tw | FB
SAP Ambassador,
General Secretary, Computer Society
Team IEEE UVCE,
3rd Year Undergraduate Student,
University Visvesvaraya College of Engineering,
Bangalore, IN
