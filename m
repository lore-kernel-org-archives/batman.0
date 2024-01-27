Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8463C46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:52:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 359F283E53
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:52:24 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706359944;
 b=Jpde4I3cufBGDc4CJZlrTJF7Q1k/sVaeeqE3/o4V2YkIudeIqBtCzQGRXjFV7e6q1y0ih
 LSNfgIVR2iWYOEAtFeb9dyFteVDQ3ciEhlHXE9mhliQ5Zw7VshJueYHOGjOzkAVF05wAtTU
 63RNrn3n6EzpXOQyYKQbAnY5JMLYE4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706359944; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MlZqupngQ4hOf43zDc8rcYPDe1chXjmjhx93knF68kg=;
 b=0F1PYiz9TmH8wJMtDLmWfquvXw4gt7jgvoXu2G1IaJ/C4WGdK7LX5ThtsMLI16JglfJfU
 1KcPjk3i3vubxHggan9DGToC129LK2BUh6k6sCJ1iQqw+b6KLk9+FQeyCLuChuAJS8gEPS6
 Y0y2d58I+XiGBuSbfG7PBnL5hz9ycI4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A208983E5A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:49:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MlZqupngQ4hOf43zDc8rcYPDe1chXjmjhx93knF68kg=;
	b=pcHlext+b2/Yn0aw5k4lhax+Tc5E9z4NlOTglA97HRQSBEyIFqgJvlBAxA5nobKRigTHLh
	Y4jgxRHJ2QyWfwFJWbSgfYZqSGg08wgj0GhH+8TO+TnipjRh6F2wnJu6XaIrKU9vuFjEMe
	NNZSbfe4uQCxKAxIfTzsen+WOR8/Pok=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359781; a=rsa-sha256;
	cv=none;
	b=UoixlkKzIrQuima3+FQYzCAcd6xYJBzh2bHuaBFwgjx+7iiN7zGLnmVDGDpfjJpDCUGjam
	9OCvsBYt6kV9+ZKLOftHTUsGRytRvn8GEJK8p+1f7t/zDEFmy1I6TC7whQRGPPSmaEz6pG
	sj4lFvGBNQ9s+lGqMP4o5FfG4JqyyXs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VrgzfNZj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlZqupngQ4hOf43zDc8rcYPDe1chXjmjhx93knF68kg=;
	b=VrgzfNZjYjvLpsNgZYZUL1DJlYfcep8sDSjukSvJxv0CehrzipzgN0D0QGFmr4N9eFt0il
	q5zPh4CrzgmLQhCnjj8hI5CzEqrI5E8RBTlfZRxLTQEwQ0tu7xjpGKDZjIZ3IxvBIupry/
	f5ZRgmUm/3kOJbaWG7Q5Lb0KQXZO0LU=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Jan 2024 13:49:02 +0100
Subject: [PATCH 4/6] batctl: tcpdump: Add missing ICMPv6 Neighbor Advert
 length check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-tcpdump_fuzzing-v1-4-fbc1e1d3fec1@narfation.org>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
In-Reply-To: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Marco Dalla Torre <marco.dallato@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=sven@narfation.org;
 h=from:subject:message-id; bh=0ZS/GXQW9dlNRdAikwA5/iE+EDw6xDBEk5pQNVzuES8=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBltPvhSIGU+W1IxzNH7aoF4hWdZLSxpLEfeJBBE
 0ZYFfRNr2+JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZbT74QAKCRBdhwoHwSZ7
 RtfpD/4u4aD+z3E0A1e5eP0aRK30o7+vJLkr65lLB5VyrbGEUNBqpLdjdfDTeRJQC8PdgPljrKT
 m1cx0m/4wKmEJHEK3miOq6RcKN0ChLS5jjbj0UQWd0SacdSIRqzY+1JdgZu2Xj/vAJVCe1F3Mi4
 JNp/JVIkhLfquJDQ/9wXP3uNj1gA17h1726XSjc3N+7GME8aoB5jo3wGpPbkdiTI+nhIiuezh93
 m11+8sucooKR2IovsxPXpFa/02NHuxDQmXXnbu6kdGtGn6fDT4yLaarM0jkLc8wknWL6qYq3FAG
 /MxO60Wafp2INirzGX0vkJwHsE5rOpOuu4ZDM8mknnmgSW/CgK3ilyA7wTaxd8h7fNOuwhZ20k/
 QGP+Lp6MoOiuwjDpTMrr2HWyYzhAoW1WHT7jMApU9Q5lJSGB+lyHOcRVlP19MzUZrZ+VTHB4ar0
 dy9RXc1RA+bC+40kV3vTD/PgkMA3eiwwno7BwDcr3KVTYrLTt2myVWYrrGv6Sga6wa8h6Y01RRI
 OeiD9RjrcV96zliRKHwBQsg/u/aI8gcyh4Rjp7mgyZhCkKgi3GWpxXStTLCB1RV6Anex5pBo4kJ
 r7moqijq8M7FfRUtgXbnJuDyI9oaW/ZJkm5x0mq2TaKc136Uutj4pNN4N/iih3rNd8Guhe85fp9
 8W4ovDnE6LAhgdw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HZ2HNZZUZWZQ4MOBJ3CMCWACQJNYXGQA
X-Message-ID-Hash: HZ2HNZZUZWZQ4MOBJ3CMCWACQJNYXGQA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HZ2HNZZUZWZQ4MOBJ3CMCWACQJNYXGQA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

dump_ipv6() is doing a length check for the original ICMPv6 header length.
But the neighbor advertisement (which is also handled by this function) is
accessed without doing an additional length check. So it is possible that
it tries to read outside of the received data.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Cc: Marco Dalla Torre <marco.dallato@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index 3fdd7c3..2ae3909 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -659,6 +659,8 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 			       nd_nas_target, buff_len);
 			break;
 		case ND_NEIGHBOR_ADVERT:
+			LEN_CHECK((size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),
+				  sizeof(*nd_advert), "ICMPv6 Neighbor Advertisement");
 			nd_advert = (struct nd_neighbor_advert *)icmphdr;
 			inet_ntop(AF_INET6, &(nd_advert->nd_na_target),
 				  nd_nas_target, 40);

-- 
2.39.2

