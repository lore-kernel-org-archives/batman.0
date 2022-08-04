Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 2/3] alfred: fix erroneous documentation of '-r' argument
Date: Thu,  4 Aug 2022 20:52:11 +0200
Message-Id: <20220804185212.3074514-2-mareklindner@neomailbox.ch>
In-Reply-To: <20220804185212.3074514-1-mareklindner@neomailbox.ch>
References: <20220804185212.3074514-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 main.c       | 2 +-
 man/alfred.8 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 3fe7b42..2c3f06e 100644
--- a/main.c
+++ b/main.c
@@ -31,7 +31,7 @@ static void alfred_usage(void)
 	printf("  -s, --set-data [data type]          sets new data to distribu=
te from stdin\n");
 	printf("                                      for the supplied data typ=
e (0-255)\n");
 	printf("  -r, --request [data type]           collect data from the net=
work and prints\n");
-	printf("                                      it on the network\n");
+	printf("                                      it on stdout\n");
 	printf("  -d, --verbose                       Show extra information in=
 the data output\n");
 	printf("  -V, --req-version                   specify the data version =
set for -s\n");
 	printf("  -M, --modeswitch primary            switch daemon to mode pri=
mary\n");
diff --git a/man/alfred.8 b/man/alfred.8
index ca83f02..20c703b 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -67,7 +67,7 @@ must be periodically written again to alfred, otherwise=
 it will timeout and
 alfred will forget about it (after 10 minutes).
 .TP
 \fB\-r\fP, \fB\-\-request\fP \fIdata\-type\fP
-Collect data from the network and prints it on the network
+Collect data from the network and prints it on stdout
 .TP
 \fB\-d\fP, \fB\-\-verbose\fP
 Show extra information in the data output
--=20
2.36.1
