Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B16C5516D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:47:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC05E8402E
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:47:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498452;
 b=lgWDrn/1QY55536uak02iudi5nSZYkf/iBMPm8u1NCs9esAbU6oz+Geg6M+4CwxYZ1DXB
 SnqKQoWVtN7kaHZgCjzA25BGFyZ6gCUjqkjkq6eGqy535hf2OgfF7KfcFQPOnEDWltk46KQ
 LdV1Jch89cUTWEXno6Y+lVsksBZYU7w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498452; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qu/Zsji8niWsKFPUT5G9pUfvN4ZRBSA8y70BPCiqfwc=;
 b=VSpmt0Z+3d+CirUc+bH1erh7fubPSHJKSBvGhKfY66Q1ccvzm3UQ6rSCDWVia434Cog79
 xvWG3kkxMR5Ikun7w4XXWw4DfKvhJwcEjm+DWhteyvOy/qcN8csFK49u3ahlqvx5JjT6l6q
 HYj6FUzZTn4ARnxVbPMB1YeIoaXjFXE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E0B8B84016
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:45:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498349;
	b=U2T/Hk2Wrk1AxgB22RXXYOUQjvJIUoEIFzdCPWR9klTnTumCPufUFrJxAlre5xYrc2aOhw
	v1nrdlsU18vSZMTzoxkgPhgXUeSfxu1c6np1MjqPe+5gftkZ9mxziTULtn8R5swYdESecO
	dYXqYXt/2e1JzOzP8ybsYvAJJBMRPwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qu/Zsji8niWsKFPUT5G9pUfvN4ZRBSA8y70BPCiqfwc=;
	b=nmgM3W+1N1TFkIvh/V1zf3fdLP9sHsVvtSM8YWoRPzf8U+bPYLm5MGZfkvS96BaNMYalje
	wDPNLkeEi625yEHSanGQMj37a4fCRYIZEX+yXb57qprD3bfY68jyAwyMab5+qiLR4xzJu1
	RtJaI06rb0HA16KkkgTk1yZ/qZmpW4o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NpMITBZ3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7C8BB20CB8;
	Fri, 31 Jul 2026 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu/Zsji8niWsKFPUT5G9pUfvN4ZRBSA8y70BPCiqfwc=;
	b=NpMITBZ38hDvHJc+728GlwZ5QcHU3I4OUeAUOwksETHiHxjyxU1pNMtw0mBJq6U2A5PlTa
	Z72Oef35IVA6GciyUXtvpbPTGstL4yxdRXE2gQs77qRCSJ1tc+ezShDaDPTrm1PvRxxZjj
	kawjNgqmy8GtGtrKuAXbUMaWTnp7E24=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 13:44:53 +0200
Subject: [PATCH 4/6] alfred: keep the running interfaces when
 reconfiguration fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-interfaces-v1-4-a148ca2f6688@narfation.org>
References: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
In-Reply-To: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4045; i=sven@narfation.org;
 h=from:subject:message-id; bh=HvalYcejK+Ymz1JDnl+76XGFTQXouhV3prUYV/MOQZc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZu7wtsd95znS1a69YbV6vZKgbVzzqxdzq8WNbVJV
 CZVafayjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEon4y/I8w03gpfp3lou4T
 1zsbeOZ0VTxM/TLBuW4V7/QT0bcY6vUYGf7U3Hi04az0lzzrwl2FCvWdWpeZePSWHNJZWNTSPEc
 jghEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: C4OCT764Y6YFFSQTMEVV5UCSA3XEZUYH
X-Message-ID-Hash: C4OCT764Y6YFFSQTMEVV5UCSA3XEZUYH
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/C4OCT764Y6YFFSQTMEVV5UCSA3XEZUYH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netsock_set_interfaces() tore down the existing interface list with
netsock_close_all() before building the new one. When an allocation failed
while building the replacement it called netsock_close_all() again and
returned -ENOMEM, leaving the daemon with no interfaces at all.

Build the replacement into a temporary list first and only swap it in once
it is complete. On failure the temporary list is discarded and the running
interfaces are kept intact.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netsock.c   | 41 +++++++++++++++++++++++++++--------------
 unix_sock.c |  7 +++++--
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/netsock.c b/netsock.c
index 60b2285..3505041 100644
--- a/netsock.c
+++ b/netsock.c
@@ -100,12 +100,12 @@ struct interface *netsock_first_interface(struct globals *globals)
 	return NULL;
 }
 
-static struct interface *netsock_find_interface(struct globals *globals,
+static struct interface *netsock_find_interface(struct list_head *interfaces,
 						const char *name)
 {
 	struct interface *interface;
 
-	list_for_each_entry(interface, &globals->interfaces, list) {
+	list_for_each_entry(interface, interfaces, list) {
 		if (strcmp(name, interface->interface) == 0)
 			return interface;
 	}
@@ -115,30 +115,32 @@ static struct interface *netsock_find_interface(struct globals *globals,
 
 int netsock_set_interfaces(struct globals *globals, char *interfaces)
 {
+	struct list_head new_interfaces;
 	struct interface *interface;
+	struct interface *is;
 	char *saveptr;
 	char *input;
 	char *token;
 
-	netsock_close_all(globals);
+	INIT_LIST_HEAD(&new_interfaces);
 
 	/* interface 'none' disables all interface operations */
-	if (is_iface_disabled(interfaces))
+	if (is_iface_disabled(interfaces)) {
+		netsock_close_all(globals);
 		return 0;
+	}
 
 	input = interfaces;
 	while ((token = strtok_r(input, ",", &saveptr))) {
 		input = NULL;
 
-		interface = netsock_find_interface(globals, token);
+		interface = netsock_find_interface(&new_interfaces, token);
 		if (interface)
 			continue;
 
 		interface = malloc(sizeof(*interface));
-		if (!interface) {
-			netsock_close_all(globals);
-			return -ENOMEM;
-		}
+		if (!interface)
+			goto err;
 
 		memset(&interface->hwaddr, 0, sizeof(interface->hwaddr));
 		memset(&interface->address, 0, sizeof(interface->address));
@@ -151,8 +153,7 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 		interface->interface = strdup(token);
 		if (!interface->interface) {
 			free(interface);
-			netsock_close_all(globals);
-			return -ENOMEM;
+			goto err;
 		}
 
 		interface->server_hash = hash_new(64, server_compare,
@@ -160,14 +161,26 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 		if (!interface->server_hash) {
 			free(interface->interface);
 			free(interface);
-			netsock_close_all(globals);
-			return -ENOMEM;
+			goto err;
 		}
 
-		list_add_tail(&interface->list, &globals->interfaces);
+		list_add_tail(&interface->list, &new_interfaces);
 	}
 
+	netsock_close_all(globals);
+	list_splice_tail(&new_interfaces, &globals->interfaces);
+
 	return 0;
+
+err:
+	list_for_each_entry_safe(interface, is, &new_interfaces, list) {
+		list_del(&interface->list);
+		hash_delete(interface->server_hash, free);
+		free(interface->interface);
+		free(interface);
+	}
+
+	return -ENOMEM;
 }
 
 static int enable_raw_bind_capability(int enable)
diff --git a/unix_sock.c b/unix_sock.c
index 417b380..d0e82dc 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -388,11 +388,14 @@ unix_sock_change_iface(struct globals *globals,
 	if (!net_iface)
 		goto err;
 
+	if (netsock_set_interfaces(globals, change_iface->ifaces) < 0) {
+		free(net_iface);
+		goto err;
+	}
+
 	free(globals->net_iface);
 	globals->net_iface = net_iface;
 
-	netsock_set_interfaces(globals, change_iface->ifaces);
-
 	ret = 0;
 err:
 	close(client_sock);

-- 
2.47.3

