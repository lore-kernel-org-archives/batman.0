Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  6 Jan 2014 20:37:22 +0100
Message-Id: <1389037044-27530-1-git-send-email-sven@narfation.org>
In-Reply-To: <6312194.LhI8hzXjyH@bentobox>
References: <6312194.LhI8hzXjyH@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Avoid name clash "rtnl_open"
	with libnl
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
Cc: Sven Eckelmann <sven@narfation.org>

libnl is used in Debian to avoid code duplication which should be avoided to
reduce maintenance and security risks. This library already provides a
function called rtnl_open and therefore has a name clash with the self defined
function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/functions.c b/functions.c
index 8894df4..10a7f86 100644
--- a/functions.c
+++ b/functions.c
@@ -499,13 +499,13 @@ static void request_mac_resolve(int ai_family, const void *l3addr)
 }
 
 /**
- * rtnl_open - open a socket to rtnl and send a request
+ * batadv_rtnl_open - open a socket to rtnl and send a request
  * @nh: the header of the request to send
  * @protocol: the protocol to use when opening the socket
  *
  * Return 0 on success or a negative error code otherwise
  */
-static int rtnl_open(void *req, int protocol)
+static int batadv_rtnl_open(void *req, int protocol)
 {
 	static uint32_t nr_call = 0;
 	uint32_t pid = (++nr_call + getpid()) & 0x3FFFFF;
@@ -555,7 +555,7 @@ static int resolve_mac_from_cache_open(int ai_family)
 	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
 	nlreq.msg.ndm_family = ai_family;
 
-	return rtnl_open(&nlreq, NETLINK_ROUTE);
+	return batadv_rtnl_open(&nlreq, NETLINK_ROUTE);
 }
 
 static ssize_t resolve_mac_from_cache_dump(int sock, void **buf, size_t *buflen)
@@ -890,7 +890,7 @@ static int vlan_get_link_open(const char *ifname)
 	nlreq.ifi.ifi_family = AF_UNSPEC;
 	nlreq.ifi.ifi_index = if_nametoindex(ifname);
 
-	return rtnl_open(&nlreq, 0);
+	return batadv_rtnl_open(&nlreq, 0);
 }
 
 /**
-- 
1.8.5.2

