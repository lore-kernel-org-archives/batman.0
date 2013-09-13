Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Sat, 14 Sep 2013 00:22:27 +0200
Message-Id: <1379110947-7899-1-git-send-email-marco.dallato@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC] batctl ping: add IPv6 to ethernet address
	resolution
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

Extends the "ping" command available in batctl with the capability of
resolving the ethernet link layer (MAC) address from the IPv6 address of
any node partecipating the mesh.

This is possible by adding to 'batctl' a new set of functions to leverage
when performing netlink queries towards the kernel network infrastructure.
These new functions, which act as a library, have been inserted into the
"bat-mnl.c" and corresponding "bat-mnl.h" files. Such code has been
taken from the libmnl library version 1.0.3 with minor modifications.

The netlink query is needed to extract the ethernet address, corresponding to the
target IPv6 address, from the local neighbor discovery table. If the target
address is not initially found in the table, one or more datagram
are sent to it to initialize neighbor discovery exchange, just like what
already happens for ARP tables in the IPv4 case.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
 Makefile    |   2 +-
 bat-mnl.c   | 560 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat-mnl.h   |  92 ++++++++++
 functions.c | 201 +++++++++++++++++++++-
 4 files changed, 853 insertions(+), 2 deletions(-)
 create mode 100644 bat-mnl.c
 create mode 100644 bat-mnl.h

diff --git a/Makefile b/Makefile
index 1961298..c62b064 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o bat-mnl.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/bat-mnl.c b/bat-mnl.c
new file mode 100644
index 0000000..66190ff
--- /dev/null
+++ b/bat-mnl.c
@@ -0,0 +1,560 @@
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <sys/socket.h>
+#include <errno.h>
+
+#include "bat-mnl.h"
+
+struct mnl_socket {
+	int			fd;
+	struct sockaddr_nl	addr;
+};
+
+/**
+ * mnl_nlmsg_get_payload - get a pointer to the payload of the netlink message
+ * @param nlh pointer to a netlink header
+ *
+ * This function returns a pointer to the payload of the netlink message.
+ */
+void *mnl_nlmsg_get_payload(const struct nlmsghdr *nlh)
+{
+	return (void *)nlh + MNL_NLMSG_HDRLEN;
+}
+
+static int mnl_cb_noop(__attribute__((unused)) const struct nlmsghdr *nlh,
+		       __attribute__((unused)) void *data)
+{
+	return MNL_CB_OK;
+}
+
+/**
+ * mnl_nlmsg_size - calculate the size of Netlink message (without alignment)
+ * @param len length of the Netlink payload
+ *
+ * This function returns the size of a netlink message (header plus payload)
+ * without alignment.
+ */
+size_t mnl_nlmsg_size(size_t len)
+{
+	return len + MNL_NLMSG_HDRLEN;
+}
+
+static int mnl_cb_error(const struct nlmsghdr *nlh,
+			__attribute__((unused))void *data)
+{
+	const struct nlmsgerr *err = mnl_nlmsg_get_payload(nlh);
+
+	if (nlh->nlmsg_len < mnl_nlmsg_size(sizeof(struct nlmsgerr))) {
+		errno = EBADMSG;
+		return MNL_CB_ERROR;
+	}
+	/* Netlink subsystems returns the errno value with different signess */
+	if (err->error < 0)
+		errno = -err->error;
+	else
+		errno = err->error;
+
+	return err->error == 0 ? MNL_CB_STOP : MNL_CB_ERROR;
+}
+
+static int mnl_cb_stop(__attribute__((unused)) const struct nlmsghdr *nlh,
+		       __attribute__((unused))void *data)
+{
+	return MNL_CB_STOP;
+}
+
+static const mnl_cb_t default_cb_array[NLMSG_MIN_TYPE] = {
+	[NLMSG_NOOP]	= mnl_cb_noop,
+	[NLMSG_ERROR]	= mnl_cb_error,
+	[NLMSG_DONE]	= mnl_cb_stop,
+	[NLMSG_OVERRUN]	= mnl_cb_noop,
+};
+
+
+/* TLV iterators */
+/**
+ * mnl_attr_ok - check if there is room for an attribute in a buffer
+ * @param attr attribute that we want to check if there is room for
+ * @param len remaining bytes in a buffer that contains the attribute
+ *
+ * This function is used to check that a buffer, which is supposed to contain
+ * an attribute, has enough room for the attribute that it stores, i.e. this
+ * function can be used to verify that an attribute is neither malformed nor
+ * truncated.
+ *
+ * This function does not set errno in case of error since it is intended
+ * for iterations. Thus, it returns 1 on success and 0 on error.
+ *
+ * The len parameter may be negative in the case of malformed messages during
+ * attribute iteration, that is why we use a signed integer.
+ */
+bool mnl_attr_ok(const struct nlattr *attr, int len)
+{
+	return len >= (int)sizeof(struct nlattr) &&
+	       attr->nla_len >= sizeof(struct nlattr) &&
+	       (int)attr->nla_len <= len;
+}
+
+/**
+ * mnl_attr_next - get the next attribute in the payload of a netlink message
+ * @param attr pointer to the current attribute
+ * @param len length of the remaining bytes in the buffer (passed by reference).
+ *
+ * This function returns a pointer to the next attribute after the one passed
+ * as parameter. You have to use mnl_attr_ok() to ensure that the next
+ * attribute is valid.
+ */
+struct nlattr *mnl_attr_next(const struct nlattr *attr)
+{
+	return (struct nlattr *)((void *)attr + MNL_ALIGN(attr->nla_len));
+}
+
+/**
+ * mnl_nlmsg_get_payload_tail - get the ending of the netlink message
+ * @param nlh pointer to netlink message
+ *
+ * This function returns a pointer to the netlink message tail. This is useful
+ * to build a message since we continue adding attributes at the end of the
+ * message.
+ */
+void *mnl_nlmsg_get_payload_tail(const struct nlmsghdr *nlh)
+{
+	return (void *)nlh + MNL_ALIGN(nlh->nlmsg_len);
+}
+
+/**
+ * mnl_nlmsg_get_payload_offset - get a pointer to the payload of the message
+ * @param nlh pointer to a netlink header
+ * @param offset offset to the payload of the attributes TLV set
+ *
+ * This function returns a pointer to the payload of the netlink message plus
+ * a given offset.
+ */
+void *mnl_nlmsg_get_payload_offset(const struct nlmsghdr *nlh, size_t offset)
+{
+	return (void *)nlh + MNL_NLMSG_HDRLEN + MNL_ALIGN(offset);
+}
+
+
+/**
+ * mnl_attr_get_type - get type of netlink attribute
+ * @param attr pointer to netlink attribute
+ *
+ * This function returns the attribute type.
+ */
+uint16_t mnl_attr_get_type(const struct nlattr *attr)
+{
+	return attr->nla_type & NLA_TYPE_MASK;
+}
+
+/**
+ * mnl_attr_type_valid - check if the attribute type is valid
+ * @param attr pointer to attribute to be checked
+ * @param max maximum attribute type
+ *
+ * This function allows to check if the attribute type is higher than the
+ * maximum supported type. If the attribute type is invalid, this function
+ * returns -1 and errno is explicitly set. On success, this function returns 1.
+ *
+ * Strict attribute checking in user-space is not a good idea since you may
+ * run an old application with a newer kernel that supports new attributes.
+ * This leads to backward compatibility breakages in user-space. Better check
+ * if you support an attribute, if not, skip it.
+ */
+int mnl_attr_type_valid(const struct nlattr *attr, uint16_t max)
+{
+	if (mnl_attr_get_type(attr) > max) {
+		errno = EOPNOTSUPP;
+		return -1;
+	}
+	return 1;
+}
+
+/**
+ * mnl_attr_parse - parse attributes
+ * @param nlh pointer to netlink message
+ * @param offset offset to start parsing from (if payload is after any header)
+ * @param cb callback function that is called for each attribute
+ * @param data pointer to data that is passed to the callback function
+ *
+ * This function allows to iterate over the sequence of attributes that compose
+ * the Netlink message. You can then put the attribute in an array as it
+ * usually happens at this stage or you can use any other data structure (such
+ * as lists or trees).
+ *
+ * This function propagates the return value of the callback, which can be
+ * MNL_CB_ERROR, MNL_CB_OK or MNL_CB_STOP.
+ */
+int
+mnl_attr_parse(const struct nlmsghdr *nlh, unsigned int offset,
+	       mnl_attr_cb_t cb, void *data)
+{
+	int ret = MNL_CB_OK;
+	const struct nlattr *attr;
+
+	mnl_attr_for_each(attr, nlh, offset) {
+		ret = cb(attr, data);
+		if (ret <= MNL_CB_STOP)
+			return ret;
+	}
+	return ret;
+}
+
+/**
+ * mnl_nlmsg_put_extra_header - reserve and prepare room for an extra header
+ * @param nlh pointer to Netlink header
+ * @param size size of the extra header that we want to put
+ *
+ * This function sets to zero the room that is required to put the extra
+ * header after the initial Netlink header. This function also increases
+ * the nlmsg_len field. You have to invoke mnl_nlmsg_put_header() before
+ * you call this function. This function returns a pointer to the extra
+ * header.
+ */
+void *
+mnl_nlmsg_put_extra_header(struct nlmsghdr *nlh, size_t size)
+{
+	char *ptr = (char *)nlh + nlh->nlmsg_len;
+	size_t len = MNL_ALIGN(size);
+	nlh->nlmsg_len += len;
+	memset(ptr, 0, len);
+	return ptr;
+}
+
+/**
+ * mnl_nlmsg_put_header - reserve and prepare room for Netlink header
+ * @param buf memory already allocated to store the Netlink header
+ *
+ * This function sets to zero the room that is required to put the Netlink
+ * header in the memory buffer passed as parameter. This function also
+ * initializes the nlmsg_len field to the size of the Netlink header. This
+ * function returns a pointer to the Netlink header structure.
+ */
+struct nlmsghdr *mnl_nlmsg_put_header(void *buf)
+{
+	int len = MNL_ALIGN(sizeof(struct nlmsghdr));
+	struct nlmsghdr *nlh = buf;
+
+	memset(buf, 0, len);
+	nlh->nlmsg_len = len;
+	return nlh;
+}
+
+/**
+ * mnl_socket_open - open a netlink socket
+ * @param bus the netlink socket bus ID (see NETLINK_* constants)
+ *
+ * On error, it returns -1 and errno is appropriately set. Otherwise, it
+ * returns a valid pointer to the mnl_socket structure.
+ */
+struct mnl_socket *mnl_socket_open(int bus)
+{
+	struct mnl_socket *nl;
+
+	nl = calloc(sizeof(struct mnl_socket), 1);
+	if (nl == NULL)
+		return NULL;
+
+	nl->fd = socket(AF_NETLINK, SOCK_RAW, bus);
+	if (nl->fd == -1) {
+		free(nl);
+		return NULL;
+	}
+
+	return nl;
+}
+
+/**
+ * mnl_socket_bind - bind netlink socket
+ * @param nl netlink socket obtained via mnl_socket_open()
+ * @param groups the group of message you're interested in
+ * @param pid the port ID you want to use (use zero for automatic selection)
+ *
+ * On error, this function returns -1 and errno is appropriately set. On
+ * success, 0 is returned. You can use MNL_SOCKET_AUTOPID which is 0 for
+ * automatic port ID selection.
+ */
+int mnl_socket_bind(struct mnl_socket *nl, unsigned int groups, pid_t pid)
+{
+	int ret;
+	socklen_t addr_len;
+
+	nl->addr.nl_family = AF_NETLINK;
+	nl->addr.nl_groups = groups;
+	nl->addr.nl_pid = pid;
+
+	ret = bind(nl->fd, (struct sockaddr *) &nl->addr, sizeof(nl->addr));
+	if (ret < 0)
+		return ret;
+
+	addr_len = sizeof(nl->addr);
+	ret = getsockname(nl->fd, (struct sockaddr *) &nl->addr, &addr_len);
+	if (ret < 0)
+		return ret;
+
+	if (addr_len != sizeof(nl->addr)) {
+		errno = EINVAL;
+		return -1;
+	}
+	if (nl->addr.nl_family != AF_NETLINK) {
+		errno = EINVAL;
+		return -1;
+	}
+	return 0;
+}
+
+/**
+ * mnl_socket_get_portid - obtain Netlink PortID from netlink socket
+ * @param nl netlink socket obtained via mnl_socket_open()
+ *
+ * This function returns the Netlink PortID of a given netlink socket.
+ * It's a common mistake to assume that this PortID equals the process ID
+ * which is not always true. This is the case if you open more than one
+ * socket that is binded to the same Netlink subsystem from the same process.
+ */
+unsigned int mnl_socket_get_portid(const struct mnl_socket *nl)
+{
+	return nl->addr.nl_pid;
+}
+
+/**
+ * mnl_socket_sendto - send a netlink message of a certain size
+ * @param nl netlink socket obtained via mnl_socket_open()
+ * @param buf buffer containing the netlink message to be sent
+ * @param len number of bytes in the buffer that you want to send
+ *
+ * On error, it returns -1 and errno is appropriately set. Otherwise, it
+ * returns the number of bytes sent.
+ */
+ssize_t
+mnl_socket_sendto(const struct mnl_socket *nl, const void *buf, size_t len)
+{
+	static const struct sockaddr_nl snl = {
+		.nl_family = AF_NETLINK
+	};
+	return sendto(nl->fd, buf, len, 0,
+		      (struct sockaddr *) &snl, sizeof(snl));
+}
+
+/**
+ * mnl_socket_recvfrom - receive a netlink message
+ * @param nl netlink socket obtained via mnl_socket_open()
+ * @param buf buffer that you want to use to store the netlink message
+ * @param bufsiz size of the buffer passed to store the netlink message
+ *
+ * On error, it returns -1 and errno is appropriately set. If errno is set
+ * to ENOSPC, it means that the buffer that you have passed to store the
+ * netlink message is too small, so you have received a truncated message.
+ * To avoid this, you have to allocate a buffer of MNL_SOCKET_BUFFER_SIZE
+ * (which is 8KB, see linux/netlink.h for more information). Using this
+ * buffer size ensures that your buffer is big enough to store the netlink
+ * message without truncating it.
+ */
+ssize_t
+mnl_socket_recvfrom(const struct mnl_socket *nl, void *buf, size_t bufsiz)
+{
+	ssize_t ret;
+	struct sockaddr_nl addr;
+	struct iovec iov = {
+		.iov_base	= buf,
+		.iov_len	= bufsiz,
+	};
+	struct msghdr msg = {
+		.msg_name	= &addr,
+		.msg_namelen	= sizeof(struct sockaddr_nl),
+		.msg_iov	= &iov,
+		.msg_iovlen	= 1,
+		.msg_control	= NULL,
+		.msg_controllen	= 0,
+		.msg_flags	= 0,
+	};
+	ret = recvmsg(nl->fd, &msg, 0);
+	if (ret == -1)
+		return ret;
+
+	if (msg.msg_flags & MSG_TRUNC) {
+		errno = ENOSPC;
+		return -1;
+	}
+	if (msg.msg_namelen != sizeof(struct sockaddr_nl)) {
+		errno = EINVAL;
+		return -1;
+	}
+	return ret;
+}
+
+/**
+ * mnl_nlmsg_portid_ok - perform portID origin check
+ * @param nlh current netlink message that we are handling
+ * @param portid netlink portid that we want to check
+ *
+ * This functions returns true if the origin is fulfilled, otherwise
+ * false is returned. We skip the tracking for netlink message whose portID
+ * is zero since it is reserved for event-based kernel notifications. On the
+ * other hand, if portid is set but the message PortID is not (i.e. this
+ * is an event message coming from kernel-space), then we also skip the
+ * tracking. This approach is good if we use the same socket to send commands
+ * to kernel-space (that we want to track) and to listen to events (that we
+ * do not track).
+ */
+bool
+mnl_nlmsg_portid_ok(const struct nlmsghdr *nlh, unsigned int portid)
+{
+	return nlh->nlmsg_pid && portid ? nlh->nlmsg_pid == portid : true;
+}
+
+/**
+ * mnl_nlmsg_ok - check a there is room for netlink message
+ * @param nlh netlink message that we want to check
+ * @param len remaining bytes in a buffer that contains the netlink message
+ *
+ * This function is used to check that a buffer that contains a netlink
+ * message has enough room for the netlink message that it stores, ie. this
+ * function can be used to verify that a netlink message is not malformed nor
+ * truncated.
+ *
+ * This function does not set errno in case of error since it is intended
+ * for iterations. Thus, it returns 1 on success and 0 on error.
+ *
+ * The len parameter may become negative in malformed messages during message
+ * iteration, that is why we use a signed integer.
+ */
+bool mnl_nlmsg_ok(const struct nlmsghdr *nlh, int len)
+{
+	return len >= (int)sizeof(struct nlmsghdr) &&
+	       nlh->nlmsg_len >= sizeof(struct nlmsghdr) &&
+	       (int)nlh->nlmsg_len <= len;
+}
+
+/**
+ * mnl_nlmsg_next - get the next netlink message in a multipart message
+ * @param nlh current netlink message that we are handling
+ * @param len length of the remaining bytes in the buffer (passed by reference).
+ *
+ * This function returns a pointer to the next netlink message that is part
+ * of a multi-part netlink message. Netlink can batch several messages into
+ * one buffer so that the receiver has to iterate over the whole set of
+ * Netlink messages.
+ *
+ * You have to use mnl_nlmsg_ok() to check if the next Netlink message is
+ * valid.
+ */
+struct nlmsghdr *
+mnl_nlmsg_next(const struct nlmsghdr *nlh, int *len)
+{
+	*len -= MNL_ALIGN(nlh->nlmsg_len);
+	return (struct nlmsghdr *)((void *)nlh + MNL_ALIGN(nlh->nlmsg_len));
+}
+
+/**
+ * mnl_nlmsg_seq_ok - perform sequence tracking
+ * @param nlh current netlink message that we are handling
+ * @param seq last sequence number used to send a message
+ *
+ * This functions returns true if the sequence tracking is fulfilled, otherwise
+ * false is returned. We skip the tracking for netlink messages whose sequence
+ * number is zero since it is usually reserved for event-based kernel
+ * notifications. On the other hand, if seq is set but the message sequence
+ * number is not set (i.e. this is an event message coming from kernel-space),
+ * then we also skip the tracking. This approach is good if we use the same
+ * socket to send commands to kernel-space (that we want to track) and to
+ * listen to events (that we do not track).
+ */
+bool
+mnl_nlmsg_seq_ok(const struct nlmsghdr *nlh, unsigned int seq)
+{
+	return nlh->nlmsg_seq && seq ? nlh->nlmsg_seq == seq : true;
+}
+
+static inline int
+__mnl_cb_run(const void *buf, size_t numbytes, unsigned int seq,
+	     unsigned int portid, mnl_cb_t cb_data, void *data,
+	     mnl_cb_t *cb_ctl_array, unsigned int cb_ctl_array_len)
+{
+	int ret = MNL_CB_OK, len = numbytes;
+	const struct nlmsghdr *nlh = buf;
+
+	while (mnl_nlmsg_ok(nlh, len)) {
+		/* check message source */
+		if (!mnl_nlmsg_portid_ok(nlh, portid)) {
+			errno = ESRCH;
+			return -1;
+		}
+		/* perform sequence tracking */
+		if (!mnl_nlmsg_seq_ok(nlh, seq)) {
+			errno = EPROTO;
+			return -1;
+		}
+
+		/* dump was interrupted */
+		if (nlh->nlmsg_flags & NLM_F_DUMP_INTR) {
+			errno = EINTR;
+			return -1;
+		}
+
+		/* netlink data message handling */
+		if (nlh->nlmsg_type >= NLMSG_MIN_TYPE) {
+			if (cb_data) {
+				ret = cb_data(nlh, data);
+				if (ret <= MNL_CB_STOP)
+					goto out;
+			}
+		} else if (nlh->nlmsg_type < cb_ctl_array_len) {
+			if (cb_ctl_array && cb_ctl_array[nlh->nlmsg_type]) {
+				ret = cb_ctl_array[nlh->nlmsg_type](nlh, data);
+				if (ret <= MNL_CB_STOP)
+					goto out;
+			}
+		} else if (default_cb_array[nlh->nlmsg_type]) {
+			ret = default_cb_array[nlh->nlmsg_type](nlh, data);
+			if (ret <= MNL_CB_STOP)
+				goto out;
+		}
+		nlh = mnl_nlmsg_next(nlh, &len);
+	}
+out:
+	return ret;
+}
+
+/**
+ * mnl_cb_run - callback runqueue for netlink messages (simplified version)
+ * @param buf buffer that contains the netlink messages
+ * @param numbytes number of bytes stored in the buffer
+ * @param seq sequence number that we expect to receive
+ * @param portid Netlink PortID that we expect to receive
+ * @param cb_data callback handler for data messages
+ * @param data pointer to data that will be passed to the data callback handler
+ *
+ * This function is like mnl_cb_run2() but it does not allow you to set
+ * the control callback handlers.
+ *
+ * Your callback may return three possible values:
+ *	- MNL_CB_ERROR (<=-1): an error has occurred. Stop callback runqueue.
+ *	- MNL_CB_STOP (=0): stop callback runqueue.
+ *	- MNL_CB_OK (>=1): no problems has occurred.
+ *
+ * This function propagates the callback return value.
+ */
+int
+mnl_cb_run(const void *buf, size_t numbytes, unsigned int seq,
+	   unsigned int portid, mnl_cb_t cb_data, void *data)
+{
+	return __mnl_cb_run(buf, numbytes, seq, portid, cb_data, data, NULL, 0);
+}
+
+
+/**
+ * mnl_socket_close - close a given netlink socket
+ * @param nl netlink socket obtained via mnl_socket_open()
+ *
+ * On error, this function returns -1 and errno is appropriately set.
+ * On success, it returns 0.
+ */
+int mnl_socket_close(struct mnl_socket *nl)
+{
+	int ret = close(nl->fd);
+	free(nl);
+	return ret;
+}
+
diff --git a/bat-mnl.h b/bat-mnl.h
new file mode 100644
index 0000000..255b568
--- /dev/null
+++ b/bat-mnl.h
@@ -0,0 +1,92 @@
+#ifndef _BATMNL_H_
+#define _BATMNL_H_
+
+#include <unistd.h>
+#include <stdint.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+
+/*
+ * Netlink socket API
+ */
+#define MNL_SOCKET_AUTOPID	0
+#define MNL_SOCKET_BUFFER_SIZE (getpagesize() < 8192L ? getpagesize() : 8192L)
+
+/*
+ * nla_type (16 bits)
+ * +---+---+-------------------------------+
+ * | N | O | Attribute Type                |
+ * +---+---+-------------------------------+
+ * N := Carries nested attributes
+ * O := Payload stored in network byte order
+ *
+ * Note: The N and O flag are mutually exclusive.
+ */
+#define NLA_F_NESTED		(1 << 15)
+#define NLA_F_NET_BYTEORDER	(1 << 14)
+#define NLA_TYPE_MASK		~(NLA_F_NESTED | NLA_F_NET_BYTEORDER)
+
+struct mnl_socket;
+
+extern struct mnl_socket *mnl_socket_open(int type);
+extern int mnl_socket_bind(struct mnl_socket *nl,
+			   unsigned int groups, pid_t pid);
+extern int mnl_socket_close(struct mnl_socket *nl);
+extern unsigned int mnl_socket_get_portid(const struct mnl_socket *nl);
+extern ssize_t mnl_socket_sendto(const struct mnl_socket *nl,
+				 const void *req, size_t siz);
+extern ssize_t mnl_socket_recvfrom(const struct mnl_socket *nl, void *buf,
+				   size_t siz);
+
+/*
+ * Netlink message API
+ */
+#define MNL_ALIGNTO		4
+#define MNL_ALIGN(len)		(((len)+MNL_ALIGNTO-1) & ~(MNL_ALIGNTO-1))
+#define MNL_NLMSG_HDRLEN	MNL_ALIGN(sizeof(struct nlmsghdr))
+
+
+/*
+ * callback API
+ */
+
+#define MNL_CB_ERROR		-1
+#define MNL_CB_STOP		 0
+#define MNL_CB_OK		 1
+
+typedef int (*mnl_cb_t)(const struct nlmsghdr *nlh, void *data);
+
+extern int mnl_cb_run(const void *buf, size_t numbytes, unsigned int seq,
+		      unsigned int portid, mnl_cb_t cb_data, void *data);
+
+/* TLV callback-based attribute parsers */
+typedef int (*mnl_attr_cb_t)(const struct nlattr *attr, void *data);
+
+extern int mnl_attr_parse(const struct nlmsghdr *nlh, unsigned int offset,
+			  mnl_attr_cb_t cb, void *data);
+
+
+#define mnl_attr_for_each(attr, nlh, offset) \
+	for ((attr) = mnl_nlmsg_get_payload_offset((nlh), (offset)); \
+	     mnl_attr_ok((attr), (char *)mnl_nlmsg_get_payload_tail( \
+			 nlh) - (char *)(attr)); \
+	     (attr) = mnl_attr_next(attr))
+
+
+/* Netlink message getters */
+extern void *mnl_nlmsg_get_payload(const struct nlmsghdr *nlh);
+extern void *mnl_nlmsg_get_payload_offset(const struct nlmsghdr *nlh,
+					  size_t offset);
+extern void *mnl_nlmsg_get_payload_tail(const struct nlmsghdr *nlh);
+
+/* TLV attribute getters */
+extern uint16_t mnl_attr_get_type(const struct nlattr *attr);
+
+/* TLV validation */
+extern int mnl_attr_type_valid(const struct nlattr *attr, uint16_t maxtype);
+
+/* Netlink message header builder */
+extern struct nlmsghdr *mnl_nlmsg_put_header(void *buf);
+extern void *mnl_nlmsg_put_extra_header(struct nlmsghdr *nlh, size_t size);
+
+#endif
diff --git a/functions.c b/functions.c
index cc05a48..098a6eb 100644
--- a/functions.c
+++ b/functions.c
@@ -34,14 +34,19 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/time.h>
+#include <time.h>
 
 #include "main.h"
 #include "functions.h"
+#include "bat-mnl.h"
 #include "bat-hosts.h"
 #include "sys.h"
 #include "debug.h"
 #include "debugfs.h"
 
+
+#define CB_FINISH -2
+
 static struct timeval start_time;
 static char *host_name;
 char *line_ptr = NULL;
@@ -413,6 +418,29 @@ out:
 	return mac_result;
 }
 
+static struct in6_addr *resolve_ipv6(const char *asc)
+{
+	int ret;
+	struct addrinfo hints;
+	struct addrinfo *res;
+	struct sockaddr_in6 *inet;
+	struct in6_addr *addr;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = AF_INET6;
+	ret = getaddrinfo(asc, NULL, &hints, &res);
+	if (ret)
+		return 0;
+
+	if (res) {
+		inet = (struct sockaddr_in6 *)res->ai_addr;
+		addr = &(inet->sin6_addr);
+	}
+
+	freeaddrinfo(res);
+	return addr;
+}
+
 static uint32_t resolve_ipv4(const char *asc)
 {
 	int ret;
@@ -436,6 +464,32 @@ static uint32_t resolve_ipv4(const char *asc)
 	return addr;
 }
 
+/*
+ * Sends a datagram to the given IPv6 address in order to spawn a neighbor
+ * discovery exchange. If the address is correctly resolved, then the
+ * neighbor discovery table will carry the corresponding link layer address.
+ *
+ * @addr: target IPv6 address for the link layer resolution
+ */
+static void request_nd(struct in6_addr *addr)
+{
+	struct sockaddr_in6 inet;
+	int sock;
+	char t = 0;
+
+	memset(&inet, 0, sizeof(inet));
+	sock = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock < 0)
+		return;
+
+	inet.sin6_family = AF_INET6;
+	inet.sin6_port = htons(9);
+	memcpy(&(inet.sin6_addr), addr, sizeof(struct in6_addr));
+	sendto(sock, &t, sizeof(t), 0, (const struct sockaddr *)&inet,
+	       sizeof(inet));
+	close(sock);
+}
+
 static void request_arp(uint32_t ipv4_addr)
 {
 	struct sockaddr_in inet4;
@@ -455,6 +509,131 @@ static void request_arp(uint32_t ipv4_addr)
 	close(sock);
 }
 
+/*
+ * Data structure used to hold input and output data for/from netlink
+ * neighbor discovery query callback function
+ */
+struct ipv6_lladdr {
+	const struct in6_addr *ip6_addr;
+	struct ether_addr *ll_addr;
+};
+
+/*
+ * Callback function called during netlink message parsing. Popolates the array
+ * obtained in input with parsed elements from each netlink attribute found in
+ * the payload message.
+ * @attr: message current attribute
+ * @data: array to populate
+ *
+ * @return outcome of attribute parsing
+ */
+static int data_attr_cb(const struct nlattr *attr, void *data)
+{
+	const struct nlattr **tb = data;
+	int type = mnl_attr_get_type(attr);
+
+	/* skip unsupported attribute in user-space */
+	if (mnl_attr_type_valid(attr, NDA_MAX) < 0)
+		return MNL_CB_OK;
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+/*
+ * Callback function, called on every netlink packet received in response
+ * of the query.
+ */
+static int data_cb_neigh(const struct nlmsghdr *nlh, void *data)
+{
+	struct rtattr *tb[NDA_MAX+1] = {};
+	struct ndmsg *ndm = mnl_nlmsg_get_payload(nlh);
+	struct ipv6_lladdr *inout = data;
+
+	if (ndm->ndm_family != AF_INET6 &&
+		(ndm->ndm_state != NUD_REACHABLE
+			|| ndm->ndm_state != NUD_STALE)) {
+		return MNL_CB_OK;
+	}
+
+	mnl_attr_parse(nlh, sizeof(*ndm), data_attr_cb, tb);
+
+	if (!tb[NDA_LLADDR] || !tb[NDA_DST])
+		return MNL_CB_OK;
+
+	if (RTA_PAYLOAD(tb[NDA_DST]) != sizeof(struct in6_addr))
+		return MNL_CB_OK;
+
+	if (memcmp(inout->ip6_addr,
+		   RTA_DATA(tb[NDA_DST]), sizeof(struct in6_addr)) == 0) {
+		inout->ll_addr = malloc(sizeof(struct ether_addr));
+		memcpy(inout->ll_addr,
+		       RTA_DATA(tb[NDA_LLADDR]), RTA_PAYLOAD(tb[NDA_LLADDR]));
+		return CB_FINISH;
+	}
+	return MNL_CB_OK;
+}
+
+/*
+ * Queries the kernel for the link layer (ethernet) address corresponding to
+ * the given IPv6 address.
+ * @in6_addr: address that needs to be resolved
+ *
+ * Returns the ethernet address if found, NULL otherwise
+ */
+static struct ether_addr *resolve_mac_nd(const struct in6_addr *addr)
+{
+	struct mnl_socket *nl;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	struct ndmsg *ndm;
+	int ret;
+	unsigned int seq, portid;
+
+	struct ipv6_lladdr inout = {
+		.ip6_addr = addr,
+		.ll_addr = NULL
+	};
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= RTM_GETNEIGH;  /*RTM_GETNEIGHTBL RTM_GETNEIGH*/
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	nlh->nlmsg_seq = seq = time(NULL);
+	ndm = mnl_nlmsg_put_extra_header(nlh, sizeof(*ndm));
+	ndm->ndm_family = AF_INET6;
+
+	nl = mnl_socket_open(NETLINK_ROUTE);
+	if (nl == NULL) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+	portid = mnl_socket_get_portid(nl);
+
+	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
+		perror("mnl_socket_send");
+		exit(EXIT_FAILURE);
+	}
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+
+	while (ret > 0) {
+		ret = mnl_cb_run(buf, ret, seq, portid, data_cb_neigh, &inout);
+		if (ret <= MNL_CB_STOP)
+			break;
+		ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	}
+	if (ret == MNL_CB_ERROR) {
+		perror("error");
+		exit(EXIT_FAILURE);
+	}
+	mnl_socket_close(nl);
+
+	return inout.ll_addr;
+}
+
+
 static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
 {
 	struct ether_addr mac_empty;
@@ -524,6 +703,25 @@ static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
 	return mac_result;
 }
 
+static struct ether_addr *resolve_mac_from_ipv6(const char *asc)
+{
+	struct in6_addr *addr;
+	int retries = 5;
+	struct ether_addr *mac_result = NULL;
+	addr = resolve_ipv6(asc);
+	if (!addr)
+		return NULL;
+
+	while (retries-- && !mac_result) {
+		mac_result = resolve_mac_nd(addr);
+		if (!mac_result) {
+			request_nd(addr);
+			usleep(200000);
+		}
+	}
+	return mac_result;
+}
+
 static struct ether_addr *resolve_mac_from_ipv4(const char *asc)
 {
 	uint32_t ipv4_addr;
@@ -554,7 +752,8 @@ struct ether_addr *resolve_mac(const char *asc)
 		goto out;
 
 	mac_result = resolve_mac_from_ipv4(asc);
-
+	if (!mac_result)
+		mac_result = resolve_mac_from_ipv6(asc);
 out:
 	return mac_result;
 }
-- 
1.8.3.2

