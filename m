Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C213D68B2C
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 14:53:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8F6D581EEC
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 15:53:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731595999;
 b=Fii55Aun2oFd2qNz3rpKYWl68AqjoV+DvEs1Ai6cdhd9CdHlNRhRqa1CV2MhufzIoKfNJ
 MBkoeG7FT7yLzQwFDgEypmzCLhBieUMX0291jjdkPTRbQcXG+H3q9NNtcQh4ow/NNl9Xb+m
 QNocXcRU42PVYhSlQArGAL3SwyKyr3Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731595999; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J48HS1d8KeZCjuoBdiy9PjzRDvYtPJwFq/h/AQ2DrtU=;
 b=WmupufI0jWBwE1NQyS+HN11UZ79RHUvItgDg6i54za1ZMzHy1avGjyzt1tuRyZpCBwhtu
 KZn1nVsAYnuln6k9Wrxe1ZsjyfUH0/TnvAkceeYd7gk2VBh/Y8OcusfRsL2tzDDB8IMAy3m
 kEsQY2bNQeODHzfp4Uvl4S1h3eKgdrM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CABA980855
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 Nov 2024 15:53:12 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731595993; a=rsa-sha256;
	cv=none;
	b=IbxF+X09shfoT9KdLgpuG7lOXBfuui13N0aU1/PAEcVVmf+COHNiOxjMgx1PkouML5ZKHy
	WGSItl46cfPjNMzFSngnQVeeDEZZw/HXbrbFVa1dQAVE2bKlMV/g5FQv3ExcnrAZrHb6V4
	p2UYl8TqY+mR56NFZ4fJzOZB7KUO3F8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="mw/Rh97y";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of nico.escande@gmail.com designates
 2a00:1450:4864:20::42c as permitted sender)
 smtp.mailfrom=nico.escande@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731595993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=J48HS1d8KeZCjuoBdiy9PjzRDvYtPJwFq/h/AQ2DrtU=;
	b=yuyCQbyPE2Lep/QdGcZuVcIwLFP2I/hhGHo5gF0QXWhdYyhd8eG1qGaCNOZtoXgJaukyDP
	evjdAUpRP0eCjloem8GpKvKfNiKUpYHmARzfBJ9r+1ghfC2cgtIgmZRKv6YQegZJh+VDsx
	WAI65uXRttgiys3uANxoXIZ/FKa4vnY=
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3821c5f6eb1so411151f8f.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 14 Nov 2024 06:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731595992; x=1732200792;
 darn=lists.open-mesh.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J48HS1d8KeZCjuoBdiy9PjzRDvYtPJwFq/h/AQ2DrtU=;
        b=mw/Rh97yasNK2CVO/sTgbAjeEBh0fAMqkA3N7WAJDdod/zkhObs6bbSAXqFJEqcZlf
         m/3Cm+2sdDsAoSBNBXJ0/NV9wWDK7/KqIWJrWNzVCucQT36qHSJcToMpi/ABNKY9gXL8
         urxGtwJ3z9xCHmNsy4CRG6yf/9R0et8Z9OVt5nW+P0DcwSbOyMkmyO/7PYT0fh5Wsf6q
         rEsNWIMJMLP+ChHxaXJmBKDbZ84rfXJN/Czm0cPvQ6mODTNfL/Ek1ylMVYTiFJ27jeZx
         A2/jPXnluKyYQ/PS7i1ZSKYFcEs2JHLFxGAPbyXHOUWswRjeEWDXrkZgyVF+wA7D67YW
         Bbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731595992; x=1732200792;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J48HS1d8KeZCjuoBdiy9PjzRDvYtPJwFq/h/AQ2DrtU=;
        b=AdPfkgGNwzHcFHFp2oIoYEHRmEM+lGV4cogJceqYauotfJ/+/sCj3zbnELXoSfCCXX
         7loi/OQcLVxmyLbs9EsImAu4y/T63s800unU5QIz3fuWwkx82VXXsw4Hsr7Ily1YvqVs
         TgVnx5i80wKO0k8q5u4NUzlRcLATBP6FvkCvzPOZT8WUZgAKgoraX6F24VEMghbgFq1U
         6ZwOKbQzbaCYVPPJ4Wtz8sK5vXOIpMnKpC8xjh1TwXo4QBrxJzNPMedLMNSED/2udJnp
         qR33BgPuc6q74tuQOadqB2CO5qfB/26WZDW+KqGqmdY3kSN7lB3laa9oQOFmtxpG9mzh
         qvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZUO5PtzcbyN/gRek9cefzrS7J73WymPnW05KU9s9hyhN5AD9LzuuzVFwUkawLkwFs8iKq6WPEgMAAwg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwFnHrk1DlASGWUuJM7feoJW6TRiKjSDqjYeAQmnYguzQkNV357
	oNR+GVB3PPoTiTzL1J6IyJc83WeEyFEv+pNS9LG/aMjssf4sXs4a
X-Google-Smtp-Source: 
 AGHT+IHLUMin8esN0Xh9ZuL9hmZ6mTXOqZZq3JY6uKg5t9OBStqfqrwqk6RjYuJ3tP4ABoRdUgk71g==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21e9 with SMTP id
 ffacd0b85a97d-381f4432614mr14013195f8f.0.1731595992028;
        Thu, 14 Nov 2024 06:53:12 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae3102asm1676272f8f.93.2024.11.14.06.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:53:11 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 15:53:11 +0100
Message-Id: <D5LZJSJADA7Y.35OPLU5VTB46Y@gmail.com>
Subject: Re: [PATCH v2] batman-adv: add dynamic, bridged-in TT VID detection
 support
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Sven Eckelmann" <sven@narfation.org>, <linus.luessing@c0d3.blue>,
 <b.a.t.m.a.n@lists.open-mesh.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
 <6100761.lOV4Wx5bFT@ripper>
In-Reply-To: <6100761.lOV4Wx5bFT@ripper>
Message-ID-Hash: MMRS5GDFDYOVE5QK3KQFW6PBD55MVXNF
X-Message-ID-Hash: MMRS5GDFDYOVE5QK3KQFW6PBD55MVXNF
X-MailFrom: nico.escande@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MMRS5GDFDYOVE5QK3KQFW6PBD55MVXNF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu Nov 14, 2024 at 2:58 PM CET, Sven Eckelmann wrote:
> On Thursday, 14 November 2024 14:48:52 CET Nicolas Escande wrote:
> > Hi there,
> >=20
> > We've been running this for a few time and it's very usefull. So is the=
re any
> > news on merging this into the kernel ? Or is the BLA thing blocking ?
>
> I am not in favour of changing the behavior of batman-adv. Now everyone c=
an=20
> increase the number of managed VLANs without any control by the node admi=
n.
Well ok but but it makes configuration so much easier in a setup where we h=
ave
many vlan that I still find this usefull.
>
> And as Linus wrote, it also shows odd behaviors. And Antonio also didn't =
write=20
> his opinion here. I have therefore downgraded it from PATCH to RFC (inste=
ad of=20
> simply rejecting it).
This is about the BLA behaviour ? On a setup that doesn't use BLA like mine=
 it
makes things so much easier to configure that I still find this patch usefu=
ll :)
>
> [...]
> > Or maybe I missed something ?
> > =20
> > ---
> >  net/batman-adv/soft-interface.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
> > index b61f35918b5d..d7de54734725 100644
> > --- a/net/batman-adv/soft-interface.c
> > +++ b/net/batman-adv/soft-interface.c
> > @@ -599,7 +599,6 @@ batadv_softif_create_vlan(struct batadv_priv *bat_p=
riv, unsigned short vid)
> > =20
> >  	atomic_set(&vlan->ap_isolation, 0);
> > =20
> > -	kref_get(&vlan->refcount);
> >  	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
> >  	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
> > =20
> >=20
>
> This ref is for the VLAN list entry (just one line below the kref_get).
> This patch is therefore definitely wrong.

That's the part I have trouble understanding, we keep 1 ref for the list, 1=
 ref
per TT entry using this vlan. And on interface deletion, we clear the TT ta=
bles
(so we go back to a refcount of 1 for the global list), but I don't see whe=
re we
clear the list itself ?
>
> Kind regards,
> 	Sven

