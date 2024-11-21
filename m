Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F341D75BDF
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 09:29:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E1B2183C5A
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 10:29:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732181370;
 b=TAHJhcc0e/75h/HCVIyg/tjpYBEnDGzQ23o0dMj1i+5dYR5HPJrUqF0hIWfFMqZz+6wnb
 BjyB/Tv2743XN3HzQBvNYP8bnCddY+xPoMXdQXkQVcnpU2KjLrczcYknvYozERfd9lB+x8E
 D87A1/IxEsS9rgaSTfr0wKl4FR0aEkk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732181370; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uCl5cE+BHWWsqz4+5+4MdfMn/2GUyk7WxkVCLjncRrA=;
 b=DBgo+QMsXt5yI8heg4P4TQKOMnIlYFOkwQLWfGijviYnWf5vwVhO2ohFXCscBiaujICLU
 hVQ7uXYSJ93fyz6P55hEtx/VUyxaliD3qVnbaXwcV8bmJvCSTT3nBRag+I7zwOwiGZ7GuAF
 l/ldjew6bEg6h8Ev96zABdKWhq1djG8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8FE2E801DA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 10:29:18 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732181358; a=rsa-sha256;
	cv=none;
	b=pOVlpWKBEV5vLjReLegkhYkkYFStwoK7KWEKcfs9ThdD5Z0pf6LnwKkgEmgJZ9ZBvWVBM5
	/tvqNyEMf/WpdK72gi2dvo/PtJDz7OZB2wbCqRFBjxA5fFnULObqY1skucq6qThHDZf/I6
	2xIUgLFpACwvGnYVoDX21ZgeG5gq9Vg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=rtkSDB1O;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=CEYR0OaN;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.uk1d2nl4ksiwwq0=fv7qo6y7g7i3=5v4ezpakr918l4@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.uk1d2nl4ksiwwq0=fv7qo6y7g7i3=5v4ezpakr918l4@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732181358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uCl5cE+BHWWsqz4+5+4MdfMn/2GUyk7WxkVCLjncRrA=;
	b=Op7nuwdZMWx1FyY8KtksPc5OuNYrcj38VPGppiJ2F1DUs2aB4YtRFvgoDsR/1JY9st5itz
	n0hjY7z1ewLBzBE/fUc+72s79SEdI5l/UTgsJtIhAnBwrNJbomAWP2aNq/nknqjfGfr7E+
	EyzQ0/mpj1LmJYrAIhuf0lvmF6ENJLU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732182258; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=uCl5cE+BHWWsqz4+5+4MdfMn/2GUyk7WxkVCLjncRrA=; b=rtkSDB1O1v3X1q5lUujxhTLIfP
	r43YOgJbiXJUTSb8kijY29uySO28l7gbW30iXlOTOVfRJh1ieKKYIdxULs21Q0iIMGu+ZyXKHhhPV
	MEpwWLfUxwqH6zqr6N0KIvSgN3bkwjAUWplmdANKl+MiN+5K8obiS61cEfeAntSj5Vyys+oDHR8h1
	Az1vDmL+yrJCRnWwxuWT7KiLVKhKOToa2E455QbDc4AsCu8LkhlBzp3e98J7WKVjePG92+344dzGV
	79pbpp4S5vwAEOjtiSwj5PSa9H5p0TwAf8evkUPfARAkoqFEHvisVuk7kaoBFqn96VnRY67JnEQqi
	epyk2c4Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732181358; h=from : subject
 : to : message-id : date;
 bh=uCl5cE+BHWWsqz4+5+4MdfMn/2GUyk7WxkVCLjncRrA=;
 b=CEYR0OaNlJb/5QTPzeajewo69JBSycQZBwrXlMXQPs4xyKzELGFdubySAtHO425l+3egX
 uQoX6WJWYl1ZMjHOUok7T5XjyHBCWHWISROaSYuiIPLvNMNhO4oYj1WgA9bNkoOHTxCLgyk
 IbPmHoYTz0ik7NR6fUodiRfAWoQYZwY2TZEAMVz7dX0EXMHaCo5v6xinU0eXiqiNrA8y+fp
 j3fA5bD6NO7SIWGupsRWaUoU0ovSSFmGqWgEp02mqY8nORsVzuD5gWeyIf0SNjvWpPvjae2
 UU540zDnr/gOUrQimRvs1Uml7R5ouzsN1yiD1Q2JmZxrzJbgKTvQMLlRVJBA==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE3Uv-TRk4Oo-QG; Thu, 21 Nov 2024 09:29:13 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE3Uv-4o5NDgrhdGJ-qKjX; Thu, 21 Nov 2024 09:29:13 +0000
Date: Thu, 21 Nov 2024 10:28:06 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH v3 4/5] batman-adv: Remove atomic usage for
 tt.local_changes
Message-ID: <Zz79Jqaf3ee4ZxMT@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <8f60847b19a3646e13fd9eaa13cf8bca488b45f9.1732124716.git.repk@triplefau.lt>
 <9417646.rMLUfLXkoz@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9417646.rMLUfLXkoz@ripper>
X-Smtpcorp-Track: 5CYCESOuSrdS.Qv6WxLnvaAdK.dUZRBw8kG15
Feedback-ID: 510616m:510616apGKSTK:510616s18Gubagtp
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: AXLY632VO5QKT3ML4Z2LVKVBAVA77LHP
X-Message-ID-Hash: AXLY632VO5QKT3ML4Z2LVKVBAVA77LHP
X-MailFrom: 
 bT.uk1d2nl4ksiwwq0=fv7qo6y7g7i3=5v4ezpakr918l4@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AXLY632VO5QKT3ML4Z2LVKVBAVA77LHP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 10:04:15AM +0100, Sven Eckelmann wrote:
> On Wednesday, 20 November 2024 18:47:17 CET Remi Pommarel wrote:
> > The tt.local_changes atomic is either written with tt.changes_list_lock
> > or close to it (see batadv_tt_local_event()). Thus the performance gain
> > using an atomic was limited (or because of atomic_read() impact even
> > negative). Using atomic also comes with the need to be wary of potential
> > negative tt.local_changes value.
> > 
> > Simplify the tt.local_changes usage by removing the atomic property and
> > modifying it only with tt.changes_list_lock held.
> 
> The overall change assumes that the compiler never splits writes (store 
> tearing) [1]. Of course, writes are protected against each other using locks. 
> But the reader is no longer protected from partial writes. I haven't checked 
> whether store fusing might be a problem.
> 
> Kind regards,
> 	Sven
> 
> [1] https://www.kernel.org/doc/html/latest/core-api/wrappers/memory-barriers.html

Good catch thanks.

> 
> [...]
> > @@ -783,13 +783,13 @@ static int batadv_softif_init_late(struct net_device *dev)
> >  	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
> >  	atomic_set(&bat_priv->bcast_seqno, 1);
> >  	atomic_set(&bat_priv->tt.vn, 0);
> > -	atomic_set(&bat_priv->tt.local_changes, 0);
> >  	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
> >  #ifdef CONFIG_BATMAN_ADV_BLA
> >  	atomic_set(&bat_priv->bla.num_requests, 0);
> >  #endif
> >  	atomic_set(&bat_priv->tp_num, 0);
> >  
> > +	bat_priv->tt.local_changes = 0;
> 
> Would need WRITE_ONCE (just to be consistent)
> 
> [...]
> > @@ -508,21 +507,17 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
> >  del:
> >  		list_del(&entry->list);
> >  		kmem_cache_free(batadv_tt_change_cache, entry);
> > +		bat_priv->tt.local_changes--;
> >  		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
> > -		event_removed = true;
> >  		goto unlock;
> >  	}
> >  
> >  	/* track the change in the OGMinterval list */
> >  	list_add_tail(&tt_change_node->list, &bat_priv->tt.changes_list);
> > +	bat_priv->tt.local_changes++;
> 
> Needs more complex constructs with WRITE_ONCE or 
> __sync_add_and_fetch/__sync_sub_and_fetch (which were handled before inside 
> atomic_inc). The latter are not used that often in the kernel, so I wouldn't
> want to introduce them in the batman-adv module.

What about using something in the line:
	WRITE_ONCE(&bat_priv->tt.local_changes,
		   READ_ONCE(&bat_priv->tt.local_changes) + 1);

> 
> > @@ -1022,7 +1017,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >  	tt_data->flags = BATADV_TT_OGM_DIFF;
> >  
> >  	spin_lock_bh(&bat_priv->tt.changes_list_lock);
> > -	atomic_set(&bat_priv->tt.local_changes, 0);
> > +	bat_priv->tt.local_changes = 0;
> >  
> >  	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
> >  				 list) {
> 
> Would need WRITE_ONCE
> 
> > @@ -1438,7 +1433,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
> >  		kmem_cache_free(batadv_tt_change_cache, entry);
> >  	}
> >  
> > -	atomic_set(&bat_priv->tt.local_changes, 0);
> > +	bat_priv->tt.local_changes = 0;
> >  	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
> >  }
> 
> Would need WRITE_ONCE 

Yes.

Thanks for the review.

-- 
Remi
