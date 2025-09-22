Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EABCAC592
	for <batman-adv@archiver.kernel.org>; Mon, 22 Sep 2025 14:42:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A07C384889
	for <batman-adv@archiver.kernel.org>; Mon, 22 Sep 2025 16:42:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758552176;
 b=uVVJmcPma86lCbPwuZ9ZBTFwZTr+b7KrfardSQK7t+qjeJi5ECn9whtO7cU1qPYMHX4P+
 tWGqX1Eu/f/OuZQh96GUKN2kK3iNQecPg5sn5Ps7eIKCmQsR3kHsge4nc94GBZeLG6fU4qj
 TW4S1BGlaNOPQTQYfDO+0YGWsSbnwWs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758552176; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VQA9iLkUpsvACluzpjazRcqvFVtUfthikwaVB2RX/t8=;
 b=AmC6gnzmMiACl8qvZxG2mgoC0XtlnVBtcb+mSv6n44mJur9lTwRYLiL5hHeKjsWEt7gC0
 W74BJe3qyR55NSqrirCnEKz9wD8LqbFMW0rsC9LBeizQ/5YHsutsjpqgOojIJVvUZYh15vO
 uib+kacI88cddT5uRF9rtFho+NgAVc8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 87BE48439D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 22 Sep 2025 16:09:53 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758550196; a=rsa-sha256;
	cv=none;
	b=geD0lHbAsEmoZeWkXfPwnSLJwilBWuQMhk0QILZVH2SNhIydnrdVRX7yjI8yitZrc0VqWy
	nlEykEpZ1Glu8Tls4iApHnapQj/J54paWfYFl3cHose3AFtwyTYcSE+ZCUA3pAoJPObYyt
	dAI3uZ2+xE/1Mr4WBDD9ub6O/kSqmk0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of
 penguin-kernel@I-love.SAKURA.ne.jp designates 202.181.97.72 as permitted
 sender) smtp.mailfrom=penguin-kernel@I-love.SAKURA.ne.jp
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758550195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VQA9iLkUpsvACluzpjazRcqvFVtUfthikwaVB2RX/t8=;
	b=HZpjVw4i8GDHq9oRnNW7ht4jrtlIES10RW6l5wtjEymOoodTAnfVydEh7iHB2xWYrr4sjm
	m3kBfCrtEUJ679Qkqe+ktcyNDVml9hfI+m0wiVqTxF2FAGPZlWwYk6kkf1B0HXGYJgCArU
	mOmNbmYZ4yLy3F+977NR1v2OKkbgPWg=
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58ME9NOS079864;
	Mon, 22 Sep 2025 23:09:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58ME9DxM079809
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 22 Sep 2025 23:09:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
Date: Mon, 22 Sep 2025 23:09:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marek Lindner <marek.lindner@mailbox.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage count = 2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean
X-MailFrom: penguin-kernel@I-love.SAKURA.ne.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: IOAF6L474B5KHY5TAJGAPDB6XZUQBGFN
X-Message-ID-Hash: IOAF6L474B5KHY5TAJGAPDB6XZUQBGFN
X-Mailman-Approved-At: Mon, 22 Sep 2025 16:42:29 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IOAF6L474B5KHY5TAJGAPDB6XZUQBGFN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello.

I made a minimized C reproducer (shown bottom) for

  unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2
  ref_tracker: netdev@ffff88807bb4c620 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4390 [inline]
       netdev_hold include/linux/netdevice.h:4419 [inline]
       batadv_hardif_add_interface net/batman-adv/hard-interface.c:878 [inline]
       batadv_hard_if_event+0xbd1/0x1280 net/batman-adv/hard-interface.c:958
       notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
       call_netdevice_notifiers net/core/dev.c:2281 [inline]
       register_netdevice+0x1608/0x1ae0 net/core/dev.c:11325
       veth_newlink+0x5cc/0xa50 drivers/net/veth.c:1884
       rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3825
       __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
       rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
       rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6946
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       __sys_sendto+0x3bd/0x520 net/socket.c:2231
       __do_sys_sendto net/socket.c:2238 [inline]
       __se_sys_sendto net/socket.c:2234 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2234
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

problem at https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 .

When this problem happens, the

  batman_adv: batadv0: Adding interface: batadv_slave_0
  batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
  batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
  batman_adv: batadv0: Interface activated: batadv_slave_0
  batman_adv: batadv0: Interface deactivated: batadv_slave_0
  batman_adv: batadv0: Removing interface: batadv_slave_0
  batman_adv: batadv0: adding TT local entry 33:33:00:00:00:01 to non-existent VLAN -1

messages are printed but the

  batadv_hardif_release+0x44/0xb0
  batadv_hard_if_event+0x349/0x410
  notifier_call_chain+0x41/0x100
  unregister_netdevice_many_notify+0x43a/0xac0
  default_device_exit_batch+0xed/0x120
  ops_undo_list+0x10d/0x3b0
  cleanup_net+0x1f8/0x370
  process_one_work+0x223/0x590
  worker_thread+0x1cb/0x3a0
  kthread+0xff/0x240
  ret_from_fork+0x17f/0x1e0
  ret_from_fork_asm+0x1a/0x30

trace is not called (compared to when this problem does not happen).

I suspect that batadv_hard_if_event_meshif() has something to do upon
NETDEV_UNREGISTER event because batadv_hard_if_event_meshif() receives
NETDEV_POST_INIT / NETDEV_REGISTER / NETDEV_UNREGISTER / NETDEV_PRE_UNINIT
events when this reproducer is executed, but I don't know what to do...

---------- minimized C reproducer start ----------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <net/if.h>
#include <sched.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>
#include <linux/genetlink.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/veth.h>
#include <linux/batman_adv.h>

struct nlmsg {
	char* pos;
	int nesting;
	struct nlattr* nested[8];
	char buf[4096];
};

static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
                         const void* data, int size)
{
	memset(nlmsg, 0, sizeof(*nlmsg));
	struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
	hdr->nlmsg_type = typ;
	hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
	memcpy(hdr + 1, data, size);
	nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg, int typ, const void* data,
                         int size)
{
	struct nlattr* attr = (struct nlattr*)nlmsg->pos;
	attr->nla_len = sizeof(*attr) + size;
	attr->nla_type = typ;
	if (size > 0)
		memcpy(attr + 1, data, size);
	nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg* nlmsg, int typ)
{
	struct nlattr* attr = (struct nlattr*)nlmsg->pos;
	attr->nla_type = typ;
	nlmsg->pos += sizeof(*attr);
	nlmsg->nested[nlmsg->nesting++] = attr;
}

static void netlink_done(struct nlmsg* nlmsg)
{
	struct nlattr* attr = nlmsg->nested[--nlmsg->nesting];
	attr->nla_len = nlmsg->pos - (char*)attr;
}

static int netlink_send_ext(struct nlmsg* nlmsg, int sock, uint16_t reply_type,
                            int* reply_len, bool dofail)
{
	if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
		exit(1);
	struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
	hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
	struct sockaddr_nl addr;
	memset(&addr, 0, sizeof(addr));
	addr.nl_family = AF_NETLINK;
	ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
			   (struct sockaddr*)&addr, sizeof(addr));
	if (n != (ssize_t)hdr->nlmsg_len) {
		if (dofail)
			exit(1);
		return -1;
	}
	n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
	if (reply_len)
		*reply_len = 0;
	if (n < 0) {
		if (dofail)
			exit(1);
		return -1;
	}
	if (n < (ssize_t)sizeof(struct nlmsghdr)) {
		errno = EINVAL;
		if (dofail)
			exit(1);
		return -1;
	}
	if (hdr->nlmsg_type == NLMSG_DONE)
		return 0;
	if (reply_len && hdr->nlmsg_type == reply_type) {
		*reply_len = n;
		return 0;
	}
	if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
		errno = EINVAL;
		if (dofail)
			exit(1);
		return -1;
	}
	if (hdr->nlmsg_type != NLMSG_ERROR) {
		errno = EINVAL;
		if (dofail)
			exit(1);
		return -1;
	}
	errno = -((struct nlmsgerr*)(hdr + 1))->error;
	return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock)
{
	return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg, int sock,
                                   const char* family_name, bool dofail)
{
	struct genlmsghdr genlhdr;
	memset(&genlhdr, 0, sizeof(genlhdr));
	genlhdr.cmd = CTRL_CMD_GETFAMILY;
	netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
	netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
		     strnlen(family_name, GENL_NAMSIZ - 1) + 1);
	int n = 0;
	int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
	if (err < 0) {
		return -1;
	}
	uint16_t id = 0;
	struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
					       NLMSG_ALIGN(sizeof(genlhdr)));
	for (; (char*)attr < nlmsg->buf + n;
	     attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
		if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
			id = *(uint16_t*)(attr + 1);
			break;
		}
	}
	if (!id) {
		errno = EINVAL;
		return -1;
	}
	recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
	return id;
}

static void netlink_add_device_impl(struct nlmsg* nlmsg, const char* type,
                                    const char* name, bool up)
{
	struct ifinfomsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	if (up)
		hdr.ifi_flags = hdr.ifi_change = IFF_UP;
	netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
		     sizeof(hdr));
	if (name)
		netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
	netlink_nest(nlmsg, IFLA_LINKINFO);
	netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg* nlmsg, int sock, const char* type,
                               const char* name)
{
	netlink_add_device_impl(nlmsg, type, name, false);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_veth(struct nlmsg* nlmsg, int sock, const char* name,
                             const char* peer)
{
	netlink_add_device_impl(nlmsg, "veth", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	netlink_nest(nlmsg, VETH_INFO_PEER);
	nlmsg->pos += sizeof(struct ifinfomsg);
	netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_device_change(struct nlmsg* nlmsg, int sock,
                                  const char* name, bool up, const char* master,
                                  const void* mac, int macsize)
{
	struct ifinfomsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	if (up)
		hdr.ifi_flags = hdr.ifi_change = IFF_UP;
	hdr.ifi_index = if_nametoindex(name);
	netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
	if (master) {
		int ifindex = if_nametoindex(master);
		netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
	}
	if (macsize)
		netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

int main(void)
{
	static struct nlmsg nlmsg = { };
	const uint64_t macaddr = 0x00aaaaaaaaaa + ((10ull) << 40);
	unshare(CLONE_NEWNET);
	// initialize netdevices
	const int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	netlink_add_device(&nlmsg, sock, "batadv", "batadv0");
	netlink_add_veth(&nlmsg, sock, "batadv_slave_0", "veth0_to_batadv");
	netlink_device_change(&nlmsg, sock, "batadv_slave_0", false, "batadv0", 0, 0);
	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);
	close(sock);
	// execute
	int r[3];
	char buf[64] = "batadv0";
	r[0] = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	r[1] = netlink_query_family_id(&nlmsg, r[0], "batadv", false);
	ioctl(r[0], SIOCGIFINDEX, buf);
	r[2] = *(uint32_t*) (buf + 0x10);
	*(uint32_t*)buf = 0x1c; // len
	*(uint16_t*)(buf + 4) = r[1]; // type
	*(uint16_t*)(buf + 6) = NLM_F_REQUEST|NLM_F_ROOT|NLM_F_MATCH; // flags
	*(uint32_t*)(buf + 8) = 0; // seq
	*(uint32_t*)(buf + 12) = 0; // pid
	*(uint8_t*)(buf + 16) = BATADV_CMD_GET_NEIGHBORS; // cmd
	*(uint8_t*)(buf + 17) = 0; // version
	*(uint16_t*)(buf + 18) = 0; // reserved
	*(uint16_t*)(buf + 20) = 8; // nla_len
	*(uint16_t*)(buf + 22) = BATADV_ATTR_MESH_IFINDEX; // nla_type
	*(uint32_t*)(buf + 24) = r[2]; // payload
	send(r[0], buf, 28, 0);
	return 0;
}
---------- minimized C reproducer end ----------
