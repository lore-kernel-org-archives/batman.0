Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90BEC46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:53:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DE6F83E5A
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:53:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706359984;
 b=I4dWtLOHPYaUqLYhcJTkty1vp5CqKKHofLr5SLdkdZrDaHQzLZW+wsRJmbmk77pmYTTSZ
 uyULLnKVCircUfu0NJiAKvi0HnTkrz6rRa7dXy29vjhHU11v8aYrw4JwgQ3WWeLGmqtgXlw
 ctFbHe6G1qqGLi/1aOF2yPilluSvxa8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706359984; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UtlVVIBjOyaz/zwofisz1CbBdPe+cnIjnq9cGan2Wv4=;
 b=S48QiTbkajDsM6LwrLb7rR/GGoP0R6DJCI/1Whx6FAZxAX6IfaJtcQH7euF0JNn1SLtC2
 7DFkN++UjnorXohVgtd1cNMtJ8q4O4yEMbVGp9X6YknZ+Sp/WTdbYE7Tfbt6JbD4UnlVYVI
 UlqUFTM0CM97tCyv/Qfi4Cgf3AdhXt4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 35C3D83E6D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:49:42 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UtlVVIBjOyaz/zwofisz1CbBdPe+cnIjnq9cGan2Wv4=;
	b=26BEhnc/YDkVpYcpuVLOzWxBd7SF+dE4KIM27uKB1UqA+ujMjZo5yRuvMgBBg4jJLjmIwQ
	aGu4CrXzVRQ4Ac7y4pQ4/Qv/AO4sdL6ygORByj0a7189LOxXON6xpGWF9/TDwV+5ZWWDOJ
	9BPmeMTOVjZa//LtxssH+fhYVwrYryQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359782; a=rsa-sha256;
	cv=none;
	b=3hqIYeXpytFiWVYeQRmywc1uD2fQdQVcpG06XwghpE++61+7dFXqVBlPa0y+Ew24skrbxq
	6M4LhxMJkssTEp5IbynOj6whWLG18HCv+oErjUoL3kwuo66yFYDCRvJep7d0+Yqe5Dvqfe
	hU+O89ftmhPwUqvrtgIyZoeukUW78Z8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zh+7ICPs;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtlVVIBjOyaz/zwofisz1CbBdPe+cnIjnq9cGan2Wv4=;
	b=zh+7ICPsB51Km+rUlskuwNrIHa3TSsPailY/YzA6jn3U3dqE/VjSQK4HQ4vGhFJyDes0+s
	/cuT57TKzY4H/rGIyEicKwGLNX9h71z9umGC80Vy3gzqjZ1q4e7vVpRASW+tIwO/K3N5M/
	Ov4m9tFtbmPoqrXRPK0GbrgDTRjL7UE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Jan 2024 13:49:03 +0100
Subject: [PATCH 5/6] batctl: tcpdump: Add missing ICMPv6 Neighbor Solicit
 length check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-tcpdump_fuzzing-v1-5-fbc1e1d3fec1@narfation.org>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
In-Reply-To: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Marco Dalla Torre <marco.dallato@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=sven@narfation.org;
 h=from:subject:message-id; bh=G/U1H+Rg1xLdnGXamIZwhWPkTTGXJR271zLbL2RH0t4=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBltPvhwxbSGBUZDDvPGiAa1MmXcpEOaoL6t/9GT
 Xd3T0rpfACJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZbT74QAKCRBdhwoHwSZ7
 RkbHD/9YtGwDSkIH2VLxpb/2A5pU2gt13dbIaSqwNwiSsl5uoyiPxP9QwQmUoAbF75MvHPPgbTU
 J3u1l0p0QiTd1+VIeaM6DOlr0g1/M2/pWAiJM2KjbcKM2jg1D8hnNJrNn+a0ft5oN2zsYlGBRT9
 XTyn/pOp0dyhkTdsOkp50bMvCdl5x5+5bO8pKEVDW5P/ivyaEeGTHWJb5ciLBeq35dLeeFS7zWf
 zh9aThcSgwtd6odbcCWrr08OCpZWBO/vOSHMrFMrtgLXjL0jvcfRx1CIvjB05Nza1dIC258iYev
 EVeCiXy14hYKgn0a/M175Pfz0wGHBqOpaY5QCtISsS9PTZRE7pljutr96DMIH/8saiLzbCi6RoE
 gyo6yPP5+CuEb+QkSLlqOzymzU8+dfHggp5Io2puiwH3qfod5EySa3AALxSc9HKWespi8UTDCyQ
 D+POQX0VFtgXBOJ5VGPwzHx/zsp3mIcSrEcew3419FOAgd4SUA3aud89Lpk+sBHD5dTWOm8FYKG
 Xa0oK5eLW2xaMV8NvzkVlS6aVwu8IoZ15yitDYf6SF6xVfH93OQajl3fvCIjnjD/ezSJYkX5BJz
 fUIFFeblQLDrBJ938Pumw7ytZTHhkaTQiIzsv1cnGTDteLa018P0WhbxuE/6SK/69WU6r4V0E21
 JgSD8m6uo//zRDg==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5JUZGB27ZTH2JV644VZZANGURBYCZJ4C
X-Message-ID-Hash: 5JUZGB27ZTH2JV644VZZANGURBYCZJ4C
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5JUZGB27ZTH2JV644VZZANGURBYCZJ4C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

dump_ipv6() is doing a length check for the original ICMPv6 header length.
But the neighbor solicitation (which is also handled by this function) is
accessed without doing an additional length check. So it is possible that
it tries to read outside of the received data.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Cc: Marco Dalla Torre <marco.dallato@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index 2ae3909..c253755 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -652,6 +652,8 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 			       (size_t)buff_len - sizeof(struct icmp6_hdr));
 			break;
 		case ND_NEIGHBOR_SOLICIT:
+			LEN_CHECK((size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),
+				  sizeof(*nd_neigh_sol), "ICMPv6 Neighbor Solicitation");
 			nd_neigh_sol = (struct nd_neighbor_solicit *)icmphdr;
 			inet_ntop(AF_INET6, &(nd_neigh_sol->nd_ns_target),
 				  nd_nas_target, 40);

-- 
2.39.2

