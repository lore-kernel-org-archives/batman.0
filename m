Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A98EC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:50:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A248284A3D
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:50:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450245;
 b=yeOCFzVtkcaiITEH8L3gJJDO/lpf1XHFUOUUUImar6lxjrD1md+RjB7rRqCF+qjSfhf/V
 WHkNScxuXkb4XF52hU6VgIlFm9f/pim0eU+bjb+Tm2wFyucMTr/MpLW1rYTwG3bxSSObFuJ
 VypQq8cHqUsNSe5v3MvMsTMDsfuWwWU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450245; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=P94ZArtKvpyHdCfaj0ZIyoaNSWZcI/XRLMSCBOcZZLY=;
 b=OzR2bVM6KhStEsGnJk8NZsDFGIxGhcK7T3iCB7mmVjP1pugz2TIpFqgpGpPDzkwwboDVk
 diUFTVH6Qaq6S9emfuSqJkoGEYwk/9IuRBRqmdfzerHqFUJ2tBIv7ezFQOpbqxxtdz6sZ1F
 q1rWmSdllAXAlN9bItpwBX+a/d2KXs8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F241980C7B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450024;
	b=C51NTXw4QQm08Hkm2JrXy2QVyoV3hr1AT1972Rp8jQpHig/lz7WyQZ9q2GqF0ujQSVP1Lg
	oJKmpNu3HZg59mCB+CJ3yNu2racki/IAlK3OKVXV7SSWjSk74GHrAHygxkR1wiccPmAG6m
	S1OCa0IRod++/HBgcuQ/hx0SHY6XSFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=P94ZArtKvpyHdCfaj0ZIyoaNSWZcI/XRLMSCBOcZZLY=;
	b=y6OSEoJo7noXT1fV+8LA0bUH9vGXGIZlBmzEElhqPrbFbD+Nm8cNY8JsiGwyXMitIdm1Jh
	v5ujqM0akk8dkallteWsKTOQ7skkzgaK15fBOqDkPqe2tWjfettPeSQ6qgynJGQdbnQRcq
	YRw0K+VyHpFezoJgCFDHk9M8UPftU4I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bYCsvR8S;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AFEB3202D1;
	Tue, 07 Jul 2026 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P94ZArtKvpyHdCfaj0ZIyoaNSWZcI/XRLMSCBOcZZLY=;
	b=bYCsvR8SJsDc+6hGOKUpUuwSMV/YQBlMQbZ0/RgkcYSxQ2IIP50mDBqP1x4k1HS1Qoxezp
	JdU7FD3BqfptrMsly+LuNHTE+pLR7yLSJmN6/EPtrYUL94XvPpqhVuAa88SV+4AASd9h4e
	iMl1u6jsjkAK+aKRgVLlUshxfwLvrX8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:47 +0200
Subject: [PATCH 05/11] batctl: traceroute: probe the advertised maximum
 number of hops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-5-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=sven@narfation.org;
 h=from:subject:message-id; bh=H4ojzUNkpb3anuk0AacR+ctmqv50LQTsYYozdONB2K4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+ntNa7k5wXz058vGyy/+lrosp/rF0WMy2wdid/SH/J
 OEovfAdHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJCE5gZDj01LD1potXYPxj
 /zPhbp+e13hEfFxbuG1iEt+RvEPf2DIZGfa11Rbz1pXt4arb9Piw3aYv+jPlar+yKMWsbKiYbSm
 swwQA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 65MTHXGUBFC4CJEZW44O6QZ67BTKB6J7
X-Message-ID-Hash: 65MTHXGUBFC4CJEZW44O6QZ67BTKB6J7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/65MTHXGUBFC4CJEZW44O6QZ67BTKB6J7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The hop loop stops when the TTL reaches TTL_MAX, so only 49 hops are probed
while the header line announces "50 hops max". A destination which is
exactly TTL_MAX hops away is reported as unreachable even though the last
probe was never sent.

Run the loop up to and including TTL_MAX.

Fixes: e1c83d9260e8 ("[batctl] traceroute utility updated to latest batman adv")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 traceroute.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/traceroute.c b/traceroute.c
index 975c9ff..76f0f80 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -123,7 +123,7 @@ static int traceroute(struct state *state, int argc, char **argv)
 	       dst_string, mac_string, TTL_MAX, sizeof(icmp_packet_out));
 
 	for (icmp_packet_out.ttl = 1;
-	     !dst_reached && icmp_packet_out.ttl < TTL_MAX;
+	     !dst_reached && icmp_packet_out.ttl <= TTL_MAX;
 	     icmp_packet_out.ttl++) {
 		return_mac = NULL;
 		bat_host = NULL;

-- 
2.47.3

