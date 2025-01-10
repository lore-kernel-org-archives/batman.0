Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93759E77188
	for <batman@archiver.kernel.org>; Fri, 10 Jan 2025 13:13:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E48758402F
	for <batman@archiver.kernel.org>; Fri, 10 Jan 2025 14:13:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736514827;
 b=XfbOpBsgTthN74Eqz4+m7p+VHZ8lP8o+Ja+xmGpV54OjUs6rJsP2KHo1fG/91RoLzlvp8
 jZDSMdGwtyGwz+Waob+4lOtaUBcMkc9S8679zoikB3zhxK1ujlbXS2TBWF1DsJNnoQd6tQC
 KFMuZzFoqJOYimIEz6On4V6TWx9l7V4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736514827; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+gNhOeuaAcLJWDO/umj751oX3HH7FwRtfMOB76qyaOk=;
 b=EzvM1Gkkkffb0Q+PNaNSwMj7rIwCFIxdtlvLSL3Uqh1LN9jOVHJC5IiWjzcCbnXYxYt0l
 1MYhLrS48hUBqn+qCk08vVyP0mZtw058D9ZbwLTKdU/T4y/KrD708QjEk6lBkZKKzvGhtfX
 6JDJA2aEWYbgHcs+yjQ+dN5JPPF+K3Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4542A8191B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jan 2025 14:13:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736514804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+gNhOeuaAcLJWDO/umj751oX3HH7FwRtfMOB76qyaOk=;
	b=ww5lrisFsvntA/cz8yp9Vi2YJArssK0toVjWwBN+87z4+SfwuB0ye4CvQBysuZzS/PWQ0Q
	0yrUSHFDyc3MhxVm3fhaEy0HEAY+BYvtxm991L7eyuUcUEb1bQOIDC1DsoYDEysyE9KmLS
	JQ5/dfsOgDNanTqY3B4Ibn1nXEryRi0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=smtpservice.net header.s=a1-4 header.b=ssjENbBZ;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=XGlz9+y5;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bounce.d5172b2l2u78xm3=ngfyabipiq85=kklzctj36fwc0w@em510616.triplefau.lt"
 designates 158.120.84.103 as permitted sender)
 smtp.mailfrom="bounce.d5172b2l2u78xm3=ngfyabipiq85=kklzctj36fwc0w@em510616.triplefau.lt"
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736514804; a=rsa-sha256;
	cv=none;
	b=dxY3nCO+itsJasZQrgiH7lYW3mamvD/yW/Da7V0nEhrJ49Z/HZedUWGmiihXGbCQdXHfMg
	zYdTgoxtw/fWMqDYFs4NTJJFOdvgULBfSEVSHaKBENEsxyRV2YiXVVFKVSOo2JZx2pWesk
	UEc7WU6a5wQSdT0aKRHafA3VeXDBtGs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1736514803; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=+gNhOeuaAcLJWDO/umj751oX3HH7FwRtfMOB76qyaOk=;
 b=ssjENbBZhWG+Y1oC3s6C2yA4t8/DVzW1IGCQOk7Z7N85RN04rkfINQRcaUAlkffbF/Ir2
 obido4toh/POSZrJAilb5hWh1MZIbWX66BqYOrS5ozluLDXt0LH0sjHKS51DLfCcwyzfDAM
 nFMjQ9+OVnV1s7flzn0ZC+CXhfE/W10ESYHZZ5fw0gn2o4obzbHDNFDzPJI5+xSnQKHA2U1
 n/Nn5kLT0iqTbOU7rPXQWvXoUdM1cl4sOPIocVte8tx+R3j/3UMGkAv3WKIo3/B9102Yg+8
 d3ir+fltvgIc399AnX3bNNxNLbMBdY1tTisp71APXNomE8/mBayk0VUzG8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1736514803; h=from : subject
 : to : message-id : date;
 bh=+gNhOeuaAcLJWDO/umj751oX3HH7FwRtfMOB76qyaOk=;
 b=XGlz9+y5g+C3/+C3Hdz1Pwf2bnO37Zb4CGdB2wgofTOMT9CskmlgarAzoyjA6EIC9u1Yp
 J9PUgK1nw6l5vqZHcesFeis9ndYWbeWEadHfMRAosQxQdlb3EkmgN2iZym2htb1QMXWawqb
 SoS7ZqD0xFNCDyP6PbWKQldc5pEWiLeSJI71Kn+v1ZrG7IHfwUCt4GhqtvjdVbNAWk2Zo4h
 CFsqg4XVOxzRaRYMf/XMpNa6Xksh9cs0Q7Xj7jRyk3qT2TIZv5Q0eKfNpH4D5auEWyuz/mi
 C0K6JwBmFfHcqNKvPnxzuk9bhayKcIX4dpB8OZ+4ZJ5M3D32feBdwnRruqsQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tWEpG-4o5NDgruDdO-lJzI;
	Fri, 10 Jan 2025 13:13:22 +0000
Date: Fri, 10 Jan 2025 14:10:21 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Andrew Strohman <andrew@andrewstrohman.com>
Cc: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
Message-ID: <Z4EcPQOMU1BUtO07@pilgrim>
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
 <1882889.atdPhlSkOF@ripper>
 <CAA8ajJkhd=CaNoqZ+juKHh8PV975s_vEfLU4xLfwn-Yj+caEPg@mail.gmail.com>
 <5533653.Sb9uPGUboI@ripper>
 <CAA8ajJnVQWO3fhLAjQtEfjEVReY7x-==TEkhrKQKZMrVJms44w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CAA8ajJnVQWO3fhLAjQtEfjEVReY7x-==TEkhrKQKZMrVJms44w@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sRUWXvn-j-
X-smtpcorp-track: PHdAnW-j5yS5.Z9h_cZmu0ob-.IiV8lAgVDr_
Message-ID-Hash: HM3PT3Z4R57F5BPVGYCYFXDTR7RDXXFE
X-Message-ID-Hash: HM3PT3Z4R57F5BPVGYCYFXDTR7RDXXFE
X-MailFrom: 
 bounce.d5172b2l2u78xm3=ngfyabipiq85=kklzctj36fwc0w@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HM3PT3Z4R57F5BPVGYCYFXDTR7RDXXFE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Andrew,

On Fri, Jan 10, 2025 at 01:02:19AM -0800, Andrew Strohman wrote:
> > I would prefer when you would call cancel_work_sync when metric stuff should
> > be stopped. I was expecting to see this somewhere around
> > batadv_v_elp_iface_disable after the cancel_work_sync but it seems like it is
> > missing there (or in a similar place)
> >
> 
> I tried this:
> 
> diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> index 1d704574..b35ded79 100644
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
> @@ -387,8 +387,20 @@ int batadv_v_elp_iface_enable(struct
> batadv_hard_iface *hard_iface)
>   */
>  void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
>  {
> +       struct batadv_hardif_neigh_node *hardif_neigh;
> +
>         cancel_delayed_work_sync(&hard_iface->bat_v.elp_wq);
> 
> +       rcu_read_lock();
> +       hlist_for_each_entry_rcu(hardif_neigh,
> +                                &hard_iface->neigh_list, list) {
> +               if (!kref_get_unless_zero(&hardif_neigh->refcount))
> +                       continue;
> +               cancel_work_sync(&hardif_neigh->bat_v.metric_work);
> +               batadv_hardif_neigh_put(hardif_neigh);
> +       }
> +       rcu_read_unlock();
> +
>         dev_kfree_skb(hard_iface->bat_v.elp_skb);
>         hard_iface->bat_v.elp_skb = NULL;
>  }
> 
> But it seems to cause a hang on reboot every once in a while. When the hang
> happens, I'm not able to trigger sysrq over serial.

Quickly looking at that I think that metric_work may need to sleep so
calling cancel_work_sync() on this work does not seem safe while in rcu
protected context.

I would try to frame the cancel_work_sync() call with
rcu_read_unlock()/rcu_read_lock() as below:

  rcu_read_unlock();
  cancel_work_sync(...);
  rcu_read_lock();
  batadv_hardif_neigh_put(...);

But be careful as batadv_hardif_neigh_put() could modify the list you
are currently traversing. At first glance it seems safe to realease
rcu read constraint to call cancel_work_sync() as long as you take it
back before calling batadv_hardif_neigh_put(), but this could need more
though on that.

-- 
Remi
