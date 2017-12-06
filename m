Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1932095.qaFFlVjcYD@bentobox>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <20171205143514.4441-7-sven.eckelmann@openmesh.com>
 <CALx6S34QfkvbGqrSahQ17upSPDjNaHnf4wsxk90gXgR2dW_D8A@mail.gmail.com>
 <1932095.qaFFlVjcYD@bentobox>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Dec 2017 11:54:13 -0500
Message-ID: <CAF=yD-LR5WSQt5jwN-+T-1iWyrxovk0qZ1cb-QUO6_+Wy8Ci-A@mail.gmail.com>
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

On Wed, Dec 6, 2017 at 5:26 AM, Sven Eckelmann
<sven.eckelmann@openmesh.com> wrote:
> On Dienstag, 5. Dezember 2017 09:19:45 CET Tom Herbert wrote:
> [...]
>> Switch statements with cases having many LOC is hard to read and
>> __skb_flow_dissect is aleady quite convoluted to begin with.
>>
>> I suggest putting this in a static function similar to how MPLS and
>> GRE are handled.

Perhaps it can even be behind a static key depending on whether any
devices are active, adjusted in batadv_hardif_(en|dis)able_interface.

> Thanks for the feedback.
>
> I was not sure whether "inline" or an extra function would be preferred. I've
> then decided to implement it like most of the other protocols. But since an
> extra function is the preferred method for handling new protos, I will move it
> to an extra function.
>
> The change can already be found in
>  https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/ecsv/flowdissector
>
> I also saw that you've introduced in
> commit 823b96939578 ("flow_dissector: Add control/reporting of encapsulation")
> a flag to stop dissecting when something encapsulated was detected. It is not
> 100% clear to me when the  FLOW_DIS_ENCAPSULATION should be set and
> FLOW_DISSECTOR_F_STOP_AT_ENCAP be checked. Only when there is IP/eth in IP
> (like in the two examples from the commit message) or also when there is a
> ethernet header, followed by batman-adv unicast header and again followed by
> an ethernet header?

Please implement FLOW_DISSECTOR_F_STOP_AT_ENCAP. It may
be used in more flow dissector paths in the future.

The features are also used by GRE, which can encap Ethernet, for an example
that is closer to this protocol.
