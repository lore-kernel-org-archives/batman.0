Return-Path: <davem@davemloft.net>
Date: Wed, 21 Nov 2012 12:57:59 -0500 (EST)
Message-Id: <20121121.125759.322762083309845086.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1353499919-28596-10-git-send-email-ordex@autistici.org>
References: <1353499919-28596-1-git-send-email-ordex@autistici.org>
 <1353499919-28596-10-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Use packing of 2 for all
 headers before an ethernet header
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 21 Nov 2012 13:11:59 +0100

> +#pragma pack(2)
 ...
> -} __packed;

The __packed attribute is an abstraction of the actual syntax
the compiler uses, if it is supported at all.

Therefore, you can't just unconditionally use the #pragma, and
you would need to use some kind of similar compiler abstraction
for it.

But to be honest this is really ugly and for very little, if any,
gain.
