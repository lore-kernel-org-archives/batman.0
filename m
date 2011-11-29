Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 14:34:34 +0800
References: <201111290028.01655.lindner_marek@yahoo.de>
	<201111290342.31065.lindner_marek@yahoo.de>
	<20111129061810.GG13600@lunn.ch>
In-Reply-To: <20111129061810.GG13600@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111291434.34724.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: switch routing algorithm at
	runtime
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

On Tuesday, November 29, 2011 14:18:10 Andrew Lunn wrote:
> > All functions are checked right now and all functions can be NULL.
> > Check the patch #2 ...
> 
> This seems strange. What sort of routing protocol can you build, which
> has a NULL receive function? Only static routes. I would perform the
> check once in _register(), that there is a receive function, and never
> check it again. Save yourself a few cycles.
> 
> There is an LWN article about these ideas. Worth a read. I will post a
> link later.

Thanks. That will be helpful!

Cheers,
Marek
