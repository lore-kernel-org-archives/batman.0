From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] 0.3 alpha (today revison)
Date: Mon, 24 Sep 2007 20:56:10 +0200
References: <840E3F681DF3D043B353C0FDD4A6C3533F76B8@ex9.hostedexchange.local>
In-Reply-To: <840E3F681DF3D043B353C0FDD4A6C3533F76B8@ex9.hostedexchange.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200709242056.10606.axel@open-mesh.net>
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

Hello,

On Montag 24 September 2007, Michael Burmeister-Brown wrote:
> Marek,
>
> I hate to bother you but you were so responsive before...
>
> Antonio just put up a post.  We are both seeing the same problem -
> computers associated with repeaters on 0.3 (MIPS) can't browse.  But ssh
> into that node and do a wget and it works great!.  If we just replace
> 0.3 with 0.2 all works again.

So you want to use the batman-clients as APs for usual 802.11-managed-mode 
clients.
If I understand you right, then you prbably need to do network address 
translation (NAT) or MASQUERADEing on the bat0 interfaces on the batman 
clients.
And of course a second time on the batman-GW.

>
> Also, I am tracking memory and see it dropping steadily on the nodes
> (500k in about 12 hours).  This didn't happen with 0.2 and that is all
> that has changed.
Thats interesting, sounds like a memory leak, because in the lates setups i 
tested the memory consumption was constantly 3.1 percent (even after hours). 
using dynamically compiled mipsel binaries and up to 20 nodes .
Can you send the output from top right after the start, after a few minutes 
and after a few hours. And the output of debug-level -5 (hope its compiled 
in)

ciao,
axel
