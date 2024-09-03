Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B19CD343F
	for <batman@archiver.kernel.org>; Tue,  3 Sep 2024 21:20:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CA54382F29
	for <batman@archiver.kernel.org>; Tue,  3 Sep 2024 23:20:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725398430;
 b=1YJ3yhfyqxZ0E99shZqvHn/miZaHqBk8h6+1ncpMtUe3nxGUssCsmwmlPkPkmgWmA3Poa
 WIWqoBUslIlAV9HWOkVLnQKhCeg7vtrYYa7Fa6KwwTmrE4zldwCUTcLgDb0opx4/AYs2/l9
 wBkvdQ0Itrz6VRT3nWKn7iFlZvHPobk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725398430; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=L5Kz0ZdOo2EmEP+z37KhaJZjaECCzzeCoL1hlAcv700=;
 b=a+3sWoZaB+Q5KuJmJfeupMYFUV+/IL9ekrFGpn2MVO3aWXsWSKBY6P0A6v2b64T8Gbs4V
 tD0t4mfPF0toiWIczl44PKQZ3hgoC62Pv4sgLLs6AktLwA9cA1hnVglEWMCd6PN/4w6Ji7Y
 Jnlviy1JogKYTX1eDGHS1NjfOtbI5Ps=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=proton.me;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=proton.me
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=proton.me; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=proton.me
 policy.dmarc=quarantine
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch
 [185.70.43.19])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0435481992
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  3 Sep 2024 23:20:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725398404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L5Kz0ZdOo2EmEP+z37KhaJZjaECCzzeCoL1hlAcv700=;
	b=3R118aDrTe+X0DmWaFY3C7ZP98W6aQRwcgqxXrMUkk4jLahW2c80/3pvc/hoybzY47q5ut
	mZMKCdc7kVEpF1U9BXbWzz+qoe7nbiGNW0ttcrCpbjzosWeen6ZdGEOialJna4dqXhbw09
	aD3pDjQiaVTvCNwkpSBARq9egviX718=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725398404; a=rsa-sha256;
	cv=none;
	b=0t35OPmF+evTsO4TCM+5XlX1mVikwOoCDqMhzWogKDXm+Cyb4k5qbYzraFd98gKVJxgpLo
	Um+QRodDuphOXAQfTqO1dWBhxV/ZXGDX6JnKqi4L1uVTwxkePC8T9n+8xLJuNuj3yEf1ko
	eiJTGwTA93Ajqvp/s9H5Mq2x6A/wu5o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=proton.me header.s=protonmail header.b=a+h8Q+ZA;
	dmarc=pass (policy=quarantine) header.from=proton.me;
	spf=pass (diktynna.open-mesh.org: domain of rchase47@proton.me designates
 185.70.43.19 as permitted sender) smtp.mailfrom=rchase47@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725398403; x=1725657603;
	bh=L5Kz0ZdOo2EmEP+z37KhaJZjaECCzzeCoL1hlAcv700=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a+h8Q+ZAPkOmLMEe5LBSbpNONAc65ioY7vYQDSZgWuI+J3w7QubRiAMsdESXQTgI9
	 rhbG/J7JpaDMtg/oBWYx6/lp3jz3aV8Puy1s6e0iRZ56Sr+EeMAyLeH4L2NGmNH04w
	 hgCaztCuVL0K5nZ0Jg/FDSI7KfqXD45tkiPIIb+WzLd29Jinkk+mfoXIZmNmxv1Gn/
	 865QxTbKbPe7lAikU47fZlHcM9CfP7tkQMkdH7BmF9AJwuWtnYFTemB1MPiBEz6CnD
	 fjhiAm6yuaAlIdB2UQunV4wsgXhD5B1KiJ6TJwnDpkI+seGuDFq9pEdE0CY7pMIv2y
	 2rSAjIe15SWFg==
Date: Tue, 03 Sep 2024 21:19:58 +0000
To: "sven@narfation.org" <sven@narfation.org>,
 "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
From: Rich Chase <rchase47@proton.me>
Cc: "rchase47@proton.me" <rchase47@proton.me>
Subject: Re: bat0 not capable of MTU > 1500
Message-ID: 
 <XnDCBAFFEevRp269nHr9DopIL8XLn-3Amm65sloaJVZDKeMhqLMgnuOFAJTvNH1klM8IwjFliW7a1YyIpG-eQkINh9yxvU185VvQwISX1oo=@proton.me>
In-Reply-To: <1979998.CrzyxZ31qj@ripper>
References: 
 <Q1WvDb-RVDm4Z2qmDwD2hpBjITfuDQMFtWJYgRrhbad0oE0M76pzK6dfZyGkClGkkJskqjMAB0ZQUpZJ250oUB_EEZaVPqQd2pDEEKknXRM=@proton.me>
 <mwhWyjjJXHvw6-948GpvusAWgqEJ_5SglADOQJRkhdzLl_r4VYK7ZWUzRG0UHDswIyUghMf7z_dJXIJzywAtc3js09aedSvTZx0pxkEgU-Y=@proton.me>
 <1979998.CrzyxZ31qj@ripper>
Feedback-ID: 93688764:user:proton
X-Pm-Message-ID: 6174d22b4780609608459dfb499904d164bd71fd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 3ONPJMLAUHI777HVLHMS7W6T353XGIEA
X-Message-ID-Hash: 3ONPJMLAUHI777HVLHMS7W6T353XGIEA
X-MailFrom: rchase47@proton.me
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3ONPJMLAUHI777HVLHMS7W6T353XGIEA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Sven,
I have been using jumbo frames for almost nine months now with no ill affec=
ts that I have noticed. I applied the patch you provided. Seems to be fine,=
 functionally.=20

I haven't done pcap or anything, so caveat emptor. Please let me know if yo=
u would like me to perform any specific forensic analysis or tests. Otherwi=
se, this is just a sincere thank you!!!
Cheers,
Rich

Sent from Proton Mail Android


-------- Original Message --------
On 12/12/23 11:53 AM, Sven Eckelmann <sven@narfation.org> wrote:

>  On Tuesday, 12 December 2023 20:30:24 CET Rich Chase wrote:
>  > For my life I can't see anything I'm doing wrong. Why can't bat0
>  > have MTU greater than 1500?
>  >
>  > I don't have any other devices mastered by bat0, other than my .1s wif=
i mesh link.
>  >
>  > Throwing myself at your mercy. Help?
> =20
>  https://lore.kernel.org/all/20230727-jumbo-mtu-v1-3-036ce1a6e33c@narfati=
on.org/
>  https://www.open-mesh.org/issues/365
> =20
>  Kind regards,
>  =09Sven
