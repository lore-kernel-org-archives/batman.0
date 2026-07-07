Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6BC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:51:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B6DA84578
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:51:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450297;
 b=qojbSLN9sVubha8cv2xvoRgZErXhhG9N+4U/xyVGyTuPM2V8E7/yWMqF6nJ4XkOYEXGL2
 NRasE5fDEo2yesJFb7ObZeJQzGMBWuccg+2nHjngw2rkihYswkW6sBDdjP25yxvFYyZ6vd1
 Gub4L7trdzgHCrnU6LbeV44ucF6fnOo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450297; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=o93JsEmA6kjPCBHab1eJvAj7A1yxTeamAT6/6n0YQ8w=;
 b=1NrtAacvQuNQA9zW1vc9c0aJ4NSK3JmRjhb28N8x7xW9+Yz/4FZ9GOANmDsVZZths2CxD
 BtOIo9lDB7OEgDaHZhXIldCY+VOPg2QeUM7U5gX5qw4xW3cdAfq7FXLhB3hl0lqbbIB4Hed
 08IPPpvDDGovw4R6hZBSy+FcvMADn80=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2E268810E8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450026;
	b=Ljaah45XvXujyPEeAys/5yf6xtSJHcQUFsh5irxV4SE+ip9UYn43i0OWBZ4Fvlyi8jeuVO
	DZrZ2sh08DQGkRoOULdG7nJoNKnVji0pW+d59C7OlgjlNJIodHi2Ju6cPM0YtI8zR3yjlt
	GfN0VhnVXHsKBPl9M/xYRhcIYgJt1Vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=o93JsEmA6kjPCBHab1eJvAj7A1yxTeamAT6/6n0YQ8w=;
	b=Qy1Er5gfg1Fe90sxiPqEdzK1li2R0XnsUNzqPnp+18+by5Im6S1vvYtpHLK3b0C/+X7Pmm
	a1NhJ8Yr4EYoM/FR3OW8+IvMbpjmtsl8+BeZWTTSivV5w8Uc3nsJUWRIxPHBm9Ia8d8Jrj
	CjzKUjdWhfIWau7gHwLyGclLX72odso=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="JhKs/gLT";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9E973202D1;
	Tue, 07 Jul 2026 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o93JsEmA6kjPCBHab1eJvAj7A1yxTeamAT6/6n0YQ8w=;
	b=JhKs/gLTPaqFDW8r6xNl2cTKm1pqHAs1hexUzila0DTTYMm6WMV0rLiO7vcasLHE2V9n/Z
	qXvvus0Z01DCyvOFKa07MIz4iuVTPa3MSKrVdJnaaAdzSI4OMwHWKxO2QtgWkDE0PnTFhw
	1dMQAZQq9EOrBjHroB6FAubzEZNJaIE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:48 +0200
Subject: [PATCH 06/11] batctl: ping: keep huge '-i' intervals from turning
 into a flood ping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-6-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=sven@narfation.org;
 h=from:subject:message-id; bh=b9XZ8ZGKNlFeHZJL/A4Wbi1d1FI9NcqO2WoudaBjEYg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+ntOWaC+8ysHgsDxDjHft7rV+32eKJ07UyTxyes7j7
 UvO31kX2FHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYCL8zI0PTHU9OyZOXPhy7
 dm5ewfH0W66bLsttXCLqvadnTt/0e1mHGRmee06r7E5rKWs8v/6KWZ5p5a7Y7GVuwscd1/v9vf/
 qXDYvAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CPNSL6KZXSD57WRQ353YXOGMEHWR34XT
X-Message-ID-Hash: CPNSL6KZXSD57WRQ353YXOGMEHWR34XT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CPNSL6KZXSD57WRQ353YXOGMEHWR34XT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

strtod() happily accepts "inf" or values like 1e300 as ping interval.
Converting such a value to time_t for the nanosleep interval is undefined
behavior.

Clamp the interval to a well representable maximum before splitting it
into seconds and nanoseconds.

Fixes: 4ebe4fb7b08d ("batctl: ping: Add subsecond precision to ping interval")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ping.c b/ping.c
index fcb8d5e..c875c38 100644
--- a/ping.c
+++ b/ping.c
@@ -106,12 +106,14 @@ static int ping(struct state *state, int argc, char **argv)
 		case 'i':
 			errno = 0;
 			ping_interval = strtod(optarg, &endptr);
-			if (errno || *endptr != '\0') {
+			if (errno || *endptr != '\0' || endptr == optarg ||
+			    !isfinite(ping_interval) || ping_interval <= 0) {
 				fprintf(stderr, "Error - invalid ping interval '%s'\n", optarg);
 				goto out;
 			}
 
 			ping_interval = fmax(ping_interval, 0.001);
+			ping_interval = fmin(ping_interval, 1000000000.0);
 			fractional_part = modf(ping_interval, &integral_part);
 			loop_interval.tv_sec = (time_t)integral_part;
 			loop_interval.tv_nsec = (long)(fractional_part * 1000000000l);

-- 
2.47.3

