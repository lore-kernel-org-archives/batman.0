From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] nightly builds / update-interval?
Date: Tue, 18 Mar 2008 03:25:50 +0800
References: <1205761345.47de7541b7c89@mail.bluebottle.com>
In-Reply-To: <1205761345.47de7541b7c89@mail.bluebottle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803180325.50543.lindner_marek@yahoo.de>
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

On Monday, 17. March 2008 21:42:25 Bastian Bittorf wrote:
> New checkins are not instantly in repo.
> How long does it last or which algo is used
> to make the build-it-now!-decision?

They are instantly in the repository. There is a post-commit script which 
builds the packages directly after each svn commit.


> PPS: now we have build 997 in repo:
> http://downloads.open-mesh.net/batman/development/wrt-freifunk/
>
> but changeset 1004 in SVN?!
> https://dev.open-mesh.net/batman/changeset/1004

Don't get confiused by the different branches. We have one revision number for 
all branches. If one branch commits something packages for that very branch 
are created and not for all the branches.
That means the latest commit for the battool branch got the number 997. In 
recent days other branches commited their stuff and therefore the battools 
did not get recompiled.

Have a look at this link to see what is going on in the svn:
https://dev.open-mesh.net/batman/timeline

Greetings,
Marek
