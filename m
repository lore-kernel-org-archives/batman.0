From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 21 Nov 2008 22:44:10 +0100
Message-Id: <1227303850-11494-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Use %zu to print sizeof(x) with printf
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

sizeof returns size_t (a unsigned integer with a high bit count) and has to be
printed with the prefix before length motifier.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-experimental/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-experimental/control.c b/batman-experimental/control.c
index de65e89..9491019 100644
--- a/batman-experimental/control.c
+++ b/batman-experimental/control.c
@@ -57,7 +57,7 @@ void init_control( void ) {
 	
 	// just to check if sizeof( struct xyz { char[] }__attribute__((packed)); ) is zero for all compilers...
 	if ( sizeof( struct cntl_msg ) != 20 ) {
-		printf( "sizeof cntl_msg %d MUST BE 20 !!!\n", sizeof( struct cntl_msg ) ); 
+		printf( "sizeof cntl_msg %zu MUST BE 20 !!!\n", sizeof( struct cntl_msg ) );
 		exit(EXIT_FAILURE);
 	}
 
-- 
1.6.0.4

