From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 May 2009 02:37:32 +0800
References: <F6D9C212-B698-46E4-8AE3-FE76DAFD2C54@7degrees.co.za>
In-Reply-To: <F6D9C212-B698-46E4-8AE3-FE76DAFD2C54@7degrees.co.za>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905210237.32316.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Allow vis daemon to serve mesh topology
	simultaneously in dot_draw and JSON format
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

On Tuesday 19 May 2009 01:01:48 Antoine van Gelder wrote:
> After some great input from Marek I took a swing at rewriting my vis
> patch to allow serving of mesh topology simultaneously in dot_draw &
> json.
>
>
> * -j enables JSON server on port 2005
>
> * dot_draw continues to be served on port 2004 irrespective of whether
> -j is specified or not.

Nice patch - I just uploaded it.


> Some thoughts:
>
> * It is not the prettiest of patches but it works. Thinking about
> cleaner approaches makes my imagination drift in the direction of a
> simple plugin API such as OLSRd has, anyone else having any similar
> thoughts ? :)
>
> * I'm serving json on port 2005 - any alternative suggestions ?

The code itself is far from being pretty. As usual it started as a proof of 
concept grew into a temporary solution and is still around. It worked quite 
well so far but if you have ideas & energy to improve it, please go ahead. :-)

Regards,
Marek

