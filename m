Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B819FC54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:46:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5634884002
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:46:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498391;
 b=ZyJ+UALj+mzhW9p+KB0qmpHGh9PwVCCeWE5tzBTjDPfc3oZqRUEsxdLzbwudQacM2QhoA
 8xy6mWsCz4jfeju/4nJFZGWzPlTV3FTXDLac/dqflhuW5/hDv0HqWF25TTYleTSHkfDy79C
 zt2r/PP+RCFTAzgtHYtSIy6EL7Snw7c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498391; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YQV+1VaphdAunrgYYzXgOwo2uxB2Te1SKQiv2VMQFxg=;
 b=CWl1vY1vXY49aWox3y45Dqh6tMOjYAGPlrAbIC2ikNrO7b1nQWHppSFR3hAyrCKkBFb0p
 +S4V8MoUblGM8CE9NWC0XYU2U2zPFC9v46C+eaetcJNG91IqkIGGWEBVXsKQ07nkzuYYTJM
 yV6koEMJNe++SDXgDAGk/3cwAE+1ORA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 95E5B8403E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:45:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498336;
	b=qGCkKM6rcQdAXr7E8TooLL5BOWiN2UaPRZTQ6vRjYJBU9zro4n3reZhamJ0/o4gobz71Z3
	9igAj+8SjlqtsdwMR8aFNfjFri0lP2jSj53i28vJ61oljoNGxOHVH3u3bhX5ZYW4sJvLM3
	r+PALHkvEwe/8MWge3ufZef9Rq7LJN8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YQV+1VaphdAunrgYYzXgOwo2uxB2Te1SKQiv2VMQFxg=;
	b=zYDcXral22XbBVbTzpUv2RaOOeTuybulTs2lur0OxfLQEERERLfv40WTjRSVlnJzCU0BVV
	p1pNdf8aB90eBDcDUZHd9Nef1brfUP/ZTQSKMZhJp+rGGFyor1NxxvDP8dEbvhpnLVws7M
	tkx9Z08FwDK+irHFZQQnaijZOFOufsQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wfAxQT0v;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 21AA220CB8;
	Fri, 31 Jul 2026 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQV+1VaphdAunrgYYzXgOwo2uxB2Te1SKQiv2VMQFxg=;
	b=wfAxQT0vt0U2qsQPwyQIuXvBNUbB89H0EMUhXAJdezdclwU4ySztvOg95o6ZaBF9JaYr1e
	jByq8Ozas0I58XBzfFNaqZL9zJTzadSl2KYllmxMO/ve4ExeIWZOy3ld/OWnQ0rRHlKFWI
	Ex4TBT5yS622nIR9KGlYW3L8l/Y91Zc=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 13:44:51 +0200
Subject: [PATCH 2/6] alfred: update stored interface list on interface
 change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-interfaces-v1-2-a148ca2f6688@narfation.org>
References: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
In-Reply-To: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=sven@narfation.org;
 h=from:subject:message-id; bh=+LGVAY37aDnSfTJzGWeHa1Zpf96lqfilJV6zSNJfNic=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZs8dXZNjHhuxppf/C1n6c9XdUs29SzSOjVl4netQ
 p5vx2wedpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmspyHkeFc9GSnum79LUcd
 r5+83v0j7viBj3cWp9f5WR25tVHB8WkWw/+g0MAT3y/VXj86+aGj6uv3s2akRu7b2XThYOvdu4q
 rj75kBQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 543LAMRXCPV4TGVBP57TD7Z4DQ4LA5AA
X-Message-ID-Hash: 543LAMRXCPV4TGVBP57TD7Z4DQ4LA5AA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/543LAMRXCPV4TGVBP57TD7Z4DQ4LA5AA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The interface list received via ALFRED_CHANGE_INTERFACE was passed to
netsock_set_interfaces() but globals->net_iface kept the value from the
daemon start. But the stale string is used by unix_sock_add_data() to
decide whether interface operations are disabled ('none'). And for the none
interface, it is required to be in primary mode and to prefill the
data->source address.

Store a copy of the new interface list in globals->net_iface to dynamically
switch between the disabled/not disabled mode.

Fixes: 94b3c4b5744f ("alfred: receive data with valid source on unix sock without active interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unix_sock.c b/unix_sock.c
index e6b44da..64fde70 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -365,6 +365,7 @@ unix_sock_change_iface(struct globals *globals,
 		       struct alfred_change_interface_v0 *change_iface,
 		       int client_sock)
 {
+	char *net_iface;
 	int ret = -1;
 	int len;
 
@@ -383,6 +384,13 @@ unix_sock_change_iface(struct globals *globals,
 		}
 	}
 
+	net_iface = strdup(change_iface->ifaces);
+	if (!net_iface)
+		goto err;
+
+	free(globals->net_iface);
+	globals->net_iface = net_iface;
+
 	netsock_set_interfaces(globals, change_iface->ifaces);
 
 	ret = 0;

-- 
2.47.3

