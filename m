Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5212497.opIP8sI45N@bentobox>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <20171205143514.4441-3-sven.eckelmann@openmesh.com>
 <CAF=yD-JxdNu6eFha_V2650-UqZ3KNSzD4Oe2RLHEWd4cz1G6kA@mail.gmail.com>
 <5212497.opIP8sI45N@bentobox>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Dec 2017 11:58:14 -0500
Message-ID: <CAF=yD-KwdPiq7n-ANipF-U56yS85fJbUG7-LPWVBOxGQGYW07g@mail.gmail.com>
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Network Development <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>

On Wed, Dec 6, 2017 at 11:55 AM, Sven Eckelmann
<sven.eckelmann@openmesh.com> wrote:
> On Mittwoch, 6. Dezember 2017 11:42:33 CET Willem de Bruijn wrote:
>> On Tue, Dec 5, 2017 at 9:35 AM, Sven Eckelmann
>> <sven.eckelmann@openmesh.com> wrote:
>> > This file contains the relevant information to let userspace communicate
>> > with batman-adv over generic netlink. The relevant genl enums for the
>> > attributes and commands have the prefix batadv_genl. Renaming this file to
>> > this name therefore represents the content better and avoids confusion
> with
>> > the file which will contain the packet format definitions.
>> >
>> > Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
>> > ---
>> >  MAINTAINERS                                        | 2 +-
>> >  include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---
>>
>> This and the previous patch changes uapi. That might break userspace
>> applications that rely on it.
>
> I am not aware of any application because all (alfred, batctl and some gluon
> integration) of them currently ship their own copy because distribution didn't
> catch up. And this is also the reason why I want to do it now - not later.

That assumes that you know all applications, including those not
publicly available. It may be true in this instance, but it is not
possible to be certain.
