Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33619C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:34:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A42F581B41
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:34:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783272851;
 b=F+r/87uAvfXj8CEOWC19dh3sX/Pjs9vWeMubxveqTcIR42nYWgzoExHHrfuouPiTP3mMU
 egMrKY0k/WK0L4EsDBlDN63Zv8Gh7CWkOv0/vXFWBZzDMoRl+61/5tAaeBpIDVid5LxxXZb
 gXCUce6OAaa3kOPsalYXSRU2TevbH8U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783272851; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WYyMcoet5lHRQkZ5vhkguejKoPyCUwDcvR+zJlKn0Mo=;
 b=D66G8oJz++brnfdtw2HY5lVkRmNOj0ZTBfOPh5kpmjwxw6S3GVeKWN3oFMuZS+by8sFiy
 m1z0nWBXSUaXHFcb4ccU+WcJr58vvC5fPynWeBUCPSh/PFg2hrlyUTqMTC4SY3oOQiK6D7A
 lw2oKe4jSHkiU0n8ET0Gc1nC103/exY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 07C7781712
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272621;
	b=jmqeF5U2oF62i7M/YnTW4pKnWU5jj/oCtJSeTKX81KO26xWN2H4ydaw+6CxAj5jYI5sTz+
	+hP0WRxl/xK4VG8xQFykL1p5EmR40YOUbdomRMto0Y+zrM6LFu7s/u6C+aiufnHpIgsPlz
	iPPak64IhpmdRsyrt1TG1K/Ri5Sd/pA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WYyMcoet5lHRQkZ5vhkguejKoPyCUwDcvR+zJlKn0Mo=;
	b=tUkKpyxhXha2oPvGQoJfoTkSNgHVIdtQhuqS90ePlIHlFWwi2xUKWTmoW+7He7ZrMuU2W0
	dytfnKn2BHTfyZh3OQVBAyX8gEVK0ISVPgAUd65oTsMCiPAIMcC44XOlKIc7xny8ywg2Xg
	7ZaWyi6LruXgCQ4RhWG7sMxOfiyOUZw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Z9vHDbW6;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B6F511FEE6;
	Sun, 05 Jul 2026 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYyMcoet5lHRQkZ5vhkguejKoPyCUwDcvR+zJlKn0Mo=;
	b=Z9vHDbW6z6nnjqI73aWO5kVdoO/c2BBjmh+3i/DesGqlAuyYpp/64qQWVvVHHjKgzK9lwI
	XbhMeRfTHUWpnfqzkeqS3npa70TfHxcX6YjztUricUJMb2T5F9I51izePUsEm4CW4tcbtg
	jqXR2FaZEQrviecBGG3Z7hBHhtAv5oo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:08 +0200
Subject: [PATCH 5/9] batctl: tcpdump: print the unreachable host for ICMP
 port unreachable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-5-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=sven@narfation.org;
 h=from:subject:message-id; bh=vML4ZjufpCzLBzDU/EOvnReVDgulJXt5bmLBH0PwF4Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+ad/GffN+9q3ynu+xsYemotL8v9XT2/bcIhpy1zm
 axDhOf/7yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMhOcYI8O8VPmP67YdEZjW
 kenr/vWQtkK6+9Ym8wc/MyaL/r/877stw2/W2r+eyXOFDth77N8wSVn4+cOOpSyBwg897J8usyw
 6spMfAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: F3NXPVFDJH7DBATSACXWDO7367EVNJCJ
X-Message-ID-Hash: F3NXPVFDJH7DBATSACXWDO7367EVNJCJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F3NXPVFDJH7DBATSACXWDO7367EVNJCJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When decoding an ICMP port-unreachable message, tcpdump prints the
destination of the ICMP repply packet. The actual relevant IP (the original
destination) is only in the inner IP header.

The destinatin IP from the already validated tmp_udphdr must be used
instead.

Fixes: f08a28dcffb1 ("batctl: tcpdump - fix IP header parsing")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index b01581e..c532ad1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -714,6 +714,7 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len,
 		    int time_printed)
 {
 	static const char ip_string[] = "IP";
+	char ipinner[INET_ADDRSTRLEN];
 	char ipsrc[INET_ADDRSTRLEN];
 	char ipdst[INET_ADDRSTRLEN];
 	struct udphdr *tmp_udphdr;
@@ -770,9 +771,15 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len,
 
 				tmp_udphdr = (struct udphdr *)(((char *)tmp_iphdr) + (tmp_iphdr->ihl * 4));
 
+				if (!inet_ntop(AF_INET, &tmp_iphdr->daddr, ipinner,
+					       sizeof(ipinner))) {
+					fprintf(stderr, "Cannot decode unreachable destination IP\n");
+					return;
+				}
+
 				printf("%s: ICMP ", ipdst);
 				printf("%s udp port %hu unreachable, length %zu\n",
-				       ipdst, ntohs(tmp_udphdr->dest),
+				       ipinner, ntohs(tmp_udphdr->dest),
 				       (size_t)buff_len - (iphdr->ihl * 4));
 				break;
 			default:

-- 
2.47.3

