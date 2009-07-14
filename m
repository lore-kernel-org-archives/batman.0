Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 14 Jul 2009 22:48:10 +0800
References: <20090714130926.GM19071@ma.tech.ascom.ch>
	<20090714132004.GN19071@ma.tech.ascom.ch>
In-Reply-To: <20090714132004.GN19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907142248.10724.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.]
 =?iso-8859-1?q?=5Bbatman-adv=5D_bitarray=2E=5Bch?=
 =?iso-8859-1?q?=5D_Linux_coding_style=09cleanup?=
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

On Tuesday 14 July 2009 21:20:04 Andrew Lunn wrote:
> What are peoples opinion about this? Should i spend a little time
> cleaning up all the files? Some code needs refactoring a little, to
> reducing the nesting, creating more helper functions, but mostly its
> white space changes. However such changes can cause pain when trying
> to merge in other work people who diff's are against before the
> cleanup. Does anybody have any major patches?

I have a major patch myself which I did not upload yet. It aims to improve the 
routing over multiple interfaces and thus touches quite some files. I'd rather 
test this stuff a bit longer before I screw up everyones routing.  ;-)

So, in my opinion there is not need to hesitate. Cleanup is a good idea.

Regards,
Marek

