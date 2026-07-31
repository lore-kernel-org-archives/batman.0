Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD4C5516D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:48:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2BA0884070
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:48:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498520;
 b=g9A5ha5VuixgtJzbMv1k51CsuwhLXgdPPGdvPIVvNSnBJM4e51QmuO/YbNZAVN2v30AYM
 P+9XIBZWHL2h2B2gVPSv77Qv2U6s5hk6XJXV0fuNcxfTnVNneiH59Z5Ij8gD0FN+qNuzRSs
 cIrGMa72hEtXz7RLCPf2EQ1+Y2zckYo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498520; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Tf2Pz6ZaTgeQI/fHQuTx7yXxIobLdc+UM96IXSO5wbo=;
 b=b2IgiS6rc4whXRvk98if8mI7MFRkumEjoFR3ccywgyrwKpqO8tfmBvSv8rHWizw34Sb5j
 vHfV4InK8u+Y87e2xqNIv/nrQhhRuCkxwC0ZMNjamuwBLLNywtK5dbmQA298dDb3r+hmjXe
 dWd/kBFxU+m6mfTXEiS5DPO58uNnHe0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 559BF84009
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:46:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498375;
	b=F6YdtWooMukmxrpSpj0DWXVK47eQNGBV29BQyWlX9mkjYeJPSCDWOPlD1r+rQOjiEp5IRQ
	1LA60CXwoxDy+yYwG56CT80SGDjYWRLu9WuFy3CGx8/RlKuHiLAtbSTanFb/vn8aUv0UO3
	JgdQdbSnOmLljrk+DwsunyF0sTE3nws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Tf2Pz6ZaTgeQI/fHQuTx7yXxIobLdc+UM96IXSO5wbo=;
	b=mRXk41LQbSZhNxqKtoHynHJJncj97ErR9qoOGL+k8FMw/8gSaAjuDeZNZ8ieOQofQSpRY/
	Abd4Vk5H77oZ0RyERM517H3kbUhcqzijQrytBQ8rTnOVntEw6Jhf8Pe/5wQyqi4RQuSMB7
	IJvEYPms3T/ztpQ9P8CRw/p1xqQXsiQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TGlI0LcA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E16A41FD3C;
	Fri, 31 Jul 2026 11:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf2Pz6ZaTgeQI/fHQuTx7yXxIobLdc+UM96IXSO5wbo=;
	b=TGlI0LcA+KzhFST4OypuUAsResv2sw1sgR06UxcumC/aZERp+YFlZIthTreSsSe16zJcYp
	ApnWnsbWVqAyQWdFdLvDXv9XV6WA+AOm/egJ3zdPu5PaqsNQZmBIZeq1wJdufcZS2wdBdq
	zCthiJS7c90vdq2f5Abd2pu/IELV0+E=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 13:44:55 +0200
Subject: [PATCH 6/6] alfred: don't check the "none" on network interface
 change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-interfaces-v1-6-a148ca2f6688@narfation.org>
References: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
In-Reply-To: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=sven@narfation.org;
 h=from:subject:message-id; bh=EK4ergRu75SJpqNTcDgUEA0aPqVbJfL+zerMYzr5i2g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZvZbATzmNJ+bPux9dubBU8OmVV0x9X4FPg0NU3Je
 Kx40vxJRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiZu0M/7NylZTfs1pmOe9e
 y6294pAtVyjH/JNTFGc29/fYTO+wUmf4p6k3f0Hx7ITr2qJBKWu92U3jAn9r5mvmyCtM5L6pdf4
 UBwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 64MKZDUZSHRVUXD2N4NFMCEIJ5IZKF2Z
X-Message-ID-Hash: 64MKZDUZSHRVUXD2N4NFMCEIJ5IZKF2Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/64MKZDUZSHRVUXD2N4NFMCEIJ5IZKF2Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The interface name 'none' disables all network interface operations of the
server. It is accepted by the -i parameter and by netsock_set_interfaces()
but the client tested every name of the -I list before sending the request.
The lookup of 'none' always fails with ENODEV and thus the request was
never sent.

Skip the interface check for the sentinel to ensure the network interface
can also be disabled at runtime.

Fixes: 2cca53171180 ("alfred: Allow operating without any interface specified")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 client.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/client.c b/client.c
index d25e3bb..06de0c4 100644
--- a/client.c
+++ b/client.c
@@ -281,15 +281,20 @@ int alfred_client_change_interface(struct globals *globals)
 	/* test it before sending
 	 * globals->net_iface is now saved in change_interface.ifaces
 	 * and can be modified by strtok_r
+	 *
+	 * the interface 'none' disables all interface operations and is not
+	 * an interface which could be looked up
 	 */
-	input = globals->net_iface;
-	while ((token = strtok_r(input, ",", &saveptr))) {
-		input = NULL;
+	if (!is_iface_disabled(globals->net_iface)) {
+		input = globals->net_iface;
+		while ((token = strtok_r(input, ",", &saveptr))) {
+			input = NULL;
 
-		ret = check_interface(token);
-		if (ret < 0) {
-			unix_sock_close(globals);
-			return -1;
+			ret = check_interface(token);
+			if (ret < 0) {
+				unix_sock_close(globals);
+				return -1;
+			}
 		}
 	}
 

-- 
2.47.3

