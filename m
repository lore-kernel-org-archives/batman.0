Return-Path: <davem@davemloft.net>
Date: Thu, 29 Aug 2013 01:45:34 -0400 (EDT)
Message-Id: <20130829.014534.666385498886400918.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1377689291-2412-1-git-send-email-ordex@autistici.org>
References: <1377689291-2412-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-08-28
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
Date: Wed, 28 Aug 2013 13:28:07 +0200

> here is a small pull request intended for net-next/linux-3.12.
> 
> In this batch you have two really minor things (code rearranging and version
> increment) and two behavioural changes:
> 1) the 'protocol' field of outgoing SKBs is now set according to the type of
>    the payload that batman-adv is going to encapsulate;
> 2) a uevent is now sent when a node exits the "GW client" mode. This is done in
>    order to tell userspace that a remote "GW server" is not available anymore.
> 
> Please pull or let me know of any problem!

Pulled, thanks Antonio.
