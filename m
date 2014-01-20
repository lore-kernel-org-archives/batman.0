Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 20 Jan 2014 11:52:00 +0100
References: <d48019225b19f19f5ac724d3b1a247cdf921f92b.1390143639.git.mschiffer@universe-factory.net>
In-Reply-To: <d48019225b19f19f5ac724d3b1a247cdf921f92b.1390143639.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201401201152.00646.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batadv-vis: don't leak socket fd in
	get_if_mac()
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


> Leaking an fd every time get_if_mac() is called causes a batadv-vis server
> process to hit the open file limit in a matter of hours when it is as low
> as 1024 (which it is on OpenWRT).
> 
> Reported-by: Jan-Philipp Litza <janphilipp@litza.de>
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Applied in e99382e. If you use something like "alfred" in the header next time 
it will make it more unlikely for me to miss your patch. :)

Thanks!
    Simon
