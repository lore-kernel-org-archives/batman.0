Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 23 Sep 2012 17:34:36 +0800
References: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
 <20120920114250.GA29329@ritirata.org>
 <CANMkaoyhATZnFpRTDQXPFUOyPXnVOzTHgr5O1+UwZgmYZ9tvYA@mail.gmail.com>
In-Reply-To: <CANMkaoyhATZnFpRTDQXPFUOyPXnVOzTHgr5O1+UwZgmYZ9tvYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201209231734.36896.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix change mac address of
	soft iface.
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
To: Def <def@laposte.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, September 20, 2012 20:56:13 Def wrote:
> Into function interface_set_mac_addr, the function tt_local_add was
> invoked before updating dev->dev_addr. The new MAC address was not
> tagged as NoPurge.
> 
> Signed-off-by: Def <def@laposte.net>
> ---
>  soft-interface.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

As Sven already mentioned there is a small problem with your patch. I manually 
fixed it and applied the patch in revision 86fa71a. Please send correct 
patches next time.

Thanks for your fix!

Cheers,
Marek
