Return-Path: <davem@davemloft.net>
Date: Tue, 20 Aug 2013 16:55:12 -0700 (PDT)
Message-Id: <20130820.165512.254703237118139261.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1376735694-676-1-git-send-email-ordex@autistici.org>
References: <1376735694-676-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: 2013-08-17
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
Date: Sat, 17 Aug 2013 12:34:53 +0200

> here you have another very small fix intended for net/linux-3.11.
> Tha patch properly closes a seq_read session by adding an invocation to
> skb_abort_seq_read().
> 
> Please pull or let me know if there is any problem.

Pulled thanks.

> Also, when do you plan to merge net into net-next? I have a couple of changes
> for net-next which is better to apply after the merge.

I did one the other day.  I'll probably do one the next time I merge
changes to Linus, say Thursday some time.
