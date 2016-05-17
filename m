Return-Path: <andrew@lunn.ch>
Date: Tue, 17 May 2016 14:18:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160517121835.GA23383@lunn.ch>
References: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
 <1463419689-3580-2-git-send-email-andrew@lunn.ch>
 <2256828.JfWKWoeer9@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2256828.JfWKWoeer9@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 01/11] batman-adv: Handle parent
 interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

> I think I removed this multiple times but this misalignment seems to be 
> immortal:
> 
> >         return (dev1_parent_iflink == dev2->ifindex) &&
> > -              (dev2_parent_iflink == dev1->ifindex);
> > +               (dev2_parent_iflink == dev1->ifindex) &&
> > +               net_eq(dev1_parent_net, net2) &&
> > +               net_eq(dev2_parent_net, net1);

According to checkpatch and emacs, it is also correct as it is :-)

If you really want to enforce some other arbitrary white space
alignment policy than checkpatch.pl, it would help if the scripts you
are using are placed into ./tools, just like checkpatch.pl is. Better
still, provide patches to checkpatch.pl. You should also put all your
other tools there. Checkpatch mostly works because it is easily
available, making it easy to push back against when people don't use
it. Developing code for BATMAN is easy, but making it pass all your
arbitrary style checks, header file requirements, structure forward
declaration, negative value kerneldoc function headers, etc is hard
and takes much much longer than developing the code. Putting these
scripts at the figures of the developers,
./scripts/batadv-checkpatch.pl, and you stand a better chance of
compliance.

I'm actually getting close to the point where i'm going to give up.

    Andrew




