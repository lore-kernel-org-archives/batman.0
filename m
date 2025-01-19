Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B700C02185
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 03:21:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 42E4983C42
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 04:21:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737256868;
 b=Aw/WiXFX52YBl8KmI1Mm3T2StkxIddqO3XXKAbxv6ncleqEof16+MWuqzeO0gIcNTJEB0
 1kGD6QPiHJeJDIDI4M/bO6L7qrZi6DP1cu+742uHn93LIDI0ANS4mBSqo1I3JuygEXmICmE
 3R9PgMxmwGzVmfCVijYEwFMHHi8oCiA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737256868; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Bh5m9VUDVu3+nS0/IWK+lhGmjbv3OWlQMuWKw/EN3yM=;
 b=uiiSs6ZTJp7jlVbYYRLjZygjHsYmRlEgNX/L6WLY9Tzs1RNpX6PBeD3qeB7C/7o8ZAThY
 5p4feji9OcifETqtJqjl1JiPY8pOxWB0dF+K+i04cBY2quElPV824HqRHhhjEDp9WRJK9+3
 +MEKicd7HyxJE9v0Phv0JLY1jwis2UA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 56DFD81992
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 Jan 2025 04:20:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737256859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Bh5m9VUDVu3+nS0/IWK+lhGmjbv3OWlQMuWKw/EN3yM=;
	b=pcI8mPcYeReghV2S2YVh7sNx0DxtSNIgFGtubNz0Z2dg7aSOHwQo9lQd91gzPB2P1Ozxg/
	7fXiqHx6Bk6OquwtRmLYizK1a0+2t0lEbBmY6xhxqne/4QKHZnpMvln0hWdpA9Wf880v4C
	Z8LxZ6TN2uO7skB/T4AOmhlO57UiA1I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=LVHDGo9+;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::b29)
 smtp.mailfrom=andrew@andrewstrohman.com;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737256859; a=rsa-sha256;
	cv=none;
	b=TaeY/fePTYGtxqPV8YR+IU+Npiqc7QQWKWE5W6uwgpAF5DZXZysYO/EU/p6uuApcmCQ+2Q
	ZsujEEQRLWwK+ksR4Brsty7HrMPv4+DGvbgLH4rSerVY3ps/M0AHP8TY8XO8ZIE7zbQRzJ
	ip3/9S4gUl05sGKBzO+FlrCEGzU3yM0=
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e549a71dd3dso6134726276.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 18 Jan 2025 19:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1737256858;
 x=1737861658; darn=lists.open-mesh.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh5m9VUDVu3+nS0/IWK+lhGmjbv3OWlQMuWKw/EN3yM=;
        b=LVHDGo9+jfZtLkggI8VptDRn9Cmg5dKg0U4PUwV/qR0KvZUMIflSZ9hAyI04gOBnGf
         YgeSYXuR/VptFfm3B+8qN5uOUQpnMy1KUFamIChhb/qeRzpaSHxsWyoAeJv6hK0n4tPm
         tnMTAuIqznXYZeTtO0Kl8OKAJMRa2h0ufzOTS6iStcxW9UOK5QPyUG0iQKfPQhY9CBYd
         w68m83S473nESQBS3+mpzZ9PfwYWpbU90q0Aee4h+UyQatSTRWY111oZudr0/EMS57LM
         lgqYnm4jv4svDCtPGaG5g5EJJq14FgBLDnRvUXDzu739I+j51+fw1QkLBS8PQliuaQ6J
         lqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737256858; x=1737861658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh5m9VUDVu3+nS0/IWK+lhGmjbv3OWlQMuWKw/EN3yM=;
        b=PVKAnGefG20u6P8hsvqy6yz02xOTd6yWd9BhMrL2tCACTjvg0FQ4Wnls05XATsnv1H
         3T/Uh327+t4i2rybdnlf+hQ9QKIkdfAsLwq+vIAy2YUWzjPNbQkd9kfBgoprN+gaA+F7
         3geZsnly2wAbDNkz7MFSCnxhcEqQ3MK8YlnHmQi2nSqiEsbvBactZKusIyGGHAMs1Vu/
         hsC1dHcEwO5F9YL+XsFa6k5/dd2tHQsoKcCivEhXX27QQZ05e/k/SgPztKZdwiI3C69Y
         740RSYon6HHRs60pkDh3lr9aXO0NWhhd2mGy9EsvgHW+nWZE9PjwVyrMQ4wKYYsNsMUb
         GBMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzxdNgWRuJL1/s+gMv6v39kuHc3qvrOExKHWUDZFZPyV4zx4i6MXKr99lSxeyW/+yddo3WS75rV8yeyA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwmzlvDlSBzEKj+3Y0WNqb4YOj+K2f/wX9npDQqQzxSRt66pgid
	AiULC+YfbB2vhVUUh9r36rLD70w47YDRLsDg0LOPDnMtX2mlzLK7IubJXRPdZH+MRjeuqrmLeld
	X42i+wQdx11x5DcwM3yjr6fvuelkFzB6OncvZ8A==
X-Gm-Gg: ASbGncuhQnrQD/vMQ77n0TDkWiMLeolpv9FoQlLD+9S26N/JIPRZ4pHyDal1FRyWd26
	0VkV6c5mzjbty2G7J+IkmS+CvKyrRhIkgdIUomIJMrF96hdYvWoo=
X-Google-Smtp-Source: 
 AGHT+IGMdav6LHpAiiNzN8eZJnioZzdJtcM/0A5EvLQaPPn4MUR4ZZiFTKSRisp0JsTGCEezyqIbn7V+AUZRjNSbR74=
X-Received: by 2002:a05:690c:650a:b0:6ee:5cf9:f898 with SMTP id
 00721157ae682-6f6eb942fc5mr64502047b3.33.1737256857872; Sat, 18 Jan 2025
 19:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20250118003528.6843-1-linus.luessing@c0d3.blue>
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
 <6131569.pqZb4hCDXM@rousseau>
In-Reply-To: <6131569.pqZb4hCDXM@rousseau>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sat, 18 Jan 2025 19:20:46 -0800
X-Gm-Features: AbW1kvbDTnOd7BbvDctxgN-CCLM8afmthTBSVs93Xu6hBmrqzIk90uMPZNjarzA
Message-ID: 
 <CAA8ajJnwrAidkea_tVDvRxJy6T_bJ9VQDKq2FW4SSdJfZxYKqQ@mail.gmail.com>
Subject: Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link
 metric
To: Marek Lindner <marek.lindner@mailbox.org>
Cc: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	b.a.t.m.a.n@lists.open-mesh.org,
 =?UTF-8?Q?Ren=C3=A9_Treffer?= <treffer@measite.de>
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: 5J7RO56WVW7EAAHPQY4Y6AN5VDIJU2KC
X-Message-ID-Hash: 5J7RO56WVW7EAAHPQY4Y6AN5VDIJU2KC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5J7RO56WVW7EAAHPQY4Y6AN5VDIJU2KC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Marek,

> the important aspect is that the method of estimating the throughput is
> consistent across all radios on the same AP. This is necessary to make the
> estimated throughput values comparable.

Yes, I agree, and that is what my point is. The current implementation
and what is being proposed here prefer to use
sta_get_expected_throughput(), if available, and then fall back to
examining the tx rate more directly. While both of these methods
attempt to estimate throughput, one method may reliably result in
over estimation while another method may reliably result in underestimation.

In my case, my 2.4ghz radio driver uses minstrel for rate control,
so throughput estimates are derived using sta_get_expected_throughput().
For me, this estimation is chronically an over estimate. The 5ghz radio
does rate control in hardware, so we cannot use the
sta_get_expected_throughput()
method for it. As such, we fall back to using the less prefered method
of determination.
Currently, that means tx rate / 3 (which is an under-estimate).

This results in my network perferring 2.4ghz paths when it should be preferring
5ghz paths. The problem is that throughput calculation method is not consistent
across radios.

I know that both these methods of throughput estimation are trying to estimate
the same thing, but they are implemented differently. There
implementation details
can result in a bias to over or under estimation.

I'm suggesting that we make an effort to make the throughput
calculation method consistent across radios. More specifically,
if one radio doesn't support sta_get_expected_throughput(),
then we shouldn't use that method for any radio -- all radios
should use the same fallback mechanism.

Does this make sense?


The more consistent the outcomes of the methods of throughput estimation are,
the less problematic what I'm describing becomes.

After this patch, it means that the throughput estimation for 5ghz
stas/neighbors
in my network will be derived by examining an exponentially weighted
average of tx rate
with consideration of tx failures. If this new fallback method results in
in more similar results to sta_get_expected_throughput(), then my problem
will be lessened, possibly to the point of my network preferring 5ghz
(as should be done).

But as long as we keep an implementation where we have different
throughput calculation methods for different radios, we will remain susceptible
to what I'm describing.


> FYI, expected throughput and also 802.11 throughput estimation are taking
> congestion into account. If you believe this isn't sufficient to get an accurate
> read of the situation, can you please expand on your findings?

OK, thanks. If you're confident that sta_get_expected_throughput()
returns a result that reflects the recent or likely external contention on
the operating frequency, that's good to know. I was worried that
my overestimated result was a reflection of how fast we could tx towards
a client once the opportunity presented itself. But given your remark here,
it sounds like the answer to this is "no" -- the throughput estimate should
reflect external congestion, such as tx from other BSS's on the same
frequency.

Like I noted in my original message, I was seeing the estimated throughput
as 150Mb/s for the sta_get_expected_throughput() method, while really
only able to tx at ~25Mb/s. This problem might be specific
to my driver somehow, despite the fact that it uses mistrel for tx.
I'll look into this more closely and report back what I find. I'll try out
other chipsets (ie QCA) to see how they behave.

So in summary, I see one problem that results from different radios on the same
router using different throughput determination mechanisms. This problem
may get better with this change, but the underlying issue of using different
methods per radio remains.
In my case, I also found that sta_get_expected_throughput() delivers
over-estimates.
In my original message, I was considering that this could potentially be due to
the fact that sta_get_expected_throughput() was not considering external
congestion. But given your feedback, I'll now be debugging under the
assumption that something else causes overestimation in my case.

Thanks,

Andy
