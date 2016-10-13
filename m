Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 13 Oct 2016 11:03:10 +0200
Message-Id: <20161013090310.9619-1-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Keep order of interfaces from
	commandline
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The first (valid) interface mac address will be used as source mac for an
dataset. But alfred added the commandline parameters for a multi-interface
master in reverse order.

Keep the list in the same order as the commandline to fulfill the
user expectations when checking the source entries of datasets.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 netsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netsock.c b/netsock.c
index d72541e..5d37347 100644
--- a/netsock.c
+++ b/netsock.c
@@ -165,7 +165,7 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 			return -ENOMEM;
 		}
 
-		list_add(&interface->list, &globals->interfaces);
+		list_add_tail(&interface->list, &globals->interfaces);
 	}
 
 	return 0;
