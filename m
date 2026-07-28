Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C865EC54F4D
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 16:23:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0668684940
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 18:23:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785255816;
 b=NYtdEeXlVmTFKmuAvazjWqhGc/KfcH7n1w+MQO0EkyFBfVbeDzrMnQtoi2jXQOWYEPTjR
 v1expzns5Pb7JXcU8i50iyjGcGN1c5qnZqmkrWwRM3QvTlhf6rgDOxz7ubXJT+jGG1ac3yb
 /NI08rGkFDt/XEZXtQR6F2I05qMkTtU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785255816; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=h18HBqT1P54Nl/zZPtnG2l4MnBy7iY2AImIXI3py+WI=;
 b=Sd5CJV0zQ6TFjMK68BZsas8p/2wSZBRKFwKwaTMf4WczXW+cEX4LfX5rueNjtSHvti7aZ
 iznygBF7/A+jizsQRnxHJbmRuU5h4qFFxwMchQScmEl4CMMeMq8xgAh4Mdd8SrO4qs22jOW
 W8V7Usz9dGnG0+n2s1WttlrjbHzj7mQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C2AA48461B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:02:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254542;
	b=nQIYlA/BzJMQQIJpFqWn2pfCj34VfoSeZSZgjz9c8+lyWcHSVwzlyOjL8wIlpO3YBxILij
	12NWotugzqZGgI9/aZOSTYmXA0xm69N4O+xnLOAe5rv6NYf9nL/c9WcJagIhPz1791pNlI
	WancjuPAHjkQd56BdPiv+MviUETVrmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=h18HBqT1P54Nl/zZPtnG2l4MnBy7iY2AImIXI3py+WI=;
	b=GH6ly2DvUJbIdWdWt39IcVKhRim6r9+lUbzG+yf3M/vQbDj8HEfWgihiYGLS5eI5chX+mQ
	ez+P/LxNzzz0zIZeiwH+IUBx/94FHfgttIY+jjQOGsIG5o+GXF74cK3SMpa419oeJjXL6q
	yHVO+rHeyeOmBQT6W9cMEygqNo+rRso=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=P2+UEgcf;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E7B6A200D8;
	Tue, 28 Jul 2026 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h18HBqT1P54Nl/zZPtnG2l4MnBy7iY2AImIXI3py+WI=;
	b=P2+UEgcfgrIPRgKiD019u+AKzhiQsvSFuV6KKhiuMraZOgi/LP0S9hYA/y5IOGWAqgkXTB
	Dl5QyH5IPipo9lYetKzPw2L30Xb51BnfZtBZLlnSU64DgfNDqvn4+UWbWkkSO3hyU2WKhu
	wVA57+TTjpfP09+e/D5c+QWv61l+D/A=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:30 +0200
Subject: [PATCH 1/8] alfred: vis: reject too long unix socket paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-1-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=sven@narfation.org;
 h=from:subject:message-id; bh=lRhPy4KAC3iNElnjYWhRi7l/u3/RpRBYx349ZAtzLQo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2JW+V/1b5joLbTxzmbp2+/fL6yVP5I/T6BEul5lp
 /zjpxa/O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATce9mZPghL9dQlvh7mlHl
 Q/kZV788eBvMWa2g5Xg79v2qzErFQ4wM/xOLf/tEarQ93Bp41L3xsFrsrE9BnxXs9tiWCsyz6rm
 bwAgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WUYWXHULIUDP542L7U657TSNQ64AM4H5
X-Message-ID-Hash: WUYWXHULIUDP542L7U657TSNQ64AM4H5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WUYWXHULIUDP542L7U657TSNQ64AM4H5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The unix socket path needs to be stored in sockaddr_un::sun_path. But
strncpy() is silently truncating the string when the target buffer is too
small.

Reject such paths with a clear error message.

Fixes: 6c6a6f735054 ("alfred: Make unix socket path configurable")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/vis/vis.c b/vis/vis.c
index 4642227..d635798 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -152,6 +152,12 @@ static int alfred_open_sock(struct globals *globals)
 {
 	struct sockaddr_un addr;
 
+	if (strlen(globals->unix_path) >= sizeof(addr.sun_path)) {
+		fprintf(stderr, "unix socket path too long\n");
+		globals->unix_sock = -1;
+		return -1;
+	}
+
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
 		perror("can't create unix socket");

-- 
2.47.3

