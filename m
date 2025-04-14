Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9072DC369B2
	for <batman@archiver.kernel.org>; Mon, 14 Apr 2025 19:21:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D5687847C1
	for <batman@archiver.kernel.org>; Mon, 14 Apr 2025 21:21:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744658482;
 b=Gi7RTzpCoI2Zn3Qn8JDxSiq6a4ShBy2YiL6vVHvBy/AIH6QSI7vY3zpQhaL62K477zteB
 AsJkZfWxtlbgF6ml/ZJOdFiThXZ2CT/8eNVwfxkHw/Gd2rjJDIubJXf7FutOHgZMm9iSlui
 ELW3qq1CKFMiyWq2w82g9ixbpVfKuDQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744658482; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RVj63pLHPDOADttU5mk9xoBgxj6+KEfzLF7NO/zyIHU=;
 b=CYhh0UnQVgEWxW8ht+FdoVAqMBaRZ+L+ypO8dIVZw2A5PJyzt1T9btjecfi5kyoU1UCcz
 +OKMhlgykVI9/sq1krswnt8omQIpNPqvI/VXcn/2DfGh6zJcxFo6JYlYByt5qfF+LrUQDb8
 nwiFkKZjmbgVniuhmUn/SZ8KqAfvzlY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=google.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=google.com
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=google.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=google.com policy.dmarc=reject
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0BF8C843AB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Apr 2025 20:42:08 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744656129; a=rsa-sha256;
	cv=none;
	b=tOMrQDGERd8/CSLBhanNaEVDkG7sZf/3DBeMDp9SL9EPcZZ0J/eJpi4qho4PC7ULY+tc/t
	vVbTvN+c5MkqFLL8o//P+UPosRWz8RApKHdTxbRZJ0YcPlQuOT9GxxtD2qmQ3UxO/p31Y7
	4kWDh6hnyqYHTqkxj/Q1kppnZFcbv8Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=google.com header.s=20230601 header.b=JuTAQ9kv;
	spf=pass (diktynna.open-mesh.org: domain of edumazet@google.com designates
 2607:f8b0:4864:20::82e as permitted sender)
 smtp.mailfrom=edumazet@google.com;
	dmarc=pass (policy=reject) header.from=google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744656129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RVj63pLHPDOADttU5mk9xoBgxj6+KEfzLF7NO/zyIHU=;
	b=3kh5V8F/W1hOas4PcNOariwc7H9IgTQmmKrY6hlcYeK9Buz9pUo/VNcVaRAtkJInuHJd0A
	jjBcx88qTplxzoCGwEMaO/rm9rQbhTK8lIJJQ8tCWITo1P3FOdUAnhTBgwVCT1AyYA78PO
	wr3PtYDKm0r7AdlwYZJuYctXKcMkF4o=
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-47677b77725so49135121cf.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 14 Apr 2025 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744656127; x=1745260927;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVj63pLHPDOADttU5mk9xoBgxj6+KEfzLF7NO/zyIHU=;
        b=JuTAQ9kvk6qrsMYm8fcb42EP2YINjqD+fGGTV63dUWGTWWTVQ6wNeX7yvMDHUYEqzE
         0OGnBmqY705Av2LDm7D4yMqa34CbZToz+oIfkFiMuzAPqS91ldGJG0zCZWfttBWbi9jr
         /DWHG499hgDouSZcYI8/9bOD31jUzuC/j/5GORvIrjR+AkHazLCm3ej8/Z757+JL7WCl
         E8hbLrjqOSd1lO+EFw3mjDf/mOoKWdIs8Utkf+oR1t19Yu77nzfrB+eU8Qc42UvzoaJX
         hQaR3goWx8E+T8WzFi0fsnpM/b/YU9kUPeZm12R4KX3ZzHaR8lppIIRQOVIhD/4krhq7
         RriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656127; x=1745260927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVj63pLHPDOADttU5mk9xoBgxj6+KEfzLF7NO/zyIHU=;
        b=RE8wU2bAIJGfGE22SMJ/M3KPULszHSFAJPk66EERSaHE2oU5k8QcWCTdM5SsajdEne
         xkCwHav7kK7/JvfE5qapjOOPvggs63dlqJhByhu2fAEYOV4Ifu6FNORY3TPi5bcZMmaQ
         u5FpCmmDcjRAl8I7bjrTJrv6+D/tpoCLFHUcAWJl8ovdbWsTjbSYmcSGCE6+o0QpBGMC
         ZNXN7HOVAeOjcA2VE+5e0eWjvnR1wDucfO7bqQ8+GvwztEA+tq2zw51wnN/uztJsTIXl
         vYe7pkxj3iq8RX06KnWhA6Sa9Mc4ISH+U220+9VGwXTV1EVYlqngeXYXGk+m+C/uBb56
         GbDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXaD6YE3Q8k083VQIvHAu5CVij70lmWCLMA0ptEpq0VFko5AfAKOpPgE+PDYEWE9gUWvMCSfKtyTytKA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwsSOzELzsJn3EMiU+gn8e6PWEgl9g1UazaFs+1vOJeSIpJ5ETN
	EhFWDe3fY8MXpUmkON4UrvJYskA2CCJTy3ibjMB2Uk07XWrxJuVuI0yJm1+tS7w5GcgKYa7bdue
	2iThbtCCgXkUuwF3ChaSZgicfiw+idSnOwqxB
X-Gm-Gg: ASbGncs6WBTSk9LIqwqzqry0w4QROi3urk6o2IbEZe4x8PdetmxbqC652SHIsLJJ8YT
	Rq7KiKbVqOLcG/ZcgnplBjKD+6SEe0chvOxTeexVVFK9DiB2rkqrYfk7DqRzYyyXFdErGxARzaz
	Cx+qowg8qMXXVmDrcCMqsDTBXgnQuPuugg5mXMsXZqcewjuUtOdrtG
X-Google-Smtp-Source: 
 AGHT+IEM2908mcWzVKMjpolQ0hIG1B9gw1c/6MnW5biuy6F3HJ9GSftRvzmu/S4TKHnQCd3lqvgWhDveMpG2O2LCLJQ=
X-Received: by 2002:a05:622a:250:b0:476:77ba:f7 with SMTP id
 d75a77b69052e-479775d5ac4mr205613591cf.34.1744656127177; Mon, 14 Apr 2025
 11:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
In-Reply-To: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Apr 2025 11:41:56 -0700
X-Gm-Features: ATxdqUF7AI_OOcycjc1SsjBq1YuDR9GVzjAZt9KIbXpqOALRRD2LjaN3l9RR8PI
Message-ID: 
 <CANn89iJEFq4QeFDSq=-7NdPnqPgwMJDd5xvQ70YUEqHjNjdchw@mail.gmail.com>
Subject: Re: [PATCH net v5] batman-adv: Fix double-hold of meshif when getting
 enabled
To: Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com,
	syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com,
	syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com,
	syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: edumazet@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: VSZNHHJVLD27PZTBXWKBFT7XZYWNTFPR
X-Message-ID-Hash: VSZNHHJVLD27PZTBXWKBFT7XZYWNTFPR
X-Mailman-Approved-At: Mon, 14 Apr 2025 21:21:16 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VSZNHHJVLD27PZTBXWKBFT7XZYWNTFPR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Apr 14, 2025 at 11:05=E2=80=AFAM Sven Eckelmann <sven@narfation.org=
> wrote:
>
> It was originally meant to replace the dev_hold with netdev_hold. But thi=
s
> was missed in batadv_hardif_enable_interface(). As result, there was an
> imbalance and a hang when trying to remove the mesh-interface with
> (previously) active hard-interfaces:
>
>   unregister_netdevice: waiting for batadv0 to become free. Usage count =
=3D 3
>
> Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
> Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
> Reported-by: syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com
> Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
> Reported-by: syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
