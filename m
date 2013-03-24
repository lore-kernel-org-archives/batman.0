Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 24 Mar 2013 13:00:31 +0100
Message-Id: <1364126431-17774-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix interface clean up on
	error
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

When enabling an hard_iface for the first time, the
hard_iface->soft_iface member is initialised with the newly
created soft_iface.
However, in case of error during the activation procedure
this member has to be set to NULL again, otherwise the
hard_iface will result busy and will not be possible to use
it anymore

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

it is possible to easily reproduce the bug without the patch:
$ batctl if add eth0
$ brctl addbr br0
$ brctl addif br0 bat0
$ batctl if add br0
Error - can't write to file '/sys/class/net/br0/batman_adv/mesh_iface': Device or resource busy
$ batctl if add br0
$
[no error anymore because br0 is already "associated" to bat0 and check at
sysfs.c:575 evaluates to true]



with the patch:
$ batctl if add eth0
$ brctl addbr br0
$ brctl addif br0 bat0
$ batctl if add br0
Error - can't write to file '/sys/class/net/br0/batman_adv/mesh_iface': Device or resource busy
$ batctl if add br0
Error - can't write to file '/sys/class/net/br0/batman_adv/mesh_iface': Device or resource busy
$

Cheers,


 hard-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hard-interface.c b/hard-interface.c
index 368219e..70bc9ce 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -402,6 +402,7 @@ out:
 	return 0;
 
 err_dev:
+	hard_iface->soft_iface = NULL;
 	dev_put(soft_iface);
 err:
 	batadv_hardif_free_ref(hard_iface);
-- 
1.8.1.5

