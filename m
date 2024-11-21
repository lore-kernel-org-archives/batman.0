Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E96DD7877B
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 15:08:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D889284331
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 16:08:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732201732;
 b=AxhtbMf8pfagBUu/eWLNVvOs5iQrE4GjTQLATbgSiQ5DLXjlGKfGWwIOU7AMMy8/MRmWy
 Yy7oYS3qwD7bC1+kE7SZE9Js85ehgvege6wRVurwdebID/PTQZVvgXnlnaLoQFff3/SXuhy
 IZJBeJRoEcQNQ1FUalUVvpqN7wKanDw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732201732; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ry+cr0uPPWD6eO7gpv0HbIIcJiCVAQccterS4RK2glE=;
 b=OjHis0A5fzqDlxrn7XSIsCybidiA0rrjJH5ztO13p8pc/uqcnhbp24AcUeKmfGmjc7wd6
 x6wu6onw1AFh5toF6n3C3nG6NowGf75bbGEMa3MHKkbtrBrqkzA1oYCyUtHscMxUzaVxUKs
 wh4f3MwjSCLqVz0ED3P5emQysi2Bh3Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 77FE38301D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 16:08:38 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732201719; a=rsa-sha256;
	cv=none;
	b=A1Ss/5hlyxy8XXZR3buatNxhr5PN5yA4exZnPEPmSTSa/rLI5SV41hokpe2XVIM+Xrhxgw
	AtxtkL8Wli/jiAy6O7HVAG90mgcgtB6jJe5LyX3JpPZYYoStWLwCbStGWr2vmHjt55CeD3
	9if8xfgygqZEUrCuujLG0wA1ClqN7aY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=yn+LuqkI;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=RFDleyFx;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.v726lolezipvbx2=l44m50dyxvhy=c54qdkparimoct@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.v726lolezipvbx2=l44m50dyxvhy=c54qdkparimoct@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732201719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ry+cr0uPPWD6eO7gpv0HbIIcJiCVAQccterS4RK2glE=;
	b=eL2x1MJEJZhOhBaRAXZT8ox8Qnc963g1DP2MXyW3v427qGJkA0tqB7Q9qWVVn90ZUCBNhv
	zlkkqb6lPakRvAZ43bwdC87Z1pYUYvPnwmHCE4dhzy9L+xjII1jFAQjN5H/NkIQI/oObRx
	osEIxn46KaJMF8CCXZ9d94uMK4nhjp8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732202618; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=ry+cr0uPPWD6eO7gpv0HbIIcJiCVAQccterS4RK2glE=; b=yn+LuqkI9WYMRCt3z8wpl8C46i
	T4VYPqwMi6a3yS7KovN0iod2FdTKuAOl1g20OxFKskHQ/y3FzZkkeTohzJN7nPoaMkna4Blho0EUi
	33gFXOM4eJ7hG8ShFQYK9HBG8kKZxyI8BfqywfdyfXYYLQuo1utzSFoztBz3oVWkCsAHq+kkIgBj9
	3/x7y6SiPB/+W1+u5tlZhlKcEIsCOU0BtUlx7vMRT0Z7cGiLIrIRx4bjivfQeUBMB3b+bBg+9o1qx
	bwf6SlaqsEqtBgFJfmmvhGXi5IRKC/TiHmKcAtTzzHQQG+C6cMW3rgfW9fVCj6jqY8NKdDBmVXyre
	F8wZlWNg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732201718; h=from : subject
 : to : message-id : date;
 bh=ry+cr0uPPWD6eO7gpv0HbIIcJiCVAQccterS4RK2glE=;
 b=RFDleyFxlyYnf2K5rgAACyRzQ3VmCI9fyIc0c1qnJtJBfrKa0gWJdoX8TB/FNy2n3E73r
 wZVdbrUcUWclC8bNVWs6Jj6nnhzHSAk1UbSfk4sxFP/czCRSiFvuq9iq71T+O6P9YZG+9FV
 leKGAxbOtKj0isGzBokG3YIvcuDbWp6a74+yYT+iGZ1wR6XWAGmSjLmnR6hn/2lNabYslzH
 gjHMZ1ZgjPOoSOV/IMmcyBhU/iemHI3aZVKMUu0uUQGnYsVgdD2CgMLE8qUbO77PKRuRy5Z
 nxF+0kb0Xsm17hl4f/Tcco2fjCtnzynK+MpjBiLp90D5TyLHEydzGC7Iyhzw==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE8nH-TRk73i-Sq; Thu, 21 Nov 2024 15:08:31 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tE8nH-AIkwcC8trNf-JHsd; Thu, 21 Nov 2024 15:08:31 +0000
Date: Thu, 21 Nov 2024 16:07:24 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
Message-ID: <Zz9MrP6LBw0eY_Uv@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <fbc17f32703930e711353d82146a916106acd2f1.1732124716.git.repk@triplefau.lt>
 <bf055638-afff-40af-85d7-dfdbf0afa842@unstable.cc>
 <Zz88AYyDTv5W9gQk@pilgrim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz88AYyDTv5W9gQk@pilgrim>
X-Smtpcorp-Track: KLPZVHHdpiPy.ESjIFosm1nkH.BP144Q9CxQw
Feedback-ID: 510616m:510616apGKSTK:510616shuy2ZSTuu
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: 6WB55RPJMWX7YWOQL6IYNIBD3FWUD3F6
X-Message-ID-Hash: 6WB55RPJMWX7YWOQL6IYNIBD3FWUD3F6
X-MailFrom: 
 bT.v726lolezipvbx2=l44m50dyxvhy=c54qdkparimoct@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6WB55RPJMWX7YWOQL6IYNIBD3FWUD3F6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Nov 21, 2024 at 02:56:17PM +0100, Remi Pommarel wrote:
> On Thu, Nov 21, 2024 at 02:05:58PM +0100, Antonio Quartulli wrote:
> > On 20/11/2024 18:47, Remi Pommarel wrote:
> > > The number of TT changes can be less than initially expected in
> > > batadv_tt_tvlv_container_update() (changes can be removed by
> > > batadv_tt_local_event() in ADD+DEL sequence between reading
> > > tt_diff_entries_num and actually iterating the change list under lock).
> > > 
> > > Thus tt_diff_len could be bigger than the actual changes size that need
> > > to be sent. Because batadv_send_my_tt_response sends the whole
> > > packet, uninitialized data can be interpreted as TT changes on other
> > > nodes leading to weird TT global entries on those nodes such as:
> > > 
> > >   * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
> > >   * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)
> > > 
> > > All of the above also applies to OGM tvlv container buffer's tvlv_len.
> > > 
> > > Remove the extra allocated space to avoid sending uninitialized TT
> > > changes in batadv_send_my_tt_response() and batadv_v_ogm_send_softif().
> > > 
> > > Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
> > > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > > ---
> > >   net/batman-adv/translation-table.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > > index 2243cec18ecc..f0590f9bc2b1 100644
> > > --- a/net/batman-adv/translation-table.c
> > > +++ b/net/batman-adv/translation-table.c
> > > @@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> > >   	int tt_diff_len, tt_change_len = 0;
> > >   	int tt_diff_entries_num = 0;
> > >   	int tt_diff_entries_count = 0;
> > > +	size_t tt_extra_len = 0;
> > >   	u16 tvlv_len;
> > >   	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
> > > @@ -1027,6 +1028,9 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> > >   	}
> > >   	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
> > 
> > what speaks against acquiring tt.changes_list_lock before reading
> > tt.local_changes? (and making sure the writer does the update under lock
> > too) Any reason for not pursuing that path?
> 
> Nothing against, just tried to follow old behavior in case this was
> that way for performance reasons. That would mean
> batadv_tt_local_commit_changes_nolock() to take the lock; because it
> is only called once per OGM interval I think that would be ok.

Actually I initialy though that holding this lock in
batadv_tt_local_commit_changes_nolock() would be fine, but because it
purges client and updates crc (two fairly intensive operations), that
could be a bad idea to hold the lock that long.

So batadv_tt_local_commit_changes_nolock() would still need to get
tt.local_changes without the lock (needing READ_ONCE), hence updates
would need WRITE_ONCE to avoid store tearing as discussed with Sven.

So the patch would be quite similar, only tt->tt.changes_list_lock will
be taken sooner in batadv_tt_tvlv_container_update().

That will fix the ADD between two read situation as you described
though.

Do you still prefer this option ?

Thanks

-- 
Remi
