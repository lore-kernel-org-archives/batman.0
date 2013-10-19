Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 20 Oct 2013 00:21:52 +0200
Message-Id: <1382221330-3769-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] (no subject)
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this is another batch intended for net-next/linux-3.13.

This pull request is a bit bigger than usual, but 6 patches are very small
(three of them are about email updates)..

Patch 1 is fixing a previous merge conflict resolution that went wrong
(I realised that only now while checking other patches..).
Patches from 2 to 4 that are updating our emails in all the proper files
(Documentation/, headers and MAINTAINERS).

Patches 5, 6 and 7 are bringing a big improvement to the TranslationTable
component: it is now able to group non-mesh clients based on the VLAN they
belong to. In this way a lot a new enhancements are now possible thanks to the
fact that each batman-adv behaviour can be applied on a per VLAN basis.

And, of course, in patches from 8 to 12 you have some of the enhancements I was
talking about:
- make the batman-Gateway selection VLAN dependent
- make DAT (Distributed ARP Table) group ARP entries on a VLAN basis (this
  allows DAT to work even when the admin decided to use the same IP subnet on
  different VLANs)
- make the AP-Isolation behaviour switchable on each VLAN independently
- export VLAN specific attributes via sysfs. Switches like the AP-Isolation are
  now exported once per VLAN (backward compatibility of the sysfs interface has
  been preserved)

Patches 13 and 14 are small code cleanups.
Patch 15 is a minor improvement in the TT locking mechanism.

Patches 16 and 17 are other enhancements to the TT component. Those allow a
node to parse a "non-mesh client announcement message" and accept only those
TT entries belonging to certain VLANs.

Patch 18 exploits this parse&accept mechanism to make the Bridge Loop Avoidance
component reject only TT entries connected to the VLAN where it is operating.
Previous to this change, BLA was rejecting all the entries coming from any other
Backbone node, regardless of the VLAN (for more details about how the Bridge
Loop Avoidance works please check [1]).


Please pull or let me know of any problem.

Thanks a lot,
	Antonio


[1] http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-II

The following changes since commit b1eda2ac3fa6bf23b27c7c70eda6885124c79ed3:

  em_ipset: use dev_net() accessor (2013-10-18 16:23:06 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to cfd4f75701b6b13b1ec74e6f65ad0d1969c19247:

  batman-adv: make the backbone gw check VLAN specific (2013-10-19 23:25:38 +0200)

----------------------------------------------------------------
Included changed:
- email addresses update in documentation, source files and MAINTAINERS
- make the TT component distinguish non-mesh clients based on the VLAN they
  belong to
- improve all the internal components to properly work on a per-VLAN basis
  (enabled by the new TT-VLAN feature)
- enhance the sysfs interface in order to provide behaviour switches on a
  per-VLAN basis (enabled by the new TT-VLAN feature)
- improve TT lock mechanism
- improve unicast transmission APIs

----------------------------------------------------------------
Antonio Quartulli (15):
      batman-adv: check skb preparation return value
      batman-adv: update email address for Antonio Quartulli
      batman-adv: add the VLAN ID attribute to the TT entry
      batman-adv: use vid when computing local and global TT CRC
      batman-adv: print the VID together with the TT entries
      batman-adv: make the GW module correctly talk to the new VLAN-TT
      batman-adv: make the Distributed ARP Table vlan aware
      batman-adv: add per VLAN interface attribute framework
      batman-adv: add sysfs framework for VLAN
      batman-adv: make the AP isolation attribute VLAN specific
      batman-adv: remove bogus comment
      batman-adv: lock around TT operations to avoid sending inconsistent data
      batman-adv: make the TT CRC logic VLAN specific
      batman-adv: make the TT global purge routine VLAN specific
      batman-adv: make the backbone gw check VLAN specific

Linus Lüssing (1):
      batman-adv: refine API calls for unicast transmissions of SKBs

Marek Lindner (1):
      batman-adv: update email address for Marek Lindner

Simon Wunderlich (1):
      batman-adv: update email address for Simon Wunderlich

 .../ABI/testing/sysfs-class-net-batman-adv         |    4 +-
 Documentation/ABI/testing/sysfs-class-net-mesh     |   23 +-
 Documentation/networking/batman-adv.txt            |    4 +-
 MAINTAINERS                                        |    2 +-
 net/batman-adv/bridge_loop_avoidance.c             |   58 +-
 net/batman-adv/bridge_loop_avoidance.h             |   10 +-
 net/batman-adv/distributed-arp-table.c             |  160 ++-
 net/batman-adv/gateway_client.c                    |   25 +-
 net/batman-adv/hard-interface.c                    |    2 +
 net/batman-adv/main.c                              |   33 +-
 net/batman-adv/main.h                              |   15 +-
 net/batman-adv/originator.c                        |  104 +-
 net/batman-adv/originator.h                        |    7 +
 net/batman-adv/packet.h                            |   32 +-
 net/batman-adv/routing.c                           |   28 +-
 net/batman-adv/send.c                              |   98 +-
 net/batman-adv/send.h                              |   51 +-
 net/batman-adv/soft-interface.c                    |  227 +++-
 net/batman-adv/soft-interface.h                    |    4 +
 net/batman-adv/sysfs.c                             |  178 ++-
 net/batman-adv/sysfs.h                             |   10 +
 net/batman-adv/translation-table.c                 | 1157 +++++++++++++++-----
 net/batman-adv/translation-table.h                 |   23 +-
 net/batman-adv/types.h                             |   83 +-
 24 files changed, 1851 insertions(+), 487 deletions(-)
