Return-Path: <davem@davemloft.net>
Date: Wed, 01 Dec 2010 11:12:05 -0800 (PST)
Message-Id: <20101201.111205.28818479.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201012012004.34356.sven.eckelmann@gmx.de>
References: <201012011954.20275.sven.eckelmann@gmx.de>
	<20101201.105615.48506929.davem@davemloft.net>
	<201012012004.34356.sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv6] net: Add batman-adv meshing protocol
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
To: sven.eckelmann@gmx.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 1 Dec 2010 20:04:33 +0100

> David Miller wrote:
>> From: Sven Eckelmann <sven.eckelmann@gmx.de>
>> Date: Wed, 1 Dec 2010 19:54:19 +0100
>> 
>> > Do you have any more possible duplication you have in your mind right
>> > now?
>> 
>> The hashing code, for the third time.
> 
> And I asked in the past about the removal of the hashing stuff without any 
> reaction. So, we removed most of it. resize and iterate will be dropped too. 
> So, is it a problem to have a hash_find, hash_remove, hash_add? These were 
> created to reduce duplicated code and not to create a complete new dynamic 
> datastructure (which it isn't... it is just the usual hlist stuff)

Ok, fair enough.
