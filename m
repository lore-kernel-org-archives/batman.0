Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  5 Jan 2014 23:25:35 +0100
Message-Id: <1388960736-3873-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
References: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 next 2/3] batctl: implement vlan-to-link
	helper functions
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

This functions can be used to convert a vlan interface
into the real one and to extract the vlan identifier.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 functions.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 functions.h |   1 +
 2 files changed, 160 insertions(+)

diff --git a/functions.c b/functions.c
index 33ca9ff..8894df4 100644
--- a/functions.c
+++ b/functions.c
@@ -40,6 +40,7 @@
 #include <linux/neighbour.h>
 #include <sys/uio.h>
 #include <errno.h>
+#include <net/if.h>
 
 #include "main.h"
 #include "functions.h"
@@ -770,3 +771,161 @@ struct ether_addr *resolve_mac(const char *asc)
 out:
 	return mac_result;
 }
+
+/**
+ * vlan_get_link_parse - parse a get_link rtnl message and extract the important
+ *  data
+ * @nh: the reply header
+ * @iface: pointer to the buffer where the link interface has to be stored (it
+ *  is allocated by this function)
+ *
+ * Return the vid in case of success or -1 otherwise
+ */
+static int vlan_get_link_parse(struct nlmsghdr *nh, char **iface)
+{
+	struct ifinfomsg *ifi = NLMSG_DATA(nh);
+	size_t vlan_len, info_len, len = nh->nlmsg_len;
+	struct rtattr *rta, *info, *vlan;
+	int idx = -1, vid = -1;
+
+	*iface = NULL;
+
+	rta = IFLA_RTA(ifi);
+	while (RTA_OK(rta, len)) {
+		/* check if the interface is a vlan */
+		if (rta->rta_type == IFLA_LINKINFO) {
+			info = RTA_DATA(rta);
+			info_len = RTA_PAYLOAD(rta);
+
+			while (RTA_OK(info, info_len)) {
+				if (info->rta_type == IFLA_INFO_KIND &&
+				    strcmp(RTA_DATA(info), "vlan"))
+					goto err;
+
+				if (info->rta_type == IFLA_INFO_DATA) {
+					vlan = RTA_DATA(info);
+					vlan_len = RTA_PAYLOAD(info);
+
+					while (RTA_OK(vlan, vlan_len)) {
+						if (vlan->rta_type == IFLA_VLAN_ID)
+							vid = *(int *)RTA_DATA(vlan);
+						vlan = RTA_NEXT(vlan, vlan_len);
+					}
+				}
+				info = RTA_NEXT(info, info_len);
+			}
+		}
+
+		/* extract the name of the "link" interface */
+		if (rta->rta_type == IFLA_LINK) {
+			idx = *(int *)RTA_DATA(rta);
+
+			*iface = malloc(IFNAMSIZ + 1);
+			if (!if_indextoname(idx, *iface))
+				goto err;
+		}
+		rta = RTA_NEXT(rta, len);
+	}
+
+	if (vid == -1)
+		goto err;
+
+	if (idx <= 0)
+		goto err;
+
+	return vid;
+err:
+	free(*iface);
+	return -1;
+}
+
+/**
+ * vlan_get_link_dump - receive and dump a get_link rtnl reply
+ * @sock: the socket to listen for the reply on
+ * @buf: buffer where the reply has to be dumped to
+ * @buflen: length of the buffer
+ *
+ * Returns the amount of dumped bytes
+ */
+static ssize_t vlan_get_link_dump(int sock, void *buf, size_t buflen)
+{
+	struct sockaddr_nl nladdr;
+	struct msghdr msg;
+	struct iovec iov;
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&iov, 0, sizeof(iov));
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_controllen = 0;
+	msg.msg_control = NULL;
+	msg.msg_flags = 0;
+	msg.msg_name = &nladdr;
+	msg.msg_namelen = sizeof(nladdr);
+
+	iov.iov_len = buflen;
+	iov.iov_base = buf;
+
+	return recvmsg(sock, &msg, 0);
+}
+
+/**
+ * vlan_get_link_open - send a get_link request
+ * @ifname: the interface to query
+ *
+ * Returns 0 in case of success or a negative error code otherwise
+ */
+static int vlan_get_link_open(const char *ifname)
+{
+	struct {
+		struct nlmsghdr hdr;
+		struct ifinfomsg ifi;
+	} nlreq;
+
+	memset(&nlreq, 0, sizeof(nlreq));
+	nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.ifi));
+	nlreq.hdr.nlmsg_type = RTM_GETLINK;
+	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST;
+	nlreq.ifi.ifi_family = AF_UNSPEC;
+	nlreq.ifi.ifi_index = if_nametoindex(ifname);
+
+	return rtnl_open(&nlreq, 0);
+}
+
+/**
+ * vlan_get_link - convert a VLAN interface into its parent one
+ * @ifname: the interface to convert
+ * @parent: buffer where the parent interface name will be written (allocated by
+ *  this function)
+ *
+ * Returns the vlan identifier on success or -1 on error
+ */
+int vlan_get_link(const char *ifname, char **parent)
+{
+	int vid = -1, socknl;
+	void *buf = NULL;
+	size_t buflen;
+	ssize_t len;
+
+	buflen = 8192;
+	buf = malloc(buflen);
+	if (!buf)
+		goto err;
+
+	socknl = vlan_get_link_open(ifname);
+	if (socknl < 0)
+		goto err;
+
+	len = vlan_get_link_dump(socknl, buf, buflen);
+	if (len < 0)
+		goto err_sock;
+
+	vid = vlan_get_link_parse(buf, parent);
+
+err_sock:
+	close(socknl);
+err:
+	free(buf);
+	return vid;
+}
diff --git a/functions.h b/functions.h
index 522c607..14ba525 100644
--- a/functions.h
+++ b/functions.h
@@ -42,6 +42,7 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 	       const char *arg2);
 struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
+int vlan_get_link(const char *ifname, char **parent);
 
 extern char *line_ptr;
 
-- 
1.8.5.2

