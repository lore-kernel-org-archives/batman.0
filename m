Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Dec 2009 01:11:07 +0800
Message-Id: <1261242667-11525-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1261242667-11525-4-git-send-email-lindner_marek@yahoo.de>
References: <200912200101.55746.lindner_marek@yahoo.de>
	<1261242667-11525-1-git-send-email-lindner_marek@yahoo.de>
	<1261242667-11525-2-git-send-email-lindner_marek@yahoo.de>
	<1261242667-11525-3-git-send-email-lindner_marek@yahoo.de>
	<1261242667-11525-4-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batctl: adjust vis data file path
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

The kernel module changed the vis data file path which need to be changed
in batctl as well. This patch depends on the "splitting /proc vis file into
vis_server and vis_data" patch.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/vis.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batctl/vis.c b/batctl/vis.c
index 450310c..f1e95ee 100644
--- a/batctl/vis.c
+++ b/batctl/vis.c
@@ -185,7 +185,7 @@ open_vis(void)
 
   strncpy(full_path, PROC_ROOT_PATH, strlen(PROC_ROOT_PATH));
   full_path[strlen(PROC_ROOT_PATH)] = '\0';
-  strncat(full_path, "vis", sizeof(full_path) - strlen(full_path));
+  strncat(full_path, "vis_data", sizeof(full_path) - strlen(full_path));
 
   return fopen(full_path, "r");
 }
-- 
1.6.5.7

