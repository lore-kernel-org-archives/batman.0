From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Feb 2009 00:29:23 +0800
References: <238a15490902111906g23358005v35fd57d8df857154@mail.gmail.com>
	<20090212125347.GA4074@pandem0nium>
	<238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
In-Reply-To: <238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902130029.48657.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Using batman L2 on multiple wireless cards
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Thursday 12 February 2009 22:58:31 Gargi Purohit wrote:
> however when i check the /proc/net/batman-adv/originators....i see
> that all other nodes are reachable but the interface mentioned is
> ath1....(even those which are actually reachable by ath0)
>
> shouldn't some of the boards be reachable by ath0 - as some nodes are
> on a different channel...
>
> or is it like ath1 is some main interface.....

Yes, batman has the concept of "main interface" (the first given interface) to 
reduce overhead but on the node that has 2 interfaces you should see both 
interfaces in the originator table (on a more distant host this might be 
different).
Could you post the important lines from originators and explain the 
corresponding setup ?

Regards,
Marek

