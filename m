Return-Path: <davem@davemloft.net>
Date: Tue, 20 Dec 2011 14:02:09 -0500 (EST)
Message-Id: <20111220.140209.618109781658024408.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201112210259.42387.lindner_marek@yahoo.de>
References: <1324377504-20983-1-git-send-email-lindner_marek@yahoo.de>
	<20111220.133230.713811345652751674.davem@davemloft.net>
	<201112210259.42387.lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: checkpatch cleanup - remove
 lines longer than 80 chars
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
To: lindner_marek@yahoo.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 21 Dec 2011 02:59:41 +0800

> On Wednesday, December 21, 2011 02:32:30 David Miller wrote:
>> From: Marek Lindner <lindner_marek@yahoo.de>
>> Date: Tue, 20 Dec 2011 18:38:24 +0800
>> 
>> > The long line was introduced with b26e478f8f.
>> > 
>> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
>> 
>> I'm not applying this.
>> 
>> I tell people to make sure arguments line up correctly to the
>> openning parenthesis on the previous line, and that is what is
>> happening here.
> 
> I am not against lining up the arguments but what about checkpatch ? Are we 
> going to ignore the complaints or is this line limit about to be changed ?

Refactor the code so that both constraints can be satisfied.

Is this so hard to understand?
