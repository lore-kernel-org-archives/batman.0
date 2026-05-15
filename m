Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D8CCD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 09:41:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 40E958561E
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 11:41:41 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778838101;
 b=R3pjOCt0ea2+He2jEWTTg09D24MPCNx6K4+G7RF+HDYS8msIHuW3++vLGvmMtRbrROR7D
 rRpinwd9R0AF21Fh9NJIJFjb9nBfvAp0PEuC8x8FZYNVFUKMQtPRG2BDuPQ5yi5+tOmgmuP
 yjAF0z561ia9ueqkSJvosJkT729wSdE=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778838101; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eTW3edd0iz7itkPvnlatci8goZhgBs5rERZ7V0Ca1W8=;
 b=JE1hx9VbXopxJRhjE1+ZFrH/NwRKOJ+PIHuxB+eOQ5IiXNnDC9+lb49o45OKJ3w9DAGcg
 sEZs85ahckVyhDqF6KGNLep0B9iG1SrWsp2ivMW8Yvrm8AnSvDfK126OKDoVKtHmBZfYduB
 4YYLqwzxRXliOEC7QT5H3k1/JecjVvQ=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3FC66849F2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 10:27:44 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778833675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eTW3edd0iz7itkPvnlatci8goZhgBs5rERZ7V0Ca1W8=;
	b=twpAkmWdrFRVxZuYpb6qya07djoA0CsoSifbvpwa+cMLQuUhu9rAZ0ccKDLDN8C7ccnQmu
	Lsbwu3XOCmmah1YkFgx8AqiSDRE5VCi1eaSw4F0sytSlOOoVrnYB05OcvX4XXyKj5WlsvY
	ax9wGVVLCnNCRX90lVO1NdPf7zllaTA=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hrP+v5Ba;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of yuantan098@gmail.com designates
 2607:f8b0:4864:20::f2e as permitted sender)
 smtp.mailfrom=yuantan098@gmail.com;
	arc=pass ("google.com:s=arc-20240605:i=1")
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1778833675;
	b=VmKRZDvyMXVkbo1HunY0b/SEaiekRqC7PQD70Jno4pKEOoSd0hRxrEy+7q4DJr/U0utTIk
	OgsLJyIQ0XKQ2WLImZ1mBZUdVO/bZ2g3nMKv2fVtvIfJEV40VtpgIhssDJLqqvrq58P7fc
	lrRtFWNghEP5+G57WMth5owU3KLCDoM=
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8b6dd874471so116220176d6.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 15 May 2026 01:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778833663; cv=none;
        d=google.com; s=arc-20240605;
        b=E4Jwwzakh6jqU3EUu8lCldXIXJ8cFBhD9ughWKKyb1V+tFq3zvDt9L2U4ydcAhoC33
         GqC5c2JaIS8j/G80pU2lXytx8wyEqcV+VP145EHxI1pXU62F7VGmJ+r7nRCkSJeLW3yd
         vbbQW6owor0/7A5hgZL8C036WLAQjpzJZI8umsCfwZsR1sF4dvKO0KABr2e3DgGTSILf
         DawqC16m4AEP5uApECbmNCUTBEbJIM+f9YcRYX7O5uuGr9Z2/xZyBVvJQNhGmXBA6sji
         /0Hk1VbqvyfdPD/sMEaycQJhNFsAxjISL/FA5eDthlH20pf1lArgzGL/aksDrz9dykv/
         Fsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eTW3edd0iz7itkPvnlatci8goZhgBs5rERZ7V0Ca1W8=;
        fh=fGpATJGdA5gBFxywIcayagIpQImFJ7uNKXfLW6dnd4U=;
        b=X2+ntLWws67J48tnte1WQHV4lEkCy8sxhvE4Wgs78rsgJ/9sPY999JpZ7KGun3wBk7
         nwKBwj5NQ57NqlRyX3TXuRK/A269pVtql67JNlyACo6rofGLdcqvBtNvmk9m0ovqxCux
         cbMC7Qom55CDppv2nCzM7MzjMryg3TbXJcDBkkT4MDZm0Krtx0+P5KjwCmnoc+T73g/p
         alqb9zLl33PS1EotZsZxIaU8khOJxhizLgZjA0Xclyr4ThF9daRn5uTSu/Z9pdRHB8ZD
         v2v9nts1aH2i8QaPKlP9fP9HMq2nH5WIQKS4DQjM5hzcHSjwfBL6SP6NZI7rwfdVgOUP
         Qzlg==;
        darn=lists.open-mesh.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778833663; x=1779438463;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTW3edd0iz7itkPvnlatci8goZhgBs5rERZ7V0Ca1W8=;
        b=hrP+v5BahxUV5x3zSo9dhKOibSKM4Imni0XdT7HsceZ9ZF3mGzr1Z53YQQeqs3szD1
         0C2033nydTwSPqTHtVl4vGlZExDjl7E6a+GgcBNsitxDBXbZkpvbk+gZ8JRvJTPDJNrO
         AAZd1w1LGcHZvPhRmPtctYqQmbdDAm31KTMmMgeoC404dajxhT8SDkLv58ApPTSjgk5N
         v/+DvJbmtc23rWkdbhaxlNdWt3ZOSFPHSuy4MnP8UMV1E84cEPabyzvNeTp2e+m50S2L
         cnKKgazOo2dpPKeqUtdIV1L7pN9ZVyPiZYP/AKAbzV7fx9hqbrD8MjM4FU+GJoHqgPFA
         SvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833663; x=1779438463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTW3edd0iz7itkPvnlatci8goZhgBs5rERZ7V0Ca1W8=;
        b=HPIqKihEh/xFj27I3wZ2NHwgMhE2359PtfObdjHzFimLoqCWI2NbkzE+dcaFbA+Hr/
         xpasetZrqqZcar2fDf4IimesxY6LXubg/0e5hwoNjzsmRH1lVHrroH7rjB62tYIP3p30
         64Bf/h2MZvpIBujd/jnRfVrfBdPTt6z1ALTwEK1LvUAyo3+yD/BReBxhE49z0gSI1ddV
         1DSd6Wk4NInqkPNdt60sLMA/NwI8aB6vs9XOA6DeKGNSgX8+zIM0sjZkfgucXMfqzmAT
         /kQeXeeaB3Oob3tbFK/903TsxexPP5//cO7fENqpBX1liH1ff9FCElmIw4DlXQH0SvBv
         FyaQ==
X-Gm-Message-State: AOJu0Yys68jryMs25mCULE1nMXSCARtxF78GEiciH20aCVBafQJJQQgs
	zdprPqxqam5TUayoGeZSJ6YbVHavaRbT1QXAuqJSreGntiDCt2zSTbLQm6P47IdfpW9ahuPOkzZ
	ad+MNzXsjbAyrPg4VOKyNxcGtkLAKQDo=
X-Gm-Gg: Acq92OFTwy4G30e7vNGkcHNacHhJNgQSQoqHOUkk+mLGv7MK8YYYj5VJeSHGxRidEsH
	b4uhC1buL1Z5Fp/oybT2zFgDVNBWEIK0AxB5mAqOeqYzxBa3VdgIVgrqTKoFTQS13xg3ssX75/6
	vA3BgQ1o+P16nfOeUsp+6Z+SfKrp7gZHvcYhVz4I4rdoXuZsStmzMzTsz9rbbMeCPZrewvy/cgu
	JFykUtri/5EPSBZO0u4j8mWAvmDPFz1ae2NFWvmRb6/rsXnDCXGAZ8gr4dN9+rE0+bmqD6eGW3u
	A+nrA+D6Eel8uluyqa+K6rhC6efumk1pYdc6elg=
X-Received: by 2002:a05:6214:478e:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-8ca0f4fcfb8mr47115646d6.0.1778833663368; Fri, 15 May 2026
 01:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
 <20260513-yuantan098-bugfixes-v2-3-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-3-863e9caa2a57@narfation.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 15 May 2026 01:27:32 -0700
X-Gm-Features: AVHnY4L-jlZwmfq7Tu_QdGkxqKXB6IKN5KXaDYTfI3al6Vuo0u4dHF3vb4AAX_s
Message-ID: 
 <CAPuPA7LKCUnBWWrGAg7T2cgnuzp3pcRveQeXg5Vxcxi00oZs7w@mail.gmail.com>
Subject: Re: [PATCH batadv v2 3/5] batman-adv: frag: disallow unicast fragment
 in fragment
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
Message-ID-Hash: 7NPGMCMY6DSJW5TK3KL3N3EM7XRZTK5V
X-Message-ID-Hash: 7NPGMCMY6DSJW5TK3KL3N3EM7XRZTK5V
X-Mailman-Approved-At: Fri, 15 May 2026 11:41:18 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7NPGMCMY6DSJW5TK3KL3N3EM7XRZTK5V/>
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
> batadv_frag_skb_buffer() is called by batadv_batman_skb_recv() when a
> BATADV_UNICAST_FRAG packet is received. Once all fragments are collected
> and the packet is reassembled, batadv_recv_frag_packet() calls
> batadv_batman_skb_recv() again to process the defragmented payload.
>
> A malicious sender can craft a BATADV_UNICAST_FRAG packet whose reassembl=
ed
> payload is itself a BATADV_UNICAST_FRAG packet (matryoshka-style nesting)=
.
> Each nesting level recurses through batadv_batman_skb_recv() without boun=
d,
> growing the kernel stack until it is exhausted.
>
> Since refragmentation or fragments in fragments are not actually allowed,
> discard all packets which are still BATADV_UNICAST_FRAG packets after the
> defragmentation process.
>
> Cc: stable@kernel.org
> Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/fragmentation.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentatio=
n.c
> index f4e45cc2..42f3d4ee 100644
> --- a/net/batman-adv/fragmentation.c
> +++ b/net/batman-adv/fragmentation.c
> @@ -293,6 +293,31 @@ batadv_frag_merge_packets(struct hlist_head *chain)
>         return skb_out;
>  }
>
> +/**
> + * batadv_skb_is_frag() - check if newly merged skb is gain a unicast pa=
cket
> + * @skb: newly merged skb
> + *
> + * Return: if newly skb is of type BATADV_UNICAST_FRAG
> + */
> +static bool batadv_skb_is_frag(struct sk_buff *skb)
> +{
> +       struct batadv_ogm_packet *batadv_ogm_packet;
> +
> +       /* packet should hold at least type and version */
> +       if (unlikely(!pskb_may_pull(skb, 2)))
> +               return false;
> +
> +       batadv_ogm_packet =3D (struct batadv_ogm_packet *)skb->data;
> +
> +       if (batadv_ogm_packet->version !=3D BATADV_COMPAT_VERSION)
> +               return false;
> +
> +       if (batadv_ogm_packet->packet_type !=3D BATADV_UNICAST_FRAG)
> +               return false;
> +
> +       return true;
> +}
> +
>  /**
>   * batadv_frag_skb_buffer() - buffer fragment for later merge
>   * @skb: skb to buffer
> @@ -326,6 +351,16 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
>         if (!skb_out)
>                 goto out_err;
>
> +       /* fragment in fragment is not allowed. otherwise it is possible
> +        * to exhaust the stack when receiving a matryoshka-style
> +        * "fragments in a fragment packet"
> +        */
> +       if (batadv_skb_is_frag(skb_out)) {
> +               kfree_skb(skb_out);
> +               skb_out =3D NULL;
> +               goto out_err;
> +       }
> +
>  out:
>         ret =3D true;
>  out_err:
>
> --
> 2.47.3
>

Reviewed-by: Yuan Tan <yuantan098@gmail.com>
