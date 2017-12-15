Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
References: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 15 Dec 2017 17:51:19 -0500
Message-ID: <CAF=yD-LSwR3ggm5Ss4sLNx08bG8ks5TT+SvryDK5ReKtv1-dBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 0/4] flow_dissector: Provide basic
 batman-adv unicast handling
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
Cc: Network Development <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Tom Herbert <tom@herbertland.com>

On Fri, Dec 15, 2017 at 1:23 PM, Sven Eckelmann
<sven.eckelmann@openmesh.com> wrote:
> Hi,
>
> we are currently starting to use batman-adv as mesh protocol on multicore
> embedded devices. These usually don't have a lot of CPU power per core but
> are reasonable fast when using multiple cores.
>
> It was noticed that sending was working very well but receiving was
> basically only using on CPU core per neighbor. The reason for that is
> format of the (normal) incoming packet:
>
>   +--------------------+
>   | ip(v6)hdr          |
>   +--------------------+
>   | inner ethhdr       |
>   +--------------------+
>   | batadv unicast hdr |
>   +--------------------+
>   | outer ethhdr       |
>   +--------------------+
>
> The flow dissector will therefore stop after parsing the outer ethernet
> header and will not parse the actual ipv(4|6)/... header of the packet. Our
> assumption was now that it would help us to add minimal support to the flow
> dissector to jump over the batman-adv unicast and inner ethernet header
> (like in gre ETH_P_TEB). The patch was implemented in a slightly hacky
> way [1] and the results looked quite promising.
>
> I didn't get any feedback how the files should actually be named and I am
> not really happy with the current names - so please feel free to propose
> better names.
>
> The discussion of the RFC v2 can be found in the related patches of
> https://patchwork.ozlabs.org/cover/844783/
>
>
> Changes in v3:
> ==============
>
> * removed change of uapi/linux/batman_adv.h to uapi/linux/batadv_genl.h
>   - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> * removed naming fixes for enums/defines in uapi/linux/batadv_genl.h
>   - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> * renamed uapi/linux/batadv.h to uapi/linux/batadv_packet.h
> * moved batadv dissector functionality in own function
>   - requested by Tom Herbert <tom@herbertland.com>
> * added support for flags FLOW_DISSECTOR_F_STOP_AT_ENCAP and
>   FLOW_DIS_ENCAPSULATION
>   - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Thanks for making these changes. The flow dissection looks good to me.

One possible issue is that this exposes kernel fixed width types u8/u16/..
to userspace. For posix compatibility reasons, uapi headers use the
variant with underscores.
