Return-Path: <davem@davemloft.net>
Date: Wed, 07 Nov 2012 19:10:34 -0500 (EST)
Message-Id: <20121107.191034.180849843876027251.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1352315502-20324-1-git-send-email-ordex@autistici.org>
References: <1352315502-20324-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-11-07
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
Date: Wed,  7 Nov 2012 20:11:30 +0100

> Hello David,
> 
> first of all thank you for having made us aware of the packet format problem in
> batman-adv! The impact of __packed on performances was not entirely known to me,
> in particular for what concerns the RISC arch.
> 
> We have to change a number of packet formats before we can remove __packed
> everywhere which will obviously break compatibility.
> 
> However we already scheduled a compatibility break because we want to
> heavily improve our packet formats and to provide a more flexible framework that
> would allow us to add new types and features while reducing the probability of
> breaking compatibility again and again as happened in the past (we are
> implementing TypeLengthValue (TLV) containers among other things).
> 
> To avoid breaking compatibility (at least) twice we decided to fix now (in this
> patchset) what is fixable with no consequences to compatibility while we would
> ilike to defer the remaining changes for the scheduled compatibility break.
> 
> In this patchset you have the two new features intended for net-next/linux-3.8:
> 1) the new UNICAST_4ADDR packet type
> 2) the Distributed ARP Table (DAT) component
> 
> The new packet type has been reviewed to entirely address the alignment issue.
> At the same time we also reviewed the other packet types but as I told you
> before, we will send these changes later.
> 
> Other than that you have patch 02/12 that removes the __packed attribute from
> the structures where it was not really needed.

Pulled, thanks.
