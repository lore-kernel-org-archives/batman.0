Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 21 Apr 2014 04:13:22 +0200
Message-Id: <1398046402-5341-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: mark multicast-mode switch as
	potentially compiled out
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

To give users an additional hint if the multicast feature is not
compiled in, to let them know what they can do to change that.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 functions.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/functions.c b/functions.c
index 117dcff..b9ccaff 100644
--- a/functions.c
+++ b/functions.c
@@ -63,6 +63,7 @@ const char *fs_compile_out_param[] = {
 	batctl_settings[BATCTL_SETTINGS_BLA].sysfs_name,
 	batctl_settings[BATCTL_SETTINGS_DAT].sysfs_name,
 	batctl_settings[BATCTL_SETTINGS_NETWORK_CODING].sysfs_name,
+	batctl_settings[BATCTL_SETTINGS_MULTICAST_MODE].sysfs_name,
 	batctl_debug_tables[BATCTL_TABLE_BLA_CLAIMS].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_BLA_BACKBONES].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_DAT].debugfs_name,
-- 
1.7.10.4

