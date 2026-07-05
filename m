Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFD5C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 15:55:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B89E83DDC
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 17:55:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783266918;
 b=a4nZwRBi6RqxfIVFgpgjUTQCxZyhuNjHMmP9OadLS/g+viLVr0IsiSNrCuYhqA4hPRP5F
 M6XZdC2BQfxge5V4uBJnofjVyllHhll29oWtfRJU0CdRExtU/xWfdZu2Z8rCFiGj9A3+tCM
 9LRkmCjaM4w9Tq6+WN38GT2UGOZqGOM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783266918; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=07Xusib/tRUzDLRjg/lDQ4D/ZfnR68emeD+ovgQaECk=;
 b=toiZo6r6ZWfhshQ8OaBHiF/WdQgPEFFAgh56czdxYLmVgG4Pxok9YfGqVXStST72QWqf4
 4ggdhHtKWXgRkKSfk0WnmuKOwjc8lD47XeXo04hA8sy2MjJkuz2WGWtsMSlTRhtc/107ojx
 H7qZdcvsQOpvGHr9pv7/Nt+CguuYv7Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B5FB5818C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 17:54:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783266853;
	b=M0NPISQUCGTvZpUPdTWOW6heLFMplcqcaD3vMV3KcRNtsX/n1O+eNmt6YPBQWyqpVMPvwT
	2fQYY+1V8oqHblY+6BAD5lZ8YiLosgUV7rDu3kcIT9cxs9GVPLp6a/2WK9crhCEvOo67di
	Y3dlRMfRifK8ZMf5Z/oK/TBzgR7aST0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783266853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=07Xusib/tRUzDLRjg/lDQ4D/ZfnR68emeD+ovgQaECk=;
	b=yZiT9qn4fO1npT0xx8TLTzQv7WS8fPVAeYnBmVvmFbcLeHbYVQ5p942GgrZ0Da5znrs8Pb
	3W8PywfkAop1uc9Jjc8g43HluDHwMTGTrxk8E4sMFKO/lpOrtoE7wbl8GoMD5wyOXqJN5q
	EGIyc8N8iblEEMBCVtgW8XNyAXnLkak=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mSQI4nww;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F3FED2054D;
	Sun, 05 Jul 2026 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783266853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07Xusib/tRUzDLRjg/lDQ4D/ZfnR68emeD+ovgQaECk=;
	b=mSQI4nww4cRDgHrT+d03M0Q5Fpxg+iK3xVKlho6KhlTKCEaL4JU7vg5kBgEOWndhnAICcd
	U6Kma5lEVoV2qvn0jeMG+BW8FXwPi4IodOWwmfRsQJCpnp4El14m11m79+V4c4A5utbpUU
	JMc/V3tq3V/UHsjT5/eP8ZSARgQ/LIw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 17:53:37 +0200
Subject: [PATCH 3/5] batctl: genl_json: don't return negative error codes
 to main
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-genl_json-v1-3-8cc79129012c@narfation.org>
References: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
In-Reply-To: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=sven@narfation.org;
 h=from:subject:message-id; bh=L0x9JXX6mWcMEZ6PDiChob+hSMmzJSY1VowVKskihrs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFledfz2Em7/D71ucxPt7bv+6vR5xrtbrFnymQu4LLRsV
 zuHeSV1lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACaips7IMDvo1pQfooZK8o+T
 vy+LKk1Q2T499vqp/rUbPBy1Z3I7JTL8j5FesJOzbcW6CMXItC2zjzbdvyx3Z+my6XPu3Tp53fx
 MEgcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QKBJUKV3ZWA4OFYAPRYGZ2EEV56WYPYV
X-Message-ID-Hash: QKBJUKV3ZWA4OFYAPRYGZ2EEV56WYPYV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QKBJUKV3ZWA4OFYAPRYGZ2EEV56WYPYV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

handle_json_query() returns the result of netlink_print_query_json()
directly. This is a negative errno code on failure and main() passes it
straight to exit(). The process then terminates with a mangled exit status
like 161 (-95 & 0xff).

Limit the return codes to EXIT_SUCCESS and EXIT_FAILURE.

Fixes: 57cc3c472a7d ("batctl: Introduce handler for JSON_* command types")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 genl_json.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/genl_json.c b/genl_json.c
index 356c5d7..917b255 100644
--- a/genl_json.c
+++ b/genl_json.c
@@ -600,6 +600,8 @@ int handle_json_query(struct state *state, int argc, char **argv)
 	}
 
 	err = netlink_print_query_json(state, json_query);
+	if (err < 0)
+		return EXIT_FAILURE;
 
-	return err;
+	return EXIT_SUCCESS;
 }

-- 
2.47.3

