Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 27 Jan 2013 20:43:56 +0100
Message-Id: <1359315839-24136-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2013-01-27
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

This is a small patchset intended for net/linux-3.8.
Here there are three small patches from Matthias Schiffer aimed to fix some
memory problems in the recently introduced D.A.T. component. One of them is
fixing an skb memleak, one is fixing the ARP filter routine by preventing DAT to
parse not useful messages (so reducing the amount of memory used by the local
cache) and one fixing again the ARP filter routine by preventing DAT to
overwrite correct entries with bogus ones in the local cache.

Please pull or let me know if there is any problem.

Thanks a lot,
	Antonio

The following changes since commit 1591ab6740326aaf41e194c43bdf8ece6e2e4835:

  Merge branch 'for-davem' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless (2013-01-27 01:37:22 -0500)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to b618ad1103c9ea0c4a69b44f42fc3c7b4e231e22:

  batman-adv: filter ARP packets with invalid MAC addresses in DAT (2013-01-27 14:02:39 +0100)

----------------------------------------------------------------
Included changes ares:
- fix an skb memleak in DAT
- fix the ARP filtering routine in DAT by preventing bogus entries to overwrite
  already existing ones in the local cache.
- fix the ARP filtering routine in DAT by preventing it to parse and add to the
  cache bogus entries

----------------------------------------------------------------
Matthias Schiffer (3):
      batman-adv: fix skb leak in batadv_dat_snoop_incoming_arp_reply()
      batman-adv: check for more types of invalid IP addresses in DAT
      batman-adv: filter ARP packets with invalid MAC addresses in DAT

 net/batman-adv/distributed-arp-table.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)
