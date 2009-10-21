Return-Path: <andrew@lunn.ch>
Date: Wed, 21 Oct 2009 09:05:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091021070510.GK23663@lunn.ch>
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
	<200910201917.12629.sven.eckelmann@gmx.de>
	<45f642440910201259j63a37a7bi58ea8b97a094a82f@mail.gmail.com>
	<200910202222.36928.sven.eckelmann@gmx.de>
	<45f642440910202354r1224c4f5i99e6f126c09c82c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f642440910202354r1224c4f5i99e6f126c09c82c1@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
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

On Wed, Oct 21, 2009 at 08:54:02AM +0200, Francesco wrote:
> HI all,
> I've now downloaded and $make latest batman-adv trunk from
> $svn co
> http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland/
> I have issues with batctl trunk:
> $svn co http://downloads.open-mesh.net/svn/batman/trunk/batctl/

This unfortunately, does not work. The batctl sources has symbolic
links into the batman directory for the files hash.c, list-batman.c,
hash.h list-batman.h. 

Check out the complete trunk and then you will have everything you
need.

	Andrew
