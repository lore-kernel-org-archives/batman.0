Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14866C021AA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:59:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A93EC8426A
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:59:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124779;
 b=kfTCY9kY8x5sHaen4vnaIvL6/U3696j5LeplKqUxvkaoKvmt9Ri86oxvY+LMJR2zabVEd
 pgD/jqn+XupbhweG2pbvKTlDdYOcuXfhaXQ8b3VIzsHiHfpZfrWShfdAEr+fybhjTzzslyC
 LSV9UW8lOzWO7qDC1dp40CO92031L00=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124779; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
 b=21YiaHFjTtRw05W63KnKCy+a6vkIA6ExuQLPFBuvKS9i0I55Zoi0XjPgQGURj59fC+VZN
 l22kmUe4zKCo/aJ/uSfJNQZ28nQwl/S4MBOi24UxTy526rPTUBl4S/NIdBPemfLFRPAopRR
 LQBqBvknidXnTRf1L7CtSy2fBUfB9PI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D16FB80DF9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 08:35:04 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740123304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
	b=ovDtdqANrZHfY3WxBdk70frEMk+vOrBQXfpIphiyIMqkS5CgsqBff5a7bc5D8RBikHDPwN
	FIah/ajf43tPYvWczaZmDEVUtOAh3VHra19C50nLszlUa9GKrZntXNe0NcaVKhGsB1b9I3
	lEueRut/DqteVG8aIWeK6irBwX+pOok=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740123304; a=rsa-sha256;
	cv=none;
	b=pyqwmiu9rTr6HFUqGt5kZGnCBetTCkfKnWX5xLnsjMShxB0XReSjV1jKdAkbMb/BAzu9Uo
	4ZF6q2db7Wt7vaVGXbzQBP4vEZjLPDAKdEG6fS/sCrMXjaSdACLzUOAQJV+vQRX65iqZRs
	CBWdvlMxYWUq4AZtaeNka5EZnh4gsw4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Se5FajY1;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::436 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f378498b0so1451413f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 20 Feb 2025 23:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740123304; x=1740728104;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
        b=Se5FajY1x0BIWFIHY0qCXeX0MdJ6UMHyBe+rhNP25qqFtoSvnpsHOkAc+HhNeeB+X0
         YXlDQrqiXUbq19NlVozNIyLXCasywB4iz2Vtu+w6CkzKJdacyoa/zH7A28PwTZkbFuxF
         Sx+RuFjOfeczvbnw/uCLrQVZM9xj10c/ENHVuMcGn9RSZn/IteUz3TQZnqqGJchS+hJH
         tGFTOd0c32RnYHAIXpRMzk7R4ua+eo6c3NcCGT9vU2hOCyQQd1K1eSz11Ww4atiRT9IF
         WSEbub393a//bQoqyXtSZIobdhowxmH9yJ3twkk7O2FvNmf8vXhNGZejjzceY/gI7yVp
         oYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123304; x=1740728104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
        b=U9wFCRnFa/71k3ujXfSSxiuFxSWgbE84rVLgvD0Ht5iYpeD4iKb9uho5VInStAv8TJ
         x0+MkDd5OOXbGy+Uy+ImHPxSaKJyD5G0QpJ2GE2YbganmVKbiEoHIYNeoG8FvZ4OhDjL
         8o1CBkKv8F7ZjvRNRS+u8F6rGJ/y8YlRW5tlAHPWyIEGXPoK6r7EO2tnaZzDcHTVK01O
         LZoo2qv0HR8y1dbD56uwcb7CRTb6cJ9iHUXwP3MEX73gqu2Fs0ewuoswB5ImV0pzhDm7
         6TTG4V+yD3gm08PTmTAoReMwQRxaKErmZp+1UpEykqTi1vyo/1NP8zreBQtEnpchQ6A9
         EDRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX85PnjfJXvKjbE9FQHPNC/jBu5WO/AeWbLmKu9mPVsM0K8zPHoc7rZ340G83AsW32Mw2RKn0na41a/ig==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzUPYfiNkqrIwAl0VbpFnPaN9kqQkEqvRJjt1Q2sPFL09qNJMkm
	DiwNGr6BaDfUV0KFkh00T8BGx6pRFaLvwPkI5XUUINvMfiHVX9wR64Py8AALrdwsp4geqyIXng9
	d942Emo8FzwPbBl1kuTn4E/lthj0=
X-Gm-Gg: ASbGncsbR2whKtdNf8jJaIjJQKa0odAVMAKKN6GJ18DnB1hoPa5G+x2djrMNqYjz/uA
	XCc0dd3emQOB7e1khcZoINL0+sBsc7SqnQn+COJJU+vmnR7oolKHCpCuJanCK6fTosLo5VzRoCL
	VjY5EE/g==
X-Google-Smtp-Source: 
 AGHT+IEnf7T/XWdU9Kctt2h3J5gBBMYg3Bh51JvuIgDPQVVK7cGhz8HpBuMv8GGd62Uk1SqkypkvwsyahBFfgLBFMsQ=
X-Received: by 2002:a05:6000:4026:b0:38f:2856:7d9a with SMTP id
 ffacd0b85a97d-38f6e7563cfmr1756891f8f.3.1740123304054; Thu, 20 Feb 2025
 23:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20250219125039.18024-8-shaw.leon@gmail.com>
 <20250221040641.77646-1-kuniyu@amazon.com>
In-Reply-To: <20250221040641.77646-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 21 Feb 2025 15:34:27 +0800
X-Gm-Features: AWEUYZnNy9JuajIA_7tDw52YSOa4CSIEVEzv6mMTGyYFjN7-s6b2UXlhoSAg5e4
Message-ID: 
 <CABAhCOS3BC+spLNrb_P8Ovzo18BwHU6UEc6Aq80_YKUoc8rfMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns
 before registering dev
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch,
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev,
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org,
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org,
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org,
	stefan@datenfreihafen.org, steffen.klassert@secunet.com,
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 6EDYPZZF7K4Y3TROUZNBXYSZFSVB3YEE
X-Message-ID-Hash: 6EDYPZZF7K4Y3TROUZNBXYSZFSVB3YEE
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6EDYPZZF7K4Y3TROUZNBXYSZFSVB3YEE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, Feb 21, 2025 at 12:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Wed, 19 Feb 2025 20:50:33 +0800
> > Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
> > ndo_init(), which is called in register_netdevice(). However, it lacks
> > the context of link-netns when we enable cross-net tunnels at device
> > registration time.
> >
> > Let's move the init of tunnel link-netns before register_netdevice().
> >
> > ip6_gre has already initialized netns, so just remove the redundant
> > assignment.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> left a small comment, but not a blocker.
>
>
> > @@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
> >       int err;
> >
> >       nt =3D netdev_priv(dev);
> > +     nt->net =3D net;
>
> This hunk is not necessary as we'll call ipip6_tunnel_locate(),
> but it's harmless and not worth reposting the whole series given
> we are alredy in v10.  You can just post a follow-up patch after
> the series is applied.

Seems ipip6_tunnel_locate() only sets netns for newly created
devices (for ioctl). ipip6_newlink() is calling it to check for
conflicts, so we might need this line.

Thanks for your review!
