Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C08BC54E5D
	for <batman@archiver.kernel.org>; Tue, 19 Mar 2024 14:03:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C7D5481C9C
	for <batman@archiver.kernel.org>; Tue, 19 Mar 2024 15:03:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1710857027;
 b=2L0/CJ4hxruDc5nzwDZUolFrAaXoFBxyswHCqSkQO2mvbN5tHVqVoDKXaBtcbxD07yAb7
 GaiY7ZFfL7zx69w78/I1XUb7Stz5VaZLWgVxUEzJtouiG74ELW405xTKkL5GrOI+Yh2EIZF
 zMqZHfWl4Ga7kYEK41jI6B3u7Han4r0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1710857027; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
 b=yO8sEj6IXF7+73LmJlx1utvWqjTx5YOVCZa/f9JgRODLCZpGG5UYRiXQ2BGGhzRfK9wBo
 nO4x259LiYNoBJVuYAuWFe+9AJdXQHTDn2qj16HJ3dE5UUkckSCe/2IzeYvhhSK/+vT8Xns
 x5tW5MaFwodI866FP747Gj3W8WXWIhs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=google.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=google.com
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=google.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=google.com policy.dmarc=reject
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8FE7380800
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Mar 2024 14:31:49 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1710855110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
	b=B5k+peX8RP0HR9FUrT3wM08+qKe4itjN3NWkpDyyR/7t3n5gHn5arwsN0sxjo0DsrRsDu2
	hpUYRkm6QDEWKtNfvPTfFj9PotMtD5B+noCc0AEJB++M6dPETOL4RxaXuYiFSwSTtVbg+q
	+hHK2UlG8b/TJnMVZtZPT/6ujQg0IH8=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1710855110; a=rsa-sha256;
	cv=none;
	b=xfydgU9+aJodwsCnY5/wLC+IM+W4UGEaERILrctyGNNu4OZ7e8BHDGqOpFMQElCdev/Xub
	HuwuGcU85nBVzCNTt4BYkr5+ZSesA/N06l/gyqTfgCRHkPrFp7qidBVF6MIuVGJNxg/xEB
	MNz/6lh5L/5EWNW1T8T0OWaZVG2OGOA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=google.com header.s=20230601 header.b=wMeXr+AD;
	spf=pass (diktynna.open-mesh.org: domain of nogikh@google.com designates
 2607:f8b0:4864:20::62b as permitted sender) smtp.mailfrom=nogikh@google.com;
	dmarc=pass (policy=reject) header.from=google.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dee917abd5so152235ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 19 Mar 2024 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710855108; x=1711459908;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=wMeXr+ADrizlwyhua7Y0+aPeEx96yCimYt1P8cVMczPAn4kIQ5x9J2bFm5SSW5xLxD
         p88+rdFqWpcpi4j+rpAQMQU7OX9m5yDxtkQ73m6k3pOBNs1R2ivu2wKqhd30lHU77w26
         iXCHzcsAfMcsZTbf1GMO878JwrzFP6Xajkb0Ytl7rJq0EU7HjS8UJosowgnI5B6fAwe8
         SD2l9IteqGRiY+1csT3cKjkHFUW+/W6FWWOvinBnGgi0A387QQPZFVo6rNQdlefG/dvC
         bVhJGytmMvG6Zr/iCShP2mhLFhm57gg9kzPul8F43eFQN3O6HSl/dF5Dk9GlT2zC63SX
         Nzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855108; x=1711459908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=E8wULU4JzjVbAgon06MWxGPuWDgKenpm9h/T+CVzOeRLD/PNvr5soS96w0JEwYl45i
         tIKRR+GdsaJ/Mo3Muc83EUnLqqRA8TO9XdStnHc+4vrtUIHWQUI1t2L6Twn7JXhhupyp
         VBjxKcQfQ1tk6JT5TgmOGKfzhfmqOnWE5ZEzRA/Ed0ewOSyFSiVJdCZB25cC+EddTE7d
         RRvES/q/tGDJXzDZ0ys+bR2bGmvXypb2nXlFPPLBKwR8hfhOPWfTwKPi6ooQNubCMNl3
         RV+YU29sGbhTWB3uaUh1hLsGrG6WoeQ4eKdjBo83G4ngUSAelz8vExeH35/UIKD7qDiJ
         4Oqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmIiJH8qKxsySrJqFAKXovIc/V2fVCDJVg8MpIru2IVmjaBFcx4l9U/sCZvNqThfEls1MTew2LSc/cdmawGGaSX6rwBDommOv0aCD8ZFMs
X-Gm-Message-State: AOJu0YwfHCgF/Lcba7RNHhJoaoMyllYj4h/4+2A0vWgMXvu9YET8CCdj
	KGXyMBdWXqb3Y+oB7wnUbPpo99gdjI0qyv6SrPYISAh0wnh7ZKYlbBLQJZSS27TQW1OPqHYxiUU
	DGhxVybrEGF8Cbsow/TaVglCetCkONW2TiPaL
X-Google-Smtp-Source: 
 AGHT+IFNmXcGYu+lNSQ2iexTWqZe47HUoTeYhNiE93aW579mIfvRqJBheAkUJL1ix5bvm3wn2zyeJjyY46GinXgiC30=
X-Received: by 2002:a17:903:2303:b0:1dd:65bd:69ec with SMTP id
 d3-20020a170903230300b001dd65bd69ecmr240302plh.20.1710855107477; Tue, 19 Mar
 2024 06:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000901b1c0614010091@google.com>
 <2615678.iZASKD2KPV@ripper>
In-Reply-To: <2615678.iZASKD2KPV@ripper>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 19 Mar 2024 14:31:35 +0100
Message-ID: 
 <CANp29Y7SuK8P8xHa6JzAzs_NxPUN9AvFTiKfMhgLy1POGBodwA@mail.gmail.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
To: Sven Eckelmann <sven@narfation.org>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, christian@brauner.io,
	daniel@iogearbox.net, dvyukov@google.com, edumazet@google.com,
	elver@google.com, glider@google.com, hdanton@sina.com, jakub@cloudflare.com,
	jannh@google.com, john.fastabend@gmail.com, kasan-dev@googlegroups.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org,
	pabeni@redhat.com, shakeelb@google.com, syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: nogikh@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 7ATF2IBRIFQKRWYLGALD7O2DNWT32LP6
X-Message-ID-Hash: 7ATF2IBRIFQKRWYLGALD7O2DNWT32LP6
X-Mailman-Approved-At: Tue, 19 Mar 2024 15:03:31 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7ATF2IBRIFQKRWYLGALD7O2DNWT32LP6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,

On Tue, Mar 19, 2024 at 2:19=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Tuesday, 19 March 2024 11:33:17 CET syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
< ... >
>
> Sorry, this is a little bit off-topic. But how does sysbot figure out the
> subsystems (like "[batman?]"). Because neither the reproducer nor the
> backtrace nor the console output mention anything batman-adv related.

Syzbot looks at several crash reports to determine the bug subsystems
and in this case one of those crashes was pointing to
net/batman-adv/multicast.c:

https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15afccb3280000

--=20
Aleksandr

>
> Kind regards,
>         Sven
>
> --
