Return-Path: <andrew@lunn.ch>
Date: Thu, 31 Mar 2011 09:20:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110331072003.GE9965@lunn.ch>
References: <006701cbef3f$b70d9590$2528c0b0$@britton@adelaide.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006701cbef3f$b70d9590$2528c0b0$@britton@adelaide.edu.au>
Subject: Re: [B.A.T.M.A.N.] Modification of BATMAN IV's route selection
 algorithm
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

Hi Mattew

Another idea sprung to mind....

Your hysteresis value H seems to be an absolute. I think it would work
better if it was a percentage. With large meshes, the further away you
are from the originator, the smaller TQ is, because of the link
penalty. Thus with an absolute value of H, the relative quality of the
link has to change a lot more when you are many hops away, than if you
are near by.

    Andrew
