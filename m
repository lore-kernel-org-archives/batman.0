Return-Path: <davem@davemloft.net>
Date: Sat, 30 Jun 2012 22:41:27 -0700 (PDT)
Message-Id: <20120630.224127.2026489533108686887.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1341111847.4852.71.camel@deadeye.wl.decadent.org.uk>
References: <1341003484-8457-1-git-send-email-ordex@autistici.org>
	<1341003484-8457-2-git-send-email-ordex@autistici.org>
	<1341111847.4852.71.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2 stable 3.2-3.3-3.4] batman-adv: only
 drop packets of known wifi clients
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: ben@decadent.org.uk
Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de, stable@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 01 Jul 2012 04:04:07 +0100

> On Fri, 2012-06-29 at 22:58 +0200, Antonio Quartulli wrote:
>> From: Marek Lindner <lindner_marek@yahoo.de>
>> 
>> commit 5870adc68fc39d81089f1e80efdf64b97e5c37a1 upstream
>> 
>> bug introduced with 59b699cdee039d75915c354da06937102d1f9a84
>> 
>> If the source or destination mac address of an ethernet packet
>> could not be found in the translation table the packet was
>> dropped if AP isolation was turned on. This behavior would
>> make it impossible to send broadcast packets over the mesh as
>> the broadcast address will never enter the translation table.
> [...]
> 
> Are you OK with this going into 3.2.y, David?

Yes.
