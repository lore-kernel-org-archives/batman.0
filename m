Return-Path: <ruben@vfn-nrw.de>
From: Ruben Wisniewski <ruben@vfn-nrw.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Tue, 19 Jul 2016 09:06:38 +0200
Message-Id: <754884F3-4762-43EA-81D7-D1904035D163@vfn-nrw.de>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1655869.LYQpVbDg6l@prime> <20160719062907.GA10173@otheros>
 <2594732.GzDknJdsZu@sven-edge>
In-Reply-To: <2594732.GzDknJdsZu@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
	snooping received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

What exactly is the target of it? Just refresh the timer for arp entries? Wh=
y don't just ask the kernel arp table if it knows something bout the mac-add=
ress?

Every change should be pushed through the network by ne node which detected a=
 new client, don't it?

Best regards=20

Ruben

> Am 19.07.2016 um 08:59 schrieb Sven Eckelmann <sven@narfation.org>:
>=20
>> On Dienstag, 19. Juli 2016 08:29:07 CEST Linus L=C3=BCssing wrote:
>> What do you think about doing the same in batman-adv? That is,
>> only updating, but not creating DAT cache entries from IP traffic.
>> That should get rid of the main two concerns, accidentally
>> snooping routed IP traffic and performance implications, shouldn't it?
>=20
> You have to snoop the traffic anyway and search in the dat cache for each(=
?)=20
> packet. And the DAT cache is distributed. So why would it avoid the=20
> performance implications?
>=20
> Kind regards,
>    Sven

