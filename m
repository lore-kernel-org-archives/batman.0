Return-Path: <j.neuschaefer@gmx.net>
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Sat, 30 Jul 2011 13:16:05 +0200
Message-Id: <1312024565-10153-1-git-send-email-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix a memory leak in bat_hosts_init
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

normalized was not being free'd when hash_new failed, now it is.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 bat-hosts.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index 0ea4134..179e733 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -179,7 +179,7 @@ void bat_hosts_init(int read_opt)
 	if (!host_hash) {
 		if (read_opt & USE_BAT_HOSTS)
 			printf("Warning - could not create bat hosts hash table\n");
-		return;
+		goto out;
 	}
 
 	homedir = getenv("HOME");
@@ -216,6 +216,7 @@ void bat_hosts_init(int read_opt)
 			parse_hosts_file(&host_hash, normalized + (i * PATH_MAX), read_opt);
 	}
 
+out:
 	free(normalized);
 }
 
-- 
1.7.5.4

