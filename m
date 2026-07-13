Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09959C43458
	for <batman@archiver.kernel.org>; Mon, 13 Jul 2026 14:30:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 61EB88269B
	for <batman@archiver.kernel.org>; Mon, 13 Jul 2026 16:30:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783953035;
 b=0F0jAEDi35B0kM1tcfqQ60rSRquR+5Pz4RzP0SlzQlaYX9T3uAn79UgbzluUDn0bsLpSW
 IjbWACfmN84Clc1Pd5/ZBQMepDv1DgsgJm6lQCEYdTRL19x4F9ieAkruBHFMArryM8LSUS7
 Q+7VMdY/00RQXdgRMLDNsPcG/RJI33w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783953035; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=;
 b=xM5xYmnGz/XnL46NSOsvt35vyBTbCnHujK+GkuIIQ3oKDGZx9sSf62Mh8DJBnXuSe0zbW
 wF2XNdwNhhMTRNQcD7QUmmyvvBjhXJn95E4gOS1gge2bQaTOf5am6gMxbPOrSlK7aSQ6d9I
 va6bY36Rbb1NovD8DHzcw7nuD9PPiiM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=arndb.de;
 arc=pass;
 dmarc=pass header.from=arndb.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=arndb.de; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=arndb.de policy.dmarc=none
Received: from flow-b8-smtp.messagingengine.com
 (flow-b8-smtp.messagingengine.com [202.12.124.143])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0907D80F85
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jul 2026 16:22:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783952567;
	b=Va1+tY3hPHiKcjlza3AVqc3evk+q5PW0tlcJbMwgqWNYI4TStaLIW24qcKLYahext/0saI
	LSRztKNf7ZdOJS17UxVTriSYAJrnNFMKuQfC7zSfONEdi5Teua/DK4ImBUYz/6LGqXVYoB
	LFq7cCzN8HMF9cB8nNV5EUD3bdjQKFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783952567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=;
	b=JumDLAYF5HZtjPg/Q1scPp4cmax7+dhkKkW27unluFerCuHOOZRx27DbY9Ajc1Fy2lZn2b
	sKOoTmYU9Hmo+dQHg6fIpUoa+V2xsSHOzLnelo4fFwX4g/l6H0gXoZXftvTBFk6eLzBxF7
	5nD6YGzE2qE5jmsXw9Z6Fwtmneyjej8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=Lh7lF+Y9;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="g YlB95D";
	dmarc=pass (policy=none) header.from=arndb.de;
	spf=pass (diktynna.open-mesh.org: domain of arnd@arndb.de designates
 202.12.124.143 as permitted sender) smtp.mailfrom=arnd@arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D2F14130008E;
	Mon, 13 Jul 2026 10:22:28 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 10:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783952548;
	 x=1783959748; bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=; b=
	Lh7lF+Y9bDgUjn6EOGYYC29ZSbRGGbWTEqBYICxtaVgzMoCUsRMW5j0AJFe9zZKf
	QYjcpqqPLjIxsGkMxlz6Wm48qLtiFtm3jSNPAa9VR1yldqnV8iYJZuV+ka5Zryiz
	mm+PJfh3+JM6oGIon0b8xg3rB89vMHUN73yDQv9UjEeZr/weAajlVU7Bi35h68oK
	2NJ/DA/BwI815lmGCdYT4uCm0hsiCepQIqWBrk+GcqJq9n3lwp2ndWsdhBIMemQS
	WBCyhW7n9x+WVZUMmVqwZJ/EMt2ehyGJlhXnUrEyHoCf4VgAlbLX6mWtU3301JgR
	ndHXFc7fnZXg0Q8zRjq8Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783952548; x=
	1783959748; bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=; b=g
	YlB95DRbFskSS7BaRoK6Dal5i9lQFRrZabf1oih/dW8jvbLgbhdX+9D83VQlKWvy
	zhHpIKUJMXZNFUz+8BMD0BqBrDIkGVx8YbiacjAFczSoS6M2bL+Q8Fnpu54qNrGe
	FEkT/W2VQQwIeTloeEqCL6NAA+JW+eAEFKtaKQkRRtpakH39fdCM/BqpHQSMgw1T
	LJsHerjuy3xoEcF0wm6a8qlJocVQ+LpTdy4CSm6vI+kVLlzWewL7d0gg3QyP9cur
	L/jMUQ44LxHvWtRpzZBLtTTVIj+gZVP5WTG9iULb/DEsgqCumG0JpDHmWMOEx8lV
	MzlD0OJeC/wVVkAaz4f0w==
X-ME-Sender: <xms:ovRUav7TlZN-a2_unM3mLC-HWPhnAclyD_NbFNPheekrnQs8buleXA>
    <xme:ovRUavtK-ABrXEMyRUZgLQ9sqK-1WYueT1PLnWIxW7DlLf6QXdAKL_S8i95xZsOfq
    E2wxHybxcyMrHz-zKjhKXarvGVoLhf4u1lIu1B4mdO6bIAZbO-6>
X-ME-Proxy-Cause: 
 dmFkZTGkfromSsp3G4rSLONAnUYo47mIdjtZXM5DmI/mzu4ZZV/RAeMAuRK8H7+e4o2JDs
    OiZX31EHOqiT2sLAdD+Osn17l+GzdDLgqcJZopQmE1PWsA1geojywiJqDhFZUZZIB4zabR
    O3JlgG3Ef4E+wyHvFQbhgfxW6D2NxaNwqYL3Xa6ecuMGHGC3f5oGdP1/NAMK9D5Sk4iKSr
    xrMiV29NXuU8QrlZ840MTbYz8uz6GfaCpnWxc3dP25hhym7Wh0bA64ROW490WcRrZkRrNk
    2QJW9zJmfuWPGuFscrooblh2nJcbSl2nf4MHCUcAMxGxCDXO4Fqzh0ddDq7R7XXni94jKd
    JcpVjdsDo7SkAGfOW1QDESPkp+aTIeHWia8lnTMGiZPuHxgei3y/8PiGHnDrvoZ9HvoWTr
    AVFVQr2SC3lZsoXwY3E7CssI9oOGiRsso0Dm6VkYHffeNMz6QoNzQYG5XivGnnitAfHeey
    lV+bSWCs2mphE5N09KycIixzLP6/P8W3g8E6+pkScoFIXNq0pp4mScFyVrni4ziIswLgRA
    t4AWYlEvD2SRXz1zJrHgqUpIcHNE6fTul3Pka+NkRru3x+44bFia6TOHLb+0COfcEnK6Wt
    j6HLZZJIorGMDVUXd2hWIMoPQWmSUoJmP73VOfwvUA85gLVYalKq3cL6ZEhA
X-ME-Proxy: <xmx:ovRUao5OTOdoCI1NbU5ncXXeImi1FeLyUTR4J04nC2mO9aJTVBg01A>
    <xmx:ovRUagdHQT83vSsgCnhq2L2fU4HwEtJEydDYpBEl6Rwv4C25KHcApA>
    <xmx:ovRUakq0mJL1SEZy_6gXRApBLmgd6AirY4GePNNrtyg5pqO7X6OJ_Q>
    <xmx:ovRUavMgbAoHHNwrxlki6UdqL5Zv93FnXa-n7kug2Hqw7WmXxf3IiA>
    <xmx:pPRUauxGo7S8G31bNaPEH8I8UNIbDAWogLs0r42oreenpO1SWE09kUUA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC870182007E; Mon, 13 Jul 2026 10:22:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ARmmoW1aQeCk
Date: Mon, 13 Jul 2026 16:22:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>,
 Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "David Ahern" <dsahern@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>,
 "Edward Cree" <ecree.xilinx@gmail.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Marek Lindner" <marek.lindner@mailbox.org>,
 "Simon Wunderlich" <sw@simonwunderlich.de>,
 "Antonio Quartulli" <antonio@mandelbit.com>,
 "Sven Eckelmann" <sven@narfation.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>,
 "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>,
 "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>,
 "Ilya Maximets" <i.maximets@ovn.org>,
 "Allison Henderson" <achender@kernel.org>,
 "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Wenjia Zhang" <wenjia@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 "Justin Chen" <justin.chen@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>, "Yao Zi" <me@ziyao.cc>,
 "Yanteng Si" <siyanteng@cqsoftware.com.cn>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Joey Lu" <a0987203069@gmail.com>,
 "Shangjuan Wei" <weishangjuan@eswincomputing.com>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Inochi Amaoto" <inochiama@gmail.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Dmitry Safonov" <0x7f454c46@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Message-Id: <713178ff-0fb2-4f1b-90bc-9841cd42c20e@app.fastmail.com>
In-Reply-To: <2256daf4-d03c-4a57-9d72-7a388d823f18@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-2-fmancera@suse.de>
 <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
 <2256daf4-d03c-4a57-9d72-7a388d823f18@suse.de>
Subject: Re: [PATCH 01/13 RFC net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple
 the IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: 3L3PWZE5CTEXLS7CDOMT7QUSEWXX5AOW
X-Message-ID-Hash: 3L3PWZE5CTEXLS7CDOMT7QUSEWXX5AOW
X-Mailman-Approved-At: Mon, 13 Jul 2026 16:30:27 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3L3PWZE5CTEXLS7CDOMT7QUSEWXX5AOW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Jul 13, 2026, at 16:00, Fernando Fernandez Mancera wrote:
> On 7/12/26 1:01 PM, Arnd Bergmann wrote:
>> On Sun, Jul 12, 2026, at 03:38, Fernando Fernandez Mancera wrote:
>>> Historically, the IPv4 protocol has been linked to the core INET
>>> subsystem. Because shared infrastructure like the TCP/UDP engine,
>>> routing or INET hashtables live inside net/ipv4/, it has been impossible
>>> to compile a kernel with only IPv6 support.
>>>
>>> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
>>> 'def_bool y' for now. This does not allow to completely disable the
>>> IPv4 stack yet but it lays the necessary build-system work for that
>>> goal.
>> 
>> I expect this will cause additional (trivial) build regression in the
>> next step when randconfig builds run into obscure corner cases, either
>> with INET=y IPV4=n IPV6=y or with INET=y IPV4=n IPV6=n.
>> 
>> I can probably give your patch (with IPV4 visible or disabled) an
>> early go on the randconfig tree to find these more quickly.
>> If I run into regressions, should I just add more 'depends on IPV4',
>> or do you have other plans?
>> 
>
> Yes, I have a job running randconfig and verifying nothing breaks. If 
> something breaks and it isn't core networking stack I would just make 
> the Kconfig symbol depend on IPv4.
>
> Then later we will have more time to write a dedicate patch so it does 
> not depend on IPv4.

Ok

>> Should we have some logic to ensure that at least one of IPV4 or
>> IPV6 is enabled? I think this would work
>> 
>> config IPV4
>>        bool "The IPv4 protocol" if IPV6
>>        default INET
>> 
>> which only allows turning IPV4 off if IPV6 has enabled.
>> 
>
> I do wonder, should we? I mean, I didn't try it off but I don't see why 
> we should not allow a pure L2 system..

I expected a pure L2 system to be CONFIG_ETHERNET=y CONFIG_INET=n.

Which user-visible parts of CONFIG_INET would you want keep working
when both v4 and v6 are disabled?

     Arnd
