Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 15 Dec 2009 16:20:10 +0100
Message-Id: <1260890410-27960-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batman-debug4] Fix small typo "unkown" ->
	"unknown"
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
 batman-debug4.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-debug4.pl b/batman-debug4.pl
index b2f9f45..1322b32 100755
--- a/batman-debug4.pl
+++ b/batman-debug4.pl
@@ -100,7 +100,7 @@ while ( <BATMANLOG> ) {
 
 				$receive_hash{ $last_orig }{ $last_neigh }{ "uni_flag" }++;
 
-			} elsif ( m/OGM\ via\ unkown\ neighbor/ ) {
+			} elsif ( m/OGM\ via\ unknown\ neighbor/ ) {
 
 				$receive_hash{ $last_orig }{ $last_neigh }{ "unknown" }++;
 
-- 
1.6.5.4

