Return-Path: <davem@davemloft.net>
Date: Mon, 13 Apr 2015 13:32:28 -0400 (EDT)
Message-Id: <20150413.133228.1185934929215664377.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1428687999-18428-2-git-send-email-linus.luessing@c0d3.blue>
References: <1428687999-18428-1-git-send-email-linus.luessing@c0d3.blue>
 <1428687999-18428-2-git-send-email-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] net: Export IGMP/MLD message
	validation code
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
To: linus.luessing@c0d3.blue
Cc: bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, therbert@google.com

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Fri, 10 Apr 2015 19:46:39 +0200

> With this patch, the IGMP and MLD message validation functions are mo=
ved
> from the bridge code to IPv4/IPv6 multicast files. Some small
> refactoring was done to enhance readibility and to iron out some
> differences in behaviour between the IGMP and MLD parsing code (e.g. =
the
> skb-cloning of MLD messages is now only done if necessary, just like =
the
> IGMP part always did).
> =

> Finally, these IGMP and MLD message validation functions are exported=
 so
> that not only the bridge can use it but batman-adv later, too.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Please update the copyrights as per your discussion with YOSHIFUJI
Hideaki.

Also, please provide a cover "[PATCH 0/2] " posting with a top-level
summary of what this series is doing so I can use that text in the
message of the merge commit I'll create when applying your series.

Thanks.
