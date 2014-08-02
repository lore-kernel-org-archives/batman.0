Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat,  2 Aug 2014 21:18:49 +0200
Message-Id: <1407007130-23077-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Enhancements for Unsolicited Neigh. Adv. / grat ARP
	Reply
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi there,

Here's a little, rough patch to illustrate the idea we discussed a little
at the last Wireless Battle Mesh, that is forwarding the noisy IPv6
Unsolicited Neighbor Advertisements and gratuitous ARP Replies via unicast.

Currently these ugly unsol. NAs cause about 40% of ICMPv6 multicast
overhead in our networks here.

A little more detailed explanation with some pictures can be found here:

https://www.open-mesh.org/projects/batman-adv/wiki/Unicasting-unsolicited-neighbor-advertisements

In the few, simple scenarios with bridged-in hosts in VMs, the patch
seemed to do what it was supposed to do uppon roaming. Unsol. NAs did only
appear on the node the host roamed away from.

If I remember correctly, there were also some worries about how this
might work together with BLA-II. I gave it a little more thought and
had a look at the BLA-II source code, but couldn't find any issues.

The only BLA-II related non-ideal thing I could think of so far is
noted in the code of this patch at the according place (but I think
that might not matter much in practice).

Looking forward to hear about what you think about it, especially
conceptually.

Cheers, Linus


