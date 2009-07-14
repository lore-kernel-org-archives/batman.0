Return-Path: <antoine@7degrees.co.za>
Message-Id: <F51A1DAE-D376-454C-8C39-2A1680CBCC6A@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <20090714132004.GN19071@ma.tech.ascom.ch>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Tue, 14 Jul 2009 15:32:31 +0200
References: <20090714130926.GM19071@ma.tech.ascom.ch>
	<20090714132004.GN19071@ma.tech.ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] bitarray.[ch] Linux coding
	style	cleanup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


On 14 Jul 2009, at 15:20 , Andrew Lunn wrote:
> What are peoples opinion about this? Should i spend a little time
> cleaning up all the files? Some code needs refactoring a little, to
> reducing the nesting, creating more helper functions, but mostly its
> white space changes. However such changes can cause pain when trying
> to merge in other work people who diff's are against before the
> cleanup. Does anybody have any major patches?


I have a minor patch outstanding against the vis server but it  
wouldn't be affected by a cleanup.

Very happy with the decision to do a clean-up.

  - a

