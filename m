Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB0FC46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:51:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5D02A83F26
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:51:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706359864;
 b=GOdU+lPmtDXYnfx2b8lG6oBzIgUN7Y2ECVOqV9PVcD+b5fEu5NJXjFSs/hx7ZPZDmBzJ9
 RWrFdSo6lzB8W68gu5wsJ8KWMHLx+ddr9wsBCENQklL+fPT0kubQYAGqYyPB9zTE6yt2yBG
 OS/K7kn2WO1w+T5opRskzJDqx2uXY9k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706359864; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VEKUmSptcAFbw63kMDxylosb6Nfy3BC46rmfCgFDenI=;
 b=lRB8ihy99wU4tgQJJASlP0GPhj1YCFbWTKnehZ5T0dY4OeUv2xpahosxlIrGjK539t71p
 mHPuadgcNG5myVT79W7w5SVHNKV2ahCu2uSGqQ7kIBeXPeLioK6aCUAWri2KoY/e/s3hQ4v
 c6rpzKFVimemgrDcy+Jpn2+MbOl0hug=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9493E83E50
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:49:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VEKUmSptcAFbw63kMDxylosb6Nfy3BC46rmfCgFDenI=;
	b=jtU8Yj7lzNK/cz8YNzsNcMs/eVPP8cDFdebAdrkYqC5lGAvAXrQfz5XiqGy9CHrrSReOVI
	hXLINVEYOr9CxkwUiicSkkdIsIJd43eH3ksqgTNp6YDNP3u0QMidYjJALpd35EIV/7UIxb
	ylRV+XxlRjZrO74nj8f8C1ik9zIzERo=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359780; a=rsa-sha256;
	cv=none;
	b=X8eEeHW3HQyyoV76fcz1285toUSL2xFUr1viAIMtjb0FEY99fSNK7rzZgpzu8J/33WYOjB
	8fmUiD/gqpTtKwwB1PyuJ7hv8h9H0x4+A5C6JWFSUB3AaX3vbRqt6lvHBJ8+p1rle79yBj
	c00M54ryrDH6k3mBDWDL6iQXHpbiPVY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kTh+VrRC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEKUmSptcAFbw63kMDxylosb6Nfy3BC46rmfCgFDenI=;
	b=kTh+VrRCyxtwLvZ11Tl+vGObNtsHMFsSM9072vWX/GmsnPI/weqa9P8Kx5H7tWNv7ZaB9/
	kCeNEbgS9Gq/S/2kpCS8X1gUfRf/B7XJmXwz+WhW5d+99cspTBROLxTJZaEnxJpDGe2iiJ
	VqkhdlwJLjWP0pYEBsFPqRHvvKZcDTA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Jan 2024 13:49:00 +0100
Subject: [PATCH 2/6] batctl: tcpdump: Add missing throughput header length
 check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-tcpdump_fuzzing-v1-2-fbc1e1d3fec1@narfation.org>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
In-Reply-To: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=sven@narfation.org;
 h=from:subject:message-id; bh=7wrGpjc1T1ftj6xlo9ovUP1bb+CCPI4G3XrkPhbuRoc=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBltPvg3nRz4JX6GrZpFb2Rig/WIc/KKYh60LpMH
 Kp8txXKLlyJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZbT74AAKCRBdhwoHwSZ7
 RqOOD/4gXGXxuxH0bvQIvvt1g55kEEmSYGMeE3j5DL5ldlu06+3W/Fpy6FCd/iiAkQI8ciEpOKD
 OaZ9gBSyamQwNiadjyLPX2MxY3PNPX1sDnOtaRZYIyXwazAvWpVth++nhNpGzizL5yJa3cTGZ+5
 ag4wFQeoi4/VqKF12IcBOL+adC2el4SlCi869bLCk9VEpqdvWmPIGvYfgNWf3EiZ+sGAiOn8/HH
 OXVvEoMBmxj7m96ceahyvQc1gYgWaY7HEMVKWAOKyJtbk0NTEjaZzbWjBZIRqNzoibGM5clqKKU
 msh0OcQKUdhYDajtf05fLyKt2XD7c2LEnnYZi3y2DEtypeQgFXuH61i6Z4aaPwQwya8kTQ2/mQB
 Rteu6BqkB7DpqZw3YYAVqjafdbkbiMy5lwkVfxS0zHubz7217SWdeW0OHeIYcYM/2c23h8b2Zxm
 tCbTYyVyDTRo7hygVTJ9he5IT7R3L2RgbZsgp6XfDSaLZv4kdg1VpJuubzK/vHsHVrfNVfgaFwa
 mpVhznunPB6UKvl2q19mwsUAKL74FUuOAuiNUZYiYsBdCK4IHAtg7pJtkgwTj6keDnPvHl9Qy8d
 O4wB/mOsT3xsSoP+q1MSIigwjdsDX0STo47WL1WyM88fJVDQWeZV+/Ud4jRMrVBnytr65WZJYEK
 0nxDG400bfnVRHQ==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JBSX6CDCJSYXKYSIM4YAICYHBOQRYNTS
X-Message-ID-Hash: JBSX6CDCJSYXKYSIM4YAICYHBOQRYNTS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JBSX6CDCJSYXKYSIM4YAICYHBOQRYNTS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

dump_batman_icmp() is only doing a length check for the original ICMP
packet length. But the throughput packet (which is also handled by this
function) is accessed without doing an additional length check. So it is
possible that it tries to read outside of the received data.

Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index d15c32e..9bb4b9e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -911,7 +911,6 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_icmp_packet), "BAT ICMP");
 
 	icmp_packet = (struct batadv_icmp_packet *)(packet_buff + sizeof(struct ether_header));
-	tp = (struct batadv_icmp_tp_packet *)icmp_packet;
 
 	if (!time_printed)
 		print_time();
@@ -942,6 +941,10 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case BATADV_TP:
+		LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(*tp), "BAT TP");
+
+		tp = (struct batadv_icmp_tp_packet *)icmp_packet;
+
 		printf("%s: ICMP TP type %s (%hhu), id %hhu, seq %u, ttl %2d, v %d, length %zu\n",
 		       name, tp->subtype == BATADV_TP_MSG ? "MSG" :
 			     tp->subtype == BATADV_TP_ACK ? "ACK" : "N/A",

-- 
2.39.2

