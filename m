Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
Date: Tue, 10 Dec 2013 21:12:41 -0800
Message-Id: <cover.1386738050.git.joe@perches.com>
Subject: [B.A.T.M.A.N.] [PATCH -next 0/3] seq_printf/puts/putc: Start to
	convert to return void
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
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: netfilter@vger.kernel.org, Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org

Many uses of the return value of seq_printf/seq_puts/seq_putc are
incorrect.  Many assume that the return value is the number of
chars emitted into a buffer like printf/puts/putc.

It would be better to make the return value of these functions void
to avoid these misuses.

Start to do so.
Convert seq_overflow to a public function from a static function.

Remove the return uses of seq_printf/seq_puts/seq_putc from net.
Add a seq_overflow function call instead.

Joe Perches (3):
  seq: Add a seq_overflow test.
  batman-adv: Use seq_overflow
  netfilter: Use seq_overflow

 fs/seq_file.c                                      | 15 ++++----
 include/linux/seq_file.h                           |  2 +
 include/net/netfilter/nf_conntrack_acct.h          |  3 +-
 net/batman-adv/gateway_client.c                    | 25 ++++++------
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |  6 ++-
 .../netfilter/nf_conntrack_l3proto_ipv4_compat.c   | 42 +++++++++++++--------
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |  6 ++-
 net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c     | 10 +++--
 net/netfilter/nf_conntrack_acct.c                  | 11 +++---
 net/netfilter/nf_conntrack_expect.c                |  4 +-
 net/netfilter/nf_conntrack_proto_dccp.c            | 12 ++++--
 net/netfilter/nf_conntrack_proto_gre.c             | 15 +++++---
 net/netfilter/nf_conntrack_proto_sctp.c            | 12 ++++--
 net/netfilter/nf_conntrack_proto_tcp.c             | 11 ++++--
 net/netfilter/nf_conntrack_proto_udp.c             |  7 ++--
 net/netfilter/nf_conntrack_proto_udplite.c         |  7 ++--
 net/netfilter/nf_conntrack_standalone.c            | 44 +++++++++++++---------
 net/netfilter/nf_log.c                             | 26 ++++++-------
 net/netfilter/nfnetlink_log.c                      | 12 +++---
 net/netfilter/nfnetlink_queue_core.c               | 14 ++++---
 net/netfilter/x_tables.c                           |  8 ++--
 net/netfilter/xt_hashlimit.c                       | 34 +++++++++--------
 22 files changed, 191 insertions(+), 135 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty

