Date: Thu, 9 Oct 2008 09:35:55 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20081009073555.GA4544@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Let the compiler interpret the noreturn
	situation in restore_and_exit correct
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

It is just implicit that raise will not return in this case because we are in
a sighandler right now. So let call exit always afterwards even if it will
not be reached.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/posix/posix.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index 4423345..bbeac38 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -497,11 +497,10 @@ void restore_and_exit( uint8_t is_sigsegv ) {
 
 	}
 
-	if (!is_sigsegv)
-		exit(EXIT_FAILURE);
-	else
+	if (is_sigsegv)
 		raise(SIGSEGV);
 
+	exit(EXIT_FAILURE);
 }
 
 
-- 
1.6.0.1


