Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 31 Dec 2010 16:46:23 +0100
Message-Id: <1293810385-31761-9-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1293810385-31761-1-git-send-email-linus.luessing@ascom.ch>
References: <1293810385-31761-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 08/10] batman-adv: Adding sysfs parameter for
	ndp interval
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This parameter can be set individually on each interface and allows the
configuration of the ndp interval for the link quality measurements
during runtime. Usually it is desirable to set it to a higher (= slower) value
on interfaces which have a more static characteristic (e.g. wired
interfaces) or very dense neighbourhoods to reduce overhead.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 bat_sysfs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 5954389..ae15a94 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -588,10 +588,12 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 static BAT_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
 		show_mesh_iface, store_mesh_iface);
 static BAT_ATTR(iface_status, S_IRUGO, show_iface_status, NULL);
+BAT_ATTR_IF_UINT(ndp_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 
 static struct bat_attribute *batman_attrs[] = {
 	&bat_attr_mesh_iface,
 	&bat_attr_iface_status,
+	&bat_attr_ndp_interval,
 	NULL,
 };
 
-- 
1.7.1

