Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6101C02194
	for <batman-adv@archiver.kernel.org>; Thu,  6 Feb 2025 16:38:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 64BE783EF2
	for <batman-adv@archiver.kernel.org>; Thu,  6 Feb 2025 17:38:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738859934;
 b=h1YCR6qrQNoEuJCoiKZ1aUsStGWvAwdT2a8cpYIO4F8R1gN6FYs/x3LmYwQkc3AHfMj3y
 MVeZQs5jYGXqm7fHm9tCGx97OJvKRyoSy6hQ8yp7R/mwmJDM6edJeW0+PWNQre31E+Rl1x6
 9z5z+B3HvlWPJRLQC09wXODi1KEUtNQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738859934; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+KdOMKcFzgnDfOmgNKtWwp/r3hPNm7tMk0Q2fozSuNc=;
 b=ZXCLMmLDBpia6kOCJvLPaPP6HRere3nWdt3VQNXCJnlzqNeQIk0HU4VJfWj21Wf2/38F9
 Pv6Ndwu7DfPhSPYVB9vNMJXTR2oWVxbQhKEGMiytTJt/bG1Xfk0GahP0enrGfFjT7WiwOF7
 lKm6wcJn4Bt7yI+bOCJJidH0wEkHbL4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=google.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=google.com
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=google.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=google.com policy.dmarc=reject
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D04568200D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  6 Feb 2025 16:25:02 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738855503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+KdOMKcFzgnDfOmgNKtWwp/r3hPNm7tMk0Q2fozSuNc=;
	b=BcHmFK34Gku+Ppitgz311/pSah6GgBou5Rre6EqAPVrWwqi9pHlJakdLLQ6b6k+nQf/yex
	crLDmfL710F013mn9EiVlYACASVHWWK1ri4TjSHFPr9v1lisZn8uOc0GHdSuobQu+FsEzB
	tJCSQIYVrMGjjglXU7VSkbpN74CrCIM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=google.com header.s=20230601 header.b=ETlseoJP;
	spf=pass (diktynna.open-mesh.org: domain of edumazet@google.com designates
 2a00:1450:4864:20::534 as permitted sender)
 smtp.mailfrom=edumazet@google.com;
	dmarc=pass (policy=reject) header.from=google.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738855503; a=rsa-sha256;
	cv=none;
	b=GZV5qvlV1LLynmPCfn5VkFPFmdzNvFc5COHAfvOvL5w4TluDj2YPFGafoLPSLwDGbEALow
	OEtUz9B3y/AJoL9XSJzFtkLtWQibhWuxKn6JMCsw+Vsf0mspeivJ0aaFgeQnwEV1B5MwSJ
	ev42sec1L0mUTSeofGlRCnjQgczvjQ4=
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5de38c3d2acso606710a12.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 06 Feb 2025 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738855502; x=1739460302;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KdOMKcFzgnDfOmgNKtWwp/r3hPNm7tMk0Q2fozSuNc=;
        b=ETlseoJPXcWV+G4MP7St1TaOxty2sw1dQFcXWa9yoIcoAeB+4heLAQFJ5uBcKOqpJZ
         QXZZGT90lA3czv9N4s2ondqzX2snkLDqLzerr6Xmdj5zmXib2bz1SIUUEV81lgL3QN47
         wuhnIbqlDq9h1pvQ5tN2+sefdrCpxj49nK168Y5UfGq9Vcb223n9Dx1G60dxFYc8rpHN
         kIgxkdZezNSRHd2xzpbZUMoCYnG957K2gtM0jQ04V39cVE0qFT4jqSdi9bbZQxzif9BI
         MdfQ5s6jZxeEnW6QYBiofkZNew4uAqvOVwk8Qlt0zbIN8xKm+RvqEae18eXwagEKgGyG
         eoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855502; x=1739460302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KdOMKcFzgnDfOmgNKtWwp/r3hPNm7tMk0Q2fozSuNc=;
        b=cOPYxYAcKEa+bVaZe45gPqm+I8wLYQoRd9cybtgf7G9+TMdzirfip07Mg5G5lR++GV
         fEvgDBNwGY1AC2gTdo9dYaV191W4KGfMbI+JNDrmac6l8oNxte3fAsqEPGb5lFSXC+zE
         HH1FSdIdPvuq131VHk4wOzAUk1zTBch1U3mBQzDG3DpPnLohNwjUr6J/5j+hVflnUqGA
         G/Nx4DMpeqWB1KUnSlIAc7YKsBKJtX7Dsm95Q2QKku05YMoM2BAyNa5qeE90vgyzElso
         tshgAF6JxcQ/JGB+kdrlh4oD4AixU8km3j7fjVn6BzLF7g3c3Gqakacz+lBrTFMi7t+g
         jvJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdJ/BhRZNimp/CTHfO7yphYD6eYXePiDIROprFRnwP3OR/Y8r1+WwXo3LKWeJj5Tu6+FJxVkQdBccLSw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyRhE51pDrF/v0YqGpE7E/ZuKyLlsg+ZwKnmqjerSwHNVf+AYLf
	HZIPPveHBRp+5DE9un5dx2ti+zTs4aBcpdWnMCzwpqh69l4Vr5pZVFE9MM/rCXwZeYMB6r4cOes
	G1y2h917sDDy6L3Gbqzpq6rsoqeV0max8dpd2
X-Gm-Gg: ASbGncth58ajt/IfuZfkryfO1yk3mcWGPNx/zMdQFT8PtSPlvqWNQAjromJIxweQqS9
	TFnvxdV3htLSUedsl0PqXxgkHBcwOkNVZyoI8kj82HTRMtLM9S/debh2TCONEl0LHSmj6EJW1dw
	==
X-Google-Smtp-Source: 
 AGHT+IGOHBlplyJ9pA4VMmcFSNZGwnfQEuUeNgaCGG6Eqk3N+5X9Zh5XzH6+ynGov9Aw1u3s6Or12xGt4LtoDXMTx2Y=
X-Received: by 2002:a05:6402:2106:b0:5dc:893d:6dd4 with SMTP id
 4fb4d7f45d1cf-5dcdb586859mr8621466a12.0.1738855501549; Thu, 06 Feb 2025
 07:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20250206140422.3134815-1-edumazet@google.com>
 <d729f05a-e5e6-4d67-8fe6-888e1e761b34@unstable.cc>
In-Reply-To: <d729f05a-e5e6-4d67-8fe6-888e1e761b34@unstable.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 16:24:50 +0100
X-Gm-Features: AWEUYZmLNMOyertnK904apoKkiVMcJPz0eX6UZCANJ8E7eXqNpVldUrAkNrzFFQ
Message-ID: 
 <CANn89i+ySFS5C24guM9E9UsPWfQBL69-OoRDbOGfih9vLGxDJg@mail.gmail.com>
Subject: Re: [PATCH net-next] batman-adv: adopt netdev_hold() / netdev_put()
To: Antonio Quartulli <a@unstable.cc>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
	Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: edumazet@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: H5NJXTT2EVMKQQK6WFNEWVAGFQNFTWBJ
X-Message-ID-Hash: H5NJXTT2EVMKQQK6WFNEWVAGFQNFTWBJ
X-Mailman-Approved-At: Thu, 06 Feb 2025 17:38:43 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H5NJXTT2EVMKQQK6WFNEWVAGFQNFTWBJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 6, 2025 at 3:13=E2=80=AFPM Antonio Quartulli <a@unstable.cc> wr=
ote:
>
> On 06/02/2025 15:04, Eric Dumazet wrote:
> > Add a device tracker to struct batadv_hard_iface to help
> > debugging of network device refcount imbalances.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   net/batman-adv/hard-interface.c | 14 +++++---------
> >   net/batman-adv/types.h          |  3 +++
> >   2 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-inte=
rface.c
> > index 96a412beab2de9069c0f88e4cd844fbc0922aa18..9a3ae567eb12d0c65b25292=
d020462b6ad60b699 100644
> > --- a/net/batman-adv/hard-interface.c
> > +++ b/net/batman-adv/hard-interface.c
> > @@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
> >       struct batadv_hard_iface *hard_iface;
> >
> >       hard_iface =3D container_of(ref, struct batadv_hard_iface, refcou=
nt);
> > -     dev_put(hard_iface->net_dev);
> > +     netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
> >
> >       kfree_rcu(hard_iface, rcu);
> >   }
> > @@ -875,15 +875,16 @@ batadv_hardif_add_interface(struct net_device *ne=
t_dev)
> >       ASSERT_RTNL();
> >
> >       if (!batadv_is_valid_iface(net_dev))
> > -             goto out;
> > +             return NULL;
> >
> > -     dev_hold(net_dev);
> >
> >       hard_iface =3D kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
> >       if (!hard_iface)
> > -             goto release_dev;
> > +             return NULL;
> >
> > +     netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
> >       hard_iface->net_dev =3D net_dev;
> > +
> >       hard_iface->soft_iface =3D NULL;
> >       hard_iface->if_status =3D BATADV_IF_NOT_IN_USE;
> >
> > @@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net=
_dev)
> >       batadv_hardif_generation++;
> >
> >       return hard_iface;
> > -
> > -release_dev:
> > -     dev_put(net_dev);
> > -out:
> > -     return NULL;
> >   }
> >
> >   static void batadv_hardif_remove_interface(struct batadv_hard_iface *=
hard_iface)
> > diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> > index f491bff8c51b8bf68eb11dbbeb1a434d446c25f0..a73fc3ab7dd28ae2c8484c0=
d198a15437d49ea73 100644
> > --- a/net/batman-adv/types.h
> > +++ b/net/batman-adv/types.h
> > @@ -186,6 +186,9 @@ struct batadv_hard_iface {
> >       /** @net_dev: pointer to the net_device */
> >       struct net_device *net_dev;
> >
> > +     /** @dev_tracker device tracker for @net_dev */
> > +     netdevice_tracker  dev_tracker;
>
> There are two blanks between type and member name. Is that intended?

Not intended. Also a : is missing :

I can submit a V2 if you want, or feel free to make the changes.

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a73fc3ab7dd28ae2c8484c0d198a15437d49ea73..8ac061379b6f72ef7f1d4e19188=
8db2cc56376da
100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -186,8 +186,8 @@ struct batadv_hard_iface {
        /** @net_dev: pointer to the net_device */
        struct net_device *net_dev;

-       /** @dev_tracker device tracker for @net_dev */
-       netdevice_tracker  dev_tracker;
+       /** @dev_tracker: device tracker for @net_dev */
+       netdevice_tracker dev_tracker;

        /** @refcount: number of contexts the object is used */
        struct kref refcount;


>
> > +
> >       /** @refcount: number of contexts the object is used */
> >       struct kref refcount;
> >
>
> We also have hard_iface->soft_iface storing a pointer to the soft_iface
> (batX) netdev.
>
> How about converting that to netdev_put/hold as well?
> See batadv_hardif_enable_interface() / batadv_hardif_disable_interface()
>

Sure, feel free to submit a patch for this one as well.

Thanks.
