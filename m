Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat,  7 Dec 2013 11:21:23 +0100
Message-Id: <1386411684-2448-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
References: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: fix typ0s in
	batadv_store_isolation_mark()
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by e29249b4483b91d7a590a16e9b5ffe9412ce7fde
("batman-adv: add isolation_mark sysfs attribute")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index 037f411..b6a4403 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -469,8 +469,8 @@ static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
 }
 
 /**
- * batadv_store_isolation_mark - parse and store the isolation mark/mask entered by
- *  the user
+ * batadv_store_isolation_mark - parse and store the isolation mark/mask entered
+ *  by the user
  * @kobj: kobject representing the private mesh sysfs directory
  * @attr: the batman-adv attribute the user is interacting with
  * @buff: the buffer containing the user data
-- 
1.8.5.1

