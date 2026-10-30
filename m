Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88959606A31E
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=anT1vHvg
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2C28484627
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 08:07:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793344027;
 b=aDpP1P+Ak1rY0YVB5HKmhktoocUj6a/eeUQOCy2JjM7QYZAlb++u3xPX3RmAhgwYPDMLa
 oOqDjW2ECVBrabSKiejaIjGpzlIjGREDvUIGp0cSKywvlxmE+mUwRlL0UwDqRdM+Qvj9EwG
 l/Rtj6A2zdJvwUJsX2rtR54FiRDoMI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793344027; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sQmqYXwhPEoOIU+cSSlto5ZT2a+PGkxqqNn7RgX5NXs=;
 b=EPE7mqDH9V12NPzK5PraI9wIK2IAaCpD7+65ZfkchrVSra5RuC0fd3gysyrRdSdzNJ1wS
 v7OUIKxBoiQV2kYn7fNMzBpgpN6rthmX3pKVmMlDjhEs6eo33AQ09rDgsFmyRA47/xj23J1
 aaWB3QxCxWylu3cgYlqocyTbqX0PgSo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=openai.com;
 arc=pass;
 dmarc=pass header.from=openai.com policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=openai.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=openai.com policy.dmarc=reject
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F125D8143D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 05:22:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793334137;
	b=Ngr4eqCw0K+k5SuIBwDHv50Wkp+VjIUzjZgeYN5CF9WD46VSvBu3nrrnAuaKg+1YlY4Ew7
	gSZ+jVUj87r5TGO/NS5vUqMRh2JLHD1f043TUToA/8tc2ioXLVzMlacgAQEPNHXIvl+KI9
	iu+VzIfAfqs84RjatpheBGb1ligZvfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793334137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=sQmqYXwhPEoOIU+cSSlto5ZT2a+PGkxqqNn7RgX5NXs=;
	b=ZF5pJjSrFpzL2ShXUP6niebZn+KTy/GEDhFPgfjGB0X2jQ9QtcqUPqfumfAqFyJt3PYWpk
	hRZO5AfRRNvuChjs1plalhqM1eUssjy7xn6Pq/ZtWt/jYdjKagJ9aMvxLeSNJDT1gf/G3T
	3hr0YmHwMFGOa4VM6etr0yZUmcyyxAw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=openai.com header.s=google header.b=anT1vHvg;
	spf=pass (diktynna.open-mesh.org: domain of kylebot@openai.com designates
 2001:4860:4864:20::2b as permitted sender) smtp.mailfrom=kylebot@openai.com;
	dmarc=pass (policy=reject) header.from=openai.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4a76f63b243so1275014fac.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 29 Oct 2026 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334109; x=1793938909;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQmqYXwhPEoOIU+cSSlto5ZT2a+PGkxqqNn7RgX5NXs=;
        b=anT1vHvgqoKgob05x6OtYzhFb7haykWxlWJgS2Z5kNfP19AKXV6HUui9Wt2dHzBo9D
         WBe9R79GSY26TuuVox3YW8yYqQImS94xapcmBDB91MSLXPvD2lB6CRFBhsdnGoKKeNoh
         QsJDuRIyJ0NUgPsXESf32olZd4umUmNEl4TeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334109; x=1793938909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQmqYXwhPEoOIU+cSSlto5ZT2a+PGkxqqNn7RgX5NXs=;
        b=S2KFNofu3QwaFr6V/5964AYS8xMJtj7bEWsrC9TNaKmEy3jO2u8tBU0Ohi09WLSjqA
         M7zQnint+m5WZ9OcTK9d58j1MdoLCk6mhA6VdmeXzyPaHVUcIbv7fJL8T+q2y4zubaoY
         tTLqnUS5lkpTyo+JPEZF8cDfYvkoBzyeJTgX47+wfgpdsbZvc19jjSaZeOwenIVUL9f0
         z21NhZPVHzUyBiEyy9ibHVaFnVNz279N2SqAUo8ZGX6dtaOwojGmUm+gFYLnGAby5z8X
         lIU78rQ8weNdTMc+rf1coX5qZAtpvzWEYz7Y1vMIZDNE1S/n7n/SEllHnYfA2/t+wCnU
         Xkww==
X-Gm-Message-State: AFq9FYJF6uCukouZgwTCp3LSZqW00jyHtqLIKLpXdwv68dVDdjCotNuy
	JSeXuLMn5zy1Apda5rl+S6DVV0J/H0C3qHXIm6rnxhzScO9y2HZ+9fP6jioC1NMd3khz694Z5Zn
	6/fjl8VY=
X-Gm-Gg: AYBFou0fkOTS63+UuIOZgMHijquSHLt4sGO5Eb+FUVJmQNuZODVqBlvlXXtmggjZ8LN
	DjMwSEiuduflKLXf9CS9AyQnU7OQFRIELAdYwWSwSyKcm0M1ouKn51sv8mkaoejxIFqdU0ImFXv
	VAiH7BOqiqii/ljD/4eQdaPAupedxACRL5jhoLGUWN1ZWKhM8sM4sQWph8o4RIIlP7avppQqJGA
	1XOCIkJ4sY2FhplIZce3s/BGNzfEdjB2zCG5CTKTZyoGZwDFQiYSqB7UG5kQSprKCVn6rgSijur
	er0L2Ry+ml+h2QJOUIv/T2pDzoiRipo7lc8mQtKvG4m+m22dmrSz1uixgVbk0jED2/wPge2VMJk
	EO3Ts8Wtv+A/in4XHC0zxDp1rWl01mxAgMqnzvNoKFmS6ADNxQroyQi8LHmU6Kx7StF8nqgTToe
	3dElvS4TcIEneQ8BkrOq7gyen5H/U/VHBtsC1ioQQeR767U9iEMcOIL81w74ys2c4brHFKvkHXV
	qVFeOdSLYCl4zvvcqxiPu6lYFi9UDm3eMyfKQh/w67t1o8PLOseUGlklnXC2zWlf70PeYMAIiz+
	wgqAudzWwW1mFo7MchFwXFUPie4mzogmvWZBbIm9OZUZ6jCycPgj05UyE/psk/BdBBso7kmGQO5
	zUsCeNwUjub+kO3AMlMKJS47gyZvHoQ==
X-Received: by 2002:a05:6808:c122:b0:4c5:38f1:80cf with SMTP id
 5614622812f47-563ef9c93bdmr2524160b6e.21.1793334108882;
        Thu, 29 Oct 2026 21:21:48 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fd93451sm704647b6e.3.2026.10.29.21.21.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:48 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] batman-adv: mcast: validate tracker padding before forwarding
Date: Thu, 29 Oct 2026 21:21:46 -0700
Message-ID: <20261030042146.73797-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: kylebot@openai.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 5VQIK2IT6KSY7WGIBB7K4XDXUZUSTHAP
X-Message-ID-Hash: 5VQIK2IT6KSY7WGIBB7K4XDXUZUSTHAP
X-Mailman-Approved-At: Fri, 30 Oct 2026 08:06:19 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5VQIK2IT6KSY7WGIBB7K4XDXUZUSTHAP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A multicast tracker with an even number of destinations needs two
padding bytes after its destination list. batadv_mcast_forw_packet()
currently only checks that the count field and the addresses fit in
the tracker TVLV.

If an unpadded even tracker is compacted to an odd number of
destinations, batadv_mcast_forw_shrink_update_headers() includes those
missing padding bytes in the amount to remove. The subsequent memmove
can then write two bytes past the old packet tail. With no tailroom,
this corrupts skb_shared_info.

Include the required padding in the existing tracker length check.
This rejects the malformed tracker before either received or locally
generated packets can reach the compactor.

Fixes: 2dfe644a1ce0 ("batman-adv: mcast: shrink tracker packet after scrubbing")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/batman-adv/multicast_forw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index ac97cd8b81dc..9ffed1f237b6 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -950,8 +950,11 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 
 	dest = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
 
-	/* check if full tracker tvlv is within skb length */
+	/* check if full tracker tvlv, including padding, is within skb length */
 	tvlv_len = sizeof(*mcast_tracker) + ETH_ALEN * num_dests;
+	if (!(num_dests % 2))
+		tvlv_len += 2;
+
 	if (tvlv_len > skb_network_header_len(skb))
 		return -EINVAL;
 

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
