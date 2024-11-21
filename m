Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69191D75BDB
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 09:14:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E959584039
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 10:14:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732180479;
 b=gS9CVnBi9qu+11+76cBOH6/e3ZzJ/sF8msCD+gKhUZmAVHMc7KQYK4GQhn9ob+hPPjc8o
 DK0Nud89VD7rad20v20aRUCrYFfSqiDEUwrdaNgdWbbxeK9Lcq7NtMs4E7KoUiIXP5w/j6s
 PaCs7Th30UqE356XIG0H80MRx2v+NMo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732180479; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XJMf4lEKFpSoMLjGWgWOKPUos7uUp3TREJsaZ70YHKA=;
 b=aioI/xOSTSMQEq+5hSjEthWzhl4sphKORMfiQunlyL32ZHaKl8zlqTyEqw3AbvtXS/Y/x
 FbjQz/l/+0d7IQE+B5Ep1GTjIxwjKHePusuLqVPktBNpwPzD2+wDaa6WjftMcIEjpu1CE2E
 Bl9y7EPuE4gSJyATtxwfWAtvE7W9oCs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0EB7A802EA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 10:14:26 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732180467; a=rsa-sha256;
	cv=none;
	b=gc/0iHhi9EF7vMGiY2Z6nRhvfC16+evmcj+CtmGXSIuM7mzjUs/UNES+LuTqo2j4vJXvky
	QGPuvU5Z35RfXoUnNQSNlG3wJOh9BGdI2dEWVuFtyPSbcRFdBbahU/MoGdErBnRo1bPsRc
	F3tTq2EvIYTzoIet5YS8Z8k6OvlGQBc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=DeDa6xVv;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=k7MO4tGn;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.gp94cm97uxjnfm1=if6u0eum7p3b=shyb7jrcl7mv29@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.gp94cm97uxjnfm1=if6u0eum7p3b=shyb7jrcl7mv29@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732180467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XJMf4lEKFpSoMLjGWgWOKPUos7uUp3TREJsaZ70YHKA=;
	b=Gh5pSGZzfYoe1btriogFbj8+jIrPIjBotNfREFDnUx61xRpOIaEOYWzy1V/0rm9qvOyZvN
	O1lNrK0CCLc95yvO0qscWSzjGeGvH6CrOdjdbUctFQy8eRouvxl9RPmwwkXZTwDOTHxaBl
	tnubPyAE8rwVP4vkZplc64ywGO/GpBw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732181366; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=XJMf4lEKFpSoMLjGWgWOKPUos7uUp3TREJsaZ70YHKA=; b=DeDa6xVvFNFUP06vRJVui9j/KS
	TxP+baaw4XgrH7TU2jrceL4z91M67RDqWrGFyU1abtdF4xp1pMb0KcYAV34S7j21C7JdgL+tQkuaF
	lHkL2f8/htsFkK2ZwlCBdk+9W7n4kqO9K1kO2Mi6ut3tdGh/u1Eubbuvlxi6DbvxDKQMtTRvAlyJa
	7zg1AX869N0/GR8Kx0+eVJYHKs7RzXsAkImF0lcov2UN6AxXfzbzOFcxQK1tWAt5xGT1JtpsU5rli
	+xS6SoFtdksKOHQrpV64/kwAEkYlrJals+2QSbDbvlFSnvNHurE1DrcsnzqJBarMoWCPCqK7Zomiz
	sUTyQzUQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732180466; h=from : subject
 : to : message-id : date;
 bh=XJMf4lEKFpSoMLjGWgWOKPUos7uUp3TREJsaZ70YHKA=;
 b=k7MO4tGnqJbm2Rm7t2Yls9iCVeILh2/EV13A/IQZF6IlwyN8L+uOO/Wtc9hkrkG+TyMJJ
 1YnrtP0TaSxVUSdlV6onr7+wo2x8k1skE3qMz83LLaVqdKRdAMGWB7sL+xa9VDl5QXw6SjE
 Gh2PlMbisq/ToRJOejZUj4KBgOKaXO+WQ8PeMNbEnunr6twQDwqsVY0qkQFevjmr5SREv+j
 zsjX61b70zB6dyCt2fgv/AN5GsQzio2DfvZzHQyinDwl8qChlulcU1M2vH3WghnEivwS3H8
 lKMVJVomyIMK56FQEXHZLFov8KNosLgKPmt+b2iNuOYJxzpuJemmPLZWkwRg==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE3GZ-TRk0Tg-6e; Thu, 21 Nov 2024 09:14:23 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE3GY-FnQW0hPu2Et-nzpF; Thu, 21 Nov 2024 09:14:22 +0000
Date: Thu, 21 Nov 2024 10:13:15 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH v3 5/5] batman-adv: Don't keep redundant TT change events
Message-ID: <Zz75q77puwRSl5hN@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <71e47271e530851861441f55d102e55a7e5d1fc8.1732124716.git.repk@triplefau.lt>
 <2485257.jE0xQCEvom@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2485257.jE0xQCEvom@ripper>
X-Smtpcorp-Track: BH_GkMM1nyvM.7FRqTJ2ILAkh.PVANoQy-XjK
Feedback-ID: 510616m:510616apGKSTK:510616szYJJKf0WC
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: QUNQB43EKRSXNUJOMPHN34GWDW6KCCCB
X-Message-ID-Hash: QUNQB43EKRSXNUJOMPHN34GWDW6KCCCB
X-MailFrom: 
 bT.gp94cm97uxjnfm1=if6u0eum7p3b=shyb7jrcl7mv29@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QUNQB43EKRSXNUJOMPHN34GWDW6KCCCB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 09:43:01AM +0100, Sven Eckelmann wrote:
> On Wednesday, 20 November 2024 18:47:18 CET Remi Pommarel wrote:
> > -               /* this is a second add in the same originator interval. It
> > -                * means that flags have been changed: update them!
> > +               /* this is a second add or del in the same originator interval.
> > +                * It could mean that flags have been changed (e.g. double
> > +                * add): update them
> >                  */
> > -               if (!del_op_requested && !del_op_entry)
> > +               if (del_op_requested == del_op_entry) {
> >                         entry->change.flags = flags;
> > +                       goto discard;
> > +               }
> >  
> >                 continue;
> 
> >From logic perspective, the check would be irrelevant - and the continue never happens.
> 
> 
>     if (!del_op_requested && del_op_entry)
>     	goto del;
>     if (del_op_requested && !del_op_entry)
>     	goto del;
> 
> 
> Implies that del_op_requested == del_op_entry. So the check wouldn't make too 
> much sense. Maybe we should clean up this logic further:
> 
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 437c4edd..b349851b 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -484,18 +484,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
>  		if (!batadv_compare_eth(entry->change.addr, common->addr))
>  			continue;
>  
> -		/* DEL+ADD in the same orig interval have no effect and can be
> -		 * removed to avoid silly behaviour on the receiver side. The
> -		 * other way around (ADD+DEL) can happen in case of roaming of
> -		 * a client still in the NEW state. Roaming of NEW clients is
> -		 * now possible due to automatically recognition of "temporary"
> -		 * clients
> -		 */
>  		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
> -		if (!del_op_requested && del_op_entry)
> -			goto del;
> -		if (del_op_requested && !del_op_entry)
> -			goto del;
>  
>  		/* this is a second add or del in the same originator interval.
>  		 * It could mean that flags have been changed (e.g. double
> @@ -506,8 +495,13 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
>  			goto discard;
>  		}
>  
> -		continue;
> -del:
> +		/* DEL+ADD in the same orig interval have no effect and can be
> +		 * removed to avoid silly behaviour on the receiver side. The
> +		 * other way around (ADD+DEL) can happen in case of roaming of
> +		 * a client still in the NEW state. Roaming of NEW clients is
> +		 * now possible due to automatically recognition of "temporary"
> +		 * clients
> +		 */
>  		list_del(&entry->list);
>  		kmem_cache_free(batadv_tt_change_cache, entry);
>  		bat_priv->tt.local_changes--;
> 

Looks right to me, I would even simplify that more for readability with:


 		 * now possible due to automatically recognition of "temporary"
 		 * clients
 		 */
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (!del_op_requested && del_op_entry)
-			goto del;
-		if (del_op_requested && !del_op_entry)
-			goto del;
-
-		/* this is a second add or del in the same originator interval.
-		 * It could mean that flags have been changed (e.g. double
-		 * add): update them
-		 */
-		if (del_op_requested == del_op_entry) {
-			entry->change.flags = flags;
-			goto discard;
+		if (del_op_requested != del_op_entry) {
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+			bat_priv->tt.local_changes--;
 		}
-
-		continue;
-del:
-		list_del(&entry->list);
-		kmem_cache_free(batadv_tt_change_cache, entry);
-		bat_priv->tt.local_changes--;
 discard:
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto unlock;

-- 
Remi
