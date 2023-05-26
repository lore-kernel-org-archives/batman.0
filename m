Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E82C77B7A
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 21:09:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67D2D81F77
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 23:09:28 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1685135367;
 b=2cI+H4FLaVeyEzJztFwhTU7JENSU4n8WSpo2YvTNc7k85h9s/a9IaCWUH+ZG8m+2E1ydD
 f6FnhpeorQaTqvvvyLEf6ACYV8bkBztNeoOTKahNEn3KRUguDLIPXKWwATYB6hQbr1/gcOr
 06YGEBAxAb3DlyV8nXP0fwPI1w50SzE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1685135367; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jMDfLHwNhOLr7zb9IrExLR5KZ1L21sq7ibbGnshh5L0=;
 b=ebQEpM4XTEAx/4C0/LnTw/qSkImWaM1729NaqkGPdqGLf3h78ZrRnMPzOSWbGe/8bMATZ
 NYAAFHGeqYNTpPdTPexwutyiYDhnKVIRPm3rOF+hSUTgOftVC1vMg6etDbfwFL+2uVU/6aj
 5e4X1PDpUKh52B/4J7TP8AFci30kj40=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail header.d=ispras.ru;
  arc=fail;
  dmarc=fail (Used From Domain Record) header.from=ispras.ru policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail header.d=ispras.ru; arc=fail; dmarc=fail (Used From Domain Record) header.from=ispras.ru policy.dmarc=none
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EE3F2807E3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 26 May 2023 19:35:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1685122526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dYeLF47soPl7A+3mco/KP4CbNt6s64UADpsf1OpQymM=;
	b=SlerHauFGGzJ5fM6hSlIgmwhXSbHEWCYICeIVKpAdrvU+DIHCcxjQ0HfEFQTQz4JtMBx72
	aTLWGunj+Bx9yH4staGdYDlvoaktw+Yy/H9vjVPMchQdW8k05BkVu+KjSaBt+P2ppkW8da
	jCg9Ihnf+LubsKA+haLIsN69V8RLRIU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1685122526; a=rsa-sha256;
	cv=none;
	b=mDP6+N39cNAEF6QEl0KElDQb6yKKl8t2ZaG2ag2JvVMqSoB/PKKF4Ph8eZmI0jlMLPI29f
	MO48oX0np3xBj8INQnXmlT5L6s3Oi0tkr5bfipjTpAfNFs6cI7vUEi84rb+FXlX2kz1dGH
	US9tOJET9F1t2fXbsjLRp9i8aYgaHQs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=ispras.ru header.s=default header.b=pVeC0NSq;
	spf=pass (diktynna.open-mesh.org: domain of vefanov@ispras.ru designates 83.149.199.84 as permitted sender) smtp.mailfrom=vefanov@ispras.ru;
	dmarc=pass (policy=none) header.from=ispras.ru
Received: from [10.10.2.69] (unknown [10.10.2.69])
	by mail.ispras.ru (Postfix) with ESMTPSA id 25D1144C1026;
	Fri, 26 May 2023 17:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 25D1144C1026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1685122525;
	bh=dYeLF47soPl7A+3mco/KP4CbNt6s64UADpsf1OpQymM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pVeC0NSqyg0BQdlFdDE7MRCx9srs21kp9uSABHpC+mn3dAYyafLGtt/eD76tf+2Cc
	 GkzTa70/deJoETlL7/UJCZXxzSQB+7co8if99rWDXJD4aCK3oJu7c5W7LBs0HHDBQx
	 g5rpo9OEg2lALO1J/ndZkhVMg1Mpxn+mNxWXoOpY=
Message-ID: <09834e8d-ca48-e21d-fd96-9de87294a7f4@ispras.ru>
Date: Fri, 26 May 2023 20:35:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] batman-adv: Broken sync while rescheduling delayed work
Content-Language: ru
To: Sven Eckelmann <sven@narfation.org>,
 Marek Lindner <mareklindner@neomailbox.ch>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
 <5834562.MhkbZ0Pkbq@bentobox>
From: Vlad Efanov <vefanov@ispras.ru>
In-Reply-To: <5834562.MhkbZ0Pkbq@bentobox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MailFrom: vefanov@ispras.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: 2BRCB6HOJ5LWRQV4PKVR54UFH5CUW5ZC
X-Message-ID-Hash: 2BRCB6HOJ5LWRQV4PKVR54UFH5CUW5ZC
X-Mailman-Approved-At: Fri, 26 May 2023 23:09:26 +0200
CC: Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.3
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2BRCB6HOJ5LWRQV4PKVR54UFH5CUW5ZC/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Sven,


cancel_delayed_work_sync() and queue_delayed_work()

use WORK_STRUCT_PENDING_BIT in work->data to synchronize.

INIT_DELAYED_WORK() clears this bit.


The situation is :=C2=A0 __cancel_work_timer() sets WORK_STRUCT_PENDING_B=
IT

but INIT_DELAYED_WORK() in batadv_dat_start_timer() clears it

and queue_delayed_work() schedules new work.


Best regards,

Vlad.

On 26.05.2023 19:49, Sven Eckelmann wrote:
> On Friday, 26 May 2023 18:16:32 CEST Vladislav Efanov wrote:
>> The reason for these issues is the lack of synchronization. Delayed
>> work (batadv_dat_purge) schedules new timer/work while the device
>> is being deleted. As the result new timer/delayed work is set after
>> cancel_delayed_work_sync() was called. So after the device is freed
>> the timer list contains pointer to already freed memory.
> You are most likely right but could you please point out what in the wo=
rker is
> checked by the workqueue code that prevents it from being scheduled aga=
in?
> (and which seems to be overwritten as your patch seems to suggest)
>
> I think __cancel_work_timer marked the work as canceling but
> batadv_dat_start_timer reinitialized the worked (thus removing this imp=
ortant
> state). Would be nice if you could either correct me or confirm what I =
think to
> remember.
>
> Kind regards,
> 	Sven
