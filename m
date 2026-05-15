Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B37ACD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 09:42:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5FAD28534B
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 11:42:27 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778838147;
 b=T/RBS4vhcqc6nECBUyqb6DK8mvn/dihgapn690ErQhIuGnX8QwNA7W6Ta9tWsoN5YPItA
 NeLAdbRIlNY8Q38K1MHUQPMqSkAiSn+IQ7NJtpumaESf4jwJuCHfdVn8vccU8J5E4o5QlLX
 9dERGRLuN7GcdSi2cwI2SlrBVDmeLvk=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778838147; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=drIb5iX5pGZ7J161OUgFjHSR9Uf5QgPhJcrTERWfRqQ=;
 b=rNDlnuNY41O4kYtAUQp7UHPSsxN/5TN51zg8QxniT4MhpsThpOtg6l/C53bL+Rum25GW7
 VvrfNH/SIBUA4SZCZyu2y9TnZurmHHnQfL/0o0yNIYkWMe4POq3vC/GrdKdNqFYTB/RATJF
 a8fS1S5WaxaUHL56ZoUqdk4T/MCGBeQ=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 04F2E844B1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:31:17 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778837478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=drIb5iX5pGZ7J161OUgFjHSR9Uf5QgPhJcrTERWfRqQ=;
	b=NpzO5Uv5Z5kcxY5aJLBT6gW3gm+JdpI2az4SI6/W5NnOKS10K5Plq1D4nJGUxWsom76uaO
	Txom6sbB3QGcP4fPkPQ0F7k32QHpYTfxdtS0GcOSEejzJfTf+xtVR3lUV/diHynDtvZ2rS
	XgfUrVrKIKSGQCa1EiHEGcBPoLmE0Qc=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=n88v7MpO;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of yuantan098@gmail.com designates
 2607:f8b0:4864:20::836 as permitted sender)
 smtp.mailfrom=yuantan098@gmail.com;
	arc=pass ("google.com:s=arc-20240605:i=1")
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1778837478;
	b=znbPvpSOcGJsBZCzMSEsVGFtGV35H//h2i96tUtZQ0sj25I4K0uT+6HrgUEWhxQP1Sz1x/
	fBY+2eJo9MJ93KPm7KyeEyjY5CBdCzJ/lcg4wg0WNDG+8qEXPlTcIbejm3yd0a9U5B+U6t
	KUWNQmuUcA/UAwfnvzVyJ+9NZBV4hWg=
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-50fb4a7d704so67856291cf.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 15 May 2026 02:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778837476; cv=none;
        d=google.com; s=arc-20240605;
        b=krwxAxOOMXn7hjKzWb42+zvBRypKcFRiqBM34KEPij1u8Pl7iZNdDtotGFFE+UN2OU
         VLRSFzxASRlg7IZRvkJ2lHiO9z+UY9uVSoKmX62zluC3Tg7h6EUCH9Q184JK+3Zg/H0W
         nTsEyCYYmU73+WLCCxpbZrXp5m3yxFIgLFryK90hUdSCpmcl+Gk5rb41K85Xdn+KkavT
         Qeodvs7BBSzKnwkrYYWTSHMqFVbjDplNnbUid+3/EOqGQhCwqX3OQccfViIS4BM1IMm9
         I6mlVO5hxIHbN+1wDNxAOZ3w9+xeQ3KCWJNOdVuKjY/3zDKr1JcD6CdFk+HH34gVBrKO
         6vVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drIb5iX5pGZ7J161OUgFjHSR9Uf5QgPhJcrTERWfRqQ=;
        fh=fGpATJGdA5gBFxywIcayagIpQImFJ7uNKXfLW6dnd4U=;
        b=BoBspjqb7hnBE6CRbnbXvLweZaGw3H9aTxWg72EsyRfpEQQQFZm9h7hCq526m0vbIb
         8whHdmo0bn6PjnydqEeQ71UEMY8FpbMHCcFy4oeCrUZs0jczEDI5mkANTPdW5qckl5nz
         jCyaGc/EM3Si7fTiw/EzO9CKZ/USQW6aqBg5iXG6bSRpJahBq1q9Q9QDfsX5LO1oXjOa
         P2CNg7bme2MUUyY65s1Z3d5EGXZNGSTJ5DYfFc5J3ShZOWB3IZWK4PiZPUjWn4NmAxg2
         A7uJDUj36uWABvftKGyJ5pMsB5WmJkBVpSHKd7hH36dlTL3zm/2jaVqO8gzJNIWq2HcZ
         Ue7w==;
        darn=lists.open-mesh.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837476; x=1779442276;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drIb5iX5pGZ7J161OUgFjHSR9Uf5QgPhJcrTERWfRqQ=;
        b=n88v7MpOlA78utKBYAMN9kBkQmqnBbRUBDoPR4NYQIOtlbs/VOtPNCYpanBpACW5i/
         2it89kv3XGoroxOCh4Ie4djn7GwUFZmefWCltpzZJSX+TVDo5DiJeofUyaUDryUcRaes
         yxSb+rPYGGKD6qp1LfoN+4fbsD/rtv58ixn5yYjCYEpwvxmixocZmfj1txYo1Vsx25wR
         LfV8si+ml4rcdX1bkfd5lRQVNCU7+ko68L0HEyZFbfJhzaP2IhYtGiksIDA6kVaYUq6I
         qaVGQqWFgKuNAUlnWcZ3kM0661UN7k0Xlnn2KJeEreUe0OUFO1yO3khWQR8dDPv+pzLR
         nyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837476; x=1779442276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drIb5iX5pGZ7J161OUgFjHSR9Uf5QgPhJcrTERWfRqQ=;
        b=H7Lkd8A7hs5C62gSTxf4UrojXZ6edxo0+TFW8+i9xAO5YEHDFXM6MEd03SzTSQ08A1
         FRb98C466es9We0ndsz8ujCIyvXIyCMRjt3CLDtN9VV1zW20Z7o5Taf6e6rBD7a2yuVO
         tI+YjlE0LwaGSQzDLfRtEzp2p2WnBJDLbMT7MpSm0EBWhj52H7XOlO8WTFHtRSJzF4uV
         5/IZucV/LMJuSWsyR06fomiyaixY0MY0RIRQ4pMFK7KpNMsrHvIRhWiOi2pWX38glv5t
         Wywf+qoSQaczf7p/3zGytyC2/UZ0tXPtpN7BUAlT0th8NPgbsi1Frqela5icwkf/qeMG
         YMrA==
X-Gm-Message-State: AOJu0YwamBFb4hDEB1FxlJqyku8MDMabS+bNIN+zJ2LRHKpyj9mYcpE0
	Mluc+uW4zd5DosIIypwbOGghy889iUjOl1+aUzftZnDgkWAd/HPaDYFPahW9bIexr+rQJg8AOxn
	s+ZFfWrsadom/7QIqfPDlUeEPQsJUpAQ=
X-Gm-Gg: Acq92OE51RGMisCTwVk7bt+HV2pStkbjIrdY8zeR5kRswRaMcFieoHMaatHYAL+zsZD
	CtAkSy4XTLgcAIx3zECdUziViCJCm61VAHq8X57ORVPLkA9zQNMx3UAZcEu3Pc7ObeuuQK7XYtT
	8fXgJA+qQYX/fbDT0hyQqIFAKqd5a+QRpDZSh06jRWPoYtxi33Xssqt8+07Esl7lui2xonNVYCq
	g5joVuZ9cQg1XVhq/qeBIG/mTr+uahB7G4JCc6RzQOisvcYuh+3hzdfv9LRhQ/WKKQtrljQNB5g
	MfiAR1s3Hlvx2mraH1nlixFC5eSXfUTkzVUyj80=
X-Received: by 2002:a05:622a:130a:b0:50d:a301:2fc0 with SMTP id
 d75a77b69052e-5165a077858mr42815841cf.26.1778837476404; Fri, 15 May 2026
 02:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
 <20260513-yuantan098-bugfixes-v2-5-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-5-863e9caa2a57@narfation.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 15 May 2026 02:31:00 -0700
X-Gm-Features: AVHnY4L-xzaQcxvCpWWjH56EKRXIIOj1Lj_HAOe5co45NBRDzSBQMWmEUu1q62Y
Message-ID: 
 <CAPuPA7KEnOyK1cs1T=pQo7fye2TeMPZZw_pBiMCpJoQ4eXAE5g@mail.gmail.com>
Subject: Re: [PATCH batadv v2 5/5] batman-adv: v: stop OGMv2 on disabled
 interface
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
Message-ID-Hash: YFSBGAVC6QZNUSWVWEAWUA5LF3VCM4XL
X-Message-ID-Hash: YFSBGAVC6QZNUSWVWEAWUA5LF3VCM4XL
X-Mailman-Approved-At: Fri, 15 May 2026 11:41:18 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YFSBGAVC6QZNUSWVWEAWUA5LF3VCM4XL/>
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
> When a batadv_hard_iface is disabled, its mesh_iface pointer is set to
> NULL. However, batadv_v_ogm_send_meshif() may still dispatch OGMs via
> batadv_v_ogm_queue_on_if() for interfaces that have since lost their
> mesh_iface association. This results in a NULL pointer dereference when
> batadv_v_ogm_queue_on_if() unconditionally calls netdev_priv() on the
> now NULL hard_iface->mesh_iface to retrieve the batadv_priv.
>
> It is necessary to ensure that the batadv_v_ogm_queue_on_if() checks that
> it is using the same mesh_iface for which batadv_v_ogm_send_meshif() was
> called.
>
> Cc: stable@kernel.org
> Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_v_ogm.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
> index e3870492..0643a723 100644
> --- a/net/batman-adv/bat_v_ogm.c
> +++ b/net/batman-adv/bat_v_ogm.c
> @@ -113,14 +113,14 @@ static void batadv_v_ogm_start_timer(struct batadv_=
priv *bat_priv)
>
>  /**
>   * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
> + * @bat_priv: the bat priv with all the mesh interface information
>   * @skb: the OGM to send
>   * @hard_iface: the interface to use to send the OGM
>   */
> -static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
> +static void batadv_v_ogm_send_to_if(struct batadv_priv *bat_priv,
> +                                   struct sk_buff *skb,
>                                     struct batadv_hard_iface *hard_iface)
>  {
> -       struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->mesh_ifa=
ce);
> -
>         if (hard_iface->if_status !=3D BATADV_IF_ACTIVE) {
>                 kfree_skb(skb);
>                 return;
> @@ -187,6 +187,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv=
_hard_iface *hard_iface)
>
>  /**
>   * batadv_v_ogm_aggr_send() - flush & send aggregation queue
> + * @bat_priv: the bat priv with all the mesh interface information
>   * @hard_iface: the interface with the aggregation queue to flush
>   *
>   * Aggregates all OGMv2 packets currently in the aggregation queue into =
a
> @@ -196,7 +197,8 @@ static void batadv_v_ogm_aggr_list_free(struct batadv=
_hard_iface *hard_iface)
>   *
>   * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
>   */
> -static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
> +static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
> +                                  struct batadv_hard_iface *hard_iface)
>  {
>         unsigned int aggr_len =3D hard_iface->bat_v.aggr_len;
>         struct sk_buff *skb_aggr;
> @@ -226,27 +228,32 @@ static void batadv_v_ogm_aggr_send(struct batadv_ha=
rd_iface *hard_iface)
>                 consume_skb(skb);
>         }
>
> -       batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
> +       batadv_v_ogm_send_to_if(bat_priv, skb_aggr, hard_iface);
>  }
>
>  /**
>   * batadv_v_ogm_queue_on_if() - queue a batman ogm on a given interface
> + * @bat_priv: the bat priv with all the mesh interface information
>   * @skb: the OGM to queue
>   * @hard_iface: the interface to queue the OGM on
>   */
> -static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
> +static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
> +                                    struct sk_buff *skb,
>                                      struct batadv_hard_iface *hard_iface=
)
>  {
> -       struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->mesh_ifa=
ce);
> +       if (hard_iface->mesh_iface !=3D bat_priv->mesh_iface) {
> +               kfree_skb(skb);
> +               return;
> +       }
>
>         if (!atomic_read(&bat_priv->aggregated_ogms)) {
> -               batadv_v_ogm_send_to_if(skb, hard_iface);
> +               batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
>                 return;
>         }
>
>         spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
>         if (!batadv_v_ogm_queue_left(skb, hard_iface))
> -               batadv_v_ogm_aggr_send(hard_iface);
> +               batadv_v_ogm_aggr_send(bat_priv, hard_iface);
>
>         hard_iface->bat_v.aggr_len +=3D batadv_v_ogm_len(skb);
>         __skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
> @@ -343,7 +350,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_pr=
iv *bat_priv)
>                         break;
>                 }
>
> -               batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
> +               batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
>                 batadv_hardif_put(hard_iface);
>         }
>         rcu_read_unlock();
> @@ -383,12 +390,20 @@ void batadv_v_ogm_aggr_work(struct work_struct *wor=
k)
>  {
>         struct batadv_hard_iface_bat_v *batv;
>         struct batadv_hard_iface *hard_iface;
> +       struct batadv_priv *bat_priv;
> +       struct net_device *meshif;
>
>         batv =3D container_of(work, struct batadv_hard_iface_bat_v, aggr_=
wq.work);
>         hard_iface =3D container_of(batv, struct batadv_hard_iface, bat_v=
);
> +       meshif =3D hard_iface->mesh_iface;
> +
> +       if (!meshif)
> +               return;
> +
> +       bat_priv =3D netdev_priv(meshif);
>
>         spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
> -       batadv_v_ogm_aggr_send(hard_iface);
> +       batadv_v_ogm_aggr_send(bat_priv, hard_iface);
>         spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
>
>         batadv_v_ogm_start_queue_timer(hard_iface);
> @@ -578,7 +593,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *=
bat_priv,
>                    if_outgoing->net_dev->name, ntohl(ogm_forward->through=
put),
>                    ogm_forward->ttl, if_incoming->net_dev->name);
>
> -       batadv_v_ogm_queue_on_if(skb, if_outgoing);
> +       batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
>
>  out:
>         batadv_orig_ifinfo_put(orig_ifinfo);
>
> --
> 2.47.3
>

Reviewed-by: Yuan Tan <yuantan098@gmail.com>
