Return-Path: <davem@davemloft.net>
Date: Sun, 22 Feb 2015 17:00:39 -0500 (EST)
Message-Id: <20150222.170039.2130317153271557910.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1424641676.20944.18.camel@perches.com>
References: <1424136699.8287.10.camel@perches.com>
 <20150220.151843.902196140727344622.davem@davemloft.net>
 <1424641676.20944.18.camel@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next] batman-adv: Fix use of
	seq_has_overflowed()
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
To: joe@perches.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch, antonio@meshcoding.com, linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Sun, 22 Feb 2015 13:47:56 -0800

> net-next commit 6d91147d183c ("batman-adv: Remove uses of return value
> of seq_printf") incorrectly changed the overflow occurred return from
> -1 to 1.  Change it back so that the test of batadv_write_buffer_text's
> return value in batadv_gw_client_seq_print_text works properly.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied, thanks Joe.
