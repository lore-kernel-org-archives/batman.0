Return-Path: <davem@davemloft.net>
Date: Fri, 23 May 2014 23:36:37 -0400 (EDT)
Message-Id: <20140523.233637.1826798421419100755.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1400662742-31999-3-git-send-email-linus.luessing@web.de>
References: <1400662742-31999-1-git-send-email-linus.luessing@web.de>
 <1400662742-31999-3-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next 2/4] bridge: adhere to querier
 election mechanism specified by RFCs
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
To: linus.luessing@web.de
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Wed, 21 May 2014 10:59:00 +0200

> +	if (saddr <=3D br->ip4_querier.addr.u.ip4)
> +		goto update;

It is clear to me that you should be making these comparisons in cpu
endianness.

Otherwise the code will handle the same situations differently
on big-endian vs. little-endian machines.

