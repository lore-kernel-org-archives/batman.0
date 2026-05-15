Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C363CD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:08:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9418B85A61
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:08:48 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839728;
 b=GDsvvBh+LAk/o89dZVWp6AS1mV2WOUlOrLejt9JpttcKKl78c7RnCqNrNCd4BYPEX+XwY
 l3HoBxhS3VMo7tcE+7yyZigM8pMxizo1pgozs4JJXWIFu8JpwLjUPySOt2vjwiYEwlEc3Ay
 UNcPPi6lbPRcR7vYYh0sn+HqD5v20D8=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839728; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5EElz+2jxl13VfEl6Ul4cSmF0KTR6hyaxEnjiNXlNlE=;
 b=zbqU9pZ7mxUx4Odg5vGHpy8Evw/MyhqMGgkpX+/H9YVoOO2EnqtlQOoNCGP8g2wWRx4+8
 h+P+qRNjlsl8VFeR2l+f04z76LrCwDqUml8PxO+L9DScaJoMr+90qaWTEfPLnEv4sJFRqPO
 +pviND+JIc0d+qETYaGsj/sblQpEthA=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5678484264
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:54:39 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5EElz+2jxl13VfEl6Ul4cSmF0KTR6hyaxEnjiNXlNlE=;
	b=om+NCngddXC30DDSaAOd+4jmcdKFDVBaHVhmVmzmK4iv9sX7NdA23bvCFQZuhyZ0x3TEzJ
	Y8RehglDbYK61Qyr82JGZT3UY39SRKdF/nMPD+I9fIfxGqFKgilqai+CWMHIuUrzh4wOS2
	D5LOePkuM8O7j8cxHu5Infnr7Rc9SrI=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zac+Mu20;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of yuantan098@gmail.com designates
 2607:f8b0:4864:20::830 as permitted sender)
 smtp.mailfrom=yuantan098@gmail.com;
	arc=pass ("google.com:s=arc-20240605:i=1")
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1778838889;
	b=A7lHMVzyQtDKFkwLTb3VcXLffYx3DGhPYDkPfqtFkgMizPmqeM0fB40ky0zgrzXbO8GPwX
	v4LwNTQda4DOQh8cdh9P/EimkZzjff/E/afJInrBhoZlr6B8SeWdlJ8pWGEzS7DTCMkoIT
	dyOXWAAerdGMSOPb5WowtImnjzeafkc=
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50e63771d91so87392691cf.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 15 May 2026 02:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778838878; cv=none;
        d=google.com; s=arc-20240605;
        b=TrbqpwZl8T6W8MWkVUH9MF83uzsYB4EuITwRP2bK+KRTKXw+WdmVbGbU15JzYfl2E4
         blPpd3Dx/Z//N6wpXwc96M3AbNlC8KyiN2lRLW8/iSHQrNEQOWi8tra5HxEOVOabhj5K
         k+NAD8JRg/bx859axncaZ1P5PNbCaL48UWZ78Db2uygLyx9mJAZLeigXECnrE7rvH11d
         q6R0vwuMyvn+oSvDwpi0MsqpuTKd6vJ9zb4LHTr7yytO58qHjW+3Z5i4F5as1gdBERNP
         9FvZz5EU0+RBNKtJZx8cg1rGT1DV0K6pZtzoj5ffvdc5k7VhHoG7MUVlj7ELZS7kIrvb
         Idiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5EElz+2jxl13VfEl6Ul4cSmF0KTR6hyaxEnjiNXlNlE=;
        fh=fGpATJGdA5gBFxywIcayagIpQImFJ7uNKXfLW6dnd4U=;
        b=j9qYLRNyzFCjZVmSDGuGLefgWdvDz7XFPHPV2BDXd5alG9H8mIk5sSuQ3yTFgGcmiB
         EEf7lgb+1vY5PJCkaAvs6YY6mvliEfOoTU5psI1lHSR17nm3n0W4M34El25N/nKxFB1z
         ffvdyZNjRtliF/oXpXaHMjrb43fIkkPzhjZhj+64fOkJ9ItWbb5AAgzQAwuq3Poc5FTC
         6LAcdIsW8ymUkCq9p9b+Y3Q1pfhJc7sDt9SzHzgA3d7d26rGIvDbyfU3n7ODJHCjVgGf
         kPkwUpW9auURIFJSDcFyiyiA0HecfAyp2WVsngG79QQiixSSDfAWi4CrUWf4YJLkJhTU
         k3OA==;
        darn=lists.open-mesh.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778838878; x=1779443678;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EElz+2jxl13VfEl6Ul4cSmF0KTR6hyaxEnjiNXlNlE=;
        b=Zac+Mu20vSIZ5nh70WwJRAyQQNB89aChMrwexHCTU/JbrwH9tJVCP9PvWR/tBu2c3G
         uJS6FayomV0p4JlM1fXMIsULv6g2Ppj6Ti51q1AJsEH8cE6Onag/jQxgfTvGqpm991px
         qRy77OXEqStRVxClEHNMmrJzx9KMBuhCccXhx94XoOiIVfeLrol03hnsU0qvZFVhsZ+t
         2bWoiOTby86UtaM60yEp7M9ZHUAcqONgvxHT8xODiDKo97aCBwjnYcacCgnVTRwtuobU
         wvk3SBR5XBtHLAvWZHrZX2Ub/WUV2fJOG2RgYGZg/iJbbn8qlYU2l77SnxGGzXtb4Euc
         Ejog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778838878; x=1779443678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5EElz+2jxl13VfEl6Ul4cSmF0KTR6hyaxEnjiNXlNlE=;
        b=D+MZEUEmOC4tqmhraBoNMFOic6abgN05kQycXZEsHIsfHSwijoGlmMDooMubucwiKS
         dyxnWTF58InZ5FgUIT9ENMO69Swt7PRfRKlv6mwpZW1Gr9GPmggCKTy99caNxyQaxMrJ
         uWoH6NKi0Fzurm/4BJMD1nAnzVMenBnzAgOFOu7kj42U16rjd4jjok7bbbMHfH9Ta6eX
         0d0+FOXYaEkYtilOYx4d7h1rxXxjzKITim4ssGUcYNC65bTF2yU+xoAyUox8RLLmrvM4
         BaheX2ZDP2tXA93DDESgQPXFBNGzrekgF2sICtJCxyZsZVjJhxswwOFdRojhyFo+6uo4
         p9Gw==
X-Gm-Message-State: AOJu0YyLgpVlY5KVhIZ67LMCzPrW3x8gKZx1MCMG9/0dWHxETnmQTH29
	oyy1/6kUmqDUBqeQ82dhf7oyjFHg92EG0qw1YopMX42mM5vygllzRoP49Lu7fpIS3TeMcmq8fdO
	QDAYqx2tRt8B7z6AKHjoi7jA20HPecpw=
X-Gm-Gg: Acq92OFpqREgcvd3EihaO6qkPAAWLImDwfq0BjpW5JOtFYQsQwBx86ruLgJuiKAnpVO
	YkCXCKVZZY6/zfydH0pFNlkPevFHQPj3zCGJabxbe2p3Z0iBFjaR2uHN+7A/HUutWPjDbBOgBjD
	e6OSW546kFn6QFd4XOl84laQ5trXKurBR8wN0VtSDl1zgvzGSvd74//SY66vQ44s6YXylcSF32t
	fVRw/Jj3o9nVjOPrhV8o4W+8TMdysnsDyfuWfgpBCYYoSmzIRQ83kygfdNJf8bjbCHjyZeXhJWJ
	gY145yQ+jH4jdveIm5UhycDwR5kr1ppN7uDFEUKCoXn1gTPsC/4dM+NIfovl
X-Received: by 2002:a05:622a:a1b:b0:50f:c109:b78 with SMTP id
 d75a77b69052e-5165a27f690mr37826721cf.60.1778838877961; Fri, 15 May 2026
 02:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
 <20260513-yuantan098-bugfixes-v2-4-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-4-863e9caa2a57@narfation.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 15 May 2026 02:54:00 -0700
X-Gm-Features: AVHnY4JgnFKwc7UzFU2M6OHRsJF05nTQbRKQ7BYR1MBFK-NEb4BVysrnvBpv6jE
Message-ID: 
 <CAPuPA7+5uDy5JX1LR_etpVwV3UEmWir-E+7dgpMH96Ca5MQjAw@mail.gmail.com>
Subject: Re: [PATCH batadv v2 4/5] batman-adv: tvlv: reject oversized TVLV
 packets
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, stable@kernel.org,
	Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: yuantan098@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: I45SE3HHRAILHGB3PWT4GUWTXHEY7QZB
X-Message-ID-Hash: I45SE3HHRAILHGB3PWT4GUWTXHEY7QZB
X-Mailman-Approved-At: Fri, 15 May 2026 11:58:18 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I45SE3HHRAILHGB3PWT4GUWTXHEY7QZB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, May 13, 2026 at 12:01=E2=80=AFAM Sven Eckelmann <sven@narfation.org=
> wrote:
>
> batadv_tvlv_container_ogm_append() builds a TVLV packet section from
> the tvlv.container_list. The total size of this section is computed by
> batadv_tvlv_container_list_size(), which sums the sizes of all registered
> containers.
>
> The return type and accumulator in batadv_tvlv_container_list_size() were
> u16. If the accumulated size exceeds U16_MAX, the value wraps around,
> causing the subsequent allocation in batadv_tvlv_container_ogm_append()
> to be undersized. The memcpy-style copy that follows would then write
> beyond the end of the allocated buffer, corrupting kernel memory.
>
> Fix this by widening the return type of batadv_tvlv_container_list_size()
> to size_t. In batadv_tvlv_container_ogm_append(), check the computed leng=
th
> against U16_MAX before proceeding, and bail out as if the allocation had
> failed when the limit is exceeded.
>
> Cc: stable@kernel.org
> Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/tvlv.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index 8129a3f9..4e2a9ec7 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
> @@ -12,6 +12,7 @@
>  #include <linux/gfp.h>
>  #include <linux/if_ether.h>
>  #include <linux/kref.h>
> +#include <linux/limits.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
>  #include <linux/netdevice.h>
> @@ -159,10 +160,10 @@ batadv_tvlv_container_get(struct batadv_priv *bat_p=
riv, u8 type, u8 version)
>   *
>   * Return: size of all currently registered tvlv containers in bytes.
>   */
> -static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
> +static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_pr=
iv)
>  {
>         struct batadv_tvlv_container *tvlv;
> -       u16 tvlv_len =3D 0;
> +       size_t tvlv_len =3D 0;
>
>         lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
>
> @@ -314,12 +315,14 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_=
priv *bat_priv,
>  {
>         struct batadv_tvlv_container *tvlv;
>         struct batadv_tvlv_hdr *tvlv_hdr;
> -       u16 tvlv_value_len;
> +       size_t tvlv_value_len;
>         void *tvlv_value;
>         bool ret;
>
>         spin_lock_bh(&bat_priv->tvlv.container_list_lock);
>         tvlv_value_len =3D batadv_tvlv_container_list_size(bat_priv);
> +       if (tvlv_value_len > U16_MAX)
> +               goto end;
>
>         ret =3D batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_=
len,
>                                               packet_min_len, tvlv_value_=
len);
>
> --
> 2.47.3
>

Reviewed-by: Yuan Tan <yuantan098@gmail.com>
