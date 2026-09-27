Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCA2C9830E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 08:35:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5C74D8409C
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 10:35:30 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790498130;
 b=K+ElVPwcqm1WYfWW442w0mXuZ6zdVyKY66orxEqiwMQixg05AoZjUq3XDFL11a/gpN75W
 dRzdLQSui9ozVHwtMjIkMiI/U47f3RsconlQcIsUKbCy88fGJaiIRHEcMFqsj87rwXj8yPI
 1T6/b5lFAsTAD42XZcYWNGbuRMxf0oU=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790498130; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
 b=ggWmOhTFL39E/3eGAHg6BArIMDefD4wb8S7DqyvpqKZ3EpdzEKGzPgW85u6AFHd52Z6NU
 lciT2EQ9R8R7MaDYjcg8IP/SQ2Oid0OflXh/bpgTbeDwvvzK4miQ2im97KipReBtkzTFbYG
 Q3Rwy7ohJB/zb5HDGIasYFJ9wG9bzTs=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C8D6D810BF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 10:32:26 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1790497946;
	b=rPHWLSjiM41gZB0DUVBzLqeL8w+oUx+kFwjAkPw63dH7LznkztIk6bT9XXx9vJ29PzcxzT
	9V0IE85tkb8oXOsGKIfS53nX907K/OP+oVBHX1IsnTOmKkvqoKF/++mMLGhH/U3c9I8QId
	xF8fhzOYgioUUbXxhFBPRjREPy6rQIU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790497946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
	b=0kZ7X5yKQauFv+Z5LK7PFYnLOeSu0cpd+4CrX/MkmEeZbWu4LrFv4ptXr5uXRB1z0qXTjA
	lhykRbVWebSmligtgS0wfC6/xOXefOwMcJpmIFjOn9anPSrYkIfF8z5jUnu/shcNpv4BKN
	9AtVZGwV/ArD372cNcIK+kS7O3kY5eo=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xe6amKtS;
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("google.com:s=arc-20260327:i=1");
	spf=pass (diktynna.open-mesh.org: domain of nicoyip.dev@gmail.com designates
 2a00:1450:4864:33::d as permitted sender) smtp.mailfrom=nicoyip.dev@gmail.com
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6d9a3d50so55901a12.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 27 Sep 2026 01:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790497946; cv=none;
        d=google.com; s=arc-20260327;
        b=UMCRXkvOfLa5YxAYWMW4jEhGH9+4+MU2UFQxw56nHVKJBulqzup9Ht3JfLoTqx1aRK
         pe8eftIYnHKDnXDIJOB6ArmMafVGdGsuEmrAgyW0WtF0gWIoIbg9ipNT+fKEZ9VpeEZY
         r+qVC2cNKi9SY7RmBQfRjxtT2c35sEDz6hOsnPXjQartVDGYTtoABj3P//txmEMC4SHO
         PlQNJ4dJVc+kfioBcUXwK5uJU/wQPp61WJkOusZ1uqrrSjYCQXY4ceR5TAQxxvBRjFUT
         3dxLxna+1AlLzxd4Uv9wR+5dCXPzqw0PFTROo7SL3n0HZ3DYr6kEAxsGdmibHD5be/+k
         62qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
        fh=yHvEZ1GjJtOhX1Koo+aa+/ltpX22vuIsu2b4GOGf2+g=;
        b=nftFNqoCtPjVfTZWR/PA3J/YPQoykC7MfEwVdDZrpa9SeCtvxpGvRWTmZlRcCPa4ev
         b++BXDTwWT7lVoMlOt2Y3qNRXCtJrIU1IaitpIvoxN8KIR1ymt2lCXShMLK5Cp0j3Yc9
         0/bnCgGS9dmXbko3m4Qx3618nrhTLQqnOR+TsFCrzlC5H4Ymz64yEzCQRYwveVE6/atF
         9yTK2aFd/zj+yqQY+X6Oei6v+zBm0KcjA/azhVyj7IQbCUOFoWSb4VHYHTIVQdfL7BZc
         2iZNX/gT6AqoVpNFrtxmhCRDYMtg8SnGnTF1a8UmKhKBKz3TiaI9dGF0c4KGfx4MCXWr
         RYJA==;
        darn=lists.open-mesh.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790497946; x=1791102746;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
        b=Xe6amKtS7iJBX0XUA5ves7apWfT8CfNsmGFtgWzMjSqA0vJePNfP4PTYvj2s7JbpDG
         uCA9+iENLKp/mh6ouwG1VpCQF365Wxhj8wkWkf4DmB69xDyDD9HSN8dZEY9Nmd+XCqnm
         yBh9F35t7Oe7N3JEccgoM0efDe9k42iaw0oKCUOypWZqLCGq7I4FNgl2CwPagg2fLFLD
         7v1DiFYB9oMZNnGDQnj0K/Wg9f6Fv4SeTpbeUe+gNsKR2ZdaqGA9xqbA6krSDyxNemwa
         fok3dTHtf76714zACkM+VAr/UXX0CEbyUc4cvLNA82d+ytoWoOv+Z0HHWO1J56/hZDs+
         J2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790497946; x=1791102746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
        b=HYJyvBVWEcZbkkBYfjS3iGdHFuv0pzKNmzGFTvT4bAfJtIbWXipNDvx6FJJvKUPOQj
         Ay7gaQxKi4c9aqbqcMJhw+Oiqd+pLCLIRS5S+6XLeaXNoEzu7tUbSudWQhoi41Yz41Or
         D0pYrGiTO1flRT3QzEjplHFuqmEGmd1Jm49HB9apL0u/rbtHXw/qZRAlvwieKzC0jon+
         VoByaoFT8BygQuySlfU530NHRSiQyhCRLgOv+jL8CDeOMOJ7cC0E7BXixE50sQz8hCVA
         2qbou0UpmVIB7XioELqSfHsV37tvS4hbVJcn5jZaC33wFr3nlsfsQpIMUf7dhCvtcbUd
         zQ2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQE5kjpFktwYwkNI2xFLOghxw0X0qNNikBOyj7ZQXPNkclmoQ0SztR4ZXy78Mk3o9b6qDA2dQL9xqO+g==@lists.open-mesh.org
X-Gm-Message-State: AFq9FYJRvySKYALHYdRrBZ7v5BzRuYAeGQa1xV48SUnOQ2te0az6Bjya
	OTl3LHs31AGLLikLzor7HO5prUXQ/KgR1EmPM4/53E10JHP3PxhmmrEUTzeeLOpimQCIzIELtXv
	OkLqaRRRNABW/1SL6gn0NIJWnfJGQ4v8=
X-Gm-Gg: AYBFou3+Pz+gjmAx4lFdtI6ajDu6cJABTZ42UWsjq0Ge3lAu8J6vDZEj23FS1/2l+EB
	Kxk5g0aV6AcsSIex5Y9j9KTTsF4JxTeToZa+nDZd5L/M4EgCt2kxzFquuTb3Eq6vxfw3899S7xu
	I398DpZqRWml2y9hIlng6ozah7t2QRgMw7XLTeTxbo424iOsZYtlng5MR3lvOPAqeSW8pyI7rBR
	sPYfJvkVb+GJGPayBqw6+9vOLqWzBOliCf1B/v7QJDVnpBLeEc7NaeNwMbuPLnuLdEqIZF3I5NH
	X8VhKu4lN9M0EVbV88aQbN8b1QeoYDU5dgH4gO92DdCHk14bFFoLqiSGR2s1juOQ/xPZvfjIjWt
	yehPaXyWBw04kWyl5IsMcsg==
X-Received: by 2002:a05:6402:50c6:b0:6aa:f240:241 with SMTP id
 4fb4d7f45d1cf-6aaf24004c5mr4822258a12.0.1790497945733; Sun, 27 Sep 2026
 01:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
 <179049714090.25414.9706892666916736240.b4-review@b4>
In-Reply-To: <179049714090.25414.9706892666916736240.b4-review@b4>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 16:32:14 +0800
X-Gm-Features: AclHuK-VVl8oMxw1DKEDd6CYLQdS-fllp6XQOLEY4IQxZkl62p2gPbF455zhrGI
Message-ID: 
 <CAAo+4rXRTJz0wh=Xjv3ME8kfBsdgDC4q-n=M0-Z+uuOWik8fOg@mail.gmail.com>
Subject: Re: [PATCH net] batman-adv: Close OGM aggregation before transmission
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>, b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: nicoyip.dev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: X6SJPPXSMXPV63ND4WPIPLWRRX3U6AFF
X-Message-ID-Hash: X6SJPPXSMXPV63ND4WPIPLWRRX3U6AFF
X-Mailman-Approved-At: Sun, 27 Sep 2026 10:35:20 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X6SJPPXSMXPV63ND4WPIPLWRRX3U6AFF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thanks for the quick review.

On Sun, Sep 27, 2026 at 4:19=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> Thanks for the fix.
>
> Please don't submit batman-adv changes to netdev directly. And please sen=
d the
> patch also to the person which introduced the problem. You can use tools =
like
> `b4 prep --auto-to-cc` or just the underlying ./scripts/get_maintainer.pl
>
>     $ b4 mbox 20260926172600.2394088-1-nicoyip.dev@gmail.com
>     $ ./scripts/get_maintainer.pl 20260926172600.2394088-1-nicoyip.dev@gm=
ail.com.mbx
>     Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED=
)
>     Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED,=
blamed_fixes:1/1=3D100%)
>     Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED=
)
>     Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED,blame=
d_fixes:1/1=3D100%)
>     "Linus L=C3=BCssing" <linus.luessing@c0d3.blue> (blamed_fixes:1/1=3D1=
00%)
>     b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
>     linux-kernel@vger.kernel.org (open list)
>
> This change should not go directly to net.git. The target tree must be
> batadv.git

No problem, I will send the v2 to batadv.

>
>     $ ./scripts/get_maintainer.pl --scm 20260926172600.2394088-1-nicoyip.=
dev@gmail.com.mbx
>     [...]
>     git https://git.open-mesh.org/batadv.git
>     git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> The last tree is irrelevant for you because it is really unlikely that Li=
nus
> Torvalds will apply your patch directly.
>
> > The OGM send worker leaves its forwarding packet on forw_bat_list until
> > after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_loc=
k,
> > but emission reads and clones the packet without that lock.
> >
> > CPU 0 can therefore start emitting a queued packet while CPU 1 takes th=
e
> > list lock, finds the same packet and appends another OGM. The sender ca=
n
> > observe the new packet length before the corresponding direct-link flag
> > is set, or clone the skb while its length and payload are being updated=
.
> > This can transmit an OGM with incorrect flags or inconsistent data.
> >
> > KCSAN reported:
> >
> >   BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_out=
standing_bat_ogm_packet
> >   write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
> >   read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
> >   value changed: 0x00c0 -> 0x00d8
>
> Is there a reproducer and where can I find it?

I will prepare one and send it right away. The KCSAN was triggered
with a kernel-side delay() instrumentation.

> > Set num_packets to BATADV_MAX_AGGREGATION_PACKETS under the list lock
> > before emission. This waits for any ongoing append and makes the existi=
ng
> > aggregation limit check reject further appends before inspecting mutabl=
e
> > OGM flags. Emission walks packet_len rather than num_packets, so the
> > queued contents are still sent normally. Keep the packet on the list so
> > interface purging can still wait for the worker and retain its existing
> > ownership of the packet when freeing it.
>
> I might be wrong but this reads a little bit like it was written by an LL=
M. If
> this is the case, please think about following the annotation style descr=
ibed
> in https://docs.kernel.org/process/coding-assistants.html

Yes, it was generated with gpt-6-Astra, and I will add the missing tag
on v2 following the doc.

> > Backports before Linux 6.15 need count-handling adaptation.
>
> This is wrong. You are depending on 434becf57bdc ("batman-adv: Limit numb=
er of
> aggregated packets directly") and not the counting adaption. Of course, f=
or
> 4.10.x-6.14.x, you also need to change the BATADV_MAX_AGGREGATION_PACKETS=
 to
> BITS_PER_TYPE(forw_packet->direct_link_flags)
> And it doesn't belong in the commit message (like this). Please annotate =
the
> dependencies as described in
> https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-ru=
les
>
> > Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface=
 removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> >
> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 53fbdbbe8f4f7..59847299a1237 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -1909,6 +1909,10 @@ static void batadv_iv_send_outstanding_bat_ogm_p=
acket(struct work_struct *work)
> >               goto out;
> >       }
> >
> > +     spin_lock_bh(&bat_priv->forw_bat_list_lock);
> > +     forw_packet->num_packets =3D BATADV_MAX_AGGREGATION_PACKETS;
> > +     spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> > +
>
> Can you add a small comment above like "mark aggregate as full before for=
cing
> emit" (or something similar).

No problem, the commit message and the comment will be adjusted accordingly=
.

> --
> Sven Eckelmann <sven@narfation.org>
