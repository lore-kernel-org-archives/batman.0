Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EDFC02183
	for <batman-adv@archiver.kernel.org>; Sat, 18 Jan 2025 02:00:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9960381C88
	for <batman-adv@archiver.kernel.org>; Sat, 18 Jan 2025 03:00:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737165628;
 b=c+zsfWrWb/qjXqQkh7SynY8Is8S8MIWJdHo1s+FXoUAgLxbBFXSe14tiiLb6xhTkvWF4I
 qoKIvtNe8QQ1WsWBG3RaukAdCWb8KcdwbNCUkZWGpmmCh9wfoQGHJXjT92gBOVcYq9d8Ekt
 QhW24ty1jF5uDhI354nnGtBxNIwvbE8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737165628; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=y64kLDn+Ne85VgXoLiYBepeThxYfAKBBF2Vt7KfO30M=;
 b=ctn21z1YN7BVswTdfuX+1EcqtFTkNDHrmmIfNNCwMHchS/CDrI9SFSL2O7qwrw56n83g+
 DxeDYXUiDv1kDozWJT4Yk4nb5mSRG6shPceiuP9aoJAB7OyvVXiCExdFDbMNwY/qaAZ84lE
 heA6IHDbFU2JM0gwD7DFnGrGfC7j1vA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E4D3581415
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 Jan 2025 03:00:19 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737165620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y64kLDn+Ne85VgXoLiYBepeThxYfAKBBF2Vt7KfO30M=;
	b=ixdELtt0Y3h5SoR3U8e0W2nuCI0QTsjp1HJXh+yLERkMtOpPmkgHEczbvZIdKJ9n/IXHYa
	TAzaI2HmyxTSrdfLgcSjpO3RpJ6nFsyXwePQcMc5tg0icmL4qwEK1JYn5iVvkimrYLnyrn
	tDTIERrBvkDBHOVuKTXPQ5VBY/CAcrY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=uJULeWQ8;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::b30)
 smtp.mailfrom=andrew@andrewstrohman.com;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737165620; a=rsa-sha256;
	cv=none;
	b=EES/Qio/jglLBh1OzQvh2dADlLBNGgHphsH2QrFZHA2XQ6KEhUGH7bIsOAcEzHN5QopF2O
	usMN2hv6ixiCVif5UKfID+5+/dOr3KXxWRJsFJu1JaIQDz60iA9Ui/19K59KjX9XWPS/+n
	bjST5lFmDDCfzeUoSPcAx7qmni/hUP4=
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e4a6b978283so6688270276.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 17 Jan 2025 18:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1737165618;
 x=1737770418; darn=lists.open-mesh.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y64kLDn+Ne85VgXoLiYBepeThxYfAKBBF2Vt7KfO30M=;
        b=uJULeWQ8PDE3QJOGSeaC0thpmKMOqEKixIs7o8IzIsDYZ056g1QYiPxrh1pPhq6GrN
         D6wgCLQQSfiMJfh8p9cbeV4EFUmQMxPVmeB3aSxSQlOUVObacnEp9E5zlTItY4jae+9t
         WKOCrnK3VqQ1M5vx0ML60niKiIbALvLElpg45HisY46o1TT7o0ga5fZYo+q11/wFLNEB
         tgXol5Hb9l/G+waZ4H2DBIG6b4U1KSA+dGB7M6oDqDTOmI+lh6Jj9xLFYc4HyeVDG6d/
         YiknjRVxB33GvHcSidQtHYXvkHelg7VY6bTlWmxZQ20Ts3hbz5hLB8D/rIZ2yC2bsQzn
         3Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165618; x=1737770418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y64kLDn+Ne85VgXoLiYBepeThxYfAKBBF2Vt7KfO30M=;
        b=usW1edQ3VhKtW9m8vCE03ygvaQjOwJHQ7Ki/Vn0e5HVYIJ10Bt2Rq5tj/810RDM6NM
         vYwA9SMVXEeirv0dg4z/ONj3PmcORdShhqZzgF+177FHQQPqoe02cjEoPeQdZnNa6/If
         YvrmJp+YaWKWWS3rFXykl1KCBeYd7T3U65VctFFSLR91QtyiLHkGEpJ3Jh9Bp8CuuT1t
         e7wPtm2D50PmJDsTAEgo6QqbPOdLAQfHYhNaj2rcUi0ocB3xSSMH2nNamlsiSedDXvjO
         xCvv/nr7kEgfQW4cPK1vYf9a3jwI2kMrUlMdYuOlwkOJ+Gb5DiMd1+FlJWHe5x1Z8JaT
         EqEQ==
X-Gm-Message-State: AOJu0Yw8+ONkyhrqoCAmbUQLcAwXqNhl9kFtWgcHUBewF6gif0MTQoxT
	prJf5+6cgogfrVovilgMmp2jFqexaMyakbbfCYjjbJj9+bemYdbyroGbmanKrWsygchTktxA7gY
	NiBQcTXD7m7qS1GappQohnxBwaonjfTG2h33qYw==
X-Gm-Gg: ASbGncvhSXcUlrPQX/X3bu/tGyQ/p4XF2V7KXVcbZu8bVfBu2hXkqH8c7jfAPsaLUmO
	Vh1M3d2r1GDxT136iUJnh4Nt0ti3fdB0QNBuZ36eVWY/lEeGdc/M=
X-Google-Smtp-Source: 
 AGHT+IH3joysFku6DlWMWps23frWKvaU6p/NXnRlNwwz6IpN5v1SguBNwSFxQtO4KgOKOn6hiJmiLoSCb8h0KPopSJ4=
X-Received: by 2002:a05:690c:620c:b0:6ea:6666:c0c2 with SMTP id
 00721157ae682-6f6c9a6207emr119771177b3.4.1737165618503; Fri, 17 Jan 2025
 18:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20250118003528.6843-1-linus.luessing@c0d3.blue>
In-Reply-To: <20250118003528.6843-1-linus.luessing@c0d3.blue>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Fri, 17 Jan 2025 18:00:07 -0800
X-Gm-Features: AbW1kvbjaHxQq3DgSSNJXX7DefV2UnBnx8sqePSZ2vUQkPUUEwp3wJOVH35u_y0
Message-ID: 
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
Subject: Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link
 metric
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 =?UTF-8?Q?Ren=C3=A9_Treffer?= <treffer@measite.de>
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: UIEBC64LLC5IWPB7DX46VLPQJNXWSOT4
X-Message-ID-Hash: UIEBC64LLC5IWPB7DX46VLPQJNXWSOT4
X-MailFrom: andrew@andrewstrohman.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UIEBC64LLC5IWPB7DX46VLPQJNXWSOT4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Recently, I've been evaluating routing with multiple-link
(multi-radio) in my network
with batman v.

I found that adding a 2.4ghz radio to my bat interface has caused
instability and
poor performance compared to just running batman with the 5ghz radio only.

My board uses mt7915e and mt7622-wmac drivers for 5 and 2.4ghz,
respectively.

My first problem is that mt7915e doesn't use mistral, but mt7622-wmac does.
I've noticed that sta_get_expected_throughput() returns a higher rate
than (tx rate / 3).  Since this is not an apples-to-apples comparison,
there is bias for using the 2.4ghz next hops. So, I think it would be good,
if we tried to make an effort to use a consistent method to determine
bandwidth across all radios, even if some radios have better
methods of doing so than others.  In my example, it might be better
to use (tx rate / 3) for mt7622-wmac even though that driver/minstrel supports
getting the expected throughput.

I think that this change probably does a better job for the alternative
to expected bandwidth. That is to say, I think that using (tx rate +
considering fail avg)
is better than just dividing the tx rate by 3. But this proposed
method still results in
my expected bandwidth being derived differently based on the
radio.

HWMP doesn't need to consider this, because it only supports
one radio. Regardless of which method is used to calculate
metric, it will be used consistently for all possible next hops,
because there is only one wireless driver involved.

The second problem I have, seems to be that sta_get_expected_throughput()
returns a bandwidth which is an over-estimate. For example, it
estimates 150Mb/s. But really, I'm only getting 25Mb/s, or less on the
link. I *think*
the expected bandwidth delivered by minstrel is not considering the
fact that the
radio cannot tx as often as it would like due to contention. The return value
seems to reflect that fact that we tx to the sta at a high rate,
but doesn't reflect the fact that it's hard to get an opportunity to tx.
I'm not 100% sure about this yet.

Again, this is not something that is as important to HWMP, because
there is only one radio, on one frequency. As such, the contention
will be somewhat
uniform across the stas. But in my multi-radio case (and probably many others),
2.4GHz is way more crowded than 5Ghz. So it would be good to
somehow account for this when we are choosing the best next hop
among multiple radios.

Andy
