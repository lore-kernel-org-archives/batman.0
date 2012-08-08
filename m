Return-Path: <davem@davemloft.net>
Date: Wed, 08 Aug 2012 16:04:28 -0700 (PDT)
Message-Id: <20120808.160428.2244694881256062176.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120807185036.GG3891@ritirata.org>
References: <alpine.LNX.2.00.1208072030500.3227@swampdragon.chaosbits.net>
 <20120807185036.GG3891@ritirata.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix mem leak in the
 batadv_tt_local_event() function
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, siwu@hrz.tu-chemnitz.de, jj@chaosbits.net, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 7 Aug 2012 20:50:36 +0200

> On Tue, Aug 07, 2012 at 08:32:34PM +0200, Jesper Juhl wrote:
>> Memory is allocated for 'tt_change_node' with kmalloc().
>> 'tt_change_node' may go out of scope really being used for anything
>> (except have a few members initialized) if we hit the 'del:' label.
>> This patch makes sure we free the memory in that case.
>> 
>> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied, thanks.
