Return-Path: <danny.kukawka@bisect.de>
From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Fri, 17 Feb 2012 16:43:21 +0100
Message-Id: <1329493411-25750-1-git-send-email-danny.kukawka@bisect.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 00/10] Part 4: handle addr_assign_type for
	random addresses
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
To: "David S. Miller" <davem@davemloft.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jiri Pirko <jpirko@redhat.com>, e1000-devel@lists.sourceforge.net, Jiri Kosina <jkosina@suse.cz>, b.a.t.m.a.n@lists.open-mesh.org, Danny Kukawka <dkukawka@suse.de>, linux-kernel@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org, Richard Cochran <richard.cochran@omicron.at>

The fourth part of my patch series to fix the handling of 
addr_assign_type for random MAC addresses. 

This most of the patches in this series are for slightly 
more complex cases to handle addr_assign_type and the
reset to NET_ADDR_PERM as soon as the MAC get changed via 
.ndo_set_mac_address where eth_mac_addr wasn't used.

Danny Kukawka (10):
  au1000_eth: use eth_hw_addr_random() instead of random_ether_addr()
  lantiq_etop: set addr_assign_type if random_ether_addr() used
  davinci_emac: use eth_hw_addr_random() instead of random_ether_addr()
  xilinx ll_temac: use eth_hw_addr_random() instead of
    random_ether_addr()
  igbvf: reset netdevice addr_assign_type if changed
  batman-adv: use eth_hw_addr_random() instead of random_ether_addr()
  cisco/enic: use eth_hw_addr_random() instead of random_ether_addr()
  ethoc: set addr_assign_type if random_ether_addr() used
  atheros eth: set addr_assign_type if random_ether_addr() used
  UML net: set addr_assign_type if random_ether_addr() used

 arch/um/drivers/net_kern.c                      |   11 ++++++++---
 drivers/net/ethernet/amd/au1000_eth.c           |    9 +++++----
 drivers/net/ethernet/atheros/atl1c/atl1c_hw.c   |    2 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c |    9 ++++-----
 drivers/net/ethernet/atheros/atlx/atl1.c        |   12 +++++++++---
 drivers/net/ethernet/atheros/atlx/atlx.c        |    1 +
 drivers/net/ethernet/cisco/enic/enic_main.c     |   14 ++++++++++++--
 drivers/net/ethernet/ethoc.c                    |   20 ++++++++++++++++++--
 drivers/net/ethernet/intel/igbvf/netdev.c       |    1 +
 drivers/net/ethernet/lantiq_etop.c              |    7 +++++++
 drivers/net/ethernet/ti/davinci_emac.c          |    5 +++--
 drivers/net/ethernet/xilinx/ll_temac_main.c     |    4 +++-
 net/batman-adv/soft-interface.c                 |    5 ++---
 13 files changed, 74 insertions(+), 26 deletions(-)

-- 
1.7.8.3

