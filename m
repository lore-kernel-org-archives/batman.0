Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C84FCDB47E
	for <batman@archiver.kernel.org>; Wed, 18 Oct 2023 21:38:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 79CAA8312C
	for <batman@archiver.kernel.org>; Wed, 18 Oct 2023 23:38:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1697665087;
 b=CTU16OUSnGcamRngqzk06gNjo1mi2gefRu4ye9S4C7PJStPgwPv2fAgknoAs9e7gnDkDS
 /UcQN3r4GLbouWnOFzcL6KxfYv3rfORNxk932EvLEAV8v3NyL14Sk1d8OqOO9xiFdLvVg/K
 XC8GTayDp93OjCSraNKYR5jAlUEvcF0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1697665087; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qWiuYY3lQGpE+p3eYO2+lLDv7LavzotqmWjE7mK8fFw=;
 b=cj8JCeuVkdbN6T/itU7eNphRvkSpBGy+aShbYyqXwKtt/MrngiIlsvxQ2p3jY74xp+aKK
 zCTC7a4s5q1vNEGeOrqOOyVuS8UyUzyXhH8VRl0pMvGfkF3hJKk+Yw3HUmEdqBYdBwIs5j0
 UqlDMnFFUIz8QFeBVOZ+sa4BDWz7YC0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4A7480649
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Oct 2023 23:37:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1697665065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qWiuYY3lQGpE+p3eYO2+lLDv7LavzotqmWjE7mK8fFw=;
	b=cdVL2rgmFnWw0qi4vGhUK5pqH075qD1bVohi8Y4Uw6yYPYWkXk7IGPx4OqBdmHI62B3n/8
	B9waQy7ly02sE9YSbfoBAm4OMHDb1fcifBzWfG4mfCcTv6S4TF0Oeomidz9kFugzYVdPd6
	ydD22lpI4zVvxa5is7O4tfm7P9cjgic=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=HKFU+oN+;
	spf=pass (diktynna.open-mesh.org: domain of nico.escande@gmail.com designates
 2a00:1450:4864:20::62c as permitted sender)
 smtp.mailfrom=nico.escande@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1697665065; a=rsa-sha256;
	cv=none;
	b=ragS1mwSG5rromw65DaZ8bgXhwSrZ1rv1/MI7Q+2Qpserle3mw/DWa1gugAxdgW3PmrlY/
	9YbbZ8tjVtaONs3DmNMygUVTznM8Ln+4VCgHGGRH6kTmhMUq7hEwN+P3E4YB98C09HtkxI
	qV2+n8asJOgiJWBIepfyMuR1Bz+P5Vw=
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so648938266b.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Oct 2023 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697665065; x=1698269865;
 darn=lists.open-mesh.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWiuYY3lQGpE+p3eYO2+lLDv7LavzotqmWjE7mK8fFw=;
        b=HKFU+oN+9TXlCofz+dfCYly3z8mTwuyElFihgj9k978oBN6+rYgKQ44BcQb792wyYy
         VgzY3Hq55glhcmhDRxjqQHxQt29QvisMXeQS2ZkuUomhWEC52uwXFI8c6fdqgivTnvvr
         Zi8jhzh9pIrMbMZ4LKfV0iljfyh7Ny5Y7j6qA/KM+Nv82FDEdeS2kCPEM86r52/Y0zgm
         wItHdleVpwOg8LYWzYscIZYKfQcECLf397rEK3zZZ+iKHU8OsStkwRUedQBvFPnOvU8F
         eXrYBsAeIdkQqB4Vl7/iN+0kU3OpmAZI1CefBJMXanK61iWfp0KlOYObU8IEACw8gmaX
         lCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665065; x=1698269865;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWiuYY3lQGpE+p3eYO2+lLDv7LavzotqmWjE7mK8fFw=;
        b=t4fTOFOhkzkcpPfiqL8o6p4kyCsW65I9TwIY3gZx5Ls4eR/NSm/4CSqNA/aVtXMYE6
         WE+mJ9RAevp3cw9xqQ18oozeJxYTpccIcUx8vrYwRttlaxnBnj23e2NmbDVAOWbqC/Hd
         W9ya+Wba8FmX9a/l9elQUSz5y8jer1ovLJfo/+6+WbjgtkI7IxSkUOLROYaH3625Cx3v
         05JgmKXusn7YS9QS9yJVHnsN4vvCAGA6TyoRyCU4b+sY0rD6uHDZDz9XJ95pLrLjXek5
         vR/ovozx3fZybvF4FXGpJSvBajM4Dkq5MYwgBsLTrAaFdqRJubvSU0vPf8o/nQTZQ70n
         xx8g==
X-Gm-Message-State: AOJu0YzKch5CMxx/j4bq3UiiDC+GEcLuHoObBYmiStUY929GSxRpbfBc
	dz6wqGEuQT6/CN7bpJt5mCJ9DNEumWM=
X-Google-Smtp-Source: 
 AGHT+IGr1MTNQWq4cWIzR1+zmQICMeRpWUjNSnVw89JjlH5wvN/h7VzKno1+8AialrmhRx2tCJX7dQ==
X-Received: by 2002:a17:907:268e:b0:9be:a170:81d with SMTP id
 bn14-20020a170907268e00b009bea170081dmr318331ejc.25.1697665065017;
        Wed, 18 Oct 2023 14:37:45 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id
 o9-20020a170906358900b009ae587ce128sm2274855ejb.216.2023.10.18.14.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:37:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Oct 2023 23:37:43 +0200
Message-Id: <CWBW1FS4IRH7.JIAIOB8DVNK7@gmail.com>
Subject: Re: [PATCH RFC 2/2] batman-adv: Better half duplex penalty
 estimation
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Remi Pommarel" <repk@triplefau.lt>, =?utf-8?q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
X-Mailer: aerc 0.15.2
References: <cover.1695904299.git.repk@triplefau.lt>
 <09c086e5e68055e52d1f92ba17d0e921084107e7.1695904299.git.repk@triplefau.lt>
 <ZSoixFsJi5vYCRxh@sellars> <ZTA40fGA-NSvYkoq@pilgrim>
In-Reply-To: <ZTA40fGA-NSvYkoq@pilgrim>
Message-ID-Hash: 7N7DWE4Y3IL4VE2SITHYWKPURKK56727
X-Message-ID-Hash: 7N7DWE4Y3IL4VE2SITHYWKPURKK56727
X-MailFrom: nico.escande@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7N7DWE4Y3IL4VE2SITHYWKPURKK56727/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed Oct 18, 2023 at 9:58 PM CEST, Remi Pommarel wrote:
> [...]
> >=20
> > Also, this seems to assume that time slices are divided equally.
> > That's probably only be true for WiFi drivers that have airtime
> > fairness changes integrated? So only recent versions of mt76,
> > ath9k and ath10k? Has anyone verified that this works fine not
> > only in AP but also in 11s mode?
>
> I don't know how that would behave on setup that does not have airtime
> fairness changes integrated, if you think the current dividing by two
> approach is better maybe this can be made a configurable option but that
> could be tricky ?

It seems to me that airtime fairness is something that most current drivers=
 aim
at doing. Even the mac80211 scheduler is going this route with the itxq wor=
k.
So I feel like we should assume that with time, most drivers will be.
And devices that do not respect airtime fairness will probably not match th=
e
current TP/2 rule either.

> [...]
> >=20
> > And a third concern, but we'd probably have this issue with both
> > our current and your suggestion: Would we be off again 802.11be
> > and its "Multi-Link Operation" in the future?
>
> This, I have hard time figuring out how MLO would play along with
> B.A.T.M.A.N-Adv integration. Unfortunately right now I have no way
> to experiment that yet. IIUC the link would be a mix between half and
> full duplex, and this would probably complicate things a bit.
>
> Thanks a lot for your review.

For me MLO is hard to take into account. Depending on the drivers (and prob=
ably
on the firmwares mostly) we do not know if it is/will be used as a real
aggregation mechanism or as a way to have 'free' roaming between multiple b=
ands.

Moreover, currently all the path throughput estimation is based on the expe=
cted
throuput that the 80211 stack gives us for individual sta. I beleive that v=
ery
few drivers actually provide a value for it.

So IMHO we should do our best to have a good path estimation based on the s=
ta
estimated throughput, and it should be the mac80211 drivers job to provide =
us
with an accurate estimated throughput for each sta on a link. And yes in th=
e MLO
case it will be a hard job indeed...
