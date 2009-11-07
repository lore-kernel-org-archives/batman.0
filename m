Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  7 Nov 2009 17:33:05 +0100
Message-Id: <1257611585-6627-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Remove unreachable code in tcpdump
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


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/tcpdump.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index b96984b..abf20b1 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -547,8 +547,6 @@ int tcpdump(int argc, char **argv)
 
 	}
 
-	ret = EXIT_SUCCESS;
-
 out:
 	list_for_each_entry_safe(dump_if, dump_if_tmp, &dump_if_list, list) {
 		if (dump_if->raw_sock)
-- 
1.6.5.2

