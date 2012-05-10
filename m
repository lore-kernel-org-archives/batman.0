Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 14:08:07 +0800
References: <1336561976-16088-1-git-send-email-ordex@autistici.org>
	<1336561976-16088-8-git-send-email-ordex@autistici.org>
	<20120509.204111.1931607501484626500.davem@davemloft.net>
In-Reply-To: <20120509.204111.1931607501484626500.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201205101408.07750.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/14] batman-adv: split neigh_new
	function into generic and batman iv specific parts
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>


David,

> But once it gets exported out of that file, you have to give it
> an appropriate name.  Probably with a "batman_adv_" prefix or
> similar.
> 
> Otherwise, for one thing, if this code is statically built into
> the tree it can conflict with symbol names elsewhere and break
> the build.

thanks for pointing this out. I wasn't aware of the potential conflict created 
by our naming scheme. Obviously, we will change the proposed patch.
We are going to review all other exported function names and send appropriate 
patches later on.

Regards,
Marek
