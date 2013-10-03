Return-Path: <davem@davemloft.net>
Date: Thu, 03 Oct 2013 15:58:02 -0400 (EDT)
Message-Id: <20131003.155802.929707046474176566.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1380744201-2074-1-git-send-email-antonio@meshcoding.com>
References: <1380744201-2074-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: 2013-10-02
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
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  2 Oct 2013 22:03:20 +0200

> this is a "one-change" pull request intended for net/linux-3.{12,11,10}.
> 
> This patch from Matthias Schiffer is fixing the init routine of the Network
> Coding component by preventing it from registering the handler for the CODED
> packet type each time a new soft-interface is created.
> 
> Without this fix a second soft-interface cannot be created unless the Network
> Coding component is not part of the module (not compiled-in).
> 
> As I mentioned before, this fix should be queued for stable as it aims
> kernels older than linux-3.12.
> 
> Please pull or let me know of any problem.

Pulled, thanks Antonio.
