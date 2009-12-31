Return-Path: <linus.luessing@web.de>
Date: Thu, 31 Dec 2009 04:41:20 +0100
From: =?utf-8?B?PT9VVEYtOD9xP0xpbnVzPTIwTD1DMz1CQ3NzaW5nPz0=?=
	<linus.luessing@web.de>
Message-ID: <20091231034120.GC18781@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Remove unused variable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

The variable 'flag' is never being used in this function, therefore
removing it.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 soft-interface.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 4d4d542..bc0217b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -148,7 +148,6 @@ struct net_device_stats *interface_stats(struct net_device *dev)
 int interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr = p;
-	unsigned long flags;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
-- 
1.6.5.7

