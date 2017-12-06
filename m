Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7082766.sOGqpe4oL6@bentobox>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <1932095.qaFFlVjcYD@bentobox>
 <CAF=yD-LR5WSQt5jwN-+T-1iWyrxovk0qZ1cb-QUO6_+Wy8Ci-A@mail.gmail.com>
 <7082766.sOGqpe4oL6@bentobox>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Dec 2017 13:24:04 -0500
Message-ID: <CAF=yD-LK+wXLbnc56G5yzcAnwVGy09oqBz7UuEYV_h_HoSAgQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 6/6] flow_dissector: Parse batman-adv
 unicast headers
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
Cc: Tom Herbert <tom@herbertland.com>, Linux Kernel Network Developers <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org

> On Mittwoch, 6. Dezember 2017 11:54:13 CET Willem de Bruijn wrote:
>> Perhaps it can even be behind a static key depending on whether any
>> devices are active, adjusted in batadv_hardif_(en|dis)able_interface.
>
> I don't like that because we don't need batman-adv loaded to simply forward
> (bridge) traffic between interfaces. And not being able to use RPS with
> multiple cores just because the batman-adv module (and interfaces) is not
> enabled seems to be counter-intuitive.

Okay. Ack on Tom's points, too.

I want to be able to administratively limit the footprint of flow dissector,
but agreed that this can be configured independent from the rest of the
datapath, i.e., with knobs specific to flow dissector.

>> Please implement FLOW_DISSECTOR_F_STOP_AT_ENCAP. It may
>> be used in more flow dissector paths in the future.
>>
>> The features are also used by GRE, which can encap Ethernet, for an example
>> that is closer to this protocol.
>
> Thanks for the feedback. I have it now implemented like in GRE.
>
> The change can already be found in
>  https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/ecsv/flowdissector

Great, thanks.
