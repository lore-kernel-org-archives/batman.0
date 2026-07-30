Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1917AC5516E
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:32:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F17181E08
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:32:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785439974;
 b=Dpt/tGcuqK2hF6+spBEc4AnhFL9SwXKcAGA7DgH+qfHN0HeYcYyxghT6Mc1zK4rlrH2yV
 s8M8NMIcFrDc3ne5SJE8LUZIy3Z0KCqN6nfcjh7AdS0KBptAVMRLPTlI49Zcmqc5rDogN/S
 B7p4s+WMoj1mIQuLK/SqRZli7bz8XFU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785439974; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dg2xsyVmQnlip2tF3S3z4gPqCUQoQJ37sojxAKJxFkU=;
 b=Ptxa2i+gSzRNcnwX94j/MCeYI/Nvqfyv+ZEQpG9qXOIKcsaAYbDymcKGPdMvxiHoWtUbC
 bpzpLABrcEmJREpGC8W8v5B44z2Mtgw+udkKgMyt9GTuwcINYqpZipJtlXtGG1Eleww1/Nk
 Vf2Ghn/bP0kFJczxfwwAQbvN98Pt3/Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D36418222C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:32:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439930;
	b=zAabyvuUM4r/sR74QxSJDITj19OACPrvP0A/d+RSPt2vS4o3q+wPSYKwczx45SCof2TQQk
	rp2RyVbcrTIy3F3mVB5exSVriQ5kSL7ONCOX7FGUpaoS91xRMGbzWoxb81r7lWCtLqn8E2
	/BcVHfnM4a/JI5OPlX2feD2vqhHWFww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dg2xsyVmQnlip2tF3S3z4gPqCUQoQJ37sojxAKJxFkU=;
	b=dVTZ8zcJyG69Vn03/Ac+VihdzwNX038JFbi4AuZwAedMM5AcuxEjLopmSHmaLjiKa9CIQH
	5d+oxqdbm1+6ELhjjs96SY0/hG2uFBC1p43WCzfJzL9erfodg4I0uBfVIv+TMFa9V6+lHt
	5RCJwNuxIDS7BZhNeFQaj9CE93lG5gE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=b+otJFK6;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5E5101FD9C;
	Thu, 30 Jul 2026 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dg2xsyVmQnlip2tF3S3z4gPqCUQoQJ37sojxAKJxFkU=;
	b=b+otJFK6LtKkGTHLOtcH5/EKAB9Lo9PaNMDaDuN8yXPnsBBmWL3LSSiRGJCpolLfkcLoz+
	WLhp06aR3CgxkJ7qp15+fCgRTdSEEeRLL3eslptnEy57+G4mAwW0I1onOnUtgyI/Gj+MY2
	JnxY/84xQf1myzsUca1Jye4G1EZp0O0=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:31:55 +0200
Subject: [PATCH 1/6] alfred: keep interface names always in heap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-parsing-v1-1-c0f2ce4764bd@narfation.org>
References: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
In-Reply-To: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=sven@narfation.org;
 h=from:subject:message-id; bh=KZoHMQ6SPM9NoXMvrlYRLcL0dImjkwptDyZlYbXA+aU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9YG9MgYNbbdj/HgDX0aNvXlZfk7F8+vCjoVOGlaR
 8HWoEVZHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJhGUxMjTsip32SW+W6vLT
 5+5vzgrmqPp1XdOG41hyx/voRWGXHscx/NOeFfDiS4LPFZMXm/48P/Qi6asYY575ivPcOh8sYmU
 e6XEDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4Q7E43OCAF22QBDF3GPUYIFNYNN3TQTF
X-Message-ID-Hash: 4Q7E43OCAF22QBDF3GPUYIFNYNN3TQTF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4Q7E43OCAF22QBDF3GPUYIFNYNN3TQTF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The interface pointer in globals was used to store an address in .rodata or
in on the heap. This makes the handling of the allocation/deallocation
hard. At the same time, nothing checked for allocations problems. An
allocation error could cause an hard-to-debug problem later when trying to
calculate the ifindex.

Adjust the code to always allocate the string as an heap object to simplify
the handling.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 9c38fd7..21def01 100644
--- a/main.c
+++ b/main.c
@@ -191,7 +191,6 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->clientmode = CLIENT_NONE;
 	globals->best_server = NULL;
 	globals->clientmode_version = 0;
-	globals->mesh_iface = "bat0";
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 	globals->verbose = false;
 	globals->ipv4mode = false;
@@ -201,6 +200,12 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->sync_period.tv_nsec = 0;
 	bitmap_zero(globals->changed_data_types, ALFRED_NUM_TYPES);
 
+	globals->mesh_iface = strdup("bat0");
+	if (!globals->mesh_iface) {
+		perror("strdup");
+		return NULL;
+	}
+
 	time_random_seed();
 
 	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:B:SEu:dc:p:4:f", long_options,

-- 
2.47.3

