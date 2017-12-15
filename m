Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1780732.fBLghQceHc@bentobox>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <CAF=yD-KwdPiq7n-ANipF-U56yS85fJbUG7-LPWVBOxGQGYW07g@mail.gmail.com>
 <2907097.8HHYkPN8Gn@bentobox> <1780732.fBLghQceHc@bentobox>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 15 Dec 2017 11:57:55 -0500
Message-ID: <CAF=yD-JTfT-iOBG6KMhXv=KggoZ4tEP1fiJMiHMA_d0-wYncLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Network Development <netdev@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>

On Fri, Dec 15, 2017 at 6:48 AM, Sven Eckelmann
<sven.eckelmann@openmesh.com> wrote:
> On Freitag, 15. Dezember 2017 11:32:05 CET Sven Eckelmann wrote:
>> On Mittwoch, 6. Dezember 2017 11:58:14 CET Willem de Bruijn wrote:
>> [...]
>> > >> > ---
>> > >> >  MAINTAINERS                                        | 2 +-
>> > >> >  include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---
>> > >>
>> > >> This and the previous patch changes uapi. That might break userspace
>> > >> applications that rely on it.
>> > >
>> > > I am not aware of any application because all (alfred, batctl and some gluon
>> > > integration) of them currently ship their own copy because distribution didn't
>> > > catch up. And this is also the reason why I want to do it now - not later.
>> >
>> > That assumes that you know all applications, including those not
>> > publicly available. It may be true in this instance, but it is not
>> > possible to be certain.
>>
>> I've just talked with Simon. Because you have a problem with these two
>> changes, he suggested that I should drop these two patches and merge packet.h
>> with the uapi batadv genl header batman_adv.h
>
> No, this is also bad because batman_adv.h is MIT license and packet.h is
> GPL-2. So what other name would you suggest for packet.h? batman_adv_packet.h?

Sure, that sounds great. Thanks.
