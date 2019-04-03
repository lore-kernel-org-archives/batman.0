Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  3 Apr 2019 20:01:16 +0200
Message-Id: <20190403180119.26800-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/3] batctl: Add netlink support for
 sysfs-only functionality
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

some functionality in batctl was previously using sysfs to implement some
of its features. Since the sysfs support can now be disabled in the kernel,
these features were broken in such setups. This was especially problematic
for functionality which depends on the main mesh interface. The check to
make sure that this is interface is a valid batadv interface were
exclusively using sysfs.

Switching them to (or actually extending them to support) netlink should
fix this. The old sysfs functionality is still here but can be removed in
the future.

Kind regards,
	Sven

Sven Eckelmann (3):
  batctl: Support checking of meshif without sysfs
  batctl: Reimplement VLAN translation using helper
  batctl: Add netlink fallback for sysfs' iface_status

 debug.c     |   2 +-
 functions.c | 407 ++++++++++++++++++++++++++++++----------------------
 functions.h |   2 +-
 interface.c |  92 +++++++++++-
 4 files changed, 331 insertions(+), 172 deletions(-)

-- 
2.20.1

