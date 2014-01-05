Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  5 Jan 2014 23:25:34 +0100
Message-Id: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 next 1/3] batctl: introduce rtnl_open()
	helper function
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

Other part of batctl may require to open and send
a message to RTNL. Extract this code and put it in
a generic helper to simplify future uses.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

Changes from v2:
- removed IFLA_NAME attribute from request (now we send the ifindex directly)
- improved rtnl_open()

Changes from v1:
- fixed typ0
- removed len argument from rtnl_open() in 1/3
- removed error messages in 2/3
- avoided double free in 2/3
- simplified 3/3



 functions.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/functions.c b/functions.c
index 13ba190..33ca9ff 100644
--- a/functions.c
+++ b/functions.c
@@ -497,30 +497,28 @@ static void request_mac_resolve(int ai_family, const void *l3addr)
 	close(sock);
 }
 
-static int resolve_mac_from_cache_open(int ai_family)
+/**
+ * rtnl_open - open a socket to rtnl and send a request
+ * @nh: the header of the request to send
+ * @protocol: the protocol to use when opening the socket
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int rtnl_open(void *req, int protocol)
 {
-	int socknl;
-	int ret;
-	struct {
-		struct nlmsghdr hdr;
-		struct ndmsg msg;
-	} nlreq;
-	struct sockaddr_nl addrnl;
 	static uint32_t nr_call = 0;
 	uint32_t pid = (++nr_call + getpid()) & 0x3FFFFF;
+	struct sockaddr_nl addrnl;
+	struct nlmsghdr *nh;
+	int socknl;
+	int ret;
 
 	memset(&addrnl, 0, sizeof(addrnl));
 	addrnl.nl_family = AF_NETLINK;
 	addrnl.nl_pid = pid;
 	addrnl.nl_groups = 0;
 
-	memset(&nlreq, 0, sizeof(nlreq));
-	nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.msg));
-	nlreq.hdr.nlmsg_type = RTM_GETNEIGH;
-	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	nlreq.msg.ndm_family = ai_family;
-
-	socknl = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	socknl = socket(AF_NETLINK, SOCK_RAW, protocol);
 	if (socknl < 0)
 		goto out;
 
@@ -528,7 +526,12 @@ static int resolve_mac_from_cache_open(int ai_family)
 	if (ret < 0)
 		goto outclose;
 
-	ret = send(socknl, &nlreq, nlreq.hdr.nlmsg_len, 0);
+	/* the nlmsghdr object must always be the first member in the req
+	 * structure
+	 */
+	nh = (struct nlmsghdr *)req;
+
+	ret = send(socknl, nh, nh->nlmsg_len, 0);
 	if (ret < 0)
 		goto outclose;
 out:
@@ -538,6 +541,22 @@ outclose:
 	return ret;
 }
 
+static int resolve_mac_from_cache_open(int ai_family)
+{
+	struct {
+		struct nlmsghdr hdr;
+		struct ndmsg msg;
+	} nlreq;
+
+	memset(&nlreq, 0, sizeof(nlreq));
+	nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.msg));
+	nlreq.hdr.nlmsg_type = RTM_GETNEIGH;
+	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	nlreq.msg.ndm_family = ai_family;
+
+	return rtnl_open(&nlreq, NETLINK_ROUTE);
+}
+
 static ssize_t resolve_mac_from_cache_dump(int sock, void **buf, size_t *buflen)
 {
 	struct iovec iov;
-- 
1.8.5.2

