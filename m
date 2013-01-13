Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Jan 2013 17:50:39 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201301131750.39338.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] create batman-adv interfaces with netlink v2
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
Cc: Sven Eckelmann <sven@narfation.org>


Hi folks,

here the updated patchset conceived by Sven Eckelmann for netlink interface 
creation. Since the first version the following has happened:
 * the code has been rebased on top of master
 * batadv_add_slave() / batadv_del_slave() / batadv_interface_free() were 
renamed to follow general naming conventions
 * introduced batadv_softif_destroy_netlink() dedicated to netlink deletion
 * adding clear name separation between batadv_softif_init_early() / 
batadv_softif_init_late()

Apparently, busybox "ip link" does not support creating interfaces through 
netlink which is why I was unable to actually test the code in my OpenWrt 
environments. If any if you know a way of making this work on OpenWrt or are 
brave enough to run the code natively I'd be interested in getting feedback on 
whether or not this works. I am certain the code was bug free and ran 
perfectly fine before I touched it. :)

Cheers,
Marek
