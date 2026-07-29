Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A28C53200
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 06:27:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 084C3817DA
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 08:27:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785306454;
 b=GZFkC7Emci6RIKz2tOBmulWnH+X1i2KD+ApFgOHHA0g9ctsmwB1dSDVmJX/wRXccGgD97
 EtdPVLu6imKMtLJ9QQika97PQpLn/5XO8++xCniq/4NQIbSGRBZ+oKFzhRK3dhI0eGQh8tC
 o0JUZ2RLuuxsQTmnqMGJ1HKryNn1hKk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785306454; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jacbRSOvQvaNzszTIciTH6Vcms6pgwJIAVtr7y5dYGg=;
 b=nAAwMM4gqj7QJgsPhG68cXknDIwAl+ELWu9MHzOQQIAEsiqj2psbbN8DqQhaEX0yVequE
 6qXDNU+dQEz66+Ei72+WGRy5Uji5Lfldw4zg7/SVPWVfVU8b0Zyj+DYllWBFMdd3JuYomye
 9dKXBK6ijzHjM6rHvTclQJJbTfBBtPs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B985A80C84
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 08:27:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785306431;
	b=S2KXgg/JSQyA48y3FWiQITCDvHXciZ7NLI++fzniSMeoKAKLK+fPNji6qOCIW0NO5Rri6G
	+vqDqQT5d1OF1em3t4er+p//hS+2HPKJvfFqM37gN7jU5nwMkpUknLeqLnglj2EEf0HUwF
	C5fILvnennVztG2IRVA3rxuBxHNZLsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785306431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=jacbRSOvQvaNzszTIciTH6Vcms6pgwJIAVtr7y5dYGg=;
	b=j5VmN3g7QFv25KX2/UlUleYU/f8DsxgMWK88NKuhDDdqz4/9b2BmiD/g55CoRW+tBLfnKd
	WG4G+oyPBiLK/59qH+OpCrsgkKezyh/vUU8MrkaqtwgW3YJoyNue5qCYdKQbLdYbpvWgFJ
	gKTkhcRL0FgU8bwhxuXk0koLtV8+2FU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=b8a+nvL0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7F1D8200C4;
	Wed, 29 Jul 2026 06:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785306416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jacbRSOvQvaNzszTIciTH6Vcms6pgwJIAVtr7y5dYGg=;
	b=b8a+nvL0COnfKkegM0Ewyh6uAY7pAebJO2066xvFof1X7RPRav4X0EedldqZrdwlpPWpoS
	5a9d1Cs8aFLRlwttMmkjGHmyn9YkDRhq5O1P3Hcp9FuiRUt+/YNn7BShQEJq9FJgS3Yd1H
	2gJGo1x0b95rTnyZAkIgIJWLROJmnLY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] alfred: libcap: random fixes
Date: Wed, 29 Jul 2026 08:26:27 +0200
Message-Id: <20260729-bugfixes-libcap-v1-0-23529745c828@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOdaWoC/yXMyw5AMBCF4VeRWWuidfcqYqE1GBGkoyIR765Yf
 jn5zwWMlpChCi6weBDTunjIMAAztsuAgjpvUJHKolyVQruhpxNZzKRNu4lSplmh+qQzsQRfbRa
 /3Ud185udntDs7w3c9wPN9aX3cwAAAA==
X-Change-ID: 20260729-bugfixes-libcap-915682f4dc31
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=sven@narfation.org;
 h=from:subject:message-id; bh=CsrtpraB0oy0mhn8L1nr2PpPu0CBiPm/6iQwVQ0z520=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmZc5XKnwZ5MJ40b7pZkbX75sJJ83777bZa+cfyxyyhv
 99eVZ/17ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJOwQw/+iQ3M+RwYvf3ya
 wZxf4rrRnCVsK/naPsYuqLI9635Qh9GNkeHBBPUJXJ8arjQcCExxd298/5Zr0kK+eIu3xbEms7Y
 /M2UDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GZA4QC7LIGM7EGZQHADHWVI77KIHA6Q5
X-Message-ID-Hash: GZA4QC7LIGM7EGZQHADHWVI77KIHA6Q5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GZA4QC7LIGM7EGZQHADHWVI77KIHA6Q5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the batctl fixes, I have now compiled a list of potential fixes
for alfred. Instead of posting everything at once, I will be posted in
smaller chunks. They are just various (mostly minor) problems which should
be tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      alfred: drop CAP_NET_RAW when binding to the device fails
      alfred: free the correct capability set when cap_init() fails

 main.c    |  2 +-
 netsock.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260729-bugfixes-libcap-915682f4dc31

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

