Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 3 Jan 2012 18:27:28 +0800
References: <201112252236.22377.clemens-john@gmx.de>
	<1542912.6mqKHTfaCm@ostrea>
	<3014476.qt0n1BBs4R@sven-laptop.home.narfation.org>
In-Reply-To: <3014476.qt0n1BBs4R@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201201031827.29057.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, January 03, 2012 07:10:02 Sven Eckelmann wrote:
> Marek already suggested that the packet format version should be increased
> to clearly state that these versions are not compatible. But it could also
> be that you triggered a bug in the new bla implementation... still I don't
> understand why you are doing this. Which node should detect the ARP
> packets? Maybe you can explain it again to better understand your network
> architecture.

Before you update all your nodes to the same version it would be really 
helpful to find out if there is an incompatibility between the old BLA and the 
new BLA. We are not 100% sure about that.

By the way, looking at our compatibility number table (http://www.open-
mesh.org/wiki/batman-adv/Compatversion) I see that 2011.0.0 has compat 12 
whereas 2011.4.0 has compat number 14. That could be the reason why your setup 
is not working.

Cheers,
Marek
