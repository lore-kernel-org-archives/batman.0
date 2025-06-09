Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEFAC61CE8
	for <batman-adv@archiver.kernel.org>; Mon,  9 Jun 2025 19:16:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F3D1B8477A
	for <batman-adv@archiver.kernel.org>; Mon,  9 Jun 2025 21:16:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1749496601;
 b=IFlCUTmXplzCHFRhUG3M20DEBz8ojv8kD7h+Wk4GaLEYScenKEeS5WSF5V9yzakL00AOx
 zJXR5CxvTXtcXKEym8MdE23qU5K9Kxy+cVy9XAK7WSs3P8ZV5AUWvopJ2zbjrIaQ6BGNzJc
 EUzits1FMzCbToN6sMhRKYTyFGq+WcQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1749496601; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Gm694UbRA2FsHSktdWiEibC98mf9+ieBghmbgjCPjcA=;
 b=cKMias3M/xNh8e7tHMUcgkVe1PbN/nwQQ27Sheqoze0ZpARNf6jsEYQm1ZZyPH070+rLL
 QNykucl/rlXmUymWkSeydaqj3A/7t1l3hc+xs7g6h4J5d2o0fP3zUN392eBj9TbO2uPT2NW
 zUfuFI++rnMmgfQXab8HcO835FaU4Y8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 45CB482F33
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Jun 2025 21:08:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1749496112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=Gm694UbRA2FsHSktdWiEibC98mf9+ieBghmbgjCPjcA=;
	b=iGtoZ7vlW7SF59Gi/2fYghWFzJhir5NyiEzA90HsEb0Sco9Mp/etCee4gZOdmj3J5AtwJ0
	jNXGyLr7+A0XRqx0J5zEdLDVYoWlCFeJxTq46e6orqOlkwGksZTQ4c2ZvLw2xIrpss7GBe
	69DQVjeSF47SwRGGheYO73yWsNhMW0I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="Gs+9X/8w";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of rustamabd@gmail.com designates
 2001:4860:4864:20::29 as permitted sender) smtp.mailfrom=rustamabd@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1749496112; a=rsa-sha256;
	cv=none;
	b=PR6Rp4+qel+YABd+Z9lnCg81rOrcuu/QwekdbxZjXF6RBLPi2mLZQKkGOyqkTb/Bp4gXqz
	fwn4a0h7JbWLEsl+p9UX8gK45Dr1y4HgKwdzBA/d6MnQLouXp5jQYkaNH0LRSJKXzqvQz7
	mBKkzGlvNJvWl2D+Igz8J8IkF+dlHXc=
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2dfe2913a4bso1079409fac.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Jun 2025 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749496098; x=1750100898;
 darn=lists.open-mesh.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gm694UbRA2FsHSktdWiEibC98mf9+ieBghmbgjCPjcA=;
        b=Gs+9X/8wmPOomNLZW8+Rxc4R6DQcbH76WTcekNKPz+s54Jjci42uS0+yCszsfh9iaz
         mfN9XHzGt+n575RkDqNUbwMV9iYHBqk6x5vub2spmtM9YcQeXpdOGU79kLnKzuSz9hlL
         pLVRc/5aj9yqRjCdktMa9kXzTYYkuz/1lLqaJu4V3UAmD087bMBKB66rxxs1SyrgVL7V
         ZBtNOrD7H1YM7Dhe1l9Cpr+PQIPhcZ29a55HvxBDIvOdDqAGyqUyZEXGDnJl3PEptGdl
         VqvMuvQ9uSYVv1FHxILQHjNkjwauNCOGI28O4ikf7v4xQXt8Gq/woIhrdDUIacrUghxW
         2jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749496098; x=1750100898;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm694UbRA2FsHSktdWiEibC98mf9+ieBghmbgjCPjcA=;
        b=jA1HAGxAQtMr5V6pMTwxR2OO3SF+nQux0i6ES2dKTbUESgEUFjyRwY+/u3x0OdPrAE
         JPzgNn8eHYPqym537G0eHRLsA92bXlPW85ortUjiKEFxY2LTR7QZIZalVlZ+w3hY/SA/
         YMYHeZlzBraZSOhCAkA9gRVmiRKbMPp9RUgNxTduzIlwQ1xT0tzg9Cj8WIaWL9BODcZO
         OmyspDZajX5CfL7zpUHLGGvHlxUJxWpjky9CDrPnERDmjAb/6gS5AAlBGqHTfI/2RhhM
         UwWYv4CcannH+EwQTnYHvm4N/1lLJ14trGOJ+tg8bYv2k0ky01p7hIje/25XspU+v7t1
         8ouA==
X-Gm-Message-State: AOJu0Yx+JT0G/Pqp7u7v+qD/oXwgdOFmiAU22Cf2V6n8RHO04eL3qsjK
	VLdL8sLMfqCX1U4ZWBpkcRUQo7TONxcj5aknXhptvnu+Z0N5lUP+mbEAtDqUqy72U/muW/81YFj
	zLj/Nfp4JgLjT7TmTAPwSkRdC0evqxz40J1tfp8Xc+Q==
X-Gm-Gg: ASbGncsrG7L3IGKqnrSJoupHAj36vWyfibln6r6ewHURizAbZf+hS6PPcu7Aa4y+3gN
	X2BEUKAIS0abRkc5WRiTDQ3Erk2EvtovczpR0cayJVrS2s0bpFhGnFvuXbyXBClM35wo04Bza1T
	j/JBKC3qMtWmx5NI7tidzel+I2zNbpjQIVhcc3K6mAcmpLSxKHnse34ZLRs/Cw
X-Google-Smtp-Source: 
 AGHT+IEOCnybk36PeBUsqoCKxXBsvyypWsiaDkIUugtFRJWWyHzydsp4f5dpo3sFf4BgpBBc67B2+A9DQGD8w9Hm3nU=
X-Received: by 2002:a05:6871:7c07:b0:2b7:7abf:df6b with SMTP id
 586e51a60fabf-2ea012e44dfmr9527091fac.26.1749496098587; Mon, 09 Jun 2025
 12:08:18 -0700 (PDT)
MIME-Version: 1.0
From: Rustam <rustamabd@gmail.com>
Date: Mon, 9 Jun 2025 21:08:07 +0200
X-Gm-Features: AX0GCFvTe4oJkc8KaIx2dbaqFvfjY825RnkgwR106rylYfc7EnN8pnbv-6_fUaY
Message-ID: 
 <CAPzS6u_U+BgkE+Unc_nmikEb45QeN7TVF7MFu=6ckAu-c44=Rw@mail.gmail.com>
Subject: suppressing warning about unavailable link speed
To: b.a.t.m.a.n@lists.open-mesh.org
Content-Type: multipart/alternative; boundary="0000000000007e09390637284d5f"
X-MailFrom: rustamabd@gmail.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: CU2LLOIOKVGLCB5DSRILFOBLRN7XI3Y6
X-Message-ID-Hash: CU2LLOIOKVGLCB5DSRILFOBLRN7XI3Y6
X-Mailman-Approved-At: Mon, 09 Jun 2025 21:16:30 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CU2LLOIOKVGLCB5DSRILFOBLRN7XI3Y6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--0000000000007e09390637284d5f
Content-Type: text/plain; charset="UTF-8"

When I try to configure batman_adv on a bridge interface, I get this
warning from the kernel:

> batman_adv: bat0: WiFi driver or ethtool info does not provide
information about link speeds on interface br0.100, therefore defaulting to
hardcoded throughput values of 1.0 Mbps. Consider overriding the throughput
manually or checking your driver.

It seems there is no way to suppress it.

I could do `batctl hardif br0.100 to 100000` but only *after* I add the
interface and get the above warning.

So here's a suggestion - maybe there could be a "default link speed"
setting, which, when set, would also suppress the warning?
And/or allow setting the link speed override *before* adding the interface.
Then we could patch systemd-networkd to make it configurable.

Or perhaps expand link speed detection to descend into bridges and grab the
underlying link speeds?

---
To prevent discussion about why I'm adding a bridge interface instead of
underlying ports, it's because my ethernet has loops and I have STP
enabled, and STP doesn't interoperate with batman_adv at all, plus I have
other services that run outside batman_adv so I have to keep the bridge
with STP on.

Thanks in advance for any reaction on this matter,

Cheers
Rustam

--0000000000007e09390637284d5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr">When I try to configure batman_adv on a bridge interface, I get t=
his warning from the kernel:<div><br></div><div>&gt; batman_adv: bat0: WiFi=
 driver or ethtool info does not provide information about link speeds on i=
nterface br0.100, therefore defaulting to hardcoded throughput values of 1.=
0 Mbps. Consider overriding the throughput manually or checking your driver=
.</div><div><br></div><div>It seems there is no way to suppress it.</div><d=
iv><br></div><div>I could do `batctl hardif br0.100 to 100000` but only *af=
ter* I add the interface and get the above warning.</div><div><br></div><di=
v>So here&#39;s a suggestion - maybe there could be a &quot;default link sp=
eed&quot; setting, which, when set, would also suppress the warning?</div><=
div>And/or allow setting the link speed override *before* adding the interf=
ace.</div><div><div>Then we could patch systemd-networkd to make it configu=
rable.</div><div><br></div><div>Or perhaps expand link speed detection to d=
escend into bridges and grab the underlying link speeds?</div><div><br></di=
v></div><div>---</div><div>To prevent discussion about why I&#39;m adding a=
 bridge interface instead of underlying ports, it&#39;s because my ethernet=
 has loops and I have STP enabled, and STP doesn&#39;t interoperate with ba=
tman_adv at all, plus I have other services that run outside batman_adv so =
I have to keep the bridge with STP on.</div><div><br></div><div>Thanks in a=
dvance for any reaction on this matter,</div><div><br></div><div>Cheers</di=
v><div>Rustam</div></div></div></div></div></div>

--0000000000007e09390637284d5f--
