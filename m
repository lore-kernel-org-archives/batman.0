Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 20 Jan 2016 18:48:26 +0100
Message-Id: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BPATCH_0/4=5D_batman-adv=3A_Add_networ?=
	=?utf-8?q?k_name_space_support?=
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This patchset makes batman-adv network namespace aware. A soft
interface can be creates in a namespace and hard interfaces added to
it. soft interfaces cannot be moved between name spaces.

The biggest change is to debugfs, which is not natively netns aware,
unlike sysfs which is. A new netns directory has been added and within
that, a directory per network name space which batman is used within.
The changes are backwards compatible, in that interfaces in the global
namespace are not placed into a subdirectory.

/sys/kernel/debug/batman_adv
├── eth0
│   └── originators
├── eth1
│   └── originators
├── eth2
│   └── originators
├── netns
│   ├── 4026531957 -> ..
│   ├── 4026532176
│   │   ├── bat0
│   │   │   ├── bla_backbone_table
│   │   │   ├── bla_claim_table
│   │   │   ├── dat_cache
│   │   │   ├── gateways
│   │   │   ├── nc
│   │   │   │   ├── max_buffer_time
│   │   │   │   ├── max_fwd_delay
│   │   │   │   └── min_tq
│   │   │   ├── nc_nodes
│   │   │   ├── originators
│   │   │   ├── socket
│   │   │   ├── transtable_global
│   │   │   └── transtable_local
│   │   ├── emu1-veth1
│   │   │   └── originators
│   │   └── emu1-veth2
│   │       └── originators
│   ├── 4026532225
│   │   ├── bat0
│   │   │   ├── bla_backbone_table
│   │   │   ├── bla_claim_table
│   │   │   ├── dat_cache
│   │   │   ├── gateways
│   │   │   ├── nc
│   │   │   │   ├── max_buffer_time
│   │   │   │   ├── max_fwd_delay
│   │   │   │   └── min_tq
│   │   │   ├── nc_nodes
│   │   │   ├── originators
│   │   │   ├── socket
│   │   │   ├── transtable_global
│   │   │   └── transtable_local
│   │   ├── emu2-veth1
│   │   │   └── originators
│   │   └── emu2-veth2
│   │       └── originators

Patches are available for batctl and alfred, to make use of this new
structure.

The bat-over-bat detection has been enhanced, so that it is also netns
aware. It can also now cope with veth interfaces which are mutual
parents.

Andrew Lunn (4):
  batman-adv: NETIF_F_NETNS_LOCAL feature to prevent netns moves
  batman-adv: Create batman soft interfaces within correct netns.
  batman-adv: Handle parent interfaces in a different netns
  batman-adv: debugfs: Add netns support

 net/batman-adv/debugfs.c           | 118 ++++++++++++++++++++++++++++++++++++-
 net/batman-adv/hard-interface.c    |  49 +++++++++++++--
 net/batman-adv/hard-interface.h    |   2 +-
 net/batman-adv/soft-interface.c    |   9 ++-
 net/batman-adv/soft-interface.h    |   2 +-
 net/batman-adv/sysfs.c             |   3 +-
 net/batman-adv/translation-table.c |   3 +-
 7 files changed, 172 insertions(+), 14 deletions(-)

-- 
2.7.0.rc3

