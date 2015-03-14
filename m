Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:51 +0100
Message-Id: <1426333379-17777-7-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/14] alfred: Remove spaces before tabs
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index e9821be..7ad4625 100644
--- a/main.c
+++ b/main.c
@@ -149,8 +149,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"interface",		required_argument,	NULL,	'i'},
 		{"master",		no_argument,		NULL,	'm'},
 		{"help",		no_argument,		NULL,	'h'},
-		{"req-version", 	required_argument,	NULL,	'V'},
-		{"modeswitch",  	required_argument,	NULL,	'M'},
+		{"req-version",		required_argument,	NULL,	'V'},
+		{"modeswitch",		required_argument,	NULL,	'M'},
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"version",		no_argument,		NULL,	'v'},
-- 
2.1.4

