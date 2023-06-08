Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50166C7EE25
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 09:35:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8038781932
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 11:35:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686216930;
 b=CTJirHL/0hKiKbN3j/TTRyfnJcLfPPM2J6XWnyo/3QvNEXRYIzYp+jE0+stS0dOJuzJt+
 MsxxElApPNREJd98WZykjZTFVOmmZ54Oin1hSPZc0kSgontgdYz9F5MwpnlCrpBftULE8IY
 0FTzA9JHsf4ve0hCzTcxQKvlwhDxL8A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686216930; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TkZdXAW7CSjCPUke2Sq5/5CWJURTImAgkFUg7fQ3MxM=;
 b=QVwwqde8aVn4K0re7vz0dMJgrxW76rIMQaLZwjNVrL/1YZrxfj70ZX+43gQX1zNb3PcfA
 v3I9N7wTvmDQ1n7vfS+4ZfDgTz7vT9VeUn59zGZmle2TMMLRrUxJ7LRTnLf9j439SqbdDbc
 3jKqFLz8LvSfyUBtWj+G01ujvciD37A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=none
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CEEAF80494
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  8 Jun 2023 11:27:38 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686216459; a=rsa-sha256;
	cv=none;
	b=Oq2Ztq43uGd4t2OJnDdOXm7BiizP+T7vuoiGCmvLDb2Pgp8kE4Vmpef0ynUVmABiwu0zSP
	rIne9ob40vJWCGm490YfqI+NBKVl5a8nAG0+xmWFAVxd8kbo3DA6u0Yi34N9wV59A9hv+9
	1fl0uO+qiNH/PpM1pWcs7t6hcWN94I0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DdjX4vAb;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=none) header.from=redhat.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686216459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TkZdXAW7CSjCPUke2Sq5/5CWJURTImAgkFUg7fQ3MxM=;
	b=UJ9Ghq4P29MPgHLMd+b+5MWSR90o+VNoHtMY/LPzmBlwlgbv76WbLqRZCwVikITTOo3vii
	KwhA3yEBFdmU8zGgyAbk8HqU5EJlToWH/owM+j8NcLN7QoHW/WymFXJeGnppEYG9n2Yll9
	ra1xcZPQ2PzkFmc4vWSGNqN7Pab+dN4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686216457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkZdXAW7CSjCPUke2Sq5/5CWJURTImAgkFUg7fQ3MxM=;
	b=DdjX4vAbFNYMQkshlyPV6eZNMl2KaZTPGVblvMxOJmnWcPhe4rHqxjtMjoXHTpjGZV1Z6M
	Y6bw1vOlietxyLYTWhJMO1DFq+2/qd3DwoNKWV0ZyXz65ZfC6QPcwyAjbxqDK2gJb5DtJl
	lwb0f0dTkH076WsoFpUXeUJhNa6tjCA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-9rr5MKmLNhKldgafzI29xw-1; Thu, 08 Jun 2023 05:27:35 -0400
X-MC-Unique: 9rr5MKmLNhKldgafzI29xw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b337f2504so10579285a.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 08 Jun 2023 02:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216455; x=1688808455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkZdXAW7CSjCPUke2Sq5/5CWJURTImAgkFUg7fQ3MxM=;
        b=AguhpVQfYuAEhImnPl92Dvk1a9odKlqQLjKQRYwvTwOGsOteo8fROhV2b+Vby+lCIB
         fto+1//DBUQJ0MMSwY/kCEtA4rKVAzfJdL8uRwZwGTDHdESInZd4QzcYp81ARaMgxGYt
         kHmU4chkv68tQTlhd+BYyxpVR+xwHj6wjFMN87UbjXPIQ6G4hGltvfi950EE7oHu7O8z
         fFEnY4boo+Qw0SXsgpdfsXP/UZ1ggpcjWHqstW6kRnIpY5uHFEZY0KT6PgJN3dk76PtV
         pgCVFEOE54SKDWYcWqneYBqPgeJPBrbcAAniW7FJkZki8srnlBMGVqUySiIDuAzwwMYD
         /P1Q==
X-Gm-Message-State: AC+VfDwYc/eWJ04AtXVU3f4D6olWi4iXql9GLaMz0MhK54HjuSrUPJRH
	7bUNPlIerB1l6en8y98vhEUeNyeK7c83ZKlRrPXWm2EQw5iZK7OP9bmsqr5UAZNpruHHvQbFmUA
	QPJvrAboOU1G7ntBxD3oRZfo/bDnm
X-Received: by 2002:a37:788:0:b0:75b:23a1:69e7 with SMTP id
 130-20020a370788000000b0075b23a169e7mr4438065qkh.7.1686216455502;
        Thu, 08 Jun 2023 02:27:35 -0700 (PDT)
X-Google-Smtp-Source: 
 ACHHUZ6HZNF7dR1NukuezxGy3h0BzC3f9Uf1uhzscu16+FNiP7Er4IAcCI1rAEntrmRr8IKv9oYotg==
X-Received: by 2002:a37:788:0:b0:75b:23a1:69e7 with SMTP id
 130-20020a370788000000b0075b23a169e7mr4438053qkh.7.1686216455161;
        Thu, 08 Jun 2023 02:27:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-199.dyn.eolo.it.
 [146.241.247.199])
        by smtp.gmail.com with ESMTPSA id
 e17-20020a05620a12d100b0075cc95eb30asm216629qkl.8.2023.06.08.02.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:27:34 -0700 (PDT)
Message-ID: <6a36f208b961181df9a0c611a6f5ffc4c76911f6.camel@redhat.com>
Subject: Re: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed
 work
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Simon Wunderlich
 <sw@simonwunderlich.de>
Date: Thu, 08 Jun 2023 11:27:31 +0200
In-Reply-To: <20230607220126.26c6ee40@kernel.org>
References: <20230607155515.548120-1-sw@simonwunderlich.de>
	 <20230607155515.548120-2-sw@simonwunderlich.de>
	 <20230607220126.26c6ee40@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: T7XPQRAY6V3BKI7AKRSBGAWHY6EQZK5L
X-Message-ID-Hash: T7XPQRAY6V3BKI7AKRSBGAWHY6EQZK5L
X-Mailman-Approved-At: Thu, 08 Jun 2023 11:34:39 +0200
CC: davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, Vladislav Efanov <VEfanov@ispras.ru>,
 stable@kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T7XPQRAY6V3BKI7AKRSBGAWHY6EQZK5L/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, 2023-06-07 at 22:01 -0700, Jakub Kicinski wrote:
> On Wed,  7 Jun 2023 17:55:15 +0200 Simon Wunderlich wrote:
> > The reason for these issues is the lack of synchronization. Delayed
> > work (batadv_dat_purge) schedules new timer/work while the device
> > is being deleted. As the result new timer/delayed work is set after
> > cancel_delayed_work_sync() was called. So after the device is freed
> > the timer list contains pointer to already freed memory.
>=20
> I guess this is better than status quo but is the fix really complete?
> We're still not preventing the timer / work from getting scheduled
> and staying alive after the netdev has been freed, right?

I *think* this specific use case does not expose such problem, as the
delayed work is (AFAICS) scheduled only at device creation time and by
the work itself, it should never be re-scheduled after
cancel_delayed_work_sync()

Cheers,

Paolo

