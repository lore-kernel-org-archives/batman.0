Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D4DCD4F25
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 10:26:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C3A585BAA
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 12:26:28 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778754388;
 b=vCiLW4VU5vy0F7OpL/kNmsMvydXAECOZlVqY7bniPfIhpOrhdaR2MY5xcAA0+cn7G4+2o
 13Yb+h7o8PghYZnqd8mvxmjRzjBKxU33sBkhcZPG3pYBq+gSGaL1JK5aOCZw9707qYzJ4/z
 r6zBLupAaJmP2lc74lrP9hzXksLs8Po=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778754388; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hZbf5xZ7vG2nz/jMN/6J45eHu/xua3eX62uyODUM3x8=;
 b=a9hyM5VkjUMTswHyeLw3wBPFCQroQLL/mXc/u03j/cddNtyfLof6nnas3s/a15Z39MNKT
 LMZ+kB5+ICqP4WM4ZwtnnoDJWdT4D7muYoY1J7oPA16HgN7LVamaMfyjYTY2qvNwjCPY00k
 O7Hs8sgX3Ly4A3H+zQzmxY9PCTyBdsM=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3613281FD5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 12:23:54 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778754234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hZbf5xZ7vG2nz/jMN/6J45eHu/xua3eX62uyODUM3x8=;
	b=zhDY2NynBOWDVfEuy+kyQFaVV8wAuWNoWpZMnLrLu2L0SHh9OgZsIlLXquNIywEx37Yysf
	xzAknIBBv93622Nkeoe1m7nfo6MSfF9tj5N4mp1KyPA9Jxcr7zUFVSGnT5LAexY3VDEriL
	i7EU2LlHJn0g13q4Q7WDKKS85mLe4Dg=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lJOLop6K;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of yuantan098@gmail.com designates
 2607:f8b0:4864:20::736 as permitted sender)
 smtp.mailfrom=yuantan098@gmail.com;
	arc=pass ("google.com:s=arc-20240605:i=1")
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1778754234;
	b=ukJmJ/Lhw4ahHTEujCde9ymX4n/FqV++hJZbOrek1VAOaWUMQrESQnstl3SNd9GXaLXGDg
	f8rUFmfQhzkVzXI4hhMYoV61K9VrQxD+6+4CYs4AvmTqD5ZHE7TZrLKIyqv4bW2cq5lTla
	0hMxDuQUhu2++KMW7Vlh9DwpImlUtRc=
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-9103019f8c4so166256385a.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 14 May 2026 03:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778754233; cv=none;
        d=google.com; s=arc-20240605;
        b=QDjeNMlgqCvkS6VDIElSwRfNcXL4A/Bvn3VdFkTo4P2BvRUvxCMGBP7jZWY0BZhM0G
         HaYmnfQjWFVKQRpFHDGjDeVe5mRYbK9Nvrtq2CdtzwZyMLzNH6o//iD6XniIZIcUW6LN
         NS5Vg2zcFHq9TwLVIjZ4PDsGK5bVoPOKdT/ozgOrRLH1MoJuv7e52DfkyDIvwYbptbHc
         qcbNqnRAZzhC/8BQ5/QPQF3B85vuQyMejuZu5FaUKqn9klhL28coTRoxY2qb3iEynrv3
         wS3AVpumGef/HsphGpm7wkS85RMxNO0n5rBU0DuJigYbBUjmY91dhJMRmn89OrOViicV
         6/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZbf5xZ7vG2nz/jMN/6J45eHu/xua3eX62uyODUM3x8=;
        fh=fGpATJGdA5gBFxywIcayagIpQImFJ7uNKXfLW6dnd4U=;
        b=HaXNrvQwOOt2hHd3qx14Ao64xkA0ex+ijuNODUFTvgoiaJI51DKJfOut/cGVfDxMeR
         YJgRlg2dgJilyBCDZeAwqgmP9jN7KZtXVVucEL0uYzrkHdm3ClpWVXuZeXNDpIPzT0n5
         0OLLsKEL/+aa+qBHvQrKfIsmQPf/13+V4A2j60Tfcn2sc9XVPWT+VXwXEhdgWs0+Jd+Q
         HK7BxoKuX4CxsQQfpsOFBKvRlRjOYk+IBbkvMv1fEqSVaCEzZrj+dtb4Rqiwo4nYdm2D
         gq9bq7fCLNtN2TzNTv/CkK+V929l0+UPc3ztc+58duLR3kIpHIMdIF5FiV2q2QHLN08I
         r5TA==;
        darn=lists.open-mesh.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778754233; x=1779359033;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZbf5xZ7vG2nz/jMN/6J45eHu/xua3eX62uyODUM3x8=;
        b=lJOLop6KKo3a4OAmeXDFkab0zoEyxvixPiplP6M2jkJORfoxj0WHplP7kLvz7X3q3h
         UvuJTbas2bBgN1qfWbLBj8aTDsl8FAZpDIOOe2T7ZmRWTSUQnDh8DouXq4RfTCueCGp0
         7jOv/mCAK6898PecY+r4rvK7ZuG95ZYzKJRCcuIEdLvE1qKigjOnwUVohj1AhvOaMBh8
         YPa+N2R8HdgXlxsq8R+Pjl3+rhx8oVAMzpkirHhHJQ4GE/dj5zyewBX8QoO+sD3xUJzI
         36m3UAQM0M4saaBBBmTf0IpQwVQu4Mvp48npvWZfrOAQqUQSqWKOdqZKh+8ISkCrzUc4
         IjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778754233; x=1779359033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZbf5xZ7vG2nz/jMN/6J45eHu/xua3eX62uyODUM3x8=;
        b=f72zNEMQvy2Ykids23arWccGEOCKUncWINKN6DwunfKwChYs0+gQ2PKtRt2eLGjODv
         8q3WwnX1dy9957RZ6YIDl2iW1CT6CZLf7uoAm6zSZAI2g9q7SKDe7997zySr7/1XRbm9
         xBzLjDUJ6KwfCZ/ho3NKOI1GT1AiHZp0AhQq1f6dKKZJ9OS/3poUQ2zCCDKCcrmdw6Ii
         ooOnkhr9yEoN2m1vsi46AZ/Yyn7bfwNy7BtyPQ17dayIM15HVsc9/Lyi4SW5Et20H2W0
         QvBvFFqk20lOXn2xhQ7g08PeGuyHjRh7bkY6zNFaiSiJF7g/4dD8x4mKPaOxRWCMbrNy
         C/2g==
X-Gm-Message-State: AOJu0YzIQFQpvOONxwgEBOoXWBhv8NlAchlUaFbJKD1JQTg8wKQgTNnU
	fiOI6slSz/yeZvkFHbSpdv7TdnKh7oTaldGMp5TgVFkiH+HuprvjEyfER39PWvx7VhcHktCIOn0
	/JftpiPowExIYiWr8TCHYL9KRVUPYDwc=
X-Gm-Gg: Acq92OFUO9Wh5Md8wtd8MctvUVdc2rMUtDk+y0Bz8poz8SmUMWZDfPIokSFK277VZtM
	ZWBhUwKdenxZIzXQZZLHWnPuruTeiOTp9AD88yDQ654kQMI7EXLz6qj4HFF2dqZx3JGa94Z0yUI
	u//qALV2Ki1P0lg3GNABZJ9WiPLW3CrAjRLgLbYelMOSlFaG8uSsRmfzW/48IriGAb0Kvpc0oxz
	3RKNvN+zAVXVfx5VFq6H/rAHFCQVChk79KEweVkjr9fs+vAQre7McZZ22t5bEYKeXp343utzcWT
	UiiG1zZX
X-Received: by 2002:ac8:7c47:0:b0:510:141d:9d03 with SMTP id
 d75a77b69052e-5162f434aebmr95776781cf.7.1778754232825; Thu, 14 May 2026
 03:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
 <20260513-yuantan098-bugfixes-v2-2-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-2-863e9caa2a57@narfation.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Thu, 14 May 2026 03:23:00 -0700
X-Gm-Features: AVHnY4IfJWtEPq-vMXGG3L4NrL52CVZCHh4k8nnYOzb7trF153MX9fHnw8Utfis
Message-ID: 
 <CAPuPA7KrZcdrHm6w-qZe2BEgt-JEqLt3kT0NXQZBTA84vbcrKQ@mail.gmail.com>
Subject: Re: [PATCH batadv v2 2/5] batman-adv: tp_meter: avoid use of uninit
 sender vars
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
Message-ID-Hash: WA72I4N6QSSFH7NIWOVJYURIO2YTKRGP
X-Message-ID-Hash: WA72I4N6QSSFH7NIWOVJYURIO2YTKRGP
X-Mailman-Approved-At: Thu, 14 May 2026 12:26:05 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WA72I4N6QSSFH7NIWOVJYURIO2YTKRGP/>
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
> batadv_tp_recv_ack() and batadv_tp_stop() are only valid for tp_vars in t=
he
> BATADV_TP_SENDER role. When called with a BATADV_TP_RECEIVER role, it
> proceeds to read sender-only members that were never initialized, leading
> to undefined behavior.
>
> This can be triggered when a node that is currently acting as a receiver =
in
> an ongoing tp_meter session receives a malicious ACK packet.
>
> Guard against this by checking tp_vars->role immediately after the
> lookup and bailing out if it is not BATADV_TP_SENDER, before any of
> those members are accessed.
>
> Cc: stable@kernel.org
> Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/tp_meter.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index ca6c3f63..a3593d10 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -664,6 +664,9 @@ static void batadv_tp_recv_ack(struct batadv_priv *ba=
t_priv,
>         if (unlikely(!tp_vars))
>                 return;
>
> +       if (unlikely(tp_vars->role !=3D BATADV_TP_SENDER))
> +               goto out;
> +
>         if (unlikely(atomic_read(&tp_vars->sending) =3D=3D 0))
>                 goto out;
>
> @@ -1101,12 +1104,16 @@ void batadv_tp_stop(struct batadv_priv *bat_priv,=
 const u8 *dst,
>         if (!tp_vars) {
>                 batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
>                            "Meter: trying to interrupt an already over co=
nnection\n");
> -               goto out;
> +               goto out_put_orig_node;
>         }
>
> +       if (unlikely(tp_vars->role !=3D BATADV_TP_SENDER))
> +               goto out_put_tp_vars;
> +
>         batadv_tp_sender_shutdown(tp_vars, return_value);
> +out_put_tp_vars:
>         batadv_tp_vars_put(tp_vars);
> -out:
> +out_put_orig_node:
>         batadv_orig_node_put(orig_node);
>  }
>
>
> --
> 2.47.3
>

Sorry for the delay, I was traveling and just had a chance to review the pa=
tch.

Reviewed-by: Yuan Tan <yuantan098@gmail.com>
