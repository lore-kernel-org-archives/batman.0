Return-Path: <davem@davemloft.net>
Date: Thu, 30 May 2013 15:53:59 -0700 (PDT)
Message-Id: <20130530.155359.2022430388757359040.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1369815051-708-1-git-send-email-ordex@autistici.org>
References: <1369815051-708-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-05-29b
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
Date: Wed, 29 May 2013 10:10:30 +0200

> The only real behavioural change in this batch is the broadcast overhead
> reduction on non-wireless interfaces brought by Matthias Schiffer.
> 
> The rest is made up by code cleanups and refactoring.
> 
> Two highlights on the refactoring are the introduction of
> netdev_alloc_skb_ip_align() to avoid to deal with NET_IP_ALIGN manually and the
> introduction of the eth_hdr() wherever it was possible in order to improve
> readability.
> 
> Please pull or let me know of any problem.
 ...
> The following changes since commit 06ecf24bdf2b7afc6c8fd13de6dba2a96dd331b6:
> 
>   net: Fix build warnings after mac_header and transport_header became __u16. (2013-05-28 13:15:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

Pulled, thanks Antonio.
