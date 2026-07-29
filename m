Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF7DC53200
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 06:28:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9480081824
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 08:28:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785306486;
 b=lzEs/rChk9fJIAC2qtHFzDk3TPvHJeFwpBxyEpBVnT78MM3y5AuvIq6q0BHv4bblT9qE1
 8owY4ahMtHsyA86Cqwefc3ZWTf3o4eyIuYom8eppVooclpDIxiNa0/OsUDT/ZJTt9+QOaej
 01CHxzuejb3pgt0tG91YncsWjk30gOQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785306486; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LBXVVcnLT5Yh0TkbeQtA/T7muAaZcATWCBIqHOmeQa0=;
 b=qnogva66v2ruIkBvFVQVIDcno9wu4l+TitzF88PRPHPZoI1hiFknFOe7Vhn2d++P0K+g/
 FwyfTE5e2hZHPYP7St2leW7SN/11ABoUW9FeAnq5IIlE3RvOhY4pCqHJAaVnRGHQ/ulhFEU
 vuX4An+xEZKV0kwwvsSSBB6R+DNpCFo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 31551817DA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 08:27:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785306444;
	b=tJ1EFs4lKepKEr2W6I8suEqwVIDDKz5OGkTQP6l+jsnXWQRfL49LhfP+EPoAZ6k6Lj30VR
	sMkBO7F+f1rzrCEtQf89QyTJgqfrbkpkqzBc2qLySPFH6XyEKAYjpNK8QRdan/jzFF7sZB
	ovPuzbmo7NicGGU6hzV2uWf9IqAd9bw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785306444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LBXVVcnLT5Yh0TkbeQtA/T7muAaZcATWCBIqHOmeQa0=;
	b=CXnpW71MHyqqB9xJ6N2xp6YzyjUMFc4EPcWEEf2gELd2iZ4p/cvvCK1lzin+gHorxMHksJ
	X3dQ9pr3NBH5SPUzok2Wa4ql2Idnn7hXtGCxToosCVjxkFSX4D6/ON6KF2jAHPp7pSra2k
	Z6/1LTlkiURKlRzzHdH3+v819vdj4gI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="bGJ/eJqV";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B0D7A204EB;
	Wed, 29 Jul 2026 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785306428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBXVVcnLT5Yh0TkbeQtA/T7muAaZcATWCBIqHOmeQa0=;
	b=bGJ/eJqVlJzaMmBAPY3bUVqkEnfGGOMvCymqW+Lk+iid54ti1Im+/eZcMvIE2TZ8HzRQWd
	9Fd6uHlJMR+zXK9O7e7HEkoHg3ci31Hd/oXMSE7l8/X1JeoB0P3MTDk6DSJpoDdhK7wAdj
	j+2vaFujP9I4dWX6hGKw63cjcL3AZu0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jul 2026 08:26:28 +0200
Subject: [PATCH 1/2] alfred: drop CAP_NET_RAW when binding to the device
 fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-bugfixes-libcap-v1-1-23529745c828@narfation.org>
References: <20260729-bugfixes-libcap-v1-0-23529745c828@narfation.org>
In-Reply-To: <20260729-bugfixes-libcap-v1-0-23529745c828@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=sven@narfation.org;
 h=from:subject:message-id; bh=OsuSRD7Nx2Oa1xeU/EhNxGHMsWq5BqxD7Bx0umaqMFg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmZc5Us9iyWYOt6HS9ybfPxtLWvIn7k1J3RvmlT6nZnT
 92s7/HyHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJnL/B8N9DfufTTM/Ffn+9
 j97e+M/uYde1j7s9rv+9taua27ZK7vc6RoZPUzUM2ULCPppJvD92+u60rU8/m3Hck13uW65c+iL
 4uxMbAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: A2FA24HLOUDIBLQVO6LJ3E6UAJQAC4AH
X-Message-ID-Hash: A2FA24HLOUDIBLQVO6LJ3E6UAJQAC4AH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A2FA24HLOUDIBLQVO6LJ3E6UAJQAC4AH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netsock_open() and netsock_open4() raise the CAP_NET_RAW effective
capability around the two SO_BINDTODEVICE setsockopt() calls and drop it
again with enable_raw_bind_capability(0). When either setsockopt() fails
the "goto err" jumps straight to the socket cleanup and skipped the drop.
The daemon was then still using the CAP_NET_RAW.

Route the bind failures through a new err_bind label that drops the
capability before the existing error cleanup.

Fixes: b0877b387ba1 ("alfred: Drop capabilities when not needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netsock.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/netsock.c b/netsock.c
index 60b2285..54148e2 100644
--- a/netsock.c
+++ b/netsock.c
@@ -317,14 +317,14 @@ static int netsock_open(struct globals *globals, struct interface *interface)
 	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, interface->interface,
 		       strlen(interface->interface) + 1)) {
 		perror("can't bind to device");
-		goto err;
+		goto err_bind;
 	}
 
 	if (setsockopt(sock_mc, SOL_SOCKET, SO_BINDTODEVICE,
 		       interface->interface,
 		       strlen(interface->interface) + 1)) {
 		perror("can't bind to device");
-		goto err;
+		goto err_bind;
 	}
 	enable_raw_bind_capability(0);
 
@@ -408,6 +408,9 @@ static int netsock_open(struct globals *globals, struct interface *interface)
 	interface->netsock_mcast = sock_mc;
 
 	return 0;
+
+err_bind:
+	enable_raw_bind_capability(0);
 err:
 	close(sock);
 	close(sock_mc);
@@ -464,13 +467,13 @@ static int netsock_open4(struct globals *globals, struct interface *interface)
 	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, interface->interface,
 		       strlen(interface->interface) + 1)) {
 		perror("ipv4: can't bind to device");
-		goto err;
+		goto err_bind;
 	}
 
 	if (setsockopt(sock_mc, SOL_SOCKET, SO_BINDTODEVICE,
 		       interface->interface, strlen(interface->interface) + 1)) {
 		perror("ipv4: can't bind to device");
-		goto err;
+		goto err_bind;
 	}
 	enable_raw_bind_capability(0);
 
@@ -558,6 +561,9 @@ static int netsock_open4(struct globals *globals, struct interface *interface)
 	interface->netsock_mcast = sock_mc;
 
 	return 0;
+
+err_bind:
+	enable_raw_bind_capability(0);
 err:
 	close(sock);
 	close(sock_mc);

-- 
2.47.3

