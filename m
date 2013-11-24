Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 24 Nov 2013 14:05:44 +0100
Message-Id: <1385298345-13746-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
References: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: fix wrong alignment for
	batadv_originators_hardif_open
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Introduced in my commit f13f960797fd1969b3c0470cc97435ddfb6aecb4
("batman-adv: add debugfs support to view multiif tables")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debugfs.c b/debugfs.c
index cd5d24a..fcdb51b 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -252,7 +252,7 @@ static int batadv_originators_open(struct inode *inode, struct file *file)
  * @file: pointer to the seq_file
  */
 static int batadv_originators_hardif_open(struct inode *inode,
-					   struct file *file)
+					  struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 	return single_open(file, batadv_orig_hardif_seq_print_text, net_dev);
-- 
1.7.10.4

