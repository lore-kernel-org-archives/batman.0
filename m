Message-ID: <45D47518.3030708@gmx.net>
Date: Thu, 15 Feb 2007 15:58:32 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] First batman tests
References: <560c7c9a0702140437l21bad4f4v7d12854ee932a7c0@mail.gmail.com>
In-Reply-To: <560c7c9a0702140437l21bad4f4v7d12854ee932a7c0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi -

please use the most recent version in the download section for your 
tests. There are known bugs in 0.1.

Happy routing!

cu elektra
> Hi,
>
> We met with several people in Brussels active on the reseaucitoyen
> project to test Batman.
>
> Our configuration was 4 laptops like this:
>
> laptop1 <----ethernet----> laptop2
> +                                               +
> +                                               +
> +                                               +
> wlan1                                    wlan11
> +                                               +
> +                                               +
> +                                               +
> laptop3 <----ethernet----> laptop4
>
> With 8 different IPs for the 8 interfaces.
>
> We launched batman-0.10 on all the nodes, but it appeared that one of
> the interfaces was not reachable via ping. And the experience was
> reproductible when we restarted the dameon, sometimes with a different
> IP unreachable.
>
> We are going to test the same configuration soon to see if batman
> chooses the fastest route in terms of throughput.
>
> Best,
>
> -- 
> Benjamin Henrion <bhenrion at ffii.org>
> FFII Brussels - +32-484-566109 - +32-2-4148403
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

