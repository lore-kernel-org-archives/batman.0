Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFBECD3427
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 21:25:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 478B68537E
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 23:25:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777843519;
 b=rQVk+fWmwi8SNptUUw9vmIv1Ezu4CUqusrJHffWZUvf9YEKVVLd99DDHzP299lbQOZOfa
 MjI78wiIiFf2y0wf3xCa572/1DKkd3lUjAXzzECDx80ef6zGIkO8mDBNbxPj/NVKxJX2Hti
 NG905KOeYOQIoiDP0CRyW/YK5DCOqqU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777843519; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wNIWGuJIHbUovJaFu/ppK4rRJ4ZLzcU720XhRAu7lQ4=;
 b=CVonvfiAEenWwV0VFg5pCjrDzQKvHhjL2eG1vttk13z5KCNJS5KXx33fTMbx1O56fN1wR
 FVp97u9JKA/1f1kFtj5r5Gl1ZKqxNqBj++0bLXuf/GIhjPuAHEU4YtBYmlEuLE6xzOWqeZe
 s0ImPpW3p6QRMGBuEfbXimXGVV8qODM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=unstable.cc;
 arc=pass; dmarc=none
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0085A82E69
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 23:25:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777843514;
	b=ALlz9xCXaU8NUcK8TGaxzxXP8Mqs74G/na0Yuiso6Kp9lW9mztQ9CadIcmV7p1P1cf8gSj
	ECIkcCB5rWQ8FXfFK2y3wfmiwO1Kw234JscrvgUg1cql2KnajFxSorqNYGZM+lKSdQHqYo
	Kd+S4hrbNsaBFQaD8bhcRbItFw6rPpA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=MBO0001 header.b=jv4OUVR0;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 80.241.56.152 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777843514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wNIWGuJIHbUovJaFu/ppK4rRJ4ZLzcU720XhRAu7lQ4=;
	b=0Kmt5CWcQK/nJGDIrTECIMJrfAFU7dRuPzldz18eYiYJd6B3XftChz3odlDhomWSmOkwTJ
	Fe07PP0MU5p7nWnQvqOvIhjZmOHYDXdNK2QX0rNonwf+9L7kSB9iPZJqmXWobQtCjwl99d
	qYGIxu7Xjji7N1itwdyMuobtc+auAc4=
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g7yVJ19BKz9v75;
	Sun,  3 May 2026 23:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc;
 s=MBO0001;
	t=1777843512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNIWGuJIHbUovJaFu/ppK4rRJ4ZLzcU720XhRAu7lQ4=;
	b=jv4OUVR0pj9l6qS5bVG0zlXHljlh01zMjMokCpfpNpfx/McnXSTBjdHrR2O7QiO+xGPKPf
	eFghYEGF/1sXRM47DdG4POE94QAqEffWxD56pVINX73xRJj3lZS4CsC4pdvQrcBojlupzd
	COzg/ChtCoMw2xctUuBPalS/Y2Q1UiLuL93KtoCt22nEWwhP8pOipgY/QmdOLRnk5LXHND
	kkEq47bdtFITshxG1pHhjIhgmkHtKru3+vhqsszLxiv+Fk7OcLB99zkZALZqAybmJU/xtP
	PZlXNHYMHhjUV6mcdqIZgPjlcSiBMB56t/4g2T//beHk89HveWnEOq58xFJ/BA==
Message-ID: <6c76fd19-c9f5-4cc9-82c4-778a2c010b04@unstable.cc>
Date: Sun, 3 May 2026 23:25:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH batadv-next 2/2] batman-adv: tt: replace open-coded
 overflow check with helper
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260503-post-fixes-cleanup-v1-0-9c5c0ff0fcb4@narfation.org>
 <20260503-post-fixes-cleanup-v1-2-9c5c0ff0fcb4@narfation.org>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260503-post-fixes-cleanup-v1-2-9c5c0ff0fcb4@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: RMUDWM4BGFCRTVNQLSJZVG7J223FNERG
X-Message-ID-Hash: RMUDWM4BGFCRTVNQLSJZVG7J223FNERG
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RMUDWM4BGFCRTVNQLSJZVG7J223FNERG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 03/05/2026 22:46, Sven Eckelmann wrote:
> The commit 6043a632dd06 ("batman-adv: reject oversized global TT response
> buffers") introduced an open-coded check to ensure that the allocated
> buffer size can be stored in a u16. The check_add_overflow() helper can
> perform the addition and overflow check in one step, so use that instead.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@mandelbit.com>


-- 
Antonio Quartulli

