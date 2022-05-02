Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] alfred: Drop argument requirement from --server-status
Date: Mon,  2 May 2022 13:40:00 +0200
Message-Id: <20220502114000.25980-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

The short form -S doesn't require a parameter but the --server-status
requires one (which no one reads). If none is supplied, following is
printed:

   ./alfred: option '--server-status' requires an argument

and the execution stops. Just drop this requirement because it is not used
and no where documented.

Fixes: 5a7d28b1866d ("alfred: introduce 'server status' IPC call")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 68d6efd..30e18a5 100644
--- a/main.c
+++ b/main.c
@@ -163,7 +163,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"modeswitch",		required_argument,	NULL,	'M'},
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"change-bat-iface",	required_argument,	NULL,	'B'},
-		{"server-status",	required_argument,	NULL,	'S'},
+		{"server-status",	no_argument,		NULL,	'S'},
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"update-command",	required_argument,	NULL,	'c'},
 		{"version",		no_argument,		NULL,	'v'},
-- 
2.34.1

