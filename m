Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4B3C761AE
	for <batman@archiver.kernel.org>; Thu, 29 Aug 2024 06:15:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 28EED83CB2
	for <batman@archiver.kernel.org>; Thu, 29 Aug 2024 08:15:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1724912106;
 b=BN6EcLVMF4lUnSRZs/PrOLTMawIgVG0rf0MR62im0RS50nrqqjCi1+BYu8EgKD61gH30w
 atv8AyLf/QASAF9HuQe7Y/naD65OiDM9EVixdaVC8M8KVvWie5Ak66WACaFUI5dTIRzNHvP
 p1gO66A03XeeG89RXKP7J87UAlR3tRY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1724912106; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
 b=ggiiX13pSOiFJ6aVelxvei8UADbMtZPskULfeJ1+6vOpe21AkJr/r3kN0rydTQQrwVz5E
 qTM/oT3Y4J3xYo5l+j/PvlCydFsdIKpMJ8TSga6t9y85ZrB2+gzy1Le7puKjPDtGiMmaMov
 g4curbYSCuxpZxi+VocWb3ceZEVo5VA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=ucr.edu header.i=@ucr.edu;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=fail header.d=ucr.edu header.i=@ucr.edu; arc=pass; dmarc=none
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1FF2C8276C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 29 Aug 2024 06:30:36 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1724905839; a=rsa-sha256;
	cv=none;
	b=rcGfQ5F1msXeyb089xDCLTiMKrLDxF4592sdkrJKVRsg7L89WHWWvikLbQOrfc1P82hg/4
	y6i1k9HIBXdC618d3xmQVxrg9B0ToCGpIg7Rawe9QnsfFJaqNKoZk+UutG4Rc1SISrMdE6
	5HN9HnJfuTZ7aAeDDgAY9HJnbQmpSa8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=ucr.edu header.s=selector3 header.b=jEl25g7N;
	dkim=pass header.d=ucr.edu header.s=rmail header.b=JXou+Ddw;
	dmarc=pass (policy=quarantine) header.from=ucr.edu;
	spf=pass (diktynna.open-mesh.org: domain of xli399@ucr.edu designates
 169.235.156.35 as permitted sender) smtp.mailfrom=xli399@ucr.edu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1724905839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
	b=lUwmIBtE3z+fiwta8bB64b+2+GmD6tLyCR7LT2ESnkaQlynAtT90XWsXmdwH+rLhCT85Oh
	eS/y0zRmgdTILgfWEBKyqmAM9xc5lPEz/mmSP1GTqvgkvKg9ybR9cjehRpK9tL1H6YBpD+
	225ZlBnPxq5KcMeNC66uEQ82bNbRZyE=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724905838; x=1756441838;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Hm8X6G7US76DjH1BlXkmp5j9VJxJk6hQZ6v/aVdZfiA=;
  b=jEl25g7NL1N5bE1UWecJPC9ZKLROI8w7nCr63xd8v0nVzERswM+NgWeY
   TeTGOKdhui89A3ItzK6Xo8Tt8Fh7GoVsa2P5yxlfEv9F4PJd9Z38rKAFK
   I1Zc7ttv00E8r4gdS3SZRf0vO6ecWFLJc9yYL54i4V7b2tmSeDoNc7qcX
   +vSrrqcbqRa7kWTPj0GrIpE4T10s9A/me3a6XIKcrd/fB1CQ9aQsQo7ra
   3arGkSfb1PPqlYL3sgQacjiV2jXO7yE3jhJbD92e0W5eokuxE0apFIjx5
   2h1DTEbzaBv7ze3mqrEkHIeSQBSctfP7rfTxlxGLJ7TbjzaqV9DdCLh+N
   Q==;
X-CSE-ConnectionGUID: cAtByA6yQGunoNDeu+VGEg==
X-CSE-MsgGUID: p8LIOGYITP2zZIqrDp7LeA==
Received: from mail-il1-f200.google.com ([209.85.166.200])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Aug 2024 21:30:35 -0700
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-39d5101012eso2079155ab.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 28 Aug 2024 21:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724905834; x=1725510634;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
        b=JXou+DdwZurxPRKSDG8O/qvIot2jNthBFhjftHbtwkFMYNucTKTy0BtSeDrS6AWT9I
         8Qx4CeYBgzIu8zevw2+dAjm5Pek/rJxbxfKpVIyYsSrevIdtMvF0A6qy84JLs+wtcyY/
         DX5dvlxzEqweqEzpzySuOkkQdxzvUKmGig84A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724905834; x=1725510634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
        b=HXVJMDEx73wemS4Z3NCjxf9+WYcpWHqMJ2eVCtiNPanzC0fy/l74SRnQWNyBM2csFS
         7O5xlJiAQLgkRBAqEFKF1ymz63vqHniXq20WoHeVQZpAR6aobTeHfNpfOTIrOcF61ocD
         wxv1AVPaoSVJGh6nz1RG9yDmCaYLJEFnNIK8cKE8m8yC5FVRIPR21YHlp1IP+99XDhNH
         abk0x+zpl0Xyvbn2N2m8irGIal8TflW8YIkS+MvOZuZvZ7Z8z6exoJ7htkARC7vzT7iy
         z4aAZuJyJUyI/pie4GUk+NHs+6b8MC5PFXMVVIS27p4yLSuhSq1Moet+S3T+t4T7Vt8n
         bKmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdsp2LF366odHaT+E+XgDyt/iWc+viwx/8nT2yrh2r3rPHVNH6OQpWNx4uJQ5uCOMM404VPGFVNGkoaQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YziDFWg+kZh1fNIRLJulkK5CZK78s8RsEk9EeKJY4MHwc4POY0P
	UhfLMw1VoMFRQJBP+uSrCqrQVvIsI4kFXWjGWIECDrn7PbZRyOzPOQKd7FIF3njE+jZ6B9WmkuF
	wedX3xOLlLFdxzn2qJ4JaU3hez1y5T7gk9zovX/wjyxcbvjdgHQQMkPGjRgeOuDiFD/vY0EhULQ
	EJFUyDgeAPMKoQkcjYJMlj+d2LfMCr7iPsRaoPnnTWYQ==
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39f3780c6f7mr24796695ab.13.1724905834305;
        Wed, 28 Aug 2024 21:30:34 -0700 (PDT)
X-Google-Smtp-Source: 
 AGHT+IGQ8G4yBQZl8uMVmbjN2GKvaVb134BrRd4Eeb8qtEDfsvzBlguVr1+MIJ/adcXERyfRH9HRB6shu5q79ziNrk0=
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39f3780c6f7mr24796515ab.13.1724905833918; Wed, 28 Aug 2024
 21:30:33 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
 <13617673.uLZWGnKmhe@bentobox>
In-Reply-To: <13617673.uLZWGnKmhe@bentobox>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:30:23 -0700
Message-ID: 
 <CALAgD-7AOA0At+y0BR2MZ0WXPFM03tQneRbeGZQqiKy6=1T0rw@mail.gmail.com>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
To: Sven Eckelmann <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: xli399@ucr.edu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 34GHSK6OXOIY3RXJFHNNYYNQVH7MSMA6
X-Message-ID-Hash: 34GHSK6OXOIY3RXJFHNNYYNQVH7MSMA6
X-Mailman-Approved-At: Thu, 29 Aug 2024 08:14:41 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/34GHSK6OXOIY3RXJFHNNYYNQVH7MSMA6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Which line would that be in your build?

Somehow, the bug report does not include the line number in my end.

At the moment, I am unable to reproduce this crash with the provided
reproducer.

Can you reproduce it with it?

Sorry. The above syzkaller reproducer needs the additional support  to run =
it.
But here is a C reproducer:
https://gist.github.com/freexxxyyy/0be5002c45d7f060cb599dd7595cab78

On Sun, Aug 25, 2024 at 9:24=E2=80=AFAM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
> > "hash =3D backbone_gw->bat_priv->bla.claim_hash;", it does not check if
> > "backbone_gw->bat_priv=3D=3DNULL".
>
> Because it cannot be NULL unless something really, really, really bad
> happened. bat_priv will only be set when the gateway gets created using
> batadv_bla_get_backbone_gw(). It never gets unset during the lifetime on =
the
> backbone gateway.
>
> Maybe Simon has more to say about that.
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
>
> Which line would that be in your build?
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > Syzkaller reproducer:
>
> At the moment, I am unable to reproduce this crash with the provided
> reproducer.
>
> Can you reproduce it with it? If you can, did you try to perform a bisect
> using the reproducer?
>
> Kind regards,
>         Sven



--=20
Yours sincerely,
Xingyu
