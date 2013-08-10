Return-Path: <davem@davemloft.net>
Date: Sat, 10 Aug 2013 15:39:22 -0700 (PDT)
Message-Id: <20130810.153922.1351681744983531065.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1376168881-4079-1-git-send-email-ordex@autistici.org>
References: <1376168881-4079-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request for net: batman-adv 2013-08-10
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 10 Aug 2013 23:08:00 +0200

> here you have one fix intended for net/linux-3.11.
> 
> To avoid kernel paging errors, this patch takes care of re-assigning the value
> of skb->data to the related pointers after that the skb has been re-allocated.
> 
> Please pull or let me know of any problem!

Pulled, thanks.
