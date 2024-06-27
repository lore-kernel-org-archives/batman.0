Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE9DC2BBCA
	for <batman@archiver.kernel.org>; Fri, 28 Jun 2024 04:12:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F143F830AB
	for <batman@archiver.kernel.org>; Fri, 28 Jun 2024 06:12:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1719547975;
 b=qscYku6yZctY9Z/1QFcB3CfgiCC0p+7203QNr/YeimX+kS/AWklPpZBhJ9Pu/jnYykpqq
 AlsEqQCn80BIsQ79VjS4zLgBhIB0pswGY2ktw/ufmE0ZWsDUuLsmC3Rj1JjFUenHPJikGYu
 Pn/QCdUXocpuWxLkTpJeXJEUow7Sed4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1719547975; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O55wARCAFXnWW0EcXr31CWT0cfuxa9+VMCp7DkWyngo=;
 b=ERCo4GAyRu3NGN+SuFRegB3zo03+dTpnsEVqqPcQPYdLPQHKCAC9lGighA/FagT8vn8GX
 c9pj6IU1UiCqzduhDt9co6VEYF9R/bXHB+3fl0rG8zhBk+puwiu6Dt+LBSfK4tDE6pDCbCX
 uFKKpIDrOYB8OB3XUEgSjEoS0vlgfwY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=knds.fr policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=knds.fr policy.dmarc=none
Received: from mx01-out.cloud.vadesecure.com (mx01-out.cloud.vadesecure.com
 [217.74.103.251])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4118482ECE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 27 Jun 2024 21:44:01 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1719517441; a=rsa-sha256;
	cv=none;
	b=T3XVocMWTA/h456429WSFcZ11Te2pWu+Tqe/sFB60IQUq8JDtetThsx3J5DL9EVOKIiXmF
	sq51A4IG5+Q5JA12FRg22nNdOwbRPlyvzZX4V9mJrh120TGpa8EqH5fnGK1j4BC1NVM2L4
	3WqalfOfvott10yt5OY9+A136R3qnvE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=knds.fr;
	spf=pass (diktynna.open-mesh.org: domain of Romain.BEAL@knds.fr designates
 217.74.103.251 as permitted sender) smtp.mailfrom=Romain.BEAL@knds.fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1719517441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O55wARCAFXnWW0EcXr31CWT0cfuxa9+VMCp7DkWyngo=;
	b=d3Z/Hx/nACkGw3wsK82LXlBFS7xxRGydDaXrApQXDHBUM7QjmgG1vzvxKsy5ABzSpIW+0y
	mdeQWyFAtoMf5Weq4ebGs6U3eeTp5ZgPCypiG9LG0Bm1bcDjld8UHOJsBw05gWsQxA/qdr
	wO5/e/6S8om3zm0NNxEyPt7+HqgO8xE=
Received: from mail2.knds.fr (unknown [10.250.73.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mx01-out.cloud.vadesecure.com (vcfr1mtao01p) with ESMTPS id
 4W98C44tyKz1nmh
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 27 Jun 2024 21:44:00 +0200 (CEST)
From: BEAL Romain <Romain.BEAL@knds.fr>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: configuration for mobile nodes
Thread-Topic: configuration for mobile nodes
Thread-Index: AQHayMo1APsfWA0QMEqu7kbr35ao4Q==
Date: Thu, 27 Jun 2024 19:43:59 +0000
Message-ID: <0ae0e36496504245bb8ad0fab5c054a4@knds.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.68.166]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 10.9.68.117
X-FE-Policy-ID: 2:0:0:SYSTEM
X-VRC-SPAM-STATUS: 
 0,0,gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggddugeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhitgfgggesthhqjhdttddtudenucfhrhhomhepuefgtefnucftohhmrghinhcuoeftohhmrghinhdruefgtefnsehknhgushdrfhhrqeenucggtffrrghtthgvrhhnpeeuudettdfhffehteefheevieffffegudfhjeegheeuuedvveduueehudekjeeukeenucfkphepuddtrddvhedtrdejfedrvdeipddutddrledrieekrdduieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpmhgrgihmshhgshhiiigvpedutdegkeehjeeipdhinhgvthepuddtrddvhedtrdejfedrvdeipdhhvghlohepmhgrihhlvddrkhhnughsrdhfrhdpmhgrihhlfhhrohhmpeftohhmrghinhdruefgtefnsehknhgushdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsgdrrgdrthdrmhdrrgdrnheslhhishhtshdrohhpvghnqdhmvghshhdrohhrgh
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0
X-MailFrom: Romain.BEAL@knds.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: MRRFOY2PC5ZVUKBHTKVDUWSR374SRB5W
X-Message-ID-Hash: MRRFOY2PC5ZVUKBHTKVDUWSR374SRB5W
X-Mailman-Approved-At: Fri, 28 Jun 2024 06:12:43 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MRRFOY2PC5ZVUKBHTKVDUWSR374SRB5W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

I want to use batman-adv for highly mobile nodes.
All of my nodes are robot or radio module embedded on a human, for exampl=
e.

Losing a node is very common and batman-adv needs to self-reconfigure qui=
ckly in my case.
Adding a node is very common too, maybe for only few seconds or minutes.

The default configuration doesn't work very well for my use case.
But when I use this configuration :

#define BATADV_PURGE_TIMEOUT 2000
#define BATADV_TT_LOCAL_TIMEOUT 6000
#define BATADV_TT_CLIENT_ROAM_TIMEOUT 6000
#define BATADV_TT_CLIENT_TEMP_TIMEOUT 6000
#define BATADV_ORIG_WORK_PERIOD 500
#define BATADV_DAT_ENTRY_TIMEOUT (5*600)

The result is better. I have some unstable connection for only 5 seconds =
when I loss a node.
Have you done any testing for this type of use ?

Thanks for help


Ce message =E9lectronique et tous les fichiers qui lui sont attach=E9s so=
nt confidentiels et destin=E9s exclusivement =E0 l'usage de la personne =E0=
 laquelle ils sont adress=E9s. Si vous avez re=E7u ce message par erreur,=
 merci d'en avertir imm=E9diatement son =E9metteur et de supprimer ce mes=
sage de votre syst=E8me sans en conserver de copie. La copie, la rediffus=
ion =E0 tout tiers et l'utilisation du contenu de ce message ou des fichi=
ers attach=E9s est strictement interdite sans l'accord pr=E9alable =E9cri=
t de l'=E9metteur. 
 
Ce document est susceptible de contenir de l'information soumise =E0 cont=
r=F4le (ML22) relevant de la r=E9glementation europ=E9enne quant aux expo=
rtations des mat=E9riels de guerre et mat=E9riels assimil=E9s. Toute expo=
rtation ou r=E9exportation est soumise =E0 autorisation =E9crite du gouve=
rnement fran=E7ais. 
-------------------------------------------------------------------------=
------- 
This email and any attachments are confidential and intended solely for t=
he use of the individual to whom they are addressed. If you have received=
 this e-mail in error, please inform the sender immediately without keepi=
ng any copy thereof and delete it from your system. Copy, use or distribu=
tion of contents of this message or attachments to any other person is st=
rictly prohibited without sender's prior written permission. 
 
This document may contains controlled data submitted to EU military lists=
 regulations. Any export or reexport is submitted to written authorizatio=
n of French Government. 


