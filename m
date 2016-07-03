Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 13:35:06 +0200
Message-Id: <1467545714-20722-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v10 0/8] batctl: netns and netlink support
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

Hi,

This patchset adds netns/netlink support to batctl. It complements the
batman-adv netns/netlink support v9 as sent today. This series is an
update from the v9 sent by Simon on June 6th with the following changes:

 * fix alignment of originator dumps with B.A.T.M.A.N. V
 * add support for B.A.T.M.A.N. V gateways dumps over netlink
 * add patch to document a network namespaces example
 * add fallback to use debugfs when netlink not supported
 * fix detection of unsupported cmd BATADV_CMD_GET_MESH_INFO

Kind regards,
	Sven

Andrew Lunn (2):
  batctl: Use netlink to replace some of debugfs
  batctl: Document a network namespaces example.

Simon Wunderlich (1):
  batctl: add netlink dump function for backbone tables

Sven Eckelmann (5):
  batctl: add netlink dump support for B.A.T.M.A.N. V gateways
  batctl: Import alfred version of debugfs.*
  batctl: Split translate_mac from debugfs backend
  batctl: Translate mac addresses via netlink
  batctl: Use debugfs fallback when netlink not supported

 README       |   57 +++
 batman_adv.h |   94 ++++
 debug.c      |   23 +-
 debug.h      |    4 +-
 debugfs.c    |   17 +-
 debugfs.h    |    4 +-
 functions.c  |   61 ++-
 functions.h  |    4 +-
 netlink.c    | 1403 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 netlink.h    |   25 +-
 packet.h     |   36 --
 11 files changed, 1665 insertions(+), 63 deletions(-)

-- 
2.8.1

