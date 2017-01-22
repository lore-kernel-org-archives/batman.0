Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:09 +0100
Message-Id: <20170122122113.29588-5-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] batctl: Allow to retrieve interface
	stats as non-root
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

Standard users are usually able to retrieve interface statistics via the
SIOCETHTOOL ioctl. Don't artificially prevent users to retrieve the
statistics via batctl.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ioctl.c b/ioctl.c
index 2ef4f8b..2f25dc0 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -105,8 +105,6 @@ int ioctl_statistics_get(char *mesh_iface)
 	struct ifreq ifr;
 	int fd = -1, ret = EXIT_FAILURE;
 
-	check_root_or_die("batctl statistics");
-
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, mesh_iface, sizeof(ifr.ifr_name));
 	ifr.ifr_name[sizeof(ifr.ifr_name) - 1] = '\0';
-- 
2.11.0

