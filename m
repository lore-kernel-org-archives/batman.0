Return-Path: <neumann@cgws.de>
From: Axel Neumann <neumann@cgws.de>
Date: Mon, 20 Dec 2010 20:35:47 +0100
References: <201012181801.14616.neumann@cgws.de>
	<201012201245.16891.neumann@cgws.de>
	<201012201317.52706.sven@narfation.org>
In-Reply-To: <201012201317.52706.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201012202035.47993.neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] New BMX website at www.bmx6.net
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

On Montag 20 Dezember 2010, Sven Eckelmann wrote:
[...]
> The problem is that you (sry, no offence meant) did a quite bad job to
> convert it. bmxd.git has these weird git-svn-id lines in the commit
> messages, "random" commiter names+mails, missing parts of the history,
> dangling symlinks, ...
> 
> Please take a look at git://git.open-mesh.org/ecsv/test/bmx.git
> I don't say that it is the holy grail of svn-to-git conversation, but I
> think it could be a better conversation than your bmxd.git
> 

I am kind of git newbie. You are right and I see what you mean. Finally I 
decided to simply fetch the bmx-0.3.x branch from the repository you mentioned 
and offer it as a bare master branch at git://git.bmx6.net/bmxd.git .


Is there a one line command you used to create this? Essentially I used:
git svn init http://downloads.open-mesh.org/svn/batman/trunk/batman-
experimental/ 
to create my former repository but obviously this missed some initial commits, 
full names,...:-(


Thanks anyway.


/axel



> Best regards,
> 	Sven

