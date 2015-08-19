Return-Path: <davem@davemloft.net>
Date: Tue, 18 Aug 2015 19:08:40 -0700 (PDT)
Message-Id: <20150818.190840.1520518833381816197.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1439897821-7480-1-git-send-email-sven@narfation.org>
References: <1439897821-7480-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH net] batman-adv: Fix memory leak on tt
 add with invalid vlan
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch, antonio@meshcoding.com

From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Aug 2015 13:37:01 +0200

> The object tt_local is allocated with kmalloc and not initialized when the
> function batadv_tt_local_add checks for the vlan. But this function can
> only cleanup the object when the (not yet initialized) reference counter of
> the object is 1. This is unlikely and thus the object would leak when the
> vlan could not be found.
> 
> Instead the uninitialized object tt_local has to be freed manually and the
> pointer has to set to NULL to avoid calling the function which would try to
> decrement the reference counter of the not existing object.
> 
> CID: 1316518
> Fixes: 354136bcc3c4 ("batman-adv: fix kernel crash due to missing NULL checks")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied, thanks.
