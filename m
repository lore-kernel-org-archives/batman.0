Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 17 Jan 2017 20:30:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170117193013.GA3813@otheros>
References: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
Subject: Re: [B.A.T.M.A.N.] [PATCH] IPv4 multicast distribution support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

On Mon, Jan 16, 2017 at 12:49:34PM -0700, Jonathan Haws wrote:
> Enabled via -4 expert option where multicast group address is specified.
> This option will disable IPv6 communication and is intended for use in networks
> which do not support IPv6 addressing.
> 
> When this option is enabled, all IPv6 communication is disabled. Combining
> IPv4 and IPv6 alfred nodes is unsupported.
> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> ---
>  README         |   4 +-
>  alfred.h       |  21 +++++---
>  batadv_query.c |  53 ++++++++++++-------
>  batadv_query.h |   5 +-
>  client.c       |   2 +-
>  main.c         |  10 +++-
>  man/alfred.8   |   5 ++
>  netsock.c      | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  recv.c         |  67 +++++++++++++++++-------
>  send.c         |  51 ++++++++++++------
>  server.c       |   8 +--
>  unix_sock.c    |   2 +-
>  12 files changed, 308 insertions(+), 80 deletions(-)
> 
> diff --git a/README b/README
> index bc1c3bc..28f3dc9 100644
> --- a/README
> +++ b/README
> @@ -20,7 +20,9 @@ programs to communicate with alfred (done via unix sockets). alfred then takes
>  care of distributing the local information to other alfred servers on other
>  nodes. This is done via IPv6 link-local multicast, and does not require any
>  configuration. A user can request data from alfred, and will receive the
> -information available from all alfred servers in the network.
> +information available from all alfred servers in the network. Alternatively,
> +alfred can be configured to distribute the local information via IPv4 multicast.
> +This is configured by setting the IPv4 multicast group address in the -4 option.
>  
>  Compilation
>  -----------
> diff --git a/alfred.h b/alfred.h
> index 2e8db1e..5237594 100644
> --- a/alfred.h
> +++ b/alfred.h
> @@ -48,6 +48,12 @@ enum data_source {
>  	SOURCE_SYNCED = 2,
>  };
>  
> +typedef union
> +{
> +  struct in_addr ipv4;
> +  struct in6_addr ipv6;
> +} alfred_addr;
> +

Just out of curiousity (and I suspect the answer is probably "no").
For multicast there is no API to write protocol agnostic socket
code, right?

(like these agnostic sockaddr_storage / getaddrinfo() / inet_pton()
thingies which you would use for unicast)
