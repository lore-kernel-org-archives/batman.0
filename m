Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:16 +0200
Message-Id: <1273261651-21378-12-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 11/26] Staging: batman-adv: cleanup: change
	test for end of array
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net, Dan Carpenter <error27@gmail.com>

From: Dan Carpenter <error27@gmail.com>

The code here is testing to see if "i" is passed the end of the array.
The original code works probably, but it's not the cleanest way.

Andrew Lunn suggested that I also remove all the hard coded references
to 256 so I have done that as well.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/device.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/batman-adv/device.c b/drivers/staging/batman-adv/device.c
index c82a5af..fbfe234 100644
--- a/drivers/staging/batman-adv/device.c
+++ b/drivers/staging/batman-adv/device.c
@@ -44,10 +44,7 @@ static struct device_client *device_client_hash[256];
 
 void bat_device_init(void)
 {
-	int i;
-
-	for (i = 0; i < 256; i++)
-		device_client_hash[i] = NULL;
+	memset(device_client_hash, 0, sizeof(device_client_hash));
 }
 
 int bat_device_setup(void)
@@ -103,15 +100,15 @@ int bat_device_open(struct inode *inode, struct file *file)
 	if (!device_client)
 		return -ENOMEM;
 
-	for (i = 0; i < 256; i++) {
+	for (i = 0; i < ARRAY_SIZE(device_client_hash); i++) {
 		if (!device_client_hash[i]) {
 			device_client_hash[i] = device_client;
 			break;
 		}
 	}
 
-	if (device_client_hash[i] != device_client) {
-		printk(KERN_ERR "batman-adv:Error - can't add another packet client: maximum number of clients reached \n");
+	if (i == ARRAY_SIZE(device_client_hash)) {
+		printk(KERN_ERR "batman-adv:Error - can't add another packet client: maximum number of clients reached\n");
 		kfree(device_client);
 		return -EXFULL;
 	}
-- 
1.7.1

