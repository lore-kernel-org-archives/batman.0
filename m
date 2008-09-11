Date: Thu, 11 Sep 2008 15:51:48 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080911135148.GA21632@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Unlock all spinlocks in batgat
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

We leave get_ip_addr when a client was found in hash immediately, but have have
spinlocked hash_lock before. Spinlocks on non smp kernels are simple nops which
only disable peempt (only on peempt enabled kernels) and so will never lock
anything and no dead(spin)lock will happen.
More informations about this issue can be found in "Unreliable Guide To Locking"
under the section "Locks and Uniprocessor Kernels".

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/modules/gateway.c   |    1 +
 batman/linux/modules/gateway24.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 999d3e6..5786be8 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -645,6 +645,7 @@ static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr)
 
 	if (gw_client != NULL) {
 		DBG("found client in hash");
+		spin_unlock(&hash_lock);
 		return gw_client;
 	}
 
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index 48f31a7..44dfc0e 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -587,6 +587,7 @@ static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr)
 
 	if (gw_client != NULL) {
 		printk(KERN_DEBUG "found client in hash");
+		spin_unlock(&hash_lock);
 		return gw_client;
 	}
 
-- 
1.6.0.1


