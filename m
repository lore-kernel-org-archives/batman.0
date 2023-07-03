Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C7EB64DC
	for <batman-adv@archiver.kernel.org>; Mon,  3 Jul 2023 08:43:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 76C408198A
	for <batman-adv@archiver.kernel.org>; Mon,  3 Jul 2023 10:43:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1688373805;
 b=uBBJh5iMnfiaeqExNl8KA+igO7lv5QoZPI2KHZ8mqZTBt5f2kxNM/D3/MJ9VkT2r4YuhA
 pU5V1q9ta7NdiUXzjlMz987Oruc1EMhtLLR0w+f/oqw0Ft45fqyPvv5ywlIp6DTD0QLTHbV
 kyLSi5vZ1Ssa/VQbcAxmNGcc+FUl1u0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1688373805; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A0OCey0jO27pxkiud+jDYq5fSNfWORPcVJ7hbsaxELg=;
 b=nHQHMb4/9yDL0CjMBKqpIqkb62Qd0bxDL2RrTpVG5atc2JHZz0VSHQXZ5yz3n9waWJHCP
 /Nh2ohdTvh3++3N3MMFKCSblyWKu5RLBFd//iQDjn+QaDYiWrZ1t7hQt7Q1VhFYnSNtJDGM
 1mo7hrgby0h067wfytRnhCBfvfsK9Qk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BCF5981217
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  3 Jul 2023 10:43:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1688373797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A0OCey0jO27pxkiud+jDYq5fSNfWORPcVJ7hbsaxELg=;
	b=k8DHZRcrOxvw8N5az60Rm/MdYpzZVofwgC55+eIz3sGb5A6TTBmWRKdwB+f03YY0IwutGe
	V8ZhRy+1RUg1jdrEdKbgEhuD3VfzGvUEoLmkKLTWaJ08sxGp7QgcECQNhMZZFZUxdWp8lF
	EBlMU3Ery91Skmf3okwNo3WlDhpn7Go=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1688373797; a=rsa-sha256;
	cv=none;
	b=bKUsGHQukd4WNQPdZl7jfzNSnvARHrHgmsQOemXy2/RSHjE3soBItHSOMYwaFve7ZwAKp5
	e9/ZdzVggCZsSV2lVz+yf36vkWQom5LqIlPCHotxb4RQ3ql0NEvYCHq3SXnRPEmmxe5inf
	32KlpW1px6KDkYAJs353bPwi3LnY3Fc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH] alfred: receive data with valid source on unix sock without
 active interface
Date: Mon,  3 Jul 2023 10:43:01 +0200
Message-Id: <20230703084301.60455-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 47QZT5HF7TX6UKSYX4DP4VT2TFSZHU3A
X-Message-ID-Hash: 47QZT5HF7TX6UKSYX4DP4VT2TFSZHU3A
X-MailFrom: mareklindner@neomailbox.ch
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Marek Lindner <mareklindner@neomailbox.ch>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/47QZT5HF7TX6UKSYX4DP4VT2TFSZHU3A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 unix_sock.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index ce08a51..e6208ef 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -108,10 +108,6 @@ static int unix_sock_add_data(struct globals *globals,
 	int len, data_len, ret = -1;
 	struct interface *interface;
 
-	interface = netsock_first_interface(globals);
-	if (!interface)
-		goto err;
-
 	len = ntohs(push->header.length);
 
 	if (len < (int)(sizeof(*push) - sizeof(push->header)))
@@ -133,11 +129,26 @@ static int unix_sock_add_data(struct globals *globals,
 	 * source addresses. Otherwise the data would not be
 	 * synced between primary servers.
 	 */
-	if (is_valid_ether_addr(data->source)) {
+	if (is_iface_disabled(globals->net_iface)) {
+		if (!is_valid_ether_addr(data->source))
+			goto err;
+
+		if (globals->opmode != OPMODE_PRIMARY)
+			goto err;
+
+	} else if (is_valid_ether_addr(data->source)) {
+		interface = netsock_first_interface(globals);
+		if (!interface)
+			goto err;
+
 		if (memcmp(data->source, &interface->hwaddr, ETH_ALEN) != 0 &&
 		    globals->opmode != OPMODE_PRIMARY)
 			goto err;
 	} else {
+		interface = netsock_first_interface(globals);
+		if (!interface)
+			goto err;
+
 		memcpy(data->source, &interface->hwaddr, ETH_ALEN);
 	}
 
-- 
2.38.1

