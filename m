Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADA3C43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:54:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 23F4384A3F
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:54:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450469;
 b=fA7TYau0vj5IvWv5bpPvFNd7fP76JOCZHXBKWAnajvGLXQsdrbZSGCPFp9r7YUvXsWVFj
 N/htGgCHyB8olBQkB6i5InqEfAVsjAvXmLtufaqbEq2nNx2i9QqnS44xNJwZ2rzhDewY6ME
 /7vkKVZe0wL6fygXyi6QwbuozkGWKkA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450469; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=b67R9gJcjRpDdIPTrRjQsBwHC1qxQ7H92ib4V7Yy0mc=;
 b=UMsQ7UhHAiVPaiX4aeW29eNaT5Re88qGS8DCvDkMXiMrL2LKsj1jA3yqYa4OUxDUtrt4Q
 q867oSpbNLxDcLKicikcUE3IRRvQMy9w9TvJJSfoTikzNCIUYybAVhiDjigbGBuLCzJQYzL
 IFbVqmFnLtbshH1uQrYatTeZHGc1lEw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0CE13841D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450034;
	b=BzDfFhMIZAvbR/0dGDQ4zvkakKYFLuqdqmw2rmYhtxymtg3slt4J0fb/NE3xT3o5tCoJCX
	yESVidQjtMT5s9s9UqpL8kHwg32z3Yz5KE6cB4iRnIdifVGcaJdiIckUltwY13+wigYBGf
	eomTZZN5arzNDaHsQLSLH/egvdLyHSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=b67R9gJcjRpDdIPTrRjQsBwHC1qxQ7H92ib4V7Yy0mc=;
	b=ad2DbxHjWHA+yxeVKlj7LtzL50mcm65n4rtkdMYklQm97WmiQiGnmW0AV9D5H7P6sPsPi3
	qz7694ZuCo5nhsVnUlH8/p8MDXNHP3fVq9rVNqqVWvjpJdS5GcUXSKxwb+jwgewGgtDZav
	gfNaqtJm3tJ4nOb1nkfKHdcu9cJrOMs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=euenYNZT;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 67E8D202D1;
	Tue, 07 Jul 2026 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b67R9gJcjRpDdIPTrRjQsBwHC1qxQ7H92ib4V7Yy0mc=;
	b=euenYNZTrFELdoy4hlJHDTDYh7V27daRH1HiiKbbQsfKsObur6eeVG97Ql/IjzsOOZgbH6
	IjPp68Fl25hlE5921DpNfDjCbItrRIRmiR2lt0Aea+f+I+KUdmUtOHPqtwzKkqaEzlqkOR
	P/eWGzmnZGTMZOEEa/MZzgxrPvUpIbU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:52 +0200
Subject: [PATCH 10/11] batctl: icmp_helper: fail send when the primary mac
 is unknown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-10-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=sven@narfation.org;
 h=from:subject:message-id; bh=EiFH9JXJhwtNrkYd3Cr3YUJSVQn+D+YeBIr9rm9ZXg8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+ntMuqPw6cS6bKTu5R/bfDDbDk8JxBRnTeL4vWSqne
 cj7wfa7HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJTFjNyLD9njf3UpnVYbq1
 fEU/Nb5xWbBsfLBg+evJnf/8VN1iTN4zMlz6ONOrRbFeJplx27aAcvkUl+zS9EanLT3iTf7NHxO
 /MAIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: I2ICXR7KKJK4ODPUH2SS7BZ3AZKH3WT4
X-Message-ID-Hash: I2ICXR7KKJK4ODPUH2SS7BZ3AZKH3WT4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I2ICXR7KKJK4ODPUH2SS7BZ3AZKH3WT4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

icmp_interface_update() calls get_primarymac_netlink() but discards its
return value. That helper only writes the output buffer on success; on
failure (netlink error, or BATADV_ATTR_HARD_ADDRESS missing from the
BATADV_CMD_GET_MESH_INFO reply) it returns a negative errno and leaves the
buffer untouched. primary_mac is a zero-initialised static and this is the
only place that ever writes it, so a failed query leaves it as
00:00:00:00:00:00. And address which the receiver cannot use to send a
reply.

Propagate the failure out of icmp_interface_update() and abort the send.

Fixes: 4bd751eed4dc ("batctl: Implement non-routing batadv_icmp in userspace")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 icmp_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/icmp_helper.c b/icmp_helper.c
index 65a2005..52ac22d 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -337,9 +337,7 @@ static int icmp_interface_update(struct state *state)
 	/* remove old interfaces */
 	icmp_interface_sweep();
 
-	get_primarymac_netlink(state, primary_mac);
-
-	return 0;
+	return get_primarymac_netlink(state, primary_mac);
 }
 
 static int icmp_interface_send(struct batadv_icmp_header *icmp_packet,
@@ -391,7 +389,9 @@ int icmp_interface_write(struct state *state,
 	if (icmp_packet->msg_type != BATADV_ECHO_REQUEST)
 		return -EINVAL;
 
-	icmp_interface_update(state);
+	ret = icmp_interface_update(state);
+	if (ret < 0)
+		return ret;
 
 	if (list_empty(&interface_list))
 		return -EFAULT;

-- 
2.47.3

