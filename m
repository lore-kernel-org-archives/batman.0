From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] 0.3-beta vs. 0.3-exp
Date: Mon, 15 Oct 2007 10:26:26 +0200
References: <20071015030933.GB15527@apoderado.ometepe.net>
In-Reply-To: <20071015030933.GB15527@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710151026.26278.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

On Montag 15 Oktober 2007, Jan Hetges wrote:
> Hello everyone
> first: nice work, i'm impressed!
> i'm migrating 15 node olsr network to batman.
> right now all nodes run olsrd and batman-0.2 parallel,
> but there are some issues with "hidden nodes" (thanks to Axel for
> the bmx-reference-manual)
> so my question, which of the switches from bmx (if any) are available
> in the 0.3-beta versions, 
All switches available in 0.3-beta have been documented by Wesley on the 
corresponding man page:
http://downloads.open-mesh.net/batman/development/sources/batmand_0.3-beta-current_sources/man/batmand.8.html
and batmand_howto:
https://www.open-mesh.net/batman/doc/batmand_howto.pdf

The switches mentioned in the bmx manual are not available in 0.3-beta. That 
is one of the differences between the two branches. The objective of the 
0.3-beta branch is to always identify the best paramtrization automatically, 
relieving the administrator from the task of identifying appropriate 
parameters. 
For the "hidden nodes" issues, the 0.3-beta implementation should 
automatically hide the existence of all non-primary interface originators 
beyond the local neighbor horizon and instead send host network 
advertisements (HNAs). 

> or is the beta just something like 0.3-exp --bmx-defaults ?
No! The --bmx-defaults directive activates features from the 
batmand-experimental branch which might or might not find its way into the 
final batmand-0.3 release. 

The --bmx-defaults directive is supposed to always enable the 
latest "state-of-the-art" of the current batmand-exp implementation. 
Therefore the functionality enabled by this switch will change with future 
versions. Currently the --bmx-defaults switch implements the same parameters 
as the --graz-2007 switch. And this switch is supposed to remain as it is 
also in future versions. 
See:
http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-exp-current_sources/doc/bmx/bmx.html#SECTION10060000000000000000

ciao,
axel



>
> cheers
>
>   --Jan


