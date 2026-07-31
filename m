Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77588C54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 15:47:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A0DAB84009
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 17:46:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785512819;
 b=rJUcVixbLr2O4paJL0qrfoCDJwQHl97wwDPTh8iFDOJ2gQh1Wzl9239gi73CI90db5tMW
 WQB0IWcT7wSoazcM+lZ303tg1H24zRD1unBe8waTy48r0dgiN2GJ7Oaxd637xnrGdt3Puyb
 h4LaPQfJ7eLzf9RNOxhJg91BKED8JuY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785512819; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MO43kmEouNW5qoq3aEkPpvoWPmCMhYfaHUStNrI3Lug=;
 b=3qpgxSToW7AQH1/tbEaz6B02o51L8/87js0auflcCyPezZ4thEb6d3bMNleFI4QHY+wGZ
 73L8x5pu3Uzf6tgEPnJi7TBhlnJ3OLPBvQQ419OBrOvPyyP2aAepJoqSbJvRbB+bZTq9gRO
 TFPQjw1YJxHnjqP9zv7JfHGrzZEYuN0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 80D618272B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 17:46:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785512800;
	b=Tucs8JkgQAciHlqwX9AqAtREgt+XYqjoeciQ6ioLBw0ajhPpc1r4z9oYwBTQpImYGIJyQV
	rbaO1NNqys2QqroSR6AvC+XESyLE62J1wCqK5It8Cx813vIhBApcFMqaoT3QI2IQ8BpBhq
	7ff+XIHdxQfn/M9JhHvL2o7nukGKP98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785512800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MO43kmEouNW5qoq3aEkPpvoWPmCMhYfaHUStNrI3Lug=;
	b=VaG6u6ildoIHpfIY22uxqDyYCGuEB20ImqRpFUF4orxEBZOn/HZ7ciIimL4FgUfcyxTYAC
	dif47Wo7g2FzJ52cj4jPAIY0vpfALZ8qf/6weZ5FgYMyiZj5LUsuD0WS/8A2BbnI/l3NF8
	tPa3vr5HdIMpd6iDuubtY4P4Ba/Zqk4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EeFcxJfD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DDD7B1FE4D;
	Fri, 31 Jul 2026 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785512785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO43kmEouNW5qoq3aEkPpvoWPmCMhYfaHUStNrI3Lug=;
	b=EeFcxJfD2i868HjbnjtloACLRjUDDelwg0KuLkAPXiB1EGZVuyvweZ824E/Him1tTDeYA4
	2gAhMtbhlk2Kr1vQSpNb4ijAsJiKI6GGonpJVShkFVq4R+RjMsQoMf6Gg+lpPYmbHlhYxu
	IxA44M2bnFziPTF1WbPbY/PxlzLHseo=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] batman-adv: reject unrepresentable multicast TVLV
 offsets
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260731135222.566367-1-david.lee@trailofbits.com>
References: <20260731135222.566367-1-david.lee@trailofbits.com>
Date: Fri, 31 Jul 2026 17:46:08 +0200
Message-Id: <178551276852.62695.13954065440231922020.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=236; i=sven@narfation.org;
 h=from:subject:message-id; bh=ylZa4NMyLyYEioSms6vANi+Khpsqd8shdqqKxTYHhoM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5h321PxnLPuwR3FNyfGdOZ6zEzB3vj8R+T4wwfWnX3
 JSfOvNgRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi2fMY/qddnLyH4/xKu4XJ
 J98bOdxNP3HGiuXJ/9msh44XzXm/1FqQ4Q/nkiCW3yK6sfxKC83k4l3VZ3z2Fno77e3N55wvtv3
 jWscIAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OK4D3GDPMXMFTA2XVDAZYREOIRTI2UNV
X-Message-ID-Hash: OK4D3GDPMXMFTA2XVDAZYREOIRTI2UNV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OK4D3GDPMXMFTA2XVDAZYREOIRTI2UNV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 31 Jul 2026 13:52:22 +0000, David Lee <david.lee@trailofbits.com> wrote:
> batman-adv: reject unrepresentable multicast TVLV offsets

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
