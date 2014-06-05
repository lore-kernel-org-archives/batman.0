Return-Path: <davem@davemloft.net>
Date: Thu, 05 Jun 2014 00:43:11 -0700 (PDT)
Message-Id: <20140605.004311.19890338095820543.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140602184215.GA2460@Linus-Debian>
References: <1401732466-3027-1-git-send-email-linus.luessing@web.de>
 <20140602184215.GA2460@Linus-Debian>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 net-next 0/4] bridge: multicast
 snooping patches / exports
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, herbert@gondor.apana.org.au, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Mon, 2 Jun 2014 20:42:15 +0200

> Changes in v3:
> =

> * use EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL()

This is not a sufficient header posting.

You must also describe at a high level what this patch series is
doing, and why you are doing it.
