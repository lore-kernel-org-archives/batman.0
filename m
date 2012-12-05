Return-Path: <moritzwarning@web.de>
Message-ID: <50BF086A.4020505@web.de>
Date: Wed, 05 Dec 2012 09:40:10 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: indicate successful termination when
	-h is used
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

The return value of batctl -h indicates failure while
it should indicate a successful execution.


Signed-off-by: Moritz Warning <moritzwarning@web.de>
---
From: Moritz Warning <moritzwarning@web.de>
Subject: [PATCH] batctl: change return value to indicate successful
 termination when -h is used

---
 main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 0a979bd..ea83bbf 100644
--- a/main.c
+++ b/main.c
@@ -114,8 +114,10 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	if (strcmp(argv[1], "-h") == 0)
-		goto err;
+	if (strcmp(argv[1], "-h") == 0) {
+		print_usage();
+		exit(EXIT_SUCCESS);
+	}
 
 	if (strcmp(argv[1], "-v") == 0) {
 		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
