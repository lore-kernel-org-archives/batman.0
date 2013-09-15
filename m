Return-Path: <martin@hundeboll.net>
Message-ID: <52361D3C.9080100@hundeboll.net>
Date: Sun, 15 Sep 2013 22:49:00 +0200
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <CAHQ_bghKkrNisgdgTQk2+MScz0BwAF2ESBKLjn90AHACdMKJ2g@mail.gmail.com>
In-Reply-To: <CAHQ_bghKkrNisgdgTQk2+MScz0BwAF2ESBKLjn90AHACdMKJ2g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Network Coding testing.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi Ajeet,

On 2013-09-12 15:36, ajeet singh wrote:
> I am trying to test network coding functionality of batman-adv. I am
> facing some problems.
>
> Please find my topology information,
>
> I created network with three nodes ( ad-hoc),
>
> Node A --- Node B --- Node C
>
> I did following settings,
>
> --- Complied latest batman-adv. with NC enabled.
> --- I did all setting form
> http://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding
> --- Kept all nodes in promiscuous mode. (Nodes are working properly in
> this mode).
>
> When I started iperf (TCP) from node A to node C, Node B stopped
> responding after few seconds. B is not sending OGM to A and C.
>
> When I tested without NC everything work fine.
>
> Is there any additional settings required for NC test?

As we figured out on IRC, the problems were caused by the ath9k_htc=20
chip/driver, which does not handle packet sizes larger than 1500 bytes=20
that well. So changing the MTU of your bat0 interface to something like=20
1480 solved the problem.

It is a bit weird though, cause my personal experience says that=20
ath9k_htc can handle packets up to 1550 bytes, which batman-adv+NC=20
shouldn't exceed. Maybe a quick inspection with tcpdump/wireshark can=20
give us some numbers?

// Martin

--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
