Return-Path: <davem@davemloft.net>
Date: Tue, 12 Mar 2013 11:37:02 -0400 (EDT)
Message-Id: <20130312.113702.2235058521802126828.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1363039948-27190-1-git-send-email-ordex@autistici.org>
References: <1363039948-27190-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-03-11
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
Date: Mon, 11 Mar 2013 23:12:27 +0100

> This is a single fix intended for net/linux-3.9 brought by Marek Lindner.
> It ensures that the incoming originator message parsing routine does not
> try to read beyond the packet boundary causing it to process random data.
> 
> This bug is in since a while..Please, consider sending this patch to stable.
> 
> 
> Please pull or let me know if there is any problem!

Pulled and queued up for -stable.
