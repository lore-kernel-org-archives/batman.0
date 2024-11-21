Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB60D78765
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 14:19:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 61B2B842E1
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 15:19:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732198796;
 b=PypYEwc4ID3lGLhTHvIILTBZOQFPmsd9oYXxq04TzXOuUZIcRQNwqD5KTUqArZlsa24jj
 /np+FbhyLlQgifN+4wWoge4C37+V0kingdhGySsnd/4q1F5MBh/xYcxwo7lT84zlZf2wpX2
 1jeyVoUETswnU2aV1mmCTv3jOiXRXrs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732198796; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rS2Fwurc0wTemC6GXqi0BmkDK3Q4/f9N8c7qb66QlDA=;
 b=G3jHjxh9I5fJH9y6RXzPL3GjX/+Azovzeg2tsSCkxT70Wc/hFBBJ6BRAJWIHptvyXXc79
 tzk7QLqRm1ePcb1yVSgCraLd+83ja5Keo11NO6dRXl6RiEsADKPsG5TZbzedFV4+UryivLa
 LEeB3X2It8gN+Z+Vjes3ewdvsoWD9WM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B30BB826CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 15:19:40 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732198781; a=rsa-sha256;
	cv=none;
	b=hQoraR/Ole3eSO8eLbo2Uccf3TIF0JRDXrij0iDYpZv6L1eFNdycbEDMK2t47t/RyeohmU
	5m8ji8oDngj+Wny4rie7vTpg+RceBQScenq/Q6aCXd6wgBapGD9/Uju5SxQ6YXE7+v/0E5
	8XmjioxbQVLtVTgdaSTB6ieqr/oKWo4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=F6Qa4Z3O;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b="k0aPF/T9";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.84ob4donkrfypv8=ls8mu8wsocit=ksi39jx4n0e2o6@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.84ob4donkrfypv8=ls8mu8wsocit=ksi39jx4n0e2o6@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732198781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rS2Fwurc0wTemC6GXqi0BmkDK3Q4/f9N8c7qb66QlDA=;
	b=A51EIysyGhKUUmgpXF57lKj0R9wasE86LyFPKgYT/SM5GPaAcB7gOhp0mqeHCGfAoAQ22c
	5xbs+X/hCiib2sWd5IrVJRxgJbezloWfwahn1OSe9dk57n7PDmqhj9mfnY4diVftCNo16G
	IfC/wDskL6pwGaekH2b9Uwh+OIJWtJU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732199680; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=rS2Fwurc0wTemC6GXqi0BmkDK3Q4/f9N8c7qb66QlDA=; b=F6Qa4Z3O3vR0G2PV55TIsxwG1q
	0lUH4pvfdz/UWzigFFywYga2tguH7cP3KJrhePlVdRMnB08ffXFP0mqRZnYJrv0IB27qafOJ1o3TG
	prkh81lCCfa5bVz/BPDaSi6oL9+vduvMCmQ3CXNGrL2oJfHsA3Zy1Hp/Z9F0KKTBq4zg8zhiASYvN
	LVEwAJWQhtImeRvd3IQEiZQCleZ47rYXEJRsW5uEsJ8iLjjA3GLCGqo9nloPGenWTBk6Bjo7KeWev
	NjxzfGTTrQzCsStnrqMIrcj9yfG5/ysQXJA/JjHVNsFN4ZTOXqReGjs01HWug9SB0RmW1IgzAGZaf
	LqiMLf2Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732198780; h=from : subject
 : to : message-id : date;
 bh=rS2Fwurc0wTemC6GXqi0BmkDK3Q4/f9N8c7qb66QlDA=;
 b=k0aPF/T9VDEHK4gYES7w663dBhKxQSNBKA4FRCt8Ib7SdX/PLF66p/kHCGeGrSMEL7z+P
 kaScKxVME3yp+VxwMzeWwp4X0wK/iFUl5mtVg8L7Ae/2r1U0/HctSfyxZ8bm/Yrq+1ig6tY
 dlUEsRc3i/htXiAHg9pnX1MaedHKtVxoSNnQqS6BiTC91JySVvYWpBHCKHsz/oh3HUrgDUJ
 mPQKUUaIDTfA0+bQkyMTxypckrSt1zCPgjOhCeWPyT9X55JyQXspxfF9C5cly9aGjNu1m4P
 1O6lOOpVWdIHFtFRSq6Sl/7qX1P5DbQTGl/kPClXNAyER0q+YmpWBMNVlsLA==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE81v-TRk60w-0l; Thu, 21 Nov 2024 14:19:35 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE81u-4o5NDgrnshU-r0ff; Thu, 21 Nov 2024 14:19:34 +0000
Date: Thu, 21 Nov 2024 15:18:26 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 3/5] batman-adv: Do not let TT changes list grows
 indefinitely
Message-ID: <Zz9BMvv9sFcM3xt9@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <c8ebe15252c31d9cc0dd025830ddd793345948ac.1732124716.git.repk@triplefau.lt>
 <ddd55e72-7113-44f8-8150-c2cf74486449@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd55e72-7113-44f8-8150-c2cf74486449@unstable.cc>
X-Smtpcorp-Track: zkIv_uNCEmGY.NNXKtCs0ceqW.GM1KGggOCih
Feedback-ID: 510616m:510616apGKSTK:510616ss6_05YidV
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: 7EO34VGTZNDJFZSAPXBHTJYHSROO273T
X-Message-ID-Hash: 7EO34VGTZNDJFZSAPXBHTJYHSROO273T
X-MailFrom: 
 bT.84ob4donkrfypv8=ls8mu8wsocit=ksi39jx4n0e2o6@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7EO34VGTZNDJFZSAPXBHTJYHSROO273T/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 02:50:18PM +0100, Antonio Quartulli wrote:
> On 20/11/2024 18:47, Remi Pommarel wrote:
> > When TT changes list is too big to fit in packet due to MTU size, an
> > empty OGM is sent expected other node to send TT request to get the
> > changes. The issue is that tt.last_changeset was not built thus the
> > originator was responding with previous changes to those TT requests
> > (see batadv_send_my_tt_response). Also the changes list was never
> > cleaned up effectively never ending growing from this point onwards,
> > repeatedly sending the same TT response changes over and over, and a
> > creating a new empty OGM every OGM interval expecting for the local
> > changes to be purged.
> > 
> 
> nice catch!
> 
> > When there is more TT changes that can fit in packet, drop all changes,
> > send empty OGM and wait for TT request so we can respond with a full
> > table instead.
> > 
> > Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >   net/batman-adv/translation-table.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index bbab7491c83f..d7b43868b624 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >   	int tt_diff_len, tt_change_len = 0;
> >   	int tt_diff_entries_num = 0;
> >   	int tt_diff_entries_count = 0;
> > +	bool drop_changes = false;
> >   	size_t tt_extra_len = 0;
> >   	u16 tvlv_len;
> > @@ -997,21 +998,29 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >   	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
> >   	/* if we have too many changes for one packet don't send any
> > -	 * and wait for the tt table request which will be fragmented
> > +	 * and wait for the tt table request so we can reply with the full
> > +	 * table.
> 
> I'd still say "(fragmented) table", in order to give the reader a clue about
> how we're going to handle this.
> 
> > +	 *
> > +	 * The local change history should still be cleaned up or it will only
> > +	 * grow from this point onwards. Also tt.last_changeset should be set
> > +	 * to NULL so tt response could send the full table instead of diff.
> 
> Personally I'd not add these details.
> I'd just say that the history "should still be cleaned up as we get ready
> for the next TT round". Or something along those lines.
> The rest is just a consequence of the "preparation".
> 
> >   	 */
> > -	if (tt_diff_len > bat_priv->soft_iface->mtu)
> > +	if (tt_diff_len > bat_priv->soft_iface->mtu) {
> >   		tt_diff_len = 0;
> > +		tt_diff_entries_num = 0;
> > +		drop_changes = true;
> > +	}
> >   	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
> >   						     &tt_change, &tt_diff_len);
> >   	if (!tvlv_len)
> >   		return;
> > -	tt_data->flags = BATADV_TT_OGM_DIFF;
> > -
> > -	if (tt_diff_len == 0)
> > +	if (!drop_changes && tt_diff_len == 0)
> >   		goto container_register;
> > +	tt_data->flags = BATADV_TT_OGM_DIFF;
> 
> hmm there is no mention in the commit message as to why we're moving this
> assignment. Why is that?

No reason, the if is supposed to be after this flag, thanks.

> 
> [And I just saw that this flag is never used.......]
> 

Thanks for the review.

-- 
Remi
