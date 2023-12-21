Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7CC46CD2
	for <batman@archiver.kernel.org>; Thu, 21 Dec 2023 07:38:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D1A1083CAB
	for <batman@archiver.kernel.org>; Thu, 21 Dec 2023 08:38:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1703144330;
 b=Y869sqANMcETVXNQqlF9oomB58V9nUSvq8ony+VacOgag0YPC6cnKwBmj/i4FG2SuJGVg
 fFyyx2FaJA0DKQx8BOYMlmgyIO8lIWjW/lSEAMtSWwLD4z6TFhgYJkIL8ydPBBaaaI1ckvH
 fYDQuW+3GMcE16f2zHk/jE4Dlfd/GNI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1703144330; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=k1xF3EfpYFhKYiY3uoKZ+p4bjQbOeNjIm4BUl0JoNME=;
 b=pgJZ93+158Uen+pPcfD4vP8wAMpj+Q6ij1B5DFwwOA2J5veRo09HZ5K/CTPWlOjvjsHLQ
 c/u86cF0nGaDiEe3t3fQZL3bWHYaSRSefb7VO9LVMxUl/yTt5sSNRZxh8CmbyQX7XU18jYj
 r0GJREDg+DQAkH331dUCCt9Qh7bm8Bo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 59A9280D8E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Dec 2023 07:10:58 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1703139058; a=rsa-sha256;
	cv=none;
	b=W8QeI+5WmzBPkcuqtO3Z3PwWm6kTvL4Q974vZ0W97gzEqLegJcmScyfm+D5DAUJHJS2Tbu
	UPtmLSOomfkN1UMCetZHoNmlwM85ax/BGrsPSM5WrJMGa9jQs8vdLP2u6O0/KkolqhpwuG
	uysiUyf6l+qV4fDSn5xItawF4lIFaL4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=JK2iqYWY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of wnwlsgh98@gmail.com designates
 2a00:1450:4864:20::22f as permitted sender) smtp.mailfrom=wnwlsgh98@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1703139058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k1xF3EfpYFhKYiY3uoKZ+p4bjQbOeNjIm4BUl0JoNME=;
	b=ALZKkzSA+U3abkvE6q0ETVm6w7LDq8da47SKARxT0kAbb2K3faOhtYDy1NNEkRTU637oTD
	DMdVYLA7axjuZ0RN1zg1zs6hkp05+NWIY8kbRdxfEC1E0Q2SZ9sG/JJ8PBx9nJzMoxE4UH
	bVc/xZ3annY/1rw7FCHFHzEcVB/5CBc=
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cc7d2c1ff0so4223881fa.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 20 Dec 2023 22:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703139057; x=1703743857;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1xF3EfpYFhKYiY3uoKZ+p4bjQbOeNjIm4BUl0JoNME=;
        b=JK2iqYWY736BFwIzsh9/qPOHR7M96GZaH89/pfMDwacQNRDOdxFaH2opL/EuJu1gG4
         1E//GIHtJ18ypP2zne7htl+u2voGIs3KZfaI8DF7SivTut1zhb8c+mAQOepAFtQP5uYX
         m1d/lb+zxjxsBFK1+k1NCEtTAJ9/yIMq/pzVArhM8LYcom7WxnC5Jwp4CehMCoz8eGDs
         Duc/paIknyOzu6j3nSGEwhS5IXEwYsFvalLcCYtVStblSEQT2xW9ng03dz4I0yhQOYCE
         P/MXUF141PweF0gWQ6CwWFWLKtv+iQ/GfZFuhh1DFJZNcrPBzR9bIwTTJTfglLjV5eLt
         K8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703139057; x=1703743857;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1xF3EfpYFhKYiY3uoKZ+p4bjQbOeNjIm4BUl0JoNME=;
        b=efqvt+eBx5xxRzbIc+iQuqKd4CP9NBx0BqqvCG0zy3alX1yrBhusw1tZA0lYz5o1XL
         bAjJ/CNQdXFu/HLT/A1iDa4MB/86hlWqBb9aPdwiyh8vcu43b5W1eBD666sPpdaYDV/t
         SL6SHMv+WUerJYDjqZ4nGuzF1Nft9Atgk1y8FCVFEST+flx4VH4Q5DcPD64gmzl2vnHU
         LuM48EtyaVVk1aodouRyC59gP9JQJUK4TSVlWDb3m3dQrg80nCSlihsmcpVlWantg1wo
         ZiVzl0bLgSa3u8ZuDu1k/MG2894HjitHYol08BwMDyMMKp1quO3Ty5u6Xw5Uye+rfFiU
         Bhcw==
X-Gm-Message-State: AOJu0YyPrSmyJSnYr0LEz5OR7ag3+1NJbYPlwhcgWrZ6OtGs/sbhpfzm
	uhN/fjWJg/W9Y8egYAO4xb6mNAaKNstSFgxcKK7CzQ0fPbsrWQ==
X-Google-Smtp-Source: 
 AGHT+IFGZYVSeGOHxfrQsZ1wUZ33T6fnNueundDxmvGR4KtbIcGsR7V3UxeU3WtF7np3QrudZ2V8nLpRjL4E5ovYY4Y=
X-Received: by 2002:a2e:a0d3:0:b0:2cc:5780:6915 with SMTP id
 f19-20020a2ea0d3000000b002cc57806915mr4681016ljm.10.1703139056953; Wed, 20
 Dec 2023 22:10:56 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAF0rt23md=LtOu5_u4zTvZbE-cDwoJOvg7NRCqX-P=ZuQbidAA@mail.gmail.com>
 <CAF0rt22RUW1+SkMNZBCTL85oMckDxbnVJkk1TpUpwz=Y86Cr8A@mail.gmail.com>
 <2788364.BEx9A2HvPv@sven-l14>
 <CAF0rt20CDXotBSY=wrW3oWQOQmmpDmtUpP9UaL4QK7hnuDt_0Q@mail.gmail.com>
In-Reply-To: 
 <CAF0rt20CDXotBSY=wrW3oWQOQmmpDmtUpP9UaL4QK7hnuDt_0Q@mail.gmail.com>
From: Jinho Ju <wnwlsgh98@gmail.com>
Date: Thu, 21 Dec 2023 15:10:44 +0900
Message-ID: 
 <CAF0rt231R2FW9NP_f5HOoSQsCaK3XSZfZxbhTkKvqM0n7orbOg@mail.gmail.com>
Subject: Fwd: Fwd: memory leak in batadv_iv_ogm_aggregate_new
To: b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: wnwlsgh98@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: RMCUGLMUAIC5JIGDNGPLR7TGX6Q4QXA3
X-Message-ID-Hash: RMCUGLMUAIC5JIGDNGPLR7TGX6Q4QXA3
X-Mailman-Approved-At: Thu, 21 Dec 2023 08:38:30 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RMCUGLMUAIC5JIGDNGPLR7TGX6Q4QXA3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

---------- Forwarded message ---------
=EB=B3=B4=EB=82=B8=EC=82=AC=EB=9E=8C: Jinho Ju <wnwlsgh98@gmail.com>
Date: 2023=EB=85=84 12=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 =
2:52
Subject: Re: Fwd: memory leak in batadv_iv_ogm_aggregate_new
To: Sven Eckelmann <sven@narfation.org>, <b.a.t.m.a.n@lists.open-mesh.org>
Cc: <mareklindner@neomailbox.ch>, <sw@simonwunderlich.de>, <a@unstable.cc>


Resending to everyone on the mailing list as per previous mail, adding
some things that were missing.

Regarding the cause of the L2-related crash being detected by
syzkaller, I can't say for sure - what I can say for sure at this
point is that a memleak occurring in L2 was detected by my personal
syzkaller.

Moving away from syzkaller for a moment and shifting the focus to
memleak, we have to assume that the conditions for this to occur are
that they reference the same network stack and are found in modules in
L2, but it seems that when batman-adv is freed and returned while
accessing and processing a skb in veth (L3), memleak occurs because it
is trying to reference the same skb, the veth freed skb.

I'm keeping an eye on 'static netdev_tx_t veth_xmit()' as a related
function, but for now, the above flow seems to be the most obvious as
the root cause.

Jinho Ju,
Thanks.

2023=EB=85=84 12=EC=9B=94 19=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:09, =
Sven Eckelmann <sven@narfation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tuesday, 19 December 2023 08:30:47 CET Jinho Ju wrote:
> > ---------- Forwarded message ---------
> > =EB=B3=B4=EB=82=B8=EC=82=AC=EB=9E=8C: Jinho Ju <wnwlsgh98@gmail.com>
> > Date: 2023=EB=85=84 12=EC=9B=94 19=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=
=84 1:58
> > Subject: memory leak in batadv_iv_ogm_aggregate_new
> > To: <security@kernel.org>
> >
> >
> > Hello, I am "Jinho Ju" who is studying about Kernel security in Korea.
> > A "*memory leak in batadv_iv_ogm_aggregate_new*" was reported in Syzkal=
ler
> > targeting 6.7-rc6 on December 19, 2023 at 02:03.
> > The environment in which this bug was detected is as follows.
> > Syzkaller version: 3222d10c
> > Kernel version: LInux kernel 6.7-rc6
> > The report provided by Syzkaller is as follows.
>
>
> Thanks. But why isn't this coordinated through the "normal" syzkaller
> instance? [1]
>
> Also when looking at these backtraces, I am not sure if we are the correc=
t
> recipients - but please correct me. Take as easy example
> batadv_iv_ogm_send_to_if. This function does a clone and immediately send=
s it
> via batadv_send_broadcast_skb. At the end, it goes through
> batadv_send_skb_packet - a function which either does a kfree_skb or a
> dev_queue_xmit. A function (__dev_queue_xmit) which has in its descriptio=
n:
>
>     Regardless of the return value, the skb is consumed
>
> So I would assume that something which consumes packets from this queue (=
so
> the sb_dev) is not actually doing its job correctly and leaking frames. S=
o in
> my opinion, it is necessary to figure out what tried to handle the skb af=
ter
> it left batman-adv. Which would involve information like the underlying
> interfaces.
>
> If I read the reproducer correctly, veth pairs are used as underlying int=
erfaces.
>
> But the setup is so convoluted with vlan, macvlan, hwsim, xfrm, macvtap, =
...
> I don't see a l2 link between these other interfaces (only L3) but I coul=
d be
> wrong. So it would be necessary to reduce this complexity heavily to figu=
re
> out what is not cleaning up the supplied skbuff.
>
> I should most likely study the reproducer more but my current assumption =
is
> that you would end up with backtraces that look like veth is leaking skbs=
 when
> you modify veth.c like this:
>
>     diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>     index 977861c46b1f..1d86e3869c77 100644
>     --- a/drivers/net/veth.c
>     +++ b/drivers/net/veth.c
>     @@ -344,12 +344,22 @@ static netdev_tx_t veth_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>      {
>         struct veth_priv *rcv_priv, *priv =3D netdev_priv(dev);
>         struct veth_rq *rq =3D NULL;
>     +   struct sk_buff *hack_skb;
>         int ret =3D NETDEV_TX_OK;
>         struct net_device *rcv;
>         int length =3D skb->len;
>         bool use_napi =3D false;
>         int rxq;
>
>     +   hack_skb =3D skb_clone(skb, GFP_ATOMIC);
>     +   if (!hack_skb) {
>     +           kfree_skb(skb);
>     +           return NET_XMIT_DROP;
>     +   }
>     +
>     +   consume_skb(skb);
>     +   skb =3D hack_skb;
>     +
>         rcu_read_lock();
>         rcv =3D rcu_dereference(priv->peer);
>         if (unlikely(!rcv) || !pskb_may_pull(skb, ETH_HLEN)) {
>
> But there is also a chance that actually net/dev/core.c is leaking it and=
 it
> never reaches the veth driver.
>
>
> I also don't get why we were contacted in private and why the kernel secu=
rity
> list was involved in the first place.
>
> Kind regards,
>         Sven
>
