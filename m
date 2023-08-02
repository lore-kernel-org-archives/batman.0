Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D843AC00528
	for <batman-adv@archiver.kernel.org>; Wed,  2 Aug 2023 10:02:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 53F92833BB
	for <batman-adv@archiver.kernel.org>; Wed,  2 Aug 2023 12:02:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690970541;
 b=eCWlPDI/OH7TkRwX2jeYSxCxeP3PZteC2VvoFFTclq3EeFBXJjp4mmxDAqJIk/Jojjmhx
 ++BGrgp9OhS8WZyuXOjemvnFpsBYJFEWYAzEV5U0ErL+vKom182pmiJG7ZcqMlbAsWBr62C
 5SDhHsJ3xWfYBpmRq7KBU+bh4Y0e+uc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690970541; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=u6pgN2cyyroZibvCzWWQm7wwqfAMucQmU9KwnVmuwYA=;
 b=oe6x0QQ9vYFhEhPd3N2G9kLfD2+LFHeF3cye6tt+Mffb026qijz3woAALn6+3GgZeuSLQ
 mMmsDsHu3Udpwe2ThE5eJWG16Jm4+F2KvSUQnvrmoz8yjJyFO4ffI/m8rbI0v4qA/xROnXs
 sZohe5LBJm+s6KBMtJjyW16ImJtVa/s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E07D682E82
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  2 Aug 2023 12:00:33 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690970433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u6pgN2cyyroZibvCzWWQm7wwqfAMucQmU9KwnVmuwYA=;
	b=Tbv3t8jlfOybS/lXJXnmpQJLcskoZO52iNi6HROQXi4kx7j0DxCJfJa9AaYiVtCvvbjSMj
	vV+KDcoJAvYlyRqvm6nUMUcWtKMbVm7TMgP7N1zrqs8bSsbawntNgoXu+Lci25Zae5ZN3f
	l6/Z1IS1zeA0nu/A6eNN21//H7o1iEc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="KIL/jafS";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690970433; a=rsa-sha256;
	cv=none;
	b=nnC2wUGFUONEfMiJs8fkApgirIpj6Se2dQpdZGLwV4hwrA5Gvaj30oIu7gqAjzW9PEV/sX
	7B8mC7f+HzXMkM0qwv18/Gc11eIbzKiw+/RNFHpD1IZumDdoT1DQAhIHFriIiMN2dbSzcs
	CeDZZC2Qwxk2H69dEru7kqwa8In1XK8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690970433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6pgN2cyyroZibvCzWWQm7wwqfAMucQmU9KwnVmuwYA=;
	b=KIL/jafSyx+hwc+UP0I52YXsM5sk/48hgpJ/2j2xApDONkZ9bZHKTdQWB9VVJiYjs+MTrr
	IFq+Ax981cMYr7VYqlSns0UH1c/cJz3hILkRkA+r7MqcVjGZS3vD0OARpkIlThE68EmWhG
	yCtHYuxbpxPksslN9kjBovhCr+gIQyY=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 02 Aug 2023 12:00:23 +0200
Subject: [PATCH 2/3] batman-adv: Keep batadv_netlink_notify_* static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-cleanup_functions-v1-2-1f9bfb914696@narfation.org>
References: <20230802-cleanup_functions-v1-0-1f9bfb914696@narfation.org>
In-Reply-To: <20230802-cleanup_functions-v1-0-1f9bfb914696@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=sven@narfation.org;
 h=from:subject:message-id; bh=tv5Fg8nIBJH+1gcRrZnqmBi0jIrSNnsVL8EZ6PkSVmU=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyik3w2lbDBp+294mm6ZpFKFGgIDT3qN1MVaOd
 o4DIKFj2U+JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMopNwAKCRBdhwoHwSZ7
 Rl3jEADU9/AlxEDg0/qRNQlG5NZpIOX3e2gcRYnzmJPsbBDW+v680BjCTTIiI3XPim80i1v4cxQ
 f7+r1YOH5BAtm+pviC/NGEnfUHr/xs6gF8+/W91wNnY6lYmRhfVlKXqBkkgk9s1cRsdFZlU9Llb
 J5qLjXl3AaX3Tg5lqgmahEIwD+JWxaZswp5R5IaGCV3pFW98RnAvooexQz0AfipojKLCmxqNpnq
 ORv7jYZ4jt32GyiL3e/SQnDBJ6z+if4wME1gbRP54bKg2PTLLGbYqIJWwMsVxeQ9mHpWNaT4Xbj
 3987KJ8WtEV/t5WTfjg/lvIF0rw3lrFSABepNykWZU3zPZ6qVg2gwdJ0Zu6/XucajRsAsxwikA7
 I0Mmhx5aID6zhuLweWlhbWmQQCcSes6yMAtw6HiYcWngzDMjKJMzrzr+p6mvhAB95fx2ZZcrxIr
 2VtlAs5xTUz0EVJJmaE4P27mV0B4UCTF2Ib8C0Fm4wfaYGfQSrUldEQfDFq7qfekNJYwlyjjskT
 m8F1emTmE2mukHM8SYdUFZZLfX2xV4+mJ6CelDhtlVZlUaZO5EsmPtOua0db1FQCzA9irb0Wzcu
 1WBlxWOI11ZJPsTIJToLHmXFZg14YkRElysuix0r1NfzVWpvNx8HqMB/wHyVwEJhLlnLh6hhBT5
 j/jupSQ/a1DJ9Mw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7GMXRKAA6C2J3P5CYSZPYG6WDWINXA4E
X-Message-ID-Hash: 7GMXRKAA6C2J3P5CYSZPYG6WDWINXA4E
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7GMXRKAA6C2J3P5CYSZPYG6WDWINXA4E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_netlink_notify_*() functions are not used by any other source
file. Just keep them local to netlink.c to get informed by the compiler
when they are not used anymore.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 10 +++++-----
 net/batman-adv/netlink.h |  6 ------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 07f21cdb..09b76b0f 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -377,7 +377,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
+static int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -858,8 +858,8 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
-				 struct batadv_hard_iface *hard_iface)
+static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
+					struct batadv_hard_iface *hard_iface)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -1073,8 +1073,8 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
-			       struct batadv_softif_vlan *vlan)
+static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
+				      struct batadv_softif_vlan *vlan)
 {
 	struct sk_buff *msg;
 	int ret;
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 48102cc7..876d2806 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -21,12 +21,6 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 				  u8 result, u32 test_time, u64 total_bytes,
 				  u32 cookie);
 
-int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv);
-int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
-				 struct batadv_hard_iface *hard_iface);
-int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
-			       struct batadv_softif_vlan *vlan);
-
 extern struct genl_family batadv_netlink_family;
 
 #endif /* _NET_BATMAN_ADV_NETLINK_H_ */

-- 
2.39.2

