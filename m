Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 21:55:57 +0200
Message-Id: <1350503758-20685-3-git-send-email-sven@narfation.org>
In-Reply-To: <1350503758-20685-1-git-send-email-sven@narfation.org>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] alfred: Test for failed global memory
	allocation
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 96e401a..ccb72cd 100644
--- a/main.c
+++ b/main.c
@@ -67,11 +67,11 @@ struct globals *alfred_init(int argc, char *argv[])
 	};
 
 	globals = malloc(sizeof(*globals));
-	memset(globals, 0, sizeof(*globals));
-
 	if (!globals)
 		return NULL;
 
+	memset(globals, 0, sizeof(*globals));
+
 	globals->opmode = OPMODE_SLAVE;
 	globals->clientmode = CLIENT_NONE;
 	globals->interface = NULL;
-- 
1.7.10.4

